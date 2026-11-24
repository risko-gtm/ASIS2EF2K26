using System;
using System.Collections.Generic;
using System.Windows.Forms;
using CapaControlador_Pacientes.Modelos_de_Controladores;

namespace CapaVista_Pacientes
{
    public partial class FrmProveedoresNavegador : Form
    {
        private readonly Dictionary<string, object> _fuentesReporte =
            new Dictionary<string, object>();

        public FrmProveedoresNavegador()
        {
            InitializeComponent();

         
           _fuentesReporte["DsProveedor"] = new List<ClsModeloPaciente>();
            RrhhNavMotivoBaja.NavegadorMetConfigurar("tbl_proveedor", 9000, 9709);
           RrhhNavMotivoBaja.NavegadorAccionSolicitada += PacientesMetPrepararReporte;
        }

        private void FrmProveedoresNavegador_Load(object sender, EventArgs e)
        {

        }

        private void PacientesMetPrepararReporte(string accion)
         {
           if (accion != "IMPRIMIR") return;

        // Se consulta en cada impresión para reflejar los cambios del CRUD.
         try
        {
         _fuentesReporte["DsProveedor"] =
           new ClsModeloPaciente().PacienteMetObtenerParaReporte();
         }
        catch (Exception ex)
        {
           _fuentesReporte["DsProveedor"] = new List<ClsModeloPaciente>();
        MessageBox.Show("No se pudieron obtener los pacientes para el reporte.\n" + ex.Message,
           "Reporte de pacientes", MessageBoxButtons.OK, MessageBoxIcon.Error);
         }
        }
    }
}
