namespace CapaVista_Proveedor_Logistica.Formularios
{
    partial class FrmProveedor
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
            this.LogisticaNavProveedor = new CapaVista_Navegador.Navegador();
            this.SuspendLayout();
            // 
            // LogisticaNavProveedor
            // 
            this.LogisticaNavProveedor.Location = new System.Drawing.Point(23, 75);
            this.LogisticaNavProveedor.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.LogisticaNavProveedor.Name = "LogisticaNavProveedor";
            this.LogisticaNavProveedor.Size = new System.Drawing.Size(1078, 90);
            this.LogisticaNavProveedor.TabIndex = 0;
            // 
            // FrmProveedor
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1136, 450);
            this.Controls.Add(this.LogisticaNavProveedor);
            this.Name = "FrmProveedor";
            this.Text = "FrmProveedor";
            this.ResumeLayout(false);

        }

        #endregion

        private CapaVista_Navegador.Navegador LogisticaNavProveedor;
    }
}