/*Oscar Emilio Morales Lemus; 9959-23-3070*/
using CapaModelo_Pacientes.Entidades;
using CapaModelo_Pacientes.Repositorio;
using CapaControlador_Pacientes.Objetos_de_Valor;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaControlador_Pacientes.Modelo_de_Controladores
{
    public class ClsModeloPaciente
    {
        private int _PK_idPaciente;
        private string _NombrePaciente;
        private string _ApellidoPaciente;
        private DateTime _FechaNacimientoPaciente;
        private string _SexoPaciente;
        private string _DireccionPaciente;
        private string _TelefonoPaciente;
        private int _EstadoPaciente;
        private ClsRepositorioPaciente _RepositorioPaciente;
        public EstadoEntidad Estado { private get; set; }
        private List<ClsModeloPaciente> _ListaPaciente;

        public int PK_idPaciente { get => _PK_idPaciente; set => _PK_idPaciente = value; }
        public string NombrePaciente { get => _NombrePaciente; set => _NombrePaciente = value; }
        public string ApellidoPaciente { get => _ApellidoPaciente; set => _ApellidoPaciente = value; }
        public DateTime FechaNacimientoPaciente { get => _FechaNacimientoPaciente; set => _FechaNacimientoPaciente = value; }
        public string SexoPaciente { get => _SexoPaciente; set => _SexoPaciente = value; }
        public string DireccionPaciente { get => _DireccionPaciente; set => _DireccionPaciente = value; }
        public string TelefonoPaciente { get => _TelefonoPaciente; set => _TelefonoPaciente = value; }
        public int EstadoPaciente { get => _EstadoPaciente; set => _EstadoPaciente = value; }

        public ClsModeloPaciente()
        {
            _RepositorioPaciente = new ClsRepositorioPaciente();
        }

        public string BancosMetGrabarCambios()
        {
            string Mensaje = null;

            var ModeloDatos = new ClsPaciente();
            ModeloDatos.PK_idPaciente = _PK_idPaciente;
            ModeloDatos.NombrePaciente = _NombrePaciente;
            ModeloDatos.ApellidoPaciente = _ApellidoPaciente;
            ModeloDatos.FechaNacimientoPaciente = _FechaNacimientoPaciente;
            ModeloDatos.SexoPaciente = _SexoPaciente;
            ModeloDatos.DireccionPaciente = _DireccionPaciente;
            ModeloDatos.TelefonoPaciente = _TelefonoPaciente;
            ModeloDatos.EstadoPaciente = _EstadoPaciente;

            switch (Estado)
            {
                case EstadoEntidad.Added:
                    _RepositorioPaciente.BancosMetAgregar(ModeloDatos);
                    Mensaje = "Grabacion exitosa";
                    break;
                case EstadoEntidad.Modified:
                    _RepositorioPaciente.BancosMetEditar(ModeloDatos);
                    Mensaje = "Actualizacion exitosa";
                    break;
                case EstadoEntidad.Deleted:
                    _RepositorioPaciente.BancosMetRemover(ModeloDatos);
                    Mensaje = "Eliminacion exitosa";
                    break;
            }
            return Mensaje;
        }

        public List<ClsModeloPaciente> BancosMetObtenerTodos()
        {
            var ResultadoConsulta = _RepositorioPaciente.BancosMetObtenerTodos();
            _ListaPaciente = new List<ClsModeloPaciente>();
            foreach (ClsPaciente Item in ResultadoConsulta)
            {
                _ListaPaciente.Add(new ClsModeloPaciente
                {
                    _PK_idPaciente = Item.PK_idPaciente,
                    _NombrePaciente = Item.NombrePaciente,
                    _ApellidoPaciente = Item.ApellidoPaciente,
                    _FechaNacimientoPaciente = Item.FechaNacimientoPaciente,
                    _SexoPaciente = Item.SexoPaciente,
                    _DireccionPaciente = Item.DireccionPaciente,
                    _TelefonoPaciente = Item.TelefonoPaciente,
                    _EstadoPaciente = Item.EstadoPaciente
                });
            }
            return _ListaPaciente;
        }

        public IEnumerable<ClsModeloPaciente> BancosMetBuscarPorId(int IdPaciente)
        {
            if (_ListaPaciente == null)
                BancosMetObtenerTodos();

            return _ListaPaciente.FindAll(e => e._PK_idPaciente == IdPaciente);
        }
    }
}
