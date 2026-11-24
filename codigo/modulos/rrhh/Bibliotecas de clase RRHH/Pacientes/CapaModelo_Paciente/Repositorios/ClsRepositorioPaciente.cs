/*
 * ==================================================================
 * Área : Recursos Humanos - Examen Final
 * Autor : Byron Alexander Chiquito Paredes
 * Carné : 0901-23-3747
 * Fecha : 24/11/2026
 * ==================================================================
 * Propósito :
 *  Consulta los registros de tbl_paciente para el reporte de la aplicación 9007.
 * ===================================================================
*/

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using CapaModelo_Paciente.Contratos;
using CapaModelo_Paciente.Entidades;

namespace CapaModelo_Paciente.Repositorios
{
    public class ClsRepositorioPaciente : ClsConexion, IRepositorioPaciente
    {
        private readonly string _SelectAll = @"
            SELECT pk_idPaciente, nombrePaciente, apellidoPaciente, fechaNacimientoPaciente,
                   sexoPaciente, direccionPaciente, telefonoPaciente, estadoPaciente
            FROM tbl_paciente
            ORDER BY pk_idPaciente";

        public IEnumerable<ClsPaciente> RrhhMetObtenerTodos()
        {
            var Lista = new List<ClsPaciente>();
            var Tabla = new DataTable();
            using (OdbcConnection Conexion = RrhhMetObtenerConexion())
            using (OdbcDataAdapter Adaptador = new OdbcDataAdapter(_SelectAll, Conexion))
            {
                Adaptador.Fill(Tabla);
            }
            foreach (DataRow Fila in Tabla.Rows)
            {
                Lista.Add(new ClsPaciente
                {
                    IdPaciente = Convert.ToInt32(Fila["pk_idPaciente"]),
                    NombrePaciente = Fila["nombrePaciente"].ToString(),
                    ApellidoPaciente = Fila["apellidoPaciente"].ToString(),
                    FechaNacimientoPaciente = Convert.ToDateTime(Fila["fechaNacimientoPaciente"]),
                    SexoPaciente = Fila["sexoPaciente"].ToString(),
                    DireccionPaciente = Fila["direccionPaciente"].ToString(),
                    TelefonoPaciente = Fila["telefonoPaciente"].ToString(),
                    EstadoPaciente = Convert.ToInt32(Fila["estadoPaciente"])
                });
            }
            return Lista;
        }
    }
}
