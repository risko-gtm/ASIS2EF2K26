using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaModelo_Enlace_Logistica.Entidades
{
    public class ClsVenta
    {
        public int pk_idVendedor { get; set; }
        public string nombreVendedor { get; set; }
        public string direccionVendedor { get; set; }
        public string telefonoVendedor { get; set; }
        public int estadoVendedor { get; set; }
    }
}
