/*
 * ==================================================================
 * Área : Recursos Humanos - Examen Final
 * Autor : Byron Alexander Chiquito Paredes
 * Carné : 0901-23-3747
 * Fecha : 24/11/2026
 * ==================================================================
 * Propósito :
 *  Modelo del controlador de tbl_paciente. Arma la lista que usa el reporte de la aplicación 9007.
 * ===================================================================
*/

using System.Collections.Generic;
using System.Linq;
using CapaModelo_Paciente.Entidades;
using CapaModelo_Paciente.Repositorios;

namespace CapaControlador_Paciente.Modelos_de_Controladores
{
    public class ClsModeloPaciente
    {
        private readonly ClsRepositorioPaciente _RepositorioPaciente = new ClsRepositorioPaciente();

        public List<ClsPaciente> RrhhMetObtenerParaReporte()
        {
            return _RepositorioPaciente.RrhhMetObtenerTodos().ToList();
        }
    }
}
