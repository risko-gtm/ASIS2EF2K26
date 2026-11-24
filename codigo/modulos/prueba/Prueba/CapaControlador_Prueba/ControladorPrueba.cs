using System;
using System.Data;
using CapaModelo_Prueba;

namespace CapaControlador_Prueba
{
    public sealed class ControladorPrueba
    {
        public const decimal PrecioMaximo = 99999999.99m;
        private readonly IRepositorioPrueba repositorio;

        public ControladorPrueba() : this(new RepositorioPrueba())
        {
        }

        public ControladorPrueba(IRepositorioPrueba repositorio)
        {
            this.repositorio = repositorio ?? throw new ArgumentNullException(nameof(repositorio));
        }

        public DataTable ListarCatalogo(Catalogo catalogo)
        {
            return repositorio.ListarCatalogo(catalogo);
        }

        public void GuardarCatalogo(Catalogo catalogo, int? id, string nombre, bool activo, decimal? precio)
        {
            nombre = (nombre ?? "").Trim();
            if (nombre.Length == 0 || nombre.Length > 80)
                throw new ArgumentException("Ingrese un nombre de 1 a 80 caracteres.");
            if (catalogo == Catalogo.Producto &&
                (!precio.HasValue || precio <= 0 || precio > PrecioMaximo || decimal.Round(precio.Value, 2) != precio))
                throw new ArgumentException("Ingrese un precio positivo de hasta 99,999,999.99 y con un máximo de dos decimales.");

            repositorio.GuardarCatalogo(catalogo, id, nombre, activo, precio);
        }

        public void DesactivarCatalogo(Catalogo catalogo, int id)
        {
            repositorio.DesactivarCatalogo(catalogo, id);
        }

        public DataTable ListarVentas()
        {
            return repositorio.ListarVentas();
        }

        public void GuardarVenta(int? id, int cliente, int producto, int vendedor, int cantidad)
        {
            if (cliente <= 0 || producto <= 0 || vendedor <= 0)
                throw new ArgumentException("Seleccione un cliente, un producto y un vendedor.");
            if (cantidad <= 0)
                throw new ArgumentException("Ingrese una cantidad mayor que cero.");

            repositorio.GuardarVenta(id, cliente, producto, vendedor, cantidad);
        }

        public void EliminarVenta(int id)
        {
            repositorio.EliminarVenta(id);
        }
    }
}
