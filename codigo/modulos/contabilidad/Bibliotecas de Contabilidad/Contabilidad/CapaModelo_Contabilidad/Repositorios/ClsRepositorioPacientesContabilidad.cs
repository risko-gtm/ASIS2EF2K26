/*
 * ==================================================================
 * Área : Contabilidad
 * Autor : Oskar Cermeño
 * Carné : 0901-23-15379
 * Fecha : 24/11/2026
 * ==================================================================
 * Propósito :
 *  Consulta los pacientes de tbl_paciente para el reporte.
 * Reglas especificas:
 *  El ingreso, la modificación y la eliminación los hace el Navegador.
 * ===================================================================
*/

using System.Data;

namespace CapaModelo_Contabilidad.Repositorios
{
    public class ClsRepositorioPacientesContabilidad : ClsRepositorioMaestroContabilidad
    {
        public DataTable ContabilidadFuncObtenerPacientes()
        {
            string Consulta = "SELECT pk_idPaciente AS IdPaciente, nombrePaciente AS NombrePaciente, " +
                "apellidoPaciente AS ApellidoPaciente, DATE_FORMAT(fechaNacimientoPaciente, '%d/%m/%Y') AS FechaNacimiento, " +
                "sexoPaciente AS Sexo, direccionPaciente AS Direccion, telefonoPaciente AS Telefono, " +
                "IF(estadoPaciente = 1, 'Activo', 'Inactivo') AS Estado FROM tbl_paciente";
            return ContabilidadFuncEjecutarConsulta(Consulta, CommandType.Text);
        }
    }
}
