/*
 * Autor: José Xavier Bolaños Tenas
 * Carné: 0901-23-2128
 * Descripción: Representa los datos de un tipo de movimiento de inventario.
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaModelo_Inventario_Logistica.Entidades
{
    public class ClsTipoMovimiento
    {
        public int pk_idCliente { get; set; }
        public string nombreCliente { get; set; }
        public string direccionCliente { get; set; }
        public string telefonoCliente { get; set; }
        public int estadoCliente { get; set; }
    }
}
