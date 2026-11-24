using CapaControlador_MantenimientoAsis2k26;
using Microsoft.Reporting.WinForms;
using CapaControlador_MantenimientoAsis2k26.Modelo_De_controladores;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

/*
 * ==================================================================
 * Área: Mantenimiento
 * Autores: Lourdes Isabel Melendez Pineda
 * Fecha: 23/09/2026
 * ==================================================================
 * Propósito : Formulario de la capa Vista que muestra el reporte
 * de Clientes, cargando los datos desde el controlador
 * y renderizándolos con ReportViewer.
 * ===================================================================
 */

namespace CapaVista_Mantenimiento2k26.frmReportes
{
    public partial class FrmReporteCliente : Form
    {
        private ClsModeloCliente Cliente = new ClsModeloCliente();

        public FrmReporteCliente()
        {
            InitializeComponent();
        }

        private void FrmReporteCliente_Load(object sender, EventArgs e)
        {
            ReportDataSource reportDataSource = new ReportDataSource("DsCliente", Cliente.ClienteMetObtenerParaReporte());
            reportViewer1.LocalReport.ReportEmbeddedResource = "CapaVista_Mantenimiento2k26.Reportes.RpReporteCliente.rdlc";
            reportViewer1.LocalReport.DataSources.Clear();
            reportViewer1.LocalReport.DataSources.Add(reportDataSource);
            this.reportViewer1.RefreshReport();
        }
    }
}

