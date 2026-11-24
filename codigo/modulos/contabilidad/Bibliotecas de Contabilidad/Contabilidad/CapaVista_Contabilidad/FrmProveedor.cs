using CapaControlador_Contabilidad;
using CapaVista_Contabilidad;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CapaVista_Contabilidad
{
    public partial class FrmProveedor : Form
    {

        public FrmProveedor() : this(ClsModeloPermisosPantallaContabilidad.Total)
        {

        }
        public FrmProveedor(ClsModeloPermisosPantallaContabilidad Permisos)

        {
            InitializeComponent();
            ClsPresentacionContabilidad.ContabilidadMetPrepararVentana(this, "Mantenimiento de Proveedor", new Size(1180, 688));

        }
    }
}
