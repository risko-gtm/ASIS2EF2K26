namespace CapaVista_Paciente_Logistica.Formularios
{
    partial class FrmMantenimientoPaciente
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FrmMantenimientoPaciente));
            this.LogisticaNavTipoTransporte = new CapaVista_Navegador.Navegador();
            this.SuspendLayout();
            // 
            // LogisticaNavTipoTransporte
            // 
            this.LogisticaNavTipoTransporte.Location = new System.Drawing.Point(12, 30);
            this.LogisticaNavTipoTransporte.Name = "LogisticaNavTipoTransporte";
            this.LogisticaNavTipoTransporte.Size = new System.Drawing.Size(1438, 111);
            this.LogisticaNavTipoTransporte.TabIndex = 0;
            // 
            // FrmMantenimientoPaciente
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1525, 912);
            this.Controls.Add(this.LogisticaNavTipoTransporte);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "FrmMantenimientoPaciente";
            this.Text = "5038-Paciente";
            this.ResumeLayout(false);

        }

        #endregion

        private CapaVista_Navegador.Navegador LogisticaNavTipoTransporte;
    }
}