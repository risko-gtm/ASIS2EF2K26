/*Oscar Emilio Morales Lemus; 9959-23-3070*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaModelo_PROVEEDORES.Entidades;
using CapaModelo_PROVEEDORES.Repositorio;
using CapaControlador_PROVEEDORES.Objetos_de_Valor;

namespace CapaControlador_PROVEEDORES.Modelo_de_controladores
{
    public class ClsModeloProveedor
    {
        private int _PK_idProveedor;
        private string _NombreProveedor;
        private string _DireccionProveedor;
        private string _TelefonoProveedor;
        private int _EstadoProveedor;
        private ClsRepositorioProveedor _RepositorioProveedor;
        public EstadoEntidad Estado { private get; set; }
        private List<ClsModeloProveedor> _ListaProveedor;

        public int PK_idProveedor { get => _PK_idProveedor; set => _PK_idProveedor = value; }
        public string NombreProveedor { get => _NombreProveedor; set => _NombreProveedor = value; }
        public string DireccionProveedor { get => _DireccionProveedor; set => _DireccionProveedor = value; }
        public string TelefonoProveedor { get => _TelefonoProveedor; set => _TelefonoProveedor = value; }
        public int EstadoProveedor { get => _EstadoProveedor; set => _EstadoProveedor = value; }

        public ClsModeloProveedor()
        {
            _RepositorioProveedor = new ClsRepositorioProveedor();
        }

        public string BancosMetGrabarCambios()
        {
            string Mensaje = null;

            var ModeloDatos = new ClsProveedor();
            ModeloDatos.pk_idProveedor = _PK_idProveedor;
            ModeloDatos.nombreProveedor = _NombreProveedor;
            ModeloDatos.direccionProveedor = _DireccionProveedor;
            ModeloDatos.telefonoProveedor = _TelefonoProveedor;
            ModeloDatos.estadoProveedor = _EstadoProveedor;

            switch (Estado)
            {
                case EstadoEntidad.Added:
                    _RepositorioProveedor.BancosMetAgregar(ModeloDatos);
                    Mensaje = "Grabacion exitosa";
                    break;
                case EstadoEntidad.Modified:
                    _RepositorioProveedor.BancosMetEditar(ModeloDatos);
                    Mensaje = "Actualizacion exitosa";
                    break;
                case EstadoEntidad.Deleted:
                    _RepositorioProveedor.BancosMetRemover(ModeloDatos);
                    Mensaje = "Eliminacion exitosa";
                    break;
            }
            return Mensaje;
        }

        public List<ClsModeloProveedor> BancosMetObtenerTodos()
        {
            var ResultadoConsulta = _RepositorioProveedor.BancosMetObtenerTodos();
            _ListaProveedor = new List<ClsModeloProveedor>();
            foreach (ClsProveedor Item in ResultadoConsulta)
            {
                _ListaProveedor.Add(new ClsModeloProveedor
                {
                    _PK_idProveedor = Item.pk_idProveedor,
                    _NombreProveedor = Item.nombreProveedor,
                    _DireccionProveedor = Item.direccionProveedor,
                    _TelefonoProveedor = Item.telefonoProveedor,
                    _EstadoProveedor = Item.estadoProveedor
                });
            }
            return _ListaProveedor;
        }

        public IEnumerable<ClsModeloProveedor> BancosMetBuscarPorId(int IdProveedor)
        {
            if (_ListaProveedor == null)
                BancosMetObtenerTodos();

            return _ListaProveedor.FindAll(e => e._PK_idProveedor == IdProveedor);
        }
    }
}
