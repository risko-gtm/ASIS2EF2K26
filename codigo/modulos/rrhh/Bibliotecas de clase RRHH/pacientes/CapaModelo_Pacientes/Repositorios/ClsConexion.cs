using System.Data.Odbc;

namespace CapaModelo_Pacientes.Repositorios
{
    public abstract class ClsConexion
    {
        protected OdbcConnection PacientesMetObtenerConexion()
        {
            return new OdbcConnection("Dsn=EmbutidosS.A");
        }
    }
}
