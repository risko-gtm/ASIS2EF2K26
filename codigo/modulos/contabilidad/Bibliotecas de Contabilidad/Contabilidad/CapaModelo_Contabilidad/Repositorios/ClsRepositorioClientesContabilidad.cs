using System.Data;

namespace CapaModelo_Contabilidad.Repositorios
{
    public class ClsRepositorioClientesContabilidad : ClsRepositorioMaestroContabilidad
    {
        public DataTable ContabilidadFuncObtenerClientes()
        {
            return ContabilidadFuncEjecutarConsulta(
                "SELECT pk_idCliente, nombreCliente, direccionCliente, telefonoCliente, estadoCliente " +
                "FROM tbl_cliente ORDER BY pk_idCliente", CommandType.Text);
        }
    }
}
