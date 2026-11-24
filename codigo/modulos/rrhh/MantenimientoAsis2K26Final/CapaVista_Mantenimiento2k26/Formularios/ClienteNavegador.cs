using CapaControlador_MantenimientoAsis2k26;
using CapaControlador_MantenimientoAsis2k26.Modelo_De_controladores;
using CapaControlador_Seguridad.Modelos_de_controladores;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CapaVista_Mantenimiento2k26.Formularios
{
    public partial class ClienteNavegador : Form
    {
        ClsModeloCliente datos = new ClsModeloCliente();
        ClsModeloMantenimientoApp datos2 = new ClsModeloMantenimientoApp();
        //subiendo mi navegador para la tabla clientes  
        public ClienteNavegador()
        {
            InitializeComponent();
            Dictionary<string, object> fuentes = new Dictionary<string, object>();
            fuentes.Add("DsCliente", datos.ClienteMetObtenerParaReporte());
            fuentes.Add("RpReporteMantenimientoAplicacion", datos2.SeguridadMetObtenerTodos());
            navegador1.NavegadorMetConfigurar("tbl_Cliente", 9000, 9151, fuentes);
            //Agregando el funcionamiento para mi navegador
        }
    }
}