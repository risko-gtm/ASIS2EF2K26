using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaModelo_Paciente_Logistica.Repositorios
{
    public abstract class ClsRepositorioMaestro : ClsRepositorio
    {
        public DataTable LogisticaMetEjecucionConsulta(string sql, params OdbcParameter[] parametros)
        {
            var tabla = new DataTable();
            using (var conexion = LogisticaMetObtenerConexion())
            using (var comando = new OdbcCommand(sql, conexion))
            {
                if (parametros != null && parametros.Length > 0)
                    comando.Parameters.AddRange(parametros);

                conexion.Open();
                using (var lector = comando.ExecuteReader())
                    tabla.Load(lector);
            }
            return tabla;
        }
    }
}
