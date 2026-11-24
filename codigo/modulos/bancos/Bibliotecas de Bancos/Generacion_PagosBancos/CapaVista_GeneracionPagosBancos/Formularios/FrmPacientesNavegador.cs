/*
 * ================================================================
 * Área   : Bancos
 * Autor  : Evelyn Sofía Andrade Luna
 * Carné  : 9959-23-1224
 * Fecha  : 24/11/2026
 * ================================================================
 * Propósito :
 *  Formulario navegador del mantenimiento Pacientes. Inicializa el
 *  control de navegación apuntando a la tabla tbl_paciente, dentro
 *  del módulo Bancos (8000), aplicación 8010, y le entrega los datos
 *  del reporte de pacientes para el botón Imprimir.
 * ================================================================
 */

using System;
using System.Collections.Generic;
using System.Data;
using System.Windows.Forms;
using CapaControlador_GeneracionPagos;

namespace CapaVista_GeneracionPagos.Formularios
{
    public partial class FrmPacientesNavegador : Form
    {
        private readonly ClsControladorGeneracionPagos _Controlador = new ClsControladorGeneracionPagos();
        private readonly DataTable _Pacientes = new DataTable();

        public FrmPacientesNavegador()
        {
            InitializeComponent();
        }

        private void BancosNavPacientes_Load(object sender, EventArgs e)
        {
            BancosMetCargarPacientes();

            Dictionary<string, object> Fuentes = new Dictionary<string, object>();
            Fuentes.Add("DsPacientes", _Pacientes);

            BancosNavPacientes.NavegadorAccionSolicitada += BancosNavPacientes_AccionSolicitada;
            BancosNavPacientes.NavegadorMetConfigurar("tbl_paciente", 8000, 8010, Fuentes);
        }

        private void BancosNavPacientes_AccionSolicitada(string Accion)
        {
            if (Accion == "IMPRIMIR")
            {
                BancosMetCargarPacientes();
            }
        }

        private void BancosMetCargarPacientes()
        {
            string Error = _Controlador.BancosMetConsultarReportePacientes(out DataTable Resultado);
            if (!string.IsNullOrEmpty(Error))
            {
                MessageBox.Show(Error, "No fue posible cargar el reporte", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            _Pacientes.Clear();
            _Pacientes.Merge(Resultado);
        }
    }
}
