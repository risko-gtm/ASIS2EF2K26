namespace CapaVista_Prueba
{
    partial class FrmVentas
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
            this.tlpVentas = new System.Windows.Forms.TableLayoutPanel();
            this.tlpCamposVentas = new System.Windows.Forms.TableLayoutPanel();
            this.lblClienteVenta = new System.Windows.Forms.Label();
            this.cboClienteVenta = new System.Windows.Forms.ComboBox();
            this.lblProductoVenta = new System.Windows.Forms.Label();
            this.cboProductoVenta = new System.Windows.Forms.ComboBox();
            this.lblVendedorVenta = new System.Windows.Forms.Label();
            this.cboVendedorVenta = new System.Windows.Forms.ComboBox();
            this.lblCantidadVenta = new System.Windows.Forms.Label();
            this.txtCantidadVenta = new System.Windows.Forms.TextBox();
            this.flpAccionesVentas = new System.Windows.Forms.FlowLayoutPanel();
            this.btnNuevaVenta = new System.Windows.Forms.Button();
            this.btnGuardarVenta = new System.Windows.Forms.Button();
            this.btnEliminarVenta = new System.Windows.Forms.Button();
            this.btnActualizarVentas = new System.Windows.Forms.Button();
            this.btnReporteVentas = new System.Windows.Forms.Button();
            this.btnAyudaVentas = new System.Windows.Forms.Button();
            this.dgvVentas = new System.Windows.Forms.DataGridView();
            this.lblEstadoVentas = new System.Windows.Forms.Label();
            this.tlpVentas.SuspendLayout();
            this.tlpCamposVentas.SuspendLayout();
            this.flpAccionesVentas.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvVentas)).BeginInit();
            this.SuspendLayout();
            // 
            // tlpVentas
            // 
            this.tlpVentas.ColumnCount = 1;
            this.tlpVentas.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tlpVentas.Controls.Add(this.tlpCamposVentas, 0, 0);
            this.tlpVentas.Controls.Add(this.flpAccionesVentas, 0, 1);
            this.tlpVentas.Controls.Add(this.dgvVentas, 0, 2);
            this.tlpVentas.Controls.Add(this.lblEstadoVentas, 0, 3);
            this.tlpVentas.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tlpVentas.Location = new System.Drawing.Point(12, 12);
            this.tlpVentas.Name = "tlpVentas";
            this.tlpVentas.RowCount = 4;
            this.tlpVentas.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this.tlpVentas.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this.tlpVentas.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tlpVentas.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this.tlpVentas.Size = new System.Drawing.Size(928, 505);
            this.tlpVentas.TabIndex = 0;
            // 
            // tlpCamposVentas
            // 
            this.tlpCamposVentas.AutoSize = true;
            this.tlpCamposVentas.ColumnCount = 2;
            this.tlpCamposVentas.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle());
            this.tlpCamposVentas.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tlpCamposVentas.Controls.Add(this.lblClienteVenta, 0, 0);
            this.tlpCamposVentas.Controls.Add(this.cboClienteVenta, 1, 0);
            this.tlpCamposVentas.Controls.Add(this.lblProductoVenta, 0, 1);
            this.tlpCamposVentas.Controls.Add(this.cboProductoVenta, 1, 1);
            this.tlpCamposVentas.Controls.Add(this.lblVendedorVenta, 0, 2);
            this.tlpCamposVentas.Controls.Add(this.cboVendedorVenta, 1, 2);
            this.tlpCamposVentas.Controls.Add(this.lblCantidadVenta, 0, 3);
            this.tlpCamposVentas.Controls.Add(this.txtCantidadVenta, 1, 3);
            this.tlpCamposVentas.Dock = System.Windows.Forms.DockStyle.Top;
            this.tlpCamposVentas.Location = new System.Drawing.Point(3, 3);
            this.tlpCamposVentas.Name = "tlpCamposVentas";
            this.tlpCamposVentas.RowCount = 4;
            this.tlpCamposVentas.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this.tlpCamposVentas.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this.tlpCamposVentas.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this.tlpCamposVentas.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this.tlpCamposVentas.Size = new System.Drawing.Size(922, 126);
            this.tlpCamposVentas.TabIndex = 0;
            // 
            // lblClienteVenta
            // 
            this.lblClienteVenta.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.lblClienteVenta.AutoSize = true;
            this.lblClienteVenta.Location = new System.Drawing.Point(3, 3);
            this.lblClienteVenta.Name = "lblClienteVenta";
            this.lblClienteVenta.Size = new System.Drawing.Size(63, 23);
            this.lblClienteVenta.TabIndex = 0;
            this.lblClienteVenta.Text = "Cliente";
            // 
            // cboClienteVenta
            // 
            this.cboClienteVenta.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.cboClienteVenta.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
            this.cboClienteVenta.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cboClienteVenta.DisplayMember = "Nombre";
            this.cboClienteVenta.FormattingEnabled = true;
            this.cboClienteVenta.Location = new System.Drawing.Point(93, 3);
            this.cboClienteVenta.Name = "cboClienteVenta";
            this.cboClienteVenta.Size = new System.Drawing.Size(340, 31);
            this.cboClienteVenta.TabIndex = 1;
            this.cboClienteVenta.ValueMember = "Id";
            // 
            // lblProductoVenta
            // 
            this.lblProductoVenta.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.lblProductoVenta.AutoSize = true;
            this.lblProductoVenta.Location = new System.Drawing.Point(3, 33);
            this.lblProductoVenta.Name = "lblProductoVenta";
            this.lblProductoVenta.Size = new System.Drawing.Size(80, 23);
            this.lblProductoVenta.TabIndex = 2;
            this.lblProductoVenta.Text = "Producto";
            // 
            // cboProductoVenta
            // 
            this.cboProductoVenta.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.cboProductoVenta.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
            this.cboProductoVenta.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cboProductoVenta.DisplayMember = "Nombre";
            this.cboProductoVenta.FormattingEnabled = true;
            this.cboProductoVenta.Location = new System.Drawing.Point(93, 33);
            this.cboProductoVenta.Name = "cboProductoVenta";
            this.cboProductoVenta.Size = new System.Drawing.Size(340, 31);
            this.cboProductoVenta.TabIndex = 3;
            this.cboProductoVenta.ValueMember = "Id";
            // 
            // lblVendedorVenta
            // 
            this.lblVendedorVenta.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.lblVendedorVenta.AutoSize = true;
            this.lblVendedorVenta.Location = new System.Drawing.Point(3, 63);
            this.lblVendedorVenta.Name = "lblVendedorVenta";
            this.lblVendedorVenta.Size = new System.Drawing.Size(84, 23);
            this.lblVendedorVenta.TabIndex = 4;
            this.lblVendedorVenta.Text = "Vendedor";
            // 
            // cboVendedorVenta
            // 
            this.cboVendedorVenta.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.cboVendedorVenta.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
            this.cboVendedorVenta.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cboVendedorVenta.DisplayMember = "Nombre";
            this.cboVendedorVenta.FormattingEnabled = true;
            this.cboVendedorVenta.Location = new System.Drawing.Point(93, 63);
            this.cboVendedorVenta.Name = "cboVendedorVenta";
            this.cboVendedorVenta.Size = new System.Drawing.Size(340, 31);
            this.cboVendedorVenta.TabIndex = 5;
            this.cboVendedorVenta.ValueMember = "Id";
            // 
            // lblCantidadVenta
            // 
            this.lblCantidadVenta.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.lblCantidadVenta.AutoSize = true;
            this.lblCantidadVenta.Location = new System.Drawing.Point(3, 96);
            this.lblCantidadVenta.Name = "lblCantidadVenta";
            this.lblCantidadVenta.Size = new System.Drawing.Size(79, 23);
            this.lblCantidadVenta.TabIndex = 6;
            this.lblCantidadVenta.Text = "Cantidad";
            // 
            // txtCantidadVenta
            // 
            this.txtCantidadVenta.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.txtCantidadVenta.Location = new System.Drawing.Point(93, 93);
            this.txtCantidadVenta.Name = "txtCantidadVenta";
            this.txtCantidadVenta.Size = new System.Drawing.Size(150, 30);
            this.txtCantidadVenta.TabIndex = 7;
            this.txtCantidadVenta.Text = "1";
            // 
            // flpAccionesVentas
            // 
            this.flpAccionesVentas.AutoSize = true;
            this.flpAccionesVentas.Controls.Add(this.btnNuevaVenta);
            this.flpAccionesVentas.Controls.Add(this.btnGuardarVenta);
            this.flpAccionesVentas.Controls.Add(this.btnEliminarVenta);
            this.flpAccionesVentas.Controls.Add(this.btnActualizarVentas);
            this.flpAccionesVentas.Controls.Add(this.btnReporteVentas);
            this.flpAccionesVentas.Controls.Add(this.btnAyudaVentas);
            this.flpAccionesVentas.Dock = System.Windows.Forms.DockStyle.Fill;
            this.flpAccionesVentas.Location = new System.Drawing.Point(3, 135);
            this.flpAccionesVentas.Name = "flpAccionesVentas";
            this.flpAccionesVentas.Size = new System.Drawing.Size(922, 39);
            this.flpAccionesVentas.TabIndex = 1;
            this.flpAccionesVentas.WrapContents = false;
            // 
            // btnNuevaVenta
            // 
            this.btnNuevaVenta.AutoSize = true;
            this.btnNuevaVenta.Location = new System.Drawing.Point(3, 3);
            this.btnNuevaVenta.MinimumSize = new System.Drawing.Size(100, 32);
            this.btnNuevaVenta.Name = "btnNuevaVenta";
            this.btnNuevaVenta.Size = new System.Drawing.Size(100, 33);
            this.btnNuevaVenta.TabIndex = 0;
            this.btnNuevaVenta.Text = "Nuevo";
            this.btnNuevaVenta.UseVisualStyleBackColor = true;
            // 
            // btnGuardarVenta
            // 
            this.btnGuardarVenta.AutoSize = true;
            this.btnGuardarVenta.Enabled = false;
            this.btnGuardarVenta.Location = new System.Drawing.Point(109, 3);
            this.btnGuardarVenta.MinimumSize = new System.Drawing.Size(100, 32);
            this.btnGuardarVenta.Name = "btnGuardarVenta";
            this.btnGuardarVenta.Size = new System.Drawing.Size(100, 33);
            this.btnGuardarVenta.TabIndex = 1;
            this.btnGuardarVenta.Text = "Guardar";
            this.btnGuardarVenta.UseVisualStyleBackColor = true;
            // 
            // btnEliminarVenta
            // 
            this.btnEliminarVenta.AutoSize = true;
            this.btnEliminarVenta.Enabled = false;
            this.btnEliminarVenta.Location = new System.Drawing.Point(215, 3);
            this.btnEliminarVenta.MinimumSize = new System.Drawing.Size(100, 32);
            this.btnEliminarVenta.Name = "btnEliminarVenta";
            this.btnEliminarVenta.Size = new System.Drawing.Size(100, 33);
            this.btnEliminarVenta.TabIndex = 2;
            this.btnEliminarVenta.Text = "Eliminar";
            this.btnEliminarVenta.UseVisualStyleBackColor = true;
            // 
            // btnActualizarVentas
            // 
            this.btnActualizarVentas.AutoSize = true;
            this.btnActualizarVentas.Location = new System.Drawing.Point(321, 3);
            this.btnActualizarVentas.MinimumSize = new System.Drawing.Size(100, 32);
            this.btnActualizarVentas.Name = "btnActualizarVentas";
            this.btnActualizarVentas.Size = new System.Drawing.Size(100, 33);
            this.btnActualizarVentas.TabIndex = 3;
            this.btnActualizarVentas.Text = "Actualizar";
            this.btnActualizarVentas.UseVisualStyleBackColor = true;
            // 
            // btnReporteVentas
            // 
            this.btnReporteVentas.AutoSize = true;
            this.btnReporteVentas.Location = new System.Drawing.Point(427, 3);
            this.btnReporteVentas.MinimumSize = new System.Drawing.Size(100, 32);
            this.btnReporteVentas.Name = "btnReporteVentas";
            this.btnReporteVentas.Size = new System.Drawing.Size(106, 33);
            this.btnReporteVentas.TabIndex = 4;
            this.btnReporteVentas.Text = "Ver reporte";
            this.btnReporteVentas.UseVisualStyleBackColor = true;
            this.btnReporteVentas.Click += new System.EventHandler(this.BtnReporteVentas_Click);
            // 
            // btnAyudaVentas
            // 
            this.btnAyudaVentas.AutoSize = true;
            this.btnAyudaVentas.Location = new System.Drawing.Point(539, 3);
            this.btnAyudaVentas.MinimumSize = new System.Drawing.Size(100, 32);
            this.btnAyudaVentas.Name = "btnAyudaVentas";
            this.btnAyudaVentas.Size = new System.Drawing.Size(100, 33);
            this.btnAyudaVentas.TabIndex = 5;
            this.btnAyudaVentas.Text = "Ver ayuda";
            this.btnAyudaVentas.UseVisualStyleBackColor = true;
            this.btnAyudaVentas.Click += new System.EventHandler(this.BtnAyudaVentas_Click);
            // 
            // dgvVentas
            // 
            this.dgvVentas.AllowUserToAddRows = false;
            this.dgvVentas.AllowUserToDeleteRows = false;
            this.dgvVentas.BackgroundColor = System.Drawing.SystemColors.Window;
            this.dgvVentas.ColumnHeadersHeight = 29;
            this.dgvVentas.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvVentas.Location = new System.Drawing.Point(3, 180);
            this.dgvVentas.MultiSelect = false;
            this.dgvVentas.Name = "dgvVentas";
            this.dgvVentas.ReadOnly = true;
            this.dgvVentas.RowHeadersVisible = false;
            this.dgvVentas.RowHeadersWidth = 51;
            this.dgvVentas.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvVentas.Size = new System.Drawing.Size(922, 299);
            this.dgvVentas.TabIndex = 2;
            // 
            // lblEstadoVentas
            // 
            this.lblEstadoVentas.AutoSize = true;
            this.lblEstadoVentas.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lblEstadoVentas.Location = new System.Drawing.Point(3, 482);
            this.lblEstadoVentas.Name = "lblEstadoVentas";
            this.lblEstadoVentas.Size = new System.Drawing.Size(922, 23);
            this.lblEstadoVentas.TabIndex = 3;
            // 
            // FrmVentas
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 23F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(952, 529);
            this.Controls.Add(this.tlpVentas);
            this.Font = new System.Drawing.Font("Segoe UI", 10F);
            this.Name = "FrmVentas";
            this.Padding = new System.Windows.Forms.Padding(12);
            this.ShowInTaskbar = false;
            this.Text = "Ventas";
            this.Activated += new System.EventHandler(this.FrmVentas_Activated);
            this.tlpVentas.ResumeLayout(false);
            this.tlpVentas.PerformLayout();
            this.tlpCamposVentas.ResumeLayout(false);
            this.tlpCamposVentas.PerformLayout();
            this.flpAccionesVentas.ResumeLayout(false);
            this.flpAccionesVentas.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvVentas)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TableLayoutPanel tlpVentas;
        private System.Windows.Forms.TableLayoutPanel tlpCamposVentas;
        private System.Windows.Forms.FlowLayoutPanel flpAccionesVentas;
        private System.Windows.Forms.DataGridView dgvVentas;
        private System.Windows.Forms.Label lblEstadoVentas;
        private System.Windows.Forms.DataGridViewTextBoxColumn colIdVenta;
        private System.Windows.Forms.DataGridViewTextBoxColumn colFechaVenta;
        private System.Windows.Forms.DataGridViewTextBoxColumn colClienteVenta;
        private System.Windows.Forms.DataGridViewTextBoxColumn colProductoVenta;
        private System.Windows.Forms.DataGridViewTextBoxColumn colVendedorVenta;
        private System.Windows.Forms.DataGridViewTextBoxColumn colCantidadVenta;
        private System.Windows.Forms.DataGridViewTextBoxColumn colPrecioUnitarioVenta;
        private System.Windows.Forms.DataGridViewTextBoxColumn colTotalVenta;
        private System.Windows.Forms.Label lblClienteVenta;
        private System.Windows.Forms.ComboBox cboClienteVenta;
        private System.Windows.Forms.Label lblProductoVenta;
        private System.Windows.Forms.ComboBox cboProductoVenta;
        private System.Windows.Forms.Label lblVendedorVenta;
        private System.Windows.Forms.ComboBox cboVendedorVenta;
        private System.Windows.Forms.Label lblCantidadVenta;
        private System.Windows.Forms.TextBox txtCantidadVenta;
        private System.Windows.Forms.Button btnNuevaVenta;
        private System.Windows.Forms.Button btnGuardarVenta;
        private System.Windows.Forms.Button btnEliminarVenta;
        private System.Windows.Forms.Button btnActualizarVentas;
        private System.Windows.Forms.Button btnReporteVentas;
        private System.Windows.Forms.Button btnAyudaVentas;
    }
}
