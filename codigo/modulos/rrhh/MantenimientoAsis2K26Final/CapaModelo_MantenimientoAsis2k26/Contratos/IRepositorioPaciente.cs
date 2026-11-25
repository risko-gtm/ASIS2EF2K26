using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaModelo_MantenimientoAsis2k26.Entidades;

namespace CapaModelo_MantenimientoAsis2k26.Contratos
{
    public interface IRepositorioPaciente
    {
        IEnumerable<ClsPaciente> SeguridadMetObtenerTodos();
    }
}
