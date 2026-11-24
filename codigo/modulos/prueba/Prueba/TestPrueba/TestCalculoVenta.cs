using CapaModelo_Prueba;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace TestPrueba
{
    [TestClass]
    public class TestCalculoVenta
    {
        [TestMethod]
        public void Test_CalcularTotal_MultiplicaCantidadPorPrecioUnitario()
        {
            // Arrange
            int cantidad = 3;
            decimal precioUnitario = 25.15m;

            // Act
            decimal resultado = CalculoVenta.CalcularTotal(cantidad, precioUnitario);

            // Assert
            Assert.AreEqual(75.45m, resultado);
        }

        [TestMethod]
        public void Test_CalcularTotal_ConservaLosCentavosConLosValoresMaximos()
        {
            // Arrange
            int cantidad = int.MaxValue;
            decimal precioUnitario = 99999999.99m;

            // Act
            decimal resultado = CalculoVenta.CalcularTotal(cantidad, precioUnitario);

            // Assert
            Assert.AreEqual(214748364678525163.53m, resultado);
        }
    }
}
