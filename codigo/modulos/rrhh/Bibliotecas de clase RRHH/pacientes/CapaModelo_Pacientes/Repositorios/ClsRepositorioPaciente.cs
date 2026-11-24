using System;
using System.Collections.Generic;
using System.Data.Odbc;
using CapaModelo_Pacientes.Contratos;
using CapaModelo_Pacientes.Entidades;

namespace CapaModelo_Pacientes.Repositorios
{
    public class ClsRepositorioPaciente : ClsConexion, IRepositorioPaciente
    {
        public IEnumerable<ClsPaciente> PacientesMetObtenerTodos()
        {
            var lista = new List<ClsPaciente>();
            const string consulta = @"SELECT pk_idProveedor, nombreProveedor, direccionProveedor,
                telefonoProveedor, estadoProveedor FROM tbl_proveedor ORDER BY pk_idProveedor";

            using (OdbcConnection conexion = PacientesMetObtenerConexion())
            using (var comando = new OdbcCommand(consulta, conexion))
            {
                conexion.Open();
                using (OdbcDataReader fila = comando.ExecuteReader())
                {
                    while (fila.Read())
                    {
                        lista.Add(new ClsPaciente
                        {
                            IdProveedor = Convert.ToInt32(fila["pk_idProveedor"]),
                            NombreProveedor = Convert.ToString(fila["nombreProveedor"]),
                            DireccionProveedor = Convert.ToString(fila["direccionProveedor"]),
                            TelefonoProveedor = Convert.ToString(fila["telefonoProveedor"]),
                            EstadoProveedor = Convert.ToInt32(fila["estadoProveedor"])
                        });
                    }
                }
            }
            return lista;
        }
    }
}
