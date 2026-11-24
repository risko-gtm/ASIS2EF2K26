namespace CapaVista_EvaluacionDesempeño.Formularios
{
    partial class FrmVendedoresFinal
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
            this.RrhhVendedorNavegador = new CapaVista_Navegador.Navegador();
            this.SuspendLayout();
            // 
            // RrhhVendedorNavegador
            // 
            this.RrhhVendedorNavegador.Location = new System.Drawing.Point(12, 13);
            this.RrhhVendedorNavegador.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.RrhhVendedorNavegador.Name = "RrhhVendedorNavegador";
            this.RrhhVendedorNavegador.Size = new System.Drawing.Size(1435, 107);
            this.RrhhVendedorNavegador.TabIndex = 1;
            // 
            // FrmVendedoresFinal
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1462, 730);
            this.Controls.Add(this.RrhhVendedorNavegador);
            this.Name = "FrmVendedoresFinal";
            this.Text = "FrmVendedoresFinal";
            this.ResumeLayout(false);

        }

        #endregion

        private CapaVista_Navegador.Navegador RrhhVendedorNavegador;
    }
}