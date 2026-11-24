namespace CapaVista_Prueba
{
    partial class FrmMDIPrueba
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
            this.menuPrincipal = new System.Windows.Forms.MenuStrip();
            this.menuClientes = new System.Windows.Forms.ToolStripMenuItem();
            this.menuProductos = new System.Windows.Forms.ToolStripMenuItem();
            this.menuVendedores = new System.Windows.Forms.ToolStripMenuItem();
            this.menuVentas = new System.Windows.Forms.ToolStripMenuItem();
            this.menuPrincipal.SuspendLayout();
            this.SuspendLayout();

            this.menuPrincipal.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
                this.menuClientes,
                this.menuProductos,
                this.menuVendedores,
                this.menuVentas });
            this.menuPrincipal.Name = "menuPrincipal";
            this.menuPrincipal.TabIndex = 0;

            this.menuClientes.Name = "menuClientes";
            this.menuClientes.Text = "Clientes";
            this.menuClientes.Click += new System.EventHandler(this.MenuClientes_Click);

            this.menuProductos.Name = "menuProductos";
            this.menuProductos.Text = "Productos";
            this.menuProductos.Click += new System.EventHandler(this.MenuProductos_Click);

            this.menuVendedores.Name = "menuVendedores";
            this.menuVendedores.Text = "Vendedores";
            this.menuVendedores.Click += new System.EventHandler(this.MenuVendedores_Click);

            this.menuVentas.Name = "menuVentas";
            this.menuVentas.Text = "Ventas";
            this.menuVentas.Click += new System.EventHandler(this.MenuVentas_Click);

            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 17F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(960, 560);
            this.Controls.Add(this.menuPrincipal);
            this.Font = new System.Drawing.Font("Segoe UI", 10F);
            this.IsMdiContainer = true;
            this.MainMenuStrip = this.menuPrincipal;
            this.MinimumSize = new System.Drawing.Size(740, 460);
            this.Name = "FrmMDIPrueba";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Variante F - Control de ventas";
            this.MdiChildActivate += new System.EventHandler(this.FrmMDIPrueba_MdiChildActivate);
            this.Shown += new System.EventHandler(this.FrmMDIPrueba_Shown);
            this.menuPrincipal.ResumeLayout(false);
            this.menuPrincipal.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();
        }

        #endregion

        private System.Windows.Forms.MenuStrip menuPrincipal;
        private System.Windows.Forms.ToolStripMenuItem menuClientes;
        private System.Windows.Forms.ToolStripMenuItem menuProductos;
        private System.Windows.Forms.ToolStripMenuItem menuVendedores;
        private System.Windows.Forms.ToolStripMenuItem menuVentas;
    }
}
