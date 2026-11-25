using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaModelo_MantenimientoAsis2k26.Entidades
{
    public class ClsPaciente
    {
        public int IdPaciente { get; set; }
        public string NombrePaciente { get; set; }
        public string ApellidoPaciente { get; set; }
        public DateTime? FechaNacimientoPaciente { get; set; }
        public string SexoPaciente { get; set; }
        public string DireccionPaciente { get; set; }
        public string TelefonoPaciente { get; set; }
        public int? EstadoPaciente { get; set; }
    }
}
