using System.Data.Odbc;

namespace CapaModelo_BtnBusqueda_Reporteador.Repositorios
{
    public abstract class ClsRepositorio
    {
        private readonly string _CadenaConexion;

        protected ClsRepositorio()
        {
            _CadenaConexion =
                "Dsn=“asis22k26";
        }

        protected OdbcConnection
            ReporteadorMetObtenerConexion()
        {
            return new OdbcConnection(
                _CadenaConexion);
        }
    }
}