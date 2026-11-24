using System;
using System.Collections.Generic;
using System.IO;
using System.Windows.Forms;
using CapaControlador_Reporteador;
using Microsoft.Reporting.WinForms;

namespace CapaVista_Reporteador.Formas
{
    public partial class FrmVistaReportes : Form
    {
        private readonly string _RutaReporte;
        private readonly Dictionary<string, object> _FuentesDeDatos;
        private readonly Func<Stream> _AbrirReporteLocal;

        public FrmVistaReportes(string RutaReporte, Dictionary<string, object> FuentesDeDatos)
            : this(RutaReporte, FuentesDeDatos, null) { }

        public FrmVistaReportes(string RutaReporte, Dictionary<string, object> FuentesDeDatos,
            Func<Stream> AbrirReporteLocal)
        {
            InitializeComponent();
            _RutaReporte = RutaReporte;
            _FuentesDeDatos = FuentesDeDatos;
            _AbrirReporteLocal = AbrirReporteLocal;
        }

        public FrmVistaReportes(int IdAplicacion, Dictionary<string, object> FuentesDeDatos)
            : this(IdAplicacion, FuentesDeDatos, null) { }

        public FrmVistaReportes(int IdAplicacion, Dictionary<string, object> FuentesDeDatos,
            Func<Stream> AbrirReporteLocal)
            : this(
                new ClsModeloReporteador().ReporteadorMetObtenerRutaPrimerReporte(IdAplicacion),
                FuentesDeDatos,
                AbrirReporteLocal
            ) { }

        private void ReporteadorMetCargarVistaPrevia(object Sender, EventArgs E)
        {
            if (_FuentesDeDatos == null && _AbrirReporteLocal == null)
            {
                ReporteadorRpvVistaReporte.LocalReport.ReportPath = _RutaReporte;
                ReporteadorRpvVistaReporte.RefreshReport();
                return;
            }

            try
            {
                ReporteadorMetCargarReporteDinamico(_RutaReporte, _FuentesDeDatos);
            }
            catch (Exception Error)
            {
                MessageBox.Show(this, Error.Message, "Error al cargar el reporte",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
                Close();
            }
        }

        private void ReporteadorMetCargarReporteDinamico(
            string RutaRdlc,
            Dictionary<string, object> FuentesDeDatos
        )
        {
            FuentesDeDatos = FuentesDeDatos ?? new Dictionary<string, object>();
            LocalReport Reporte = ReporteadorMetPrepararVisor();

            if (File.Exists(RutaRdlc))
            {
                Reporte.ReportPath = RutaRdlc;
                try
                {
                    ReporteadorMetVincularDatos(Reporte, FuentesDeDatos);
                    ReporteadorRpvVistaReporte.RefreshReport();
                    return;
                }
                catch (LocalProcessingException) when (_AbrirReporteLocal != null)
                {
                    // Usar el reporte del módulo si la definición registrada no se puede cargar.
                }
                catch (InvalidOperationException) when (_AbrirReporteLocal != null)
                {
                    // El reporte registrado requiere datos que este formulario no suministra.
                }
            }

            if (_AbrirReporteLocal == null)
                throw new FileNotFoundException(string.IsNullOrWhiteSpace(RutaRdlc)
                    ? "No hay un reporte registrado para esta aplicación."
                    : "No se encontró el reporte en: " + RutaRdlc);

            Reporte = ReporteadorMetPrepararVisor();
            using (Stream Definicion = _AbrirReporteLocal())
            {
                if (Definicion == null)
                    throw new FileNotFoundException("El módulo no contiene el reporte de mantenimiento.");
                Reporte.LoadReportDefinition(Definicion);
            }

            ReporteadorMetVincularDatos(Reporte, FuentesDeDatos);

            ReporteadorRpvVistaReporte.RefreshReport();
        }

        private LocalReport ReporteadorMetPrepararVisor()
        {
            ReporteadorRpvVistaReporte.Reset();
            ReporteadorRpvVistaReporte.ProcessingMode = ProcessingMode.Local;
            return ReporteadorRpvVistaReporte.LocalReport;
        }

        private static void ReporteadorMetVincularDatos(LocalReport Reporte,
            Dictionary<string, object> FuentesDeDatos)
        {
            foreach (string NombreDataset in Reporte.GetDataSourceNames())
            {
                if (!FuentesDeDatos.TryGetValue(NombreDataset, out object Datos))
                    throw new InvalidOperationException("No se proporcionaron los datos del reporte: " + NombreDataset);

                Reporte.DataSources.Add(new ReportDataSource(NombreDataset, Datos));
            }
        }
    }
}
