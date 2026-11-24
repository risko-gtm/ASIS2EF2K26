namespace CapaVista_Compras
{
    partial class FrmMantenimientoVendedor
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
            this.ComprasUsrMantenimiento = new CapaVista_Navegador.Navegador();
            this.SuspendLayout();
            // 
            // ComprasUsrMantenimiento
            // 
            this.ComprasUsrMantenimiento.Location = new System.Drawing.Point(31, 34);
            this.ComprasUsrMantenimiento.Name = "ComprasUsrMantenimiento";
            this.ComprasUsrMantenimiento.Size = new System.Drawing.Size(1438, 111);
            this.ComprasUsrMantenimiento.TabIndex = 0;
            // 
            // FrmMantenimientoVendedor
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1586, 450);
            this.Controls.Add(this.ComprasUsrMantenimiento);
            this.Name = "FrmMantenimientoVendedor";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "FrmMantenimientoVendedor";
            this.ResumeLayout(false);

        }

        #endregion

        private CapaVista_Navegador.Navegador ComprasUsrMantenimiento;
    }
}