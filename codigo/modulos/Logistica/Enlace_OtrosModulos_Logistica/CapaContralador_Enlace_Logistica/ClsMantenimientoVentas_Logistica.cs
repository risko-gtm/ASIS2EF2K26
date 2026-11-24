using CapaModelo_Enlace_Logistica.Entidades;
using CapaModelo_Enlace_Logistica.Repositorios;
using CapaContralador_Enlace_Logistica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaContralador_Enlace_Logistica
{
    public class ClsMantenimientoVentas_Logistica
    {
        private readonly ClsRepositorioVenta _RepositorioVenta;

        public int pk_idVendedor { get; set; }
        public string nombreVendedor { get; set; }
        public string direccionVendedor { get; set; }
        public string telefonoVendedor { get; set; }
        public int estadoVendedor { get; set; }

        public ClsMantenimientoVentas_Logistica()
        {
            _RepositorioVenta = new ClsRepositorioVenta();
        }

        public List<ClsMantenimientoVentas_Logistica> LogisticaMetObtenerTodos()
        {
            var ResultadoConsulta = _RepositorioVenta.LogisticaMetObtenerTodos();
            List<ClsMantenimientoVentas_Logistica> ListaVendedores =
                new List<ClsMantenimientoVentas_Logistica>();

            foreach (ClsVenta Item in ResultadoConsulta)
            {
                ListaVendedores.Add(new ClsMantenimientoVentas_Logistica
                {
                    pk_idVendedor = Item.pk_idVendedor,
                    nombreVendedor = Item.nombreVendedor,
                    direccionVendedor = Item.direccionVendedor,
                    telefonoVendedor = Item.telefonoVendedor,
                    estadoVendedor = Item.estadoVendedor
                });
            }

            return ListaVendedores;
        }
    }
}

