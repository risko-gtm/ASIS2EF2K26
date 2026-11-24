using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaModelo_Enlace_Logistica.Entidades;
using CapaModelo_Enlace_Logistica.Repositorios;

namespace CapaModelo_Enlace_Logistica.Contratos
{
    public interface IRepositorioMantenimientoVentas
    {
        IEnumerable<ClsVenta> LogisticaMetObtenerTodos();
    }
}



