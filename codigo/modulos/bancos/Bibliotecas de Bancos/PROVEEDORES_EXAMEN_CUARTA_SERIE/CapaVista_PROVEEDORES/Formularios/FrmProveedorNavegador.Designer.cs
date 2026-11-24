namespace CapaVista_PROVEEDORES.Formularios
{
    partial class FrmProveedorNavegador
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
            this.BancosProveedores = new CapaVista_Navegador.Navegador();
            this.SuspendLayout();
            // 
            // BancosProveedores
            // 
            this.BancosProveedores.Location = new System.Drawing.Point(12, 12);
            this.BancosProveedores.Name = "BancosProveedores";
            this.BancosProveedores.Size = new System.Drawing.Size(1438, 111);
            this.BancosProveedores.TabIndex = 0;
            // 
            // FrmProveedorNavegador
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1461, 450);
            this.Controls.Add(this.BancosProveedores);
            this.Name = "FrmProveedorNavegador";
            this.Text = "FrmProveedorNavegador";
            this.ResumeLayout(false);

        }

        #endregion

        private CapaVista_Navegador.Navegador BancosProveedores;
    }
}