/*
 * Autor: José Xavier Bolaños Tenas
 * Carné: 0901-23-2128
 * Descripción: Consulta y convierte los registros de tipos de movimiento en entidades del modelo.
 */
using CapaModelo_Inventario_Logistica.Contratos;
using CapaModelo_Inventario_Logistica.Entidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaModelo_Inventario_Logistica.Repositorios
{
    public class ClsRepositorioTipoMovimiento : ClsRepositorioMaestro, IRepositorioTipoMovimiento
    {
        private string _SelectAll;

        public ClsRepositorioTipoMovimiento()
        {
            _SelectAll = "SELECT pk_idCliente, nombreCliente, direccionCliente, telefonoCliente, estadoCliente FROM tbl_cliente";
        }

        public IEnumerable<ClsTipoMovimiento> LogisticaMetObtenerTodos()
        {
            var ListaTipoMovimento = new List<ClsTipoMovimiento>();
            var TablaDatos = LogisticaMetEjecucionConsulta(_SelectAll, CommandType.Text);
            foreach (DataRow Fila in TablaDatos.Rows)
            {
                var TipoMovimiento = new ClsTipoMovimiento();
                TipoMovimiento.pk_idCliente = Convert.ToInt32(Fila["idTipoMovimiento"]);
                TipoMovimiento.nombreCliente = Fila["nombreTipoMovimiento"].ToString();
                TipoMovimiento.direccionCliente = Fila["descripcionTipoMovimiento"].ToString();
                TipoMovimiento.telefonoCliente = Fila["signoTipoMovimiento"].ToString();
                TipoMovimiento.estadoCliente = Convert.ToInt32(Fila["created_at"]);
                ListaTipoMovimento.Add(TipoMovimiento);
            }
            TablaDatos.Clear();
            TablaDatos = null;
            return ListaTipoMovimento;
        }
    }
}
