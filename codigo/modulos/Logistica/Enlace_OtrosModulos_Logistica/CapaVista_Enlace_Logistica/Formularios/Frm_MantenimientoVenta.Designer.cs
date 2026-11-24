namespace CapaVista_Enlace_Logistica.Formularios
{
    partial class Frm_MantenimientoVenta
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
            this.LogisticaNavVendedor = new CapaVista_Navegador.Navegador();
            this.SuspendLayout();
            // 
            // LogisticaNavVendedor
            // 
            this.LogisticaNavVendedor.Location = new System.Drawing.Point(12, 12);
            this.LogisticaNavVendedor.Name = "LogisticaNavVendedor";
            this.LogisticaNavVendedor.Size = new System.Drawing.Size(1438, 111);
            this.LogisticaNavVendedor.TabIndex = 0;
            // 
            // Frm_MantenimientoVenta
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1533, 450);
            this.Controls.Add(this.LogisticaNavVendedor);
            this.Name = "Frm_MantenimientoVenta";
            this.Text = "Frm_MantenimientoVenta";
            this.ResumeLayout(false);

        }

        #endregion

        private CapaVista_Navegador.Navegador LogisticaNavVendedor;
    }
}