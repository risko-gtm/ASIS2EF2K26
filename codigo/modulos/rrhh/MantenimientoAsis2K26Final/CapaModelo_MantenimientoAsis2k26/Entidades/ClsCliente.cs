using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaModelo_MantenimientoAsis2k26.Entidades
{
    public class ClsCliente
    {
        public int IdCliente { get; set; }
        public string NombreCliente { get; set; }
        public string DireccionCliente { get; set; }
        public string TelefonoCliente { get; set; }
        public int? EstadoCliente { get; set; }
    }
}
