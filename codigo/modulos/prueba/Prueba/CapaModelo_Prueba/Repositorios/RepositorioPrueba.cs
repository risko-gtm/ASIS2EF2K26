using System;
using System.Data;
using System.Data.Odbc;

namespace CapaModelo_Prueba
{
    public sealed class RepositorioPrueba : IRepositorioPrueba
    {
        private const string CadenaConexion = "DSN=EmbutidosS.A";

        public DataTable ListarCatalogo(Catalogo catalogo)
        {
            string entidad = NombreCatalogo(catalogo);
            string precio = catalogo == Catalogo.Producto ? ", precio" : "";
            return Consultar($"SELECT id_{entidad} AS id, nombre{precio}, is_active FROM finalf_{entidad} ORDER BY nombre, id");
        }

        public void GuardarCatalogo(Catalogo catalogo, int? id, string nombre, bool activo, decimal? precio)
        {
            string entidad = NombreCatalogo(catalogo);
            bool esProducto = catalogo == Catalogo.Producto;
            using (var conexion = AbrirConexion())
            using (var transaccion = conexion.BeginTransaction())
            using (var comando = conexion.CreateCommand())
            {
                comando.Transaction = transaccion;
                if (id.HasValue)
                {
                    LeerCatalogo(transaccion, catalogo, id.Value, false);
                    string asignarPrecio = esProducto ? ", precio = ?" : "";
                    comando.CommandText = $"UPDATE finalf_{entidad} SET nombre = ?, is_active = ?{asignarPrecio} WHERE id_{entidad} = ?";
                }
                else
                {
                    string columnaPrecio = esProducto ? ", precio" : "";
                    string valorPrecio = esProducto ? ", ?" : "";
                    comando.CommandText = $"INSERT INTO finalf_{entidad} (nombre, is_active{columnaPrecio}) VALUES (?, ?{valorPrecio})";
                }

                comando.Parameters.Add("nombre", OdbcType.NVarChar, 80).Value = nombre;
                comando.Parameters.Add("is_active", OdbcType.TinyInt).Value = activo ? (byte)1 : (byte)0;
                if (esProducto)
                    AgregarDecimal(comando, "precio", precio.Value, 10);
                if (id.HasValue)
                    AgregarEntero(comando, "id", id.Value);

                comando.ExecuteNonQuery();
                transaccion.Commit();
            }
        }

        public void DesactivarCatalogo(Catalogo catalogo, int id)
        {
            string entidad = NombreCatalogo(catalogo);
            using (var conexion = AbrirConexion())
            using (var transaccion = conexion.BeginTransaction())
            using (var comando = conexion.CreateCommand())
            {
                LeerCatalogo(transaccion, catalogo, id, false);
                comando.Transaction = transaccion;
                comando.CommandText = $"UPDATE finalf_{entidad} SET is_active = 0 WHERE id_{entidad} = ?";
                AgregarEntero(comando, "id", id);
                comando.ExecuteNonQuery();
                transaccion.Commit();
            }
        }

        public DataTable ListarVentas()
        {
            return Consultar(@"SELECT v.id_venta AS id, v.fecha, v.id_cliente, v.id_producto, v.id_vendedor,
                                      c.nombre AS cliente, p.nombre AS producto, e.nombre AS vendedor,
                                      v.cantidad, v.precio_unitario, v.total
                               FROM finalf_venta v
                               JOIN finalf_cliente c ON c.id_cliente = v.id_cliente
                               JOIN finalf_producto p ON p.id_producto = v.id_producto
                               JOIN finalf_vendedor e ON e.id_vendedor = v.id_vendedor
                               ORDER BY v.id_venta DESC");
        }

        public void GuardarVenta(int? id, int cliente, int producto, int vendedor, int cantidad)
        {
            using (var conexion = AbrirConexion())
            using (var transaccion = conexion.BeginTransaction())
            using (var comando = conexion.CreateCommand())
            {
                VentaActual actual = id.HasValue ? LeerVenta(transaccion, id.Value) : null;
                if (actual == null || cliente != actual.Cliente)
                    LeerCatalogo(transaccion, Catalogo.Cliente, cliente, true);

                decimal precio = actual != null && producto == actual.Producto
                    ? actual.Precio
                    : LeerCatalogo(transaccion, Catalogo.Producto, producto, true);

                if (actual == null || vendedor != actual.Vendedor)
                    LeerCatalogo(transaccion, Catalogo.Vendedor, vendedor, true);

                comando.Transaction = transaccion;
                comando.CommandText = id.HasValue
                    ? @"UPDATE finalf_venta SET id_cliente = ?, id_producto = ?, id_vendedor = ?,
                               cantidad = ?, precio_unitario = ?, total = ? WHERE id_venta = ?"
                    : @"INSERT INTO finalf_venta (id_cliente, id_producto, id_vendedor, cantidad, precio_unitario, total)
                        VALUES (?, ?, ?, ?, ?, ?)";
                AgregarEntero(comando, "cliente", cliente);
                AgregarEntero(comando, "producto", producto);
                AgregarEntero(comando, "vendedor", vendedor);
                AgregarEntero(comando, "cantidad", cantidad);
                AgregarDecimal(comando, "precio_unitario", precio, 10);
                AgregarDecimal(comando, "total", CalculoVenta.CalcularTotal(cantidad, precio), 20);
                if (id.HasValue)
                    AgregarEntero(comando, "id", id.Value);

                comando.ExecuteNonQuery();
                transaccion.Commit();
            }
        }

        public void EliminarVenta(int id)
        {
            using (var conexion = AbrirConexion())
            using (var comando = new OdbcCommand("DELETE FROM finalf_venta WHERE id_venta = ?", conexion))
            {
                AgregarEntero(comando, "id", id);
                if (comando.ExecuteNonQuery() == 0)
                    throw new InvalidOperationException("La venta ya no existe. Actualice la lista.");
            }
        }

        private static decimal LeerCatalogo(OdbcTransaction transaccion, Catalogo catalogo, int id, bool requiereActivo)
        {
            string entidad = NombreCatalogo(catalogo);
            string columnaPrecio = catalogo == Catalogo.Producto ? ", precio" : "";
            using (var comando = transaccion.Connection.CreateCommand())
            {
                comando.Transaction = transaccion;
                comando.CommandText = $"SELECT is_active{columnaPrecio} FROM finalf_{entidad} WHERE id_{entidad} = ? FOR UPDATE";
                AgregarEntero(comando, "id", id);
                using (var lector = comando.ExecuteReader())
                {
                    if (!lector.Read())
                        throw new InvalidOperationException($"El registro de {entidad} ya no existe. Actualice la lista.");
                    if (requiereActivo && !Convert.ToBoolean(lector.GetValue(0)))
                        throw new InvalidOperationException($"El registro de {entidad} está inactivo. Seleccione otro.");

                    return catalogo == Catalogo.Producto ? lector.GetDecimal(1) : 0m;
                }
            }
        }

        private static VentaActual LeerVenta(OdbcTransaction transaccion, int id)
        {
            using (var comando = transaccion.Connection.CreateCommand())
            {
                comando.Transaction = transaccion;
                comando.CommandText = @"SELECT id_cliente, id_producto, id_vendedor, precio_unitario
                                        FROM finalf_venta WHERE id_venta = ? FOR UPDATE";
                AgregarEntero(comando, "id", id);
                using (var lector = comando.ExecuteReader())
                {
                    if (!lector.Read())
                        throw new InvalidOperationException("La venta ya no existe. Actualice la lista.");

                    return new VentaActual(lector.GetInt32(0), lector.GetInt32(1), lector.GetInt32(2), lector.GetDecimal(3));
                }
            }
        }

        private static DataTable Consultar(string sql)
        {
            using (var conexion = AbrirConexion())
            using (var comando = new OdbcCommand(sql, conexion))
            using (var adaptador = new OdbcDataAdapter(comando))
            {
                var datos = new DataTable();
                adaptador.Fill(datos);
                return datos;
            }
        }

        private static OdbcConnection AbrirConexion()
        {
            var conexion = new OdbcConnection(CadenaConexion);
            try
            {
                conexion.Open();
                return conexion;
            }
            catch (OdbcException)
            {
                conexion.Dispose();
                throw;
            }
        }

        private static string NombreCatalogo(Catalogo catalogo)
        {
            switch (catalogo)
            {
                case Catalogo.Cliente: return "cliente";
                case Catalogo.Producto: return "producto";
                case Catalogo.Vendedor: return "vendedor";
                default: throw new ArgumentOutOfRangeException(nameof(catalogo));
            }
        }

        private static void AgregarEntero(OdbcCommand comando, string nombre, int valor)
        {
            comando.Parameters.Add(nombre, OdbcType.Int).Value = valor;
        }

        private static void AgregarDecimal(OdbcCommand comando, string nombre, decimal valor, byte precision)
        {
            var parametro = comando.Parameters.Add(nombre, OdbcType.Decimal);
            parametro.Precision = precision;
            parametro.Scale = 2;
            parametro.Value = valor;
        }

        private sealed class VentaActual
        {
            public VentaActual(int cliente, int producto, int vendedor, decimal precio)
            {
                Cliente = cliente;
                Producto = producto;
                Vendedor = vendedor;
                Precio = precio;
            }

            public int Cliente { get; }
            public int Producto { get; }
            public int Vendedor { get; }
            public decimal Precio { get; }
        }
    }
}
