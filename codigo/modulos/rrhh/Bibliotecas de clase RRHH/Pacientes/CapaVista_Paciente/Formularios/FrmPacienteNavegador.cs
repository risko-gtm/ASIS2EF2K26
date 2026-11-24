/*
 * ==================================================================
 * Área : Recursos Humanos - Examen Final
 * Autor : Byron Alexander Chiquito Paredes
 * Carné : 0901-23-3747
 * Fecha : 24/11/2026
 * ==================================================================
 * Propósito :
 *  Formulario 9007 - Pacientes. Mantenimiento de tbl_paciente con el
 *  Navegador.
 * ===================================================================
*/

using System.Windows.Forms;

namespace CapaVista_Paciente.Formularios
{
    public partial class FrmPacienteNavegador : Form
    {
        public FrmPacienteNavegador()
        {
            InitializeComponent();
            RrhhNavPaciente.NavegadorMetConfigurar("tbl_paciente", 9000, 9007);
        }
    }
}
