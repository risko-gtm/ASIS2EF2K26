namespace CapaVista_Mantenimiento2k26.Formularios
{
    partial class PacienteNavegador
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
            this.navegador1 = new CapaVista_Navegador.Navegador();
            this.SuspendLayout();
            // 
            // navegador1
            // 
            this.navegador1.Location = new System.Drawing.Point(-1, 1);
            this.navegador1.Name = "navegador1";
            this.navegador1.Size = new System.Drawing.Size(1438, 111);
            this.navegador1.TabIndex = 0;
            
            // 
            // PacienteNavegador
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1481, 963);
            this.Controls.Add(this.navegador1);
            this.MaximizeBox = false;
            this.Name = "PacienteNavegador";
            this.Text = "FrmPacientes";
            this.ResumeLayout(false);

        }

        #endregion

        private CapaVista_Navegador.Navegador navegador1;
    }
}