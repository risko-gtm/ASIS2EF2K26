namespace CapaVista_Prueba
{
    partial class FrmClientes
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
            this.navegadorClientes = new CapaVista_Navegador.Navegador();
            this.SuspendLayout();

            this.navegadorClientes.Location = new System.Drawing.Point(12, 12);
            this.navegadorClientes.Name = "navegadorClientes";
            this.navegadorClientes.Size = new System.Drawing.Size(1438, 111);
            this.navegadorClientes.TabIndex = 0;

            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 17F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoScroll = true;
            this.ClientSize = new System.Drawing.Size(952, 529);
            this.Controls.Add(this.navegadorClientes);
            this.Font = new System.Drawing.Font("Segoe UI", 10F);
            this.Name = "FrmClientes";
            this.ShowInTaskbar = false;
            this.Text = "Clientes";
            this.ResumeLayout(false);
        }

        #endregion

        private CapaVista_Navegador.Navegador navegadorClientes;
    }
}
