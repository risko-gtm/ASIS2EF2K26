using CapaControlador_MantenimientoAsis2k26;
using CapaControlador_MantenimientoAsis2k26.Modelo_De_controladores;
using CapaControlador_Seguridad;
using CapaControlador_Seguridad.Modelos_de_controladores;
using CapaVista_Navegador;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CapaVista_Mantenimiento2k26.Formularios
{
    public partial class PacienteNavegador : Form
    {
        ClsModeloPaciente datos = new ClsModeloPaciente();
        ClsModeloMantenimientoApp datos2 = new ClsModeloMantenimientoApp();

        public PacienteNavegador()
        {
            InitializeComponent();
            Dictionary<string, object> fuentes = new Dictionary<string, object>();
            fuentes.Add("DsPaciente", datos.PacienteMetObtenerParaReporte());
            fuentes.Add("RpReporteMantenimientoAplicacion", datos2.SeguridadMetObtenerTodos());
            navegador1.NavegadorMetConfigurar("tbl_paciente", 9000, 9150, fuentes);
        }


    }
}