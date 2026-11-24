using System.Windows.Forms;

namespace CapaVista_Prueba
{
    public sealed partial class FrmVendedores : Form
    {
        public FrmVendedores()
        {
            InitializeComponent();
            navegadorVendedores.NavegadorMetConfigurar("finalf_vendedor", 7200, 7203, null, "Vendedores",
                () => typeof(FrmVendedores).Assembly.GetManifestResourceStream(
                    "CapaVista_Prueba.Reportes.Vendedores.rdlc"));
        }
    }
}
