using CapaControlador_Pacientes.Modelos_de_Controladores;
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
    public partial class frmReportePacienteNavegador : Form
    {
        private ClsModeloPaciente Paciente = new ClsModeloPaciente();
        public frmReportePacienteNavegador()
        {
            InitializeComponent();
        }

        private void frmReportePacienteNavegador_Load(object sender, EventArgs e)
        {
            try
            {
                ReportDataSource Fuente = new ReportDataSource("DsProveedor", Paciente.PacienteMetObtenerParaReporte());
                RrhhRdvPaciente.LocalReport.ReportEmbeddedResource = "CapaVista_Pacientes.Reportes.RpPaciente.rdlc";
                RrhhRdvPaciente.LocalReport.DataSources.Clear();
                RrhhRdvPaciente.LocalReport.DataSources.Add(Fuente);
                RrhhRdvPaciente.RefreshReport();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
            this.RrhhRdvPaciente.RefreshReport();
        }
    }
}
