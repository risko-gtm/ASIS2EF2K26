using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaModelo_Paciente_Logistica.Entidades
{
    public class ClsPaciente
    {
        public long pk_idPaciente { get; set; }
        public long nombrePaciente { get; set; }

        public long apellidoPaciente { get; set; }
        public DateTime fechaNacimientoPaciente { get; set; }

        public long sexoPaciente { get; set; }

        public long direccionPaciente { get; set; }

        public long telefonoPaciente { get; set; }

        public int estadoPaciente { get; set; }

    }
}
