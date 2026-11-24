using CapaModelo_MantenimientoAsis2k26.Contratos;
using CapaModelo_MantenimientoAsis2k26.Entidades;
using CapaModelo_MantenimientoAsis2k26.Repositorios;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace CapaControlador_MantenimientoAsis2k26.Modelo_De_controladores
{
    public class ClsModeloCliente
    {
        private int _IdCliente;
        private string _NombreCliente;
        private string _DireccionCliente;
        private string _TelefonoCliente;
        private int? _EstadoCliente;

        public int IdCliente { get => _IdCliente; set => _IdCliente = value; }
        public string NombreCliente { get => _NombreCliente; set => _NombreCliente = value; }
        public string DireccionCliente { get => _DireccionCliente; set => _DireccionCliente = value; }
        public string TelefonoCliente { get => _TelefonoCliente; set => _TelefonoCliente = value; }
        public int? EstadoCliente { get => _EstadoCliente; set => _EstadoCliente = value; }

        private ClsRepositorioCliente _RepositorioCliente = new ClsRepositorioCliente();

        public List<ClsModeloCliente> ClienteMetObtenerParaReporte()
        {
            var Resultado = _RepositorioCliente.SeguridadMetObtenerTodos();
            var Lista = new List<ClsModeloCliente>();

            foreach (ClsCliente Item in Resultado)
            {
                Lista.Add(new ClsModeloCliente
                {
                    _IdCliente = Item.IdCliente,
                    _NombreCliente = Item.NombreCliente,
                    _DireccionCliente = Item.DireccionCliente,
                    _TelefonoCliente = Item.TelefonoCliente,
                    _EstadoCliente = Item.EstadoCliente
                });
            }

            return Lista;
        }
    }
}
