/*
 * ==================================================================
 * Área : Contabilidad
 * Autor : Oskar Cermeño
 * Carné : 0901-23-15379
 * Fecha : 24/11/2026
 * ==================================================================
 * Propósito :
 *  Diseño de la ventana FrmMantenimientoPaciente: solo contiene el control Navegador.
 * ===================================================================
*/

namespace CapaVista_Contabilidad
{
    partial class FrmMantenimientoPaciente
    {
        private System.ComponentModel.IContainer components = null;

        protected override void Dispose(bool Disposing)
        {
            if (Disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(Disposing);
        }

        #region Windows Form Designer generated code

        private void InitializeComponent()
        {
            this.ContabilidadNavPaciente = new CapaVista_Navegador.Navegador();
            this.SuspendLayout();
            this.ContabilidadNavPaciente.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
            | System.Windows.Forms.AnchorStyles.Right)));
            this.ContabilidadNavPaciente.Location = new System.Drawing.Point(11, 11);
            this.ContabilidadNavPaciente.Margin = new System.Windows.Forms.Padding(2);
            this.ContabilidadNavPaciente.Name = "ContabilidadNavPaciente";
            this.ContabilidadNavPaciente.Size = new System.Drawing.Size(1158, 90);
            this.ContabilidadNavPaciente.TabIndex = 0;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1180, 688);
            this.Controls.Add(this.ContabilidadNavPaciente);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = global::CapaVista_Contabilidad.Properties.Resources.Icono_Contabilidad;
            this.MaximizeBox = false;
            this.Name = "FrmMantenimientoPaciente";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "10016 - MantenimientoPaciente";
            this.ResumeLayout(false);

        }

        #endregion

        private CapaVista_Navegador.Navegador ContabilidadNavPaciente;
    }
}
