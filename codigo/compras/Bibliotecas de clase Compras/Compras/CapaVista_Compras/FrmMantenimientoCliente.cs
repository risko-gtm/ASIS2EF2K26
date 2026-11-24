using CapaVista_Componentes.Componentes;
using System;
using System.Windows.Forms;

/*
 * ==================================================================
 * Área : Compras
 * Autor : Pedro José Gómez Villalobos
 * Carné : 0901-23-4868
 * Fecha : 24/11/2026
 * ==================================================================
 * Propósito :
 *  Presenta el mantenimiento de clientes mediante el navegador compartido y administra el desplazamiento del formulario.
 * ===================================================================
*/

namespace CapaVista_Compras
{
    public partial class FrmMantenimientoCliente : Form
    {
        public FrmMantenimientoCliente()
        {
            InitializeComponent();
            ClsPresentacionCompras.ComprasMetFijarTamanoFormulario(this);
            ClsMantenimientoCompras.ComprasProcConfigurar(this, ComprasNavMantenimiento, "tbl_cliente",
                CodigoAplicacion: CapaControlador_Compras.ClsAplicacionesCompras.MantenimientoProveedor);
            
        }
    }
}
