/*
 * ==================================================================
 * Área : Recursos Humanos - Examen Final
 * Autor : Byron Alexander Chiquito Paredes
 * Carné : 0901-23-3747
 * Fecha : 24/11/2026
 * ==================================================================
 * Propósito :
 *  Conexión ODBC al DSN asis22k26.
 * ===================================================================
*/

using System.Data.Odbc;

namespace CapaModelo_Paciente.Repositorios
{
    public abstract class ClsConexion
    {
        protected readonly string _ConnectionString = "Dsn=asis22k26";

        protected OdbcConnection RrhhMetObtenerConexion()
        {
            return new OdbcConnection(_ConnectionString);
        }
    }
}
