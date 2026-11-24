/*
 * ==================================================================
 * Área : Recursos Humanos - Examen Final
 * Autor : Byron Alexander Chiquito Paredes
 * Carné : 0901-23-3747
 * Fecha : 24/11/2026
 * ==================================================================
 * Propósito :
 *  Entidad de la tabla tbl_paciente.
 * ===================================================================
*/

using System;

namespace CapaModelo_Paciente.Entidades
{
    public class ClsPaciente
    {
        public int IdPaciente { get; set; }
        public string NombrePaciente { get; set; }
        public string ApellidoPaciente { get; set; }
        public DateTime FechaNacimientoPaciente { get; set; }
        public string SexoPaciente { get; set; }
        public string DireccionPaciente { get; set; }
        public string TelefonoPaciente { get; set; }
        public int EstadoPaciente { get; set; }
    }
}
