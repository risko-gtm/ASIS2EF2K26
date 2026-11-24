/*
 * ==================================================================
 * Área : Contabilidad
 * Autor : Oskar Cermeño
 * Carné : 0901-23-15379
 * Fecha : 24/11/2026
 * ==================================================================
 * Propósito :
 *  Mantenimiento de pacientes (tbl_paciente) con el Navegador.
 * Reglas especificas:
 *  Antes de imprimir se llena la tabla DsPacientes del reporte.
 * ===================================================================
*/

using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using CapaControlador_Contabilidad;

namespace CapaVista_Contabilidad
{
    public partial class FrmMantenimientoPaciente : Form
    {
        ClsControladorPacientesContabilidad Controlador = new ClsControladorPacientesContabilidad();
        DataTable TablaReporte = new DataTable("DsPacientes");

        public FrmMantenimientoPaciente(ClsModeloPermisosPantallaContabilidad Permisos)
        {
            InitializeComponent();
            ClsPresentacionContabilidad.ContabilidadMetPrepararVentana(this, "Mantenimiento de pacientes", new Size(1180, 688));

            Dictionary<string, object> Fuentes = new Dictionary<string, object>();
            Fuentes.Add("DsPacientes", TablaReporte);
            ContabilidadNavPaciente.NavegadorMetConfigurar("tbl_paciente", Permisos.IdModulo, Permisos.IdAplicacion, Fuentes);
            ContabilidadNavPaciente.NavegadorAccionSolicitada += ContabilidadMetAccionNavegador;
            ClsPresentacionContabilidad.ContabilidadMetAjustarCamposNavegador(ContabilidadNavPaciente);
        }

        private void ContabilidadMetAccionNavegador(string Accion)
        {
            if (Accion == "IMPRIMIR")
            {
                try
                {
                    Controlador.ContabilidadMetLlenarReporte(TablaReporte);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error al cargar el reporte: " + ex.Message);
                }
            }
        }
    }
}
