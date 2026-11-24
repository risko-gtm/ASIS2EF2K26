namespace CapaVista_Prueba
{
    partial class FrmReporteVentas
    {
        private void InitializeComponent()
        {
            this.visorReporte = new Microsoft.Reporting.WinForms.ReportViewer();
            this.SuspendLayout();

            this.visorReporte.Dock = System.Windows.Forms.DockStyle.Fill;
            this.visorReporte.Location = new System.Drawing.Point(0, 0);
            this.visorReporte.Name = "visorReporte";
            this.visorReporte.Size = new System.Drawing.Size(1024, 640);
            this.visorReporte.TabIndex = 0;

            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 17F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1024, 640);
            this.Controls.Add(this.visorReporte);
            this.Font = new System.Drawing.Font("Segoe UI", 10F);
            this.Name = "FrmReporteVentas";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Reporte de ventas";
            this.Load += new System.EventHandler(this.FrmReporteVentas_Load);
            this.ResumeLayout(false);
        }

        private Microsoft.Reporting.WinForms.ReportViewer visorReporte;
    }
}
