using System;

namespace CapaModelo_Pacientes.Entidades
{
    public class ClsPaciente
    {
        public int IdProveedor { get; set; }
        public string NombreProveedor { get; set; }
        public string DireccionProveedor { get; set; }
       
        public string TelefonoProveedor { get; set; }
        public int EstadoProveedor { get; set; }
    }
}
