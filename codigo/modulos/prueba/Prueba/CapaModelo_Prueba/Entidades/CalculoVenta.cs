namespace CapaModelo_Prueba
{
    public static class CalculoVenta
    {
        public static decimal CalcularTotal(int cantidad, decimal precioUnitario)
        {
            return cantidad * precioUnitario;
        }
    }
}
