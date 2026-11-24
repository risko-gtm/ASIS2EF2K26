using System.Data.Odbc;

namespace CapaModelo_BtnVerReporte_Reporteador.Repositorios
{
    public abstract class ClsRepositorio
    {
        private readonly string _CadenaConexion;

        public ClsRepositorio()
        {
            // Inicio cambio - Byron Alexander Chiquito Paredes - 0901-23-3747
            // Los reportes ahora estan en la misma base del proyecto (DSN asis22k26)
            _CadenaConexion = "Dsn=asis22k26";
            // Fin cambio - Byron Alexander Chiquito Paredes - 0901-23-3747
        }

        // OBTENER LA CONEXION ODBC CONFIGURADA PARA EL REPORTEADOR
        protected OdbcConnection ReporteadorMetObtenerConexion()
        {
            return new OdbcConnection(_CadenaConexion);
        }
    }
}
