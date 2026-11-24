namespace CapaVista_Prueba
{
    partial class FrmVendedores
    {
        private System.ComponentModel.IContainer components = null;

        protected override void Dispose(bool disposing)
        {
            if (disposing && components != null)
                components.Dispose();

            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de Windows Forms

        private void InitializeComponent()
        {
            this.navegadorVendedores = new CapaVista_Navegador.Navegador();
            this.SuspendLayout();
            // 
            // navegadorVendedores
            // 
            this.navegadorVendedores.Location = new System.Drawing.Point(0, 12);
            this.navegadorVendedores.Name = "navegadorVendedores";
            this.navegadorVendedores.Size = new System.Drawing.Size(1438, 152);
            this.navegadorVendedores.TabIndex = 0;
            // 
            // FrmVendedores
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 23F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoScroll = true;
            this.ClientSize = new System.Drawing.Size(952, 529);
            this.Controls.Add(this.navegadorVendedores);
            this.Font = new System.Drawing.Font("Segoe UI", 10F);
            this.Name = "FrmVendedores";
            this.ShowInTaskbar = false;
            this.Text = "Vendedores";
            this.ResumeLayout(false);

        }

        #endregion

        private CapaVista_Navegador.Navegador navegadorVendedores;
    }
}
