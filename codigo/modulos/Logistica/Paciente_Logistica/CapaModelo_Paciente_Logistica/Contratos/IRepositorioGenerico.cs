using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaModelo_Paciente_Logistica.Contratos
{
    public interface IRepositorioGenerico<T> where T : class
    {
        IEnumerable<T> LogisticaMetObtenerTodos();
    }
}
