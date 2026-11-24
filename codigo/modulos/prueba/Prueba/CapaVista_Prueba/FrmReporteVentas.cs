using System;
using System.Data;
using System.Windows.Forms;
using Microsoft.Reporting.WinForms;

namespace CapaVista_Prueba
{
    public sealed partial class FrmReporteVentas : Form
    {
        public FrmReporteVentas()
        {
            InitializeComponent();
        }

        internal FrmReporteVentas(DataTable ventas) : this()
        {
            visorReporte.LocalReport.ReportEmbeddedResource = "CapaVista_Prueba.Reportes.Ventas.rdlc";
            visorReporte.LocalReport.DataSources.Add(new ReportDataSource("Ventas", ventas));
        }

        private void FrmReporteVentas_Load(object sender, EventArgs e)
        {
            visorReporte.RefreshReport();
        }
    }
}
