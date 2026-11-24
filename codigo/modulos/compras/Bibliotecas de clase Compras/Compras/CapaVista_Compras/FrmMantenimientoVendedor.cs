using CapaVista_Componentes.Componentes;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CapaVista_Compras
{
    public partial class FrmMantenimientoVendedor : Form
    {
        public FrmMantenimientoVendedor()
        {
            InitializeComponent();
            ClsPresentacionCompras.ComprasMetFijarTamanoFormulario(this);
            ClsMantenimientoCompras.ComprasProcConfigurar(this, ComprasUsrMantenimiento, "tbl_vendedor",
                CodigoAplicacion: CapaControlador_Compras.ClsAplicacionesCompras.MantenimientoConceptoProveedor,
                DatasetReporte: "RpReporteConceptosProveedor",
                ArchivoReporte: "RpPruebaMantenimientoConceptosProveedor.rdlc");
        }
    }
}
