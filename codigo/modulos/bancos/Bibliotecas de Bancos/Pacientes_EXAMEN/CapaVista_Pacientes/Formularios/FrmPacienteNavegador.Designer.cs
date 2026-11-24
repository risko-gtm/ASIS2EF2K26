namespace CapaVista_Pacientes.Formularios
{
    partial class FrmPacienteNavegador
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
            this.BancosPacientes = new CapaVista_Navegador.Navegador();
            this.SuspendLayout();
            // 
            // BancosPacientes
            // 
            this.BancosPacientes.Location = new System.Drawing.Point(19, 11);
            this.BancosPacientes.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.BancosPacientes.Name = "BancosPacientes";
            this.BancosPacientes.Size = new System.Drawing.Size(1078, 90);
            this.BancosPacientes.TabIndex = 0;
            // 
            // FrmPacienteNavegador
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1116, 541);
            this.Controls.Add(this.BancosPacientes);
            this.Name = "FrmPacienteNavegador";
            this.Text = "8014-Pacientes";
            this.ResumeLayout(false);

        }

        #endregion

        private CapaVista_Navegador.Navegador BancosPacientes;
    }
}