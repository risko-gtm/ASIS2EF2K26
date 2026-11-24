/*Oscar Emilio Morales Lemus; 9959-23-3070*/
using CapaModelo_Pacientes.Contratos;
using CapaModelo_Pacientes.Entidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaModelo_Pacientes.Repositorio
{
    public class ClsRepositorioPaciente : ClsSentencias, IRepositorioPaciente
    {
        private string _SelectAll;
        private string _Insert;
        private string _Update;
        private string _Delete;

        public ClsRepositorioPaciente()
        {
            _SelectAll = "SELECT * FROM tbl_paciente";
            _Insert = "INSERT INTO tbl_paciente (pk_idPaciente, nombrePaciente, apellidoPaciente, fechaNacimientoPaciente, sexoPaciente, direccionPaciente, telefonoPaciente, estadoPaciente) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            _Update = "UPDATE tbl_paciente SET nombrePaciente=?, apellidoPaciente=?, fechaNacimientoPaciente=?, sexoPaciente=?, direccionPaciente=?, telefonoPaciente=?, estadoPaciente=? WHERE pk_idPaciente=?";
            _Delete = "DELETE FROM tbl_paciente WHERE pk_idPaciente=?";
        }

        public int BancosMetAgregar(ClsPaciente Entidad)
        {
            var Parametros = new List<OdbcParameter>();
            Parametros.Add(new OdbcParameter("p_idPaciente", Entidad.PK_idPaciente));
            Parametros.Add(new OdbcParameter("p_nombrePaciente", Entidad.NombrePaciente));
            Parametros.Add(new OdbcParameter("p_apellidoPaciente", Entidad.ApellidoPaciente));
            Parametros.Add(new OdbcParameter("p_fechaNacimientoPaciente", Entidad.FechaNacimientoPaciente));
            Parametros.Add(new OdbcParameter("p_sexoPaciente", Entidad.SexoPaciente));
            Parametros.Add(new OdbcParameter("p_direccionPaciente", Entidad.DireccionPaciente));
            Parametros.Add(new OdbcParameter("p_telefonoPaciente", Entidad.TelefonoPaciente));
            Parametros.Add(new OdbcParameter("p_estadoPaciente", Entidad.EstadoPaciente));

            return BancosMetEjecucionNonQuery(_Insert, Parametros, CommandType.Text);
        }

        public int BancosMetEditar(ClsPaciente Entidad)
        {
            var Parametros = new List<OdbcParameter>();
            Parametros.Add(new OdbcParameter("p_nombrePaciente", Entidad.NombrePaciente));
            Parametros.Add(new OdbcParameter("p_apellidoPaciente", Entidad.ApellidoPaciente));
            Parametros.Add(new OdbcParameter("p_fechaNacimientoPaciente", Entidad.FechaNacimientoPaciente));
            Parametros.Add(new OdbcParameter("p_sexoPaciente", Entidad.SexoPaciente));
            Parametros.Add(new OdbcParameter("p_direccionPaciente", Entidad.DireccionPaciente));
            Parametros.Add(new OdbcParameter("p_telefonoPaciente", Entidad.TelefonoPaciente));
            Parametros.Add(new OdbcParameter("p_estadoPaciente", Entidad.EstadoPaciente));
            Parametros.Add(new OdbcParameter("p_idPaciente", Entidad.PK_idPaciente));

            return BancosMetEjecucionNonQuery(_Update, Parametros, CommandType.Text);
        }

        public int BancosMetRemover(ClsPaciente Entidad)
        {
            var Parametros = new List<OdbcParameter>();
            Parametros.Add(new OdbcParameter("p_idPaciente", Entidad.PK_idPaciente));

            return BancosMetEjecucionNonQuery(_Delete, Parametros, CommandType.Text);
        }

        public IEnumerable<ClsPaciente> BancosMetObtenerTodos()
        {
            var ListaPaciente = new List<ClsPaciente>();
            var TablaDatos = BancosMetEjecucionConsulta(_SelectAll, CommandType.Text);
            foreach (DataRow Fila in TablaDatos.Rows)
            {
                var Paciente = new ClsPaciente();
                Paciente.PK_idPaciente = Convert.ToInt32(Fila[0]);
                Paciente.NombrePaciente = Fila[1].ToString();
                Paciente.ApellidoPaciente = Fila[2].ToString();
                Paciente.FechaNacimientoPaciente = Fila[3] == DBNull.Value ? DateTime.MinValue : Convert.ToDateTime(Fila[3]);
                Paciente.SexoPaciente = Fila[4].ToString();
                Paciente.DireccionPaciente = Fila[5].ToString();
                Paciente.TelefonoPaciente = Fila[6].ToString();
                Paciente.EstadoPaciente = Fila[7] == DBNull.Value ? 0 : Convert.ToInt32(Fila[7]);
                ListaPaciente.Add(Paciente);
            }
            TablaDatos.Clear();
            TablaDatos = null;
            return ListaPaciente;
        }
    }
}
