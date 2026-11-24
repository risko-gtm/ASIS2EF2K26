using System.Data;

namespace CapaModelo_Prueba
{
    public interface IRepositorioPrueba
    {
        DataTable ListarCatalogo(Catalogo catalogo);
        void GuardarCatalogo(Catalogo catalogo, int? id, string nombre, bool activo, decimal? precio);
        void DesactivarCatalogo(Catalogo catalogo, int id);
        DataTable ListarVentas();
        void GuardarVenta(int? id, int cliente, int producto, int vendedor, int cantidad);
        void EliminarVenta(int id);
    }
}
