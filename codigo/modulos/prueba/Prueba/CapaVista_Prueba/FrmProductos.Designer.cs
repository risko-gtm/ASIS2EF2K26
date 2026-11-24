namespace CapaVista_Prueba
{
    partial class FrmProductos
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
            this.navegadorProductos = new CapaVista_Navegador.Navegador();
            this.SuspendLayout();

            this.navegadorProductos.Location = new System.Drawing.Point(12, 12);
            this.navegadorProductos.Name = "navegadorProductos";
            this.navegadorProductos.Size = new System.Drawing.Size(1438, 111);
            this.navegadorProductos.TabIndex = 0;

            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 17F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoScroll = true;
            this.ClientSize = new System.Drawing.Size(952, 529);
            this.Controls.Add(this.navegadorProductos);
            this.Font = new System.Drawing.Font("Segoe UI", 10F);
            this.Name = "FrmProductos";
            this.ShowInTaskbar = false;
            this.Text = "Productos";
            this.ResumeLayout(false);
        }

        #endregion

        private CapaVista_Navegador.Navegador navegadorProductos;
    }
}
