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
    public class ClsRepositorioPaciente : ClsSentencias, IRepositorioPaciente
    {
        private string _SelectAll;

        public ClsRepositorioPaciente()
        {
            _SelectAll = "SELECT * FROM tbl_paciente";
        }

        public IEnumerable<ClsPaciente> SeguridadMetObtenerTodos()
        {
            var Lista = new List<ClsPaciente>();
            var TablaDatos = SeguridadMetEjecucionConsulta(_SelectAll, CommandType.Text);
            foreach (DataRow Fila in TablaDatos.Rows)
            {
                Lista.Add(new ClsPaciente
                {
                    IdPaciente = Convert.ToInt32(Fila["idPaciente"]),
                    NombrePaciente = Fila["nombrePaciente"].ToString(),
                    ApellidoPaciente = Fila["apellidoPaciente"].ToString(),
                    FechaNacimientoPaciente = Fila["fechaNacimientoPaciente"] == DBNull.Value
                        ? (DateTime?)null
                        : Convert.ToDateTime(Fila["fechaNacimientoPaciente"]),
                    SexoPaciente = Fila["sexoPaciente"].ToString(),
                    DireccionPaciente = Fila["direccionPaciente"].ToString(),
                    TelefonoPaciente = Fila["telefonoPaciente"].ToString(),
                    EstadoPaciente = Fila["estadoPaciente"] == DBNull.Value
                        ? (int?)null
                        : Convert.ToInt32(Fila["estadoPaciente"])
                });
            }
            return Lista;
        }
    }
}
