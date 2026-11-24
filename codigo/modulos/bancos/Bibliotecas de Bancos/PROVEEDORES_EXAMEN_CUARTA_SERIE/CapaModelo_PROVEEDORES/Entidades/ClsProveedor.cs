/*Oscar Emilio Morales Lemus; 9959-23-3070*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaModelo_PROVEEDORES.Entidades
{
    public class ClsProveedor
    {
        public int pk_idProveedor { get; set; }
        public string nombreProveedor { get; set; }
        public string direccionProveedor { get; set; }
        public string telefonoProveedor { get; set; }
        public int estadoProveedor { get; set; }
    }
}
