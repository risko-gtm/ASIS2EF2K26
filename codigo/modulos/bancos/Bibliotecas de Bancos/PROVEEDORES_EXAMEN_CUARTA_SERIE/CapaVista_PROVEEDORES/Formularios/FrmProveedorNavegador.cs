using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using CapaControlador_PROVEEDORES.Modelo_de_controladores;

namespace CapaVista_PROVEEDORES.Formularios
{
    public partial class FrmProveedorNavegador : Form
    {
        ClsModeloProveedor datos = new ClsModeloProveedor();
        public FrmProveedorNavegador()
        {
            InitializeComponent();
            Dictionary<string, object> fuentes = new Dictionary<string, object>();
            fuentes.Add("DsReporteProveedores", datos.BancosMetObtenerTodos());
            fuentes.Add("RpReporteProveedores", datos.BancosMetObtenerTodos());
            BancosProveedores.NavegadorMetConfigurar("tbl_proveedor", 8000, 8015, fuentes);
        }
    }
}
