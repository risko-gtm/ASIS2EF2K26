using System.Data;
using CapaModelo_Contabilidad.Repositorios;

namespace CapaControlador_Contabilidad
{
    public class ClsControladorClientesContabilidad
    {
        private readonly ClsRepositorioClientesContabilidad _Repositorio = new ClsRepositorioClientesContabilidad();

        public DataTable ContabilidadFuncObtenerClientes()
        {
            return _Repositorio.ContabilidadFuncObtenerClientes();
        }
    }
}
