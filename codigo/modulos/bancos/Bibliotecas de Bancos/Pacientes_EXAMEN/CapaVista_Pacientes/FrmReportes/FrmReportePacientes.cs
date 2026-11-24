/*Oscar Emilio Morales Lemus; 9959-23-3070*/
using CapaControlador_Pacientes.Modelo_de_Controladores;
using Microsoft.Reporting.WinForms;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CapaVista_Pacientes.FrmReportes
{
    public partial class FrmReportePacientes : Form
    {
        private ClsModeloPaciente modulo = new ClsModeloPaciente();
        public FrmReportePacientes()
        {
            InitializeComponent();
        }

        private void FrmReportePacientes_Load(object sender, EventArgs e)
        {
            ReportDataSource reportDataSource = new ReportDataSource("DsReportePaciente", modulo.BancosMetObtenerTodos());
            reportViewer1.LocalReport.ReportEmbeddedResource = "CapaVista_Pacientes.Reportes.RpReportePacientes.rdlc";
            reportViewer1.LocalReport.DataSources.Clear();
            reportViewer1.LocalReport.DataSources.Add(reportDataSource);
            this.reportViewer1.RefreshReport();

        }
    }
}
