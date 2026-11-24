/*
 * Autor: José Xavier Bolaños Tenas
 * Carné: 0901-23-2128
 * Descripción: Obtiene tipos de movimiento del repositorio y adapta sus datos al modelo del controlador.
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaModelo_Inventario_Logistica.Entidades;
using CapaModelo_Inventario_Logistica.Repositorios;

namespace CapaControlador_Inventario_Logistica.Modelos_de_Controladores
{
    public class ClsModelosTipoMovimiento
    {
        private readonly ClsRepositorioTipoMovimiento _RepositorioTipoMovimiento;

        public int pkidCliente { get; set; }
        public string nombreCliente { get; set; }
        public string direccionCliente { get; set; }
        public string telefonoCliente { get; set; }
        public int estadoCliente { get; set; }

        public ClsModelosTipoMovimiento()
        {
            _RepositorioTipoMovimiento = new ClsRepositorioTipoMovimiento();
        }

        public List<ClsModelosTipoMovimiento> LogisticaMetObtenerTodos()
        {
            var ResultadoConsulta = _RepositorioTipoMovimiento.LogisticaMetObtenerTodos();
            var ListaTipoMovimiento = new List<ClsModelosTipoMovimiento>();
            foreach (ClsTipoMovimiento Item in ResultadoConsulta)
            {
                ListaTipoMovimiento.Add(new ClsModelosTipoMovimiento
                {
                    pkidCliente = Item.pk_idCliente,
                    nombreCliente = Item.nombreCliente,
                    direccionCliente = Item.direccionCliente,
                    telefonoCliente = Item.telefonoCliente,
                    estadoCliente = Item.estadoCliente,
                });
            }
            return ListaTipoMovimiento;
        }
    }
}
