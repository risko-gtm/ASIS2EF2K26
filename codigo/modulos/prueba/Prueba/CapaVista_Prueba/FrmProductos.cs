using System.Windows.Forms;

namespace CapaVista_Prueba
{
    public sealed partial class FrmProductos : Form
    {
        public FrmProductos()
        {
            InitializeComponent();
            navegadorProductos.NavegadorMetConfigurar("finalf_producto", 7200, 7202, null, "Productos",
                () => typeof(FrmProductos).Assembly.GetManifestResourceStream(
                    "CapaVista_Prueba.Reportes.Productos.rdlc"));
        }
    }
}
