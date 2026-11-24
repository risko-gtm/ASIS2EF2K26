/*Oscar Emilio Morales Lemus; 9959-23-3070*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaModelo_Pacientes.Entidades
{
    public class ClsPaciente
    {
        public int PK_idPaciente { get; set; }
        public string NombrePaciente { get; set; }
        public string ApellidoPaciente { get; set; }
        public DateTime FechaNacimientoPaciente { get; set; }
        public string SexoPaciente { get; set; }
        public string DireccionPaciente { get; set; }
        public string TelefonoPaciente { get; set; }
        public int EstadoPaciente { get; set; }
    }
}
