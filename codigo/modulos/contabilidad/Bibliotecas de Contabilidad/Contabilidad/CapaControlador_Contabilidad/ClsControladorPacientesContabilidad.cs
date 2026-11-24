/*
 * ==================================================================
 * Área : Contabilidad
 * Autor : Oskar Cermeño
 * Carné : 0901-23-15379
 * Fecha : 24/11/2026
 * ==================================================================
 * Propósito :
 *  Llena la tabla del reporte de pacientes.
 * Reglas especificas:
 *  Se llama cada vez que se imprime para que salgan los cambios.
 * ===================================================================
*/

using System.Data;
using CapaModelo_Contabilidad.Repositorios;

namespace CapaControlador_Contabilidad
{
    public class ClsControladorPacientesContabilidad
    {
        ClsRepositorioPacientesContabilidad Repositorio = new ClsRepositorioPacientesContabilidad();

        public void ContabilidadMetLlenarReporte(DataTable TablaReporte)
        {
            DataTable Pacientes = Repositorio.ContabilidadFuncObtenerPacientes();
            TablaReporte.Clear();
            if (TablaReporte.Columns.Count == 0)
            {
                foreach (DataColumn Columna in Pacientes.Columns)
                {
                    TablaReporte.Columns.Add(Columna.ColumnName, Columna.DataType);
                }
            }
            foreach (DataRow Fila in Pacientes.Rows)
            {
                TablaReporte.Rows.Add(Fila.ItemArray);
            }
        }
    }
}
