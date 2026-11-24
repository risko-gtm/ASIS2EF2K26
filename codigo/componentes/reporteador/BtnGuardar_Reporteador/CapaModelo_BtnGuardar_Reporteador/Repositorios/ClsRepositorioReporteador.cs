using System.Data.Odbc;

namespace CapaModelo_BtnGuardar_Reporteador.Repositorios
{
    public abstract class ClsRepositorioReporteador
    {
        private readonly string _CadenaConexion;

        protected ClsRepositorioReporteador()
        {
            _CadenaConexion =
                "Dsn=asis22k26";
        }

        protected OdbcConnection ReporteadorMetObtenerConexion()
        {
            return new OdbcConnection(
                _CadenaConexion);
        }
    }
}