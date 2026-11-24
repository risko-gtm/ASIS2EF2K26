using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CapaVista_Paciente_Logistica.Formularios
{
    public partial class FrmMantenimientoPaciente : Form
    {
        public FrmMantenimientoPaciente()
        {
            InitializeComponent();
            LogisticaNavTipoTransporte.NavegadorMetConfigurar("tbl_paciente", 5000, 5038);
        }
    }
}
