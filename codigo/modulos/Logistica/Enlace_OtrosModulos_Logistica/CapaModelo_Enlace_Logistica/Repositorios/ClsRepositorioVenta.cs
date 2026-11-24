using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaModelo_Enlace_Logistica.Contratos;
using CapaModelo_Enlace_Logistica.Entidades;

namespace CapaModelo_Enlace_Logistica.Repositorios
{
    public class ClsRepositorioVenta : IRepositorioMantenimientoVentas
    {
        private readonly string _SelectAll;

        public ClsRepositorioVenta()
        {
            _SelectAll =
                "SELECT " +
                "pk_idVendedor AS idVendedor, " +
                "nombreVendedor AS nombreVendedor, " +
                "direccionVendedor AS direccionVendedor, " +
                "telefonoVendedor AS telefonoVendedor, " +
                "estadoVendedor AS estadoVendedor " +
                "FROM tbl_vendedor " +
                "ORDER BY pk_idVendedor";
        }

        public IEnumerable<ClsVenta> LogisticaMetObtenerTodos()
        {
            List<ClsVenta> ListaVentas = new List<ClsVenta>();
            DataTable TablaDatos = new DataTable();

            using (OdbcConnection Conexion = new OdbcConnection("DSN=asis22k26;"))
            using (OdbcDataAdapter Adaptador = new OdbcDataAdapter(_SelectAll, Conexion))
            {
                Adaptador.Fill(TablaDatos);
            }

            foreach (DataRow Fila in TablaDatos.Rows)
            {
                ListaVentas.Add(new ClsVenta
                {
                    pk_idVendedor = Convert.ToInt32(Fila["idVendedor"]),
                    nombreVendedor = Convert.ToString(Fila["nombreVendedor"]),
                    direccionVendedor = Convert.ToString(Fila["direccionVendedor"]),
                    telefonoVendedor = Convert.ToString(Fila["telefonoVendedor"]),
                    estadoVendedor = Convert.ToInt32(Fila["estadoVendedor"])
                });
            }

            return ListaVentas;
        }
    }
}

