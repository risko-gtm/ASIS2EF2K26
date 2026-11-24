namespace CapaVista_GeneracionPagos.Formularios
{
    partial class FrmPacientesNavegador
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
            this.BancosNavPacientes = new CapaVista_Navegador.Navegador();
            this.SuspendLayout();
            // 
            // BancosNavPacientes
            // 
            this.BancosNavPacientes.Location = new System.Drawing.Point(11, 11);
            this.BancosNavPacientes.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.BancosNavPacientes.Name = "BancosNavPacientes";
            this.BancosNavPacientes.Size = new System.Drawing.Size(1078, 90);
            this.BancosNavPacientes.TabIndex = 0;
            this.BancosNavPacientes.Load += new System.EventHandler(this.BancosNavPacientes_Load);
            // 
            // FrmPacientesNavegador
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1095, 450);
            this.Controls.Add(this.BancosNavPacientes);
            this.MaximizeBox = false;
            this.Name = "FrmPacientesNavegador";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "FrmPacientesNavegador";
            this.ResumeLayout(false);

        }

        #endregion

        private CapaVista_Navegador.Navegador BancosNavPacientes;
    }
}