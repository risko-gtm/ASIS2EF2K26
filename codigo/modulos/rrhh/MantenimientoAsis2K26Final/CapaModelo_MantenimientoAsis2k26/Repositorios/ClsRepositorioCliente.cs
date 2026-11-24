using CapaModelo_MantenimientoAsis2k26.Contratos;
using CapaModelo_MantenimientoAsis2k26.Entidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaModelo_MantenimientoAsis2k26.Repositorios
{
    public class ClsRepositorioCliente : ClsSentencias, IRepositorioCliente
    {
        private string _SelectAll;

        public ClsRepositorioCliente()
        {
            _SelectAll = "SELECT * FROM tbl_Cliente";
        }

        public IEnumerable<ClsCliente> SeguridadMetObtenerTodos()
        {
            var Lista = new List<ClsCliente>();
            var TablaDatos = SeguridadMetEjecucionConsulta(_SelectAll, CommandType.Text);
            foreach (DataRow Fila in TablaDatos.Rows)
            {
                Lista.Add(new ClsCliente
                {
                    IdCliente = Convert.ToInt32(Fila["pk_idCliente"]),
                    NombreCliente = Fila["nombreCliente"].ToString(),
                    DireccionCliente = Fila["direccionCliente"].ToString(),
                    TelefonoCliente = Fila["telefonoCliente"].ToString(),
                    EstadoCliente = Fila["estadoCliente"] == DBNull.Value
                        ? (int?)null
                        : Convert.ToInt32(Fila["estadoCliente"])
                });
            }
            return Lista;
        }
    }
}
