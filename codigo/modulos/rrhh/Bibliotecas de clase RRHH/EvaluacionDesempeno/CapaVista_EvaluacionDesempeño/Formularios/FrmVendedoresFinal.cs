using CapaVista_Navegador;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CapaVista_EvaluacionDesempeño.Formularios
{
    public partial class FrmVendedoresFinal : Form
    {
        private const int ID_MODULO = 9000;
        private const int ID_APLICACION = 9801;
        public FrmVendedoresFinal()
        {
            InitializeComponent();

            if (LicenseManager.UsageMode == LicenseUsageMode.Designtime)
                return;


            RrhhVendedorNavegador.NavegadorMetConfigurar("tbl_Vendedor", ID_MODULO, ID_APLICACION);
        }
    }
}
