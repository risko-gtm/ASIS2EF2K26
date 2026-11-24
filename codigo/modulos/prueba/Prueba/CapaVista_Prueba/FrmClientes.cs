using System.Windows.Forms;

namespace CapaVista_Prueba
{
    public sealed partial class FrmClientes : Form
    {
        public FrmClientes()
        {
            InitializeComponent();
            navegadorClientes.NavegadorMetConfigurar("finalf_cliente", 7200, 7201, null, "Clientes",
                () => typeof(FrmClientes).Assembly.GetManifestResourceStream(
                    "CapaVista_Prueba.Reportes.Clientes.rdlc"));
        }
    }
}
