using System.Collections.Generic;
using CapaModelo_Pacientes.Entidades;

namespace CapaModelo_Pacientes.Contratos
{
    public interface IRepositorioPaciente
    {
        IEnumerable<ClsPaciente> PacientesMetObtenerTodos();
    }
}
