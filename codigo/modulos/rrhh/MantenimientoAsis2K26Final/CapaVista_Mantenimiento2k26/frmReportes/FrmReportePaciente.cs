
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
 * de Pacientes, cargando los datos desde el controlador
 * y renderizándolos con ReportViewer.
 * ===================================================================
 */


namespace CapaVista_Mantenimiento2k26.frmReportes
{
    public partial class FrmReportePaciente : Form
    {
        private BindingSource bindingSource1;
        private IContainer components;
        private ReportViewer reportViewer1;
        private ClsModeloPaciente Paciente = new ClsModeloPaciente();

        public FrmReportePaciente()
        {
            InitializeComponent();
        }

        private void FrmReportePaciente_Load(object sender, EventArgs e)
        {
            ReportDataSource reportDataSource = new ReportDataSource("DsPaciente", Paciente.PacienteMetObtenerParaReporte());
            reportViewer1.LocalReport.ReportEmbeddedResource = "CapaVista_Mantenimiento2k26.Reportes.RpReportePaciente.rdlc";
            reportViewer1.LocalReport.DataSources.Clear();
            reportViewer1.LocalReport.DataSources.Add(reportDataSource);
            this.reportViewer1.RefreshReport();
        }

        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.bindingSource1 = new System.Windows.Forms.BindingSource(this.components);
            this.reportViewer1 = new Microsoft.Reporting.WinForms.ReportViewer();
            ((System.ComponentModel.ISupportInitialize)(this.bindingSource1)).BeginInit();
            this.SuspendLayout();
            // 
            // reportViewer1
            // 
            this.reportViewer1.Location = new System.Drawing.Point(13, 12);
            this.reportViewer1.Name = "reportViewer1";
            this.reportViewer1.ServerReport.BearerToken = null;
            this.reportViewer1.Size = new System.Drawing.Size(1255, 592);
            this.reportViewer1.TabIndex = 0;
            this.reportViewer1.Load += new System.EventHandler(this.reportViewer1_Load);
            // 
            // FrmReportePaciente
            // 
            this.ClientSize = new System.Drawing.Size(1280, 631);
            this.Controls.Add(this.reportViewer1);
            this.Name = "FrmReportePaciente";
            this.Load += new System.EventHandler(this.FrmReportePaciente_Load_1);
            ((System.ComponentModel.ISupportInitialize)(this.bindingSource1)).EndInit();
            this.ResumeLayout(false);

        }

        private void FrmReportePaciente_Load_1(object sender, EventArgs e)
        {

            this.reportViewer1.RefreshReport();
        }

        private void reportViewer1_Load(object sender, EventArgs e)
        {

        }
    }
}
