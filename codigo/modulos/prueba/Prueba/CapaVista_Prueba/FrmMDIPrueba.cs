using System;
using System.Linq;
using System.Windows.Forms;

namespace CapaVista_Prueba
{
    public sealed partial class FrmMDIPrueba : Form
    {
        public FrmMDIPrueba()
        {
            InitializeComponent();
        }

        private void FrmMDIPrueba_Shown(object sender, EventArgs e)
        {
            MostrarFormulario<FrmClientes>();
        }

        private void MenuClientes_Click(object sender, EventArgs e)
        {
            MostrarFormulario<FrmClientes>();
        }

        private void MenuProductos_Click(object sender, EventArgs e)
        {
            MostrarFormulario<FrmProductos>();
        }

        private void MenuVendedores_Click(object sender, EventArgs e)
        {
            MostrarFormulario<FrmVendedores>();
        }

        private void MenuVentas_Click(object sender, EventArgs e)
        {
            MostrarFormulario<FrmVentas>();
        }

        private void FrmMDIPrueba_MdiChildActivate(object sender, EventArgs e)
        {
            Form activo = ActiveMdiChild;
            menuClientes.Checked = activo is FrmClientes;
            menuProductos.Checked = activo is FrmProductos;
            menuVendedores.Checked = activo is FrmVendedores;
            menuVentas.Checked = activo is FrmVentas;
        }

        private void MostrarFormulario<T>() where T : Form, new()
        {
            T formulario = MdiChildren.OfType<T>().FirstOrDefault();
            if (formulario == null)
            {
                formulario = new T { MdiParent = this, WindowState = FormWindowState.Maximized };
                formulario.Show();
                return;
            }

            formulario.WindowState = FormWindowState.Maximized;
            formulario.Activate();
        }
    }
}
