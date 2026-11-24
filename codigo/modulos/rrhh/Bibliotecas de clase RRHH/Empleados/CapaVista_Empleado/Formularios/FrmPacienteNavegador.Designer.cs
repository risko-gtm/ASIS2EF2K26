namespace CapaVista_Empleado.Formularios
{
    partial class FrmPacienteNavegador
    {
        private System.ComponentModel.IContainer components = null;

        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FrmPacienteNavegador));
            this.RrhhNavPaciente = new CapaVista_Navegador.Navegador();
            this.SuspendLayout();
            // 
            // RrhhNavPaciente
            // 
            this.RrhhNavPaciente.Location = new System.Drawing.Point(12, 92);
            this.RrhhNavPaciente.Name = "RrhhNavPaciente";
            this.RrhhNavPaciente.Size = new System.Drawing.Size(1435, 107);
            this.RrhhNavPaciente.TabIndex = 0;
            // 
            // FrmPacienteNavegador
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1462, 640);
            this.Controls.Add(this.RrhhNavPaciente);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "FrmPacienteNavegador";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "9007 – Pacientes";
            this.ResumeLayout(false);

        }

        #endregion

        private CapaVista_Navegador.Navegador RrhhNavPaciente;
    }
}
