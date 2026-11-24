using System.Collections.Generic;
using System.Drawing;
using System.Windows.Forms;
using CapaControlador_Contabilidad;

namespace CapaVista_Contabilidad
{
    public partial class FrmMantenimientoCliente : Form
    {
        public FrmMantenimientoCliente() : this(ClsModeloPermisosPantallaContabilidad.Total)
        {
        }

        public FrmMantenimientoCliente(ClsModeloPermisosPantallaContabilidad Permisos)
        {
            InitializeComponent();
            ClsPresentacionContabilidad.ContabilidadMetPrepararVentana(this, "Mantenimiento de clientes", new Size(1180, 688));
            Dictionary<string, object> Fuentes = new Dictionary<string, object>();
            Fuentes.Add("DataSetClientes", new ClsControladorClientesContabilidad().ContabilidadFuncObtenerClientes());
            ContabilidadNavCliente.NavegadorMetConfigurar("tbl_cliente", Permisos.IdModulo, Permisos.IdAplicacion, Fuentes);
            ClsPresentacionContabilidad.ContabilidadMetAjustarCamposNavegador(ContabilidadNavCliente);
        }
    }
}
