using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CapaVista_EvaluacionDesempeño.Formularios
{
    public partial class FrmRealizarEvaluacion : Form
    {
     


        public FrmCrudCliente()
        {
            InitializeComponent();
            navegador1_Load.NavegadorMetConfigurar("tbl_Cliente", 9000, 2679);

            // El panel de Ingresar/Modificar lo arma el Navegador después de este evento,
            // por eso las validaciones se conectan cuando termina (BeginInvoke).
            navegador1_Load.NavegadorAccionSolicitada += Accion =>
            {
                if (Accion == "INGRESAR" || Accion == "MODIFICAR")
                    BeginInvoke((Action)RrhhMetConectarValidacionNotas);
            };

            // Cancelar, Salir y Ayuda deben funcionar aunque haya una nota inválida.
            foreach (string Boton in new[] { "NavegadorBtnCancelar", "NavegadorBtnSalir", "NavegadorBtnAyuda" })
                foreach (Control Control in navegador1_Load.Controls.Find(Boton, true))
                    Control.CausesValidation = false;
        }
        private void NavegadorAccionSolicitada(string accion)
        {

        private void navegador1_Load(object sender, EventArgs e)
        {

        }
    }
}
