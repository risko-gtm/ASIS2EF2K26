using CapaVista_Componentes.Componentes;
using System;
using System.Windows.Forms;

/*
 * ==================================================================
 * Área : Compras
 * Autor : Diego Fernando Santizo Samayoa
 * Carné : 0901-22-15950
 * Fecha : 24/10/2026
 * ==================================================================
 * Propósito :
 *  Presenta el mantenimiento de proveedores mediante el navegador compartido y administra el desplazamiento del formulario.
 * ===================================================================
*/

namespace CapaVista_Compras
{
    public partial class FrmMantenimientoProveedor : Form
    {
        public FrmMantenimientoProveedor()
        {
            InitializeComponent();
            ClsPresentacionCompras.ComprasMetFijarTamanoFormulario(this);
            ClsMantenimientoCompras.ComprasProcConfigurar(this, ComprasNavMantenimiento, "tbl_paciente",
                CodigoAplicacion: CapaControlador_Compras.ClsAplicacionesCompras.MantenimientoProveedor);
            
        }

        private void ComprasNavMantenimiento_Load(object sender, EventArgs e)
        {

        }
    }
}
