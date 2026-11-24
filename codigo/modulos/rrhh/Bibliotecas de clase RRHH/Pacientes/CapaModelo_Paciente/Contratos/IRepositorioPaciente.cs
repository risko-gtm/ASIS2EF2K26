/*
 * ==================================================================
 * Área : Recursos Humanos - Examen Final
 * Autor : Byron Alexander Chiquito Paredes
 * Carné : 0901-23-3747
 * Fecha : 24/11/2026
 * ==================================================================
 * Propósito :
 *  Contrato del repositorio de tbl_paciente.
 * ===================================================================
*/

using System.Collections.Generic;
using CapaModelo_Paciente.Entidades;

namespace CapaModelo_Paciente.Contratos
{
    public interface IRepositorioPaciente
    {
        IEnumerable<ClsPaciente> RrhhMetObtenerTodos();
    }
}
