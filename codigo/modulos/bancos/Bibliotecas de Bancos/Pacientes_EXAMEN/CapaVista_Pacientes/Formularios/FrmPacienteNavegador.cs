using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using CapaControlador_Pacientes.Modelo_de_Controladores;

namespace CapaVista_Pacientes.Formularios
{
    public partial class FrmPacienteNavegador : Form
    {
        ClsModeloPaciente datos = new ClsModeloPaciente();
        public FrmPacienteNavegador()
        {
            InitializeComponent();
            Dictionary<string, object> fuentes = new Dictionary<string, object>();
            fuentes.Add("DsReportePaciente", datos.BancosMetObtenerTodos());
            fuentes.Add("RpReportePacientes", datos.BancosMetObtenerTodos());
            // Inicio de cambio - Andy Garcia - 9959-23-1494 - 24/11/2026
            // Codigo de aplicacion propio: 8114 (modulo Bancos 8000)
            BancosPacientes.NavegadorMetConfigurar("tbl_paciente", 8000, 8114, fuentes);
            // Fin de cambio
        }
    }
}
