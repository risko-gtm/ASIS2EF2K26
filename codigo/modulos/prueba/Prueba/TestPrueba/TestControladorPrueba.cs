using System;
using System.Data;
using System.Globalization;
using CapaControlador_Prueba;
using CapaModelo_Prueba;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace TestPrueba
{
    [TestClass]
    public class TestControladorPrueba
    {
        [TestMethod]
        public void Test_GuardarCatalogo_NormalizaNombre()
        {
            // Arrange
            var repositorio = new RepositorioDePrueba();
            var controlador = new ControladorPrueba(repositorio);

            // Act
            controlador.GuardarCatalogo(Catalogo.Cliente, null, "  Tienda Central  ", true, null);

            // Assert
            var registro = repositorio.CatalogoGuardado.Value;
            Assert.AreEqual(Catalogo.Cliente, registro.Catalogo);
            Assert.IsNull(registro.Id);
            Assert.AreEqual("Tienda Central", registro.Nombre);
            Assert.IsTrue(registro.Activo);
            Assert.IsNull(registro.Precio);
        }

        [TestMethod]
        public void Test_GuardarCatalogo_AceptaNombreYPrecioMaximos()
        {
            // Arrange
            var repositorio = new RepositorioDePrueba();
            var controlador = new ControladorPrueba(repositorio);
            string nombre = new string('P', 80);
            const decimal precio = 99999999.99m;

            // Act
            controlador.GuardarCatalogo(Catalogo.Producto, 7, nombre, false, precio);

            // Assert
            var registro = repositorio.CatalogoGuardado.Value;
            Assert.AreEqual(Catalogo.Producto, registro.Catalogo);
            Assert.AreEqual<int?>(7, registro.Id);
            Assert.AreEqual(nombre, registro.Nombre);
            Assert.IsFalse(registro.Activo);
            Assert.AreEqual<decimal?>(precio, registro.Precio);
        }

        [TestMethod]
        public void Test_GuardarCatalogo_RechazaNombreDemasiadoLargo()
        {
            // Arrange
            var repositorio = new RepositorioDePrueba();
            var controlador = new ControladorPrueba(repositorio);
            string nombre = new string('V', 81);

            // Act y Assert
            Assert.ThrowsException<ArgumentException>(() =>
                controlador.GuardarCatalogo(Catalogo.Vendedor, null, nombre, true, null));
            Assert.IsFalse(repositorio.CatalogoGuardado.HasValue);
        }

        [TestMethod]
        [DataRow(null)]
        [DataRow("")]
        [DataRow("   ")]
        public void Test_GuardarCatalogo_RechazaNombreVacio(string nombre)
        {
            // Arrange
            var repositorio = new RepositorioDePrueba();
            var controlador = new ControladorPrueba(repositorio);

            // Act y Assert
            Assert.ThrowsException<ArgumentException>(() =>
                controlador.GuardarCatalogo(Catalogo.Cliente, null, nombre, true, null));
            Assert.IsFalse(repositorio.CatalogoGuardado.HasValue);
        }

        [TestMethod]
        [DataRow(null)]
        [DataRow("0")]
        [DataRow("-1")]
        [DataRow("0.001")]
        [DataRow("100000000.00")]
        public void Test_GuardarProducto_RechazaPrecioInvalido(string valor)
        {
            // Arrange
            var repositorio = new RepositorioDePrueba();
            var controlador = new ControladorPrueba(repositorio);
            decimal? precio = valor == null ? (decimal?)null : decimal.Parse(valor, CultureInfo.InvariantCulture);

            // Act y Assert
            Assert.ThrowsException<ArgumentException>(() =>
                controlador.GuardarCatalogo(Catalogo.Producto, null, "Caja de chorizos", true, precio));
            Assert.IsFalse(repositorio.CatalogoGuardado.HasValue);
        }

        [TestMethod]
        public void Test_ListarCatalogo_DevuelveLaConsultaDelCatalogoSolicitado()
        {
            // Arrange
            var repositorio = new RepositorioDePrueba();
            var controlador = new ControladorPrueba(repositorio);

            // Act
            DataTable resultado = controlador.ListarCatalogo(Catalogo.Vendedor);

            // Assert
            Assert.AreEqual(Catalogo.Vendedor, repositorio.CatalogoConsultado);
            Assert.AreSame(repositorio.FilasCatalogo, resultado);
        }

        [TestMethod]
        public void Test_DesactivarCatalogo_UsaElCatalogoYElIdSeleccionados()
        {
            // Arrange
            var repositorio = new RepositorioDePrueba();
            var controlador = new ControladorPrueba(repositorio);

            // Act
            controlador.DesactivarCatalogo(Catalogo.Producto, 9);

            // Assert
            Assert.AreEqual((Catalogo.Producto, 9), repositorio.CatalogoDesactivado.Value);
        }

        [TestMethod]
        public void Test_ListarVentas_DevuelveLasFilasDelRepositorio()
        {
            // Arrange
            var repositorio = new RepositorioDePrueba();
            var controlador = new ControladorPrueba(repositorio);

            // Act
            DataTable resultado = controlador.ListarVentas();

            // Assert
            Assert.AreSame(repositorio.FilasVentas, resultado);
        }

        [TestMethod]
        [DataRow(0, 2, 3)]
        [DataRow(1, -2, 3)]
        [DataRow(1, 2, 0)]
        public void Test_GuardarVenta_RechazaReferenciasInvalidas(int cliente, int producto, int vendedor)
        {
            // Arrange
            var repositorio = new RepositorioDePrueba();
            var controlador = new ControladorPrueba(repositorio);

            // Act y Assert
            Assert.ThrowsException<ArgumentException>(() =>
                controlador.GuardarVenta(null, cliente, producto, vendedor, 4));
            Assert.IsFalse(repositorio.VentaGuardada.HasValue);
        }

        [TestMethod]
        [DataRow(0)]
        [DataRow(-1)]
        public void Test_GuardarVenta_RechazaCantidadNoPositiva(int cantidad)
        {
            // Arrange
            var repositorio = new RepositorioDePrueba();
            var controlador = new ControladorPrueba(repositorio);

            // Act y Assert
            Assert.ThrowsException<ArgumentException>(() =>
                controlador.GuardarVenta(null, 1, 2, 3, cantidad));
            Assert.IsFalse(repositorio.VentaGuardada.HasValue);
        }

        [TestMethod]
        [DataRow(null)]
        [DataRow(8)]
        public void Test_GuardarVenta_EnviaLosDatosParaAltaOEdicion(int? id)
        {
            // Arrange
            var repositorio = new RepositorioDePrueba();
            var controlador = new ControladorPrueba(repositorio);
            const int cantidad = 4;

            // Act
            controlador.GuardarVenta(id, 1, 2, 3, cantidad);

            // Assert
            Assert.AreEqual((id, 1, 2, 3, cantidad), repositorio.VentaGuardada.Value);
        }

        [TestMethod]
        public void Test_GuardarVenta_PropagaElFalloDelRepositorio()
        {
            // Arrange
            var fallo = new InvalidOperationException("El producto está inactivo.");
            var repositorio = new RepositorioDePrueba { FalloGuardarVenta = fallo };
            var controlador = new ControladorPrueba(repositorio);

            // Act y Assert
            var error = Assert.ThrowsException<InvalidOperationException>(() =>
                controlador.GuardarVenta(null, 1, 2, 3, 4));
            Assert.AreSame(fallo, error);
            Assert.IsFalse(repositorio.VentaGuardada.HasValue);
        }

        [TestMethod]
        public void Test_EliminarVenta_UsaElIdSeleccionado()
        {
            // Arrange
            var repositorio = new RepositorioDePrueba();
            var controlador = new ControladorPrueba(repositorio);

            // Act
            controlador.EliminarVenta(12);

            // Assert
            Assert.AreEqual<int?>(12, repositorio.VentaEliminada);
        }

        private sealed class RepositorioDePrueba : IRepositorioPrueba
        {
            public DataTable FilasCatalogo { get; } = new DataTable();
            public DataTable FilasVentas { get; } = new DataTable();
            public Catalogo CatalogoConsultado { get; private set; }
            public (Catalogo Catalogo, int? Id, string Nombre, bool Activo, decimal? Precio)? CatalogoGuardado { get; private set; }
            public (Catalogo Catalogo, int Id)? CatalogoDesactivado { get; private set; }
            public (int? Id, int Cliente, int Producto, int Vendedor, int Cantidad)? VentaGuardada { get; private set; }
            public int? VentaEliminada { get; private set; }
            public InvalidOperationException FalloGuardarVenta { get; set; }

            public DataTable ListarCatalogo(Catalogo catalogo)
            {
                CatalogoConsultado = catalogo;
                return FilasCatalogo;
            }

            public void GuardarCatalogo(Catalogo catalogo, int? id, string nombre, bool activo, decimal? precio)
            {
                CatalogoGuardado = (catalogo, id, nombre, activo, precio);
            }

            public void DesactivarCatalogo(Catalogo catalogo, int id)
            {
                CatalogoDesactivado = (catalogo, id);
            }

            public DataTable ListarVentas()
            {
                return FilasVentas;
            }

            public void GuardarVenta(int? id, int cliente, int producto, int vendedor, int cantidad)
            {
                if (FalloGuardarVenta != null)
                    throw FalloGuardarVenta;

                VentaGuardada = (id, cliente, producto, vendedor, cantidad);
            }

            public void EliminarVenta(int id)
            {
                VentaEliminada = id;
            }
        }
    }
}
