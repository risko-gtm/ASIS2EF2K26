using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using System.Drawing;
using System.Windows.Forms;
using CapaControlador_Prueba;
using CapaModelo_Prueba;

namespace CapaVista_Prueba
{
    internal abstract class EditorRegistros
    {
        private DataGridView tabla;
        private Label estado;
        private Button eliminar;
        private Button guardar;
        private bool cargado;
        private bool cambiandoSeleccion;

        public void Conectar(DataGridView tabla, Label estado, Button nuevo, Button guardar, Button eliminar, Button actualizar)
        {
            ConectarTabla(tabla, estado, guardar, eliminar);
            nuevo.Click += (sender, e) => Nuevo();
            guardar.Click += (sender, e) => Guardar();
            eliminar.Click += (sender, e) => Eliminar();
            actualizar.Click += (sender, e) => Ejecutar(Recargar);
        }

        private void ConectarTabla(DataGridView tabla, Label estado, Button guardar, Button eliminar)
        {
            this.tabla = tabla;
            this.estado = estado;
            this.guardar = guardar;
            this.eliminar = eliminar;

            tabla.SelectionChanged += SeleccionCambiada;
        }

        protected int? IdActual { get; private set; }
        protected abstract DataTable Listar();
        protected abstract void CargarCampos(DataRow fila);
        protected abstract void GuardarRegistro();
        protected abstract void EliminarRegistro(int id);
        protected abstract string ConfirmacionEliminar { get; }
        protected virtual void RefrescarOpciones() { }

        public void Activar()
        {
            Ejecutar(() =>
            {
                if (cargado)
                    RefrescarOpciones();
                else
                    Recargar();
            });
        }

        private void Recargar()
        {
            RefrescarOpciones();
            var datos = Listar();
            cambiandoSeleccion = true;
            try
            {
                tabla.DataSource = datos;
                LimpiarSeleccion();
            }
            finally
            {
                cambiandoSeleccion = false;
            }

            cargado = true;
            guardar.Enabled = true;
            MostrarEstado($"Registros: {datos.Rows.Count}");
        }

        private void Nuevo()
        {
            cambiandoSeleccion = true;
            try
            {
                LimpiarSeleccion();
            }
            finally
            {
                cambiandoSeleccion = false;
            }

            MostrarEstado("Nuevo registro");
        }

        private void LimpiarSeleccion()
        {
            tabla.CurrentCell = null;
            tabla.ClearSelection();
            IdActual = null;
            eliminar.Enabled = false;
            CargarCampos(null);
        }

        private void SeleccionCambiada(object sender, EventArgs e)
        {
            if (cambiandoSeleccion || tabla.SelectedRows.Count == 0)
                return;

            var fila = tabla.SelectedRows[0].DataBoundItem as DataRowView;
            if (fila == null)
                return;

            IdActual = Convert.ToInt32(fila["id"]);
            eliminar.Enabled = true;
            CargarCampos(fila.Row);
            MostrarEstado($"Editando registro {IdActual}");
        }

        private void Guardar()
        {
            if (Ejecutar(GuardarRegistro))
                RecargarTrasCambio("Registro guardado.");
        }

        private void Eliminar()
        {
            if (!IdActual.HasValue ||
                MessageBox.Show(tabla.FindForm(), ConfirmacionEliminar, "Confirmar", MessageBoxButtons.YesNo,
                    MessageBoxIcon.Warning, MessageBoxDefaultButton.Button2) != DialogResult.Yes)
                return;

            if (Ejecutar(() => EliminarRegistro(IdActual.Value)))
                RecargarTrasCambio("Cambio guardado.");
        }

        private void RecargarTrasCambio(string mensaje)
        {
            if (Ejecutar(Recargar))
                MostrarEstado(mensaje);
            else
            {
                guardar.Enabled = false;
                eliminar.Enabled = false;
                MostrarEstado(mensaje + " No se pudo actualizar la lista. " + estado.Text, true);
            }
        }

        private bool Ejecutar(Action accion)
        {
            try
            {
                accion();
                return true;
            }
            catch (OdbcException error)
            {
                MostrarEstado("Error al acceder a MySQL mediante el DSN EmbutidosS.A. " + error.Message, true);
            }
            catch (ArgumentException error)
            {
                MostrarEstado(error.Message, true);
            }
            catch (InvalidOperationException error)
            {
                MostrarEstado(error.Message, true);
            }
            return false;
        }

        private void MostrarEstado(string mensaje, bool esError = false)
        {
            estado.ForeColor = esError ? Color.DarkRed : SystemColors.ControlText;
            estado.Text = mensaje;
        }
    }

    internal sealed class EditorVentas : EditorRegistros
    {
        private readonly ControladorPrueba controlador;
        private readonly ComboBox cliente;
        private readonly ComboBox producto;
        private readonly ComboBox vendedor;
        private readonly TextBox cantidad;
        private DataTable clientes;
        private DataTable productos;
        private DataTable vendedores;
        private int clienteOriginal;
        private int productoOriginal;
        private int vendedorOriginal;

        public EditorVentas(ControladorPrueba controlador, ComboBox cliente, ComboBox producto, ComboBox vendedor,
            TextBox cantidad)
        {
            this.controlador = controlador;
            this.cliente = cliente;
            this.producto = producto;
            this.vendedor = vendedor;
            this.cantidad = cantidad;
        }

        protected override string ConfirmacionEliminar => "¿Eliminar definitivamente la venta seleccionada?";

        protected override DataTable Listar()
        {
            return controlador.ListarVentas();
        }

        protected override void RefrescarOpciones()
        {
            var nuevosClientes = controlador.ListarCatalogo(Catalogo.Cliente);
            var nuevosProductos = controlador.ListarCatalogo(Catalogo.Producto);
            var nuevosVendedores = controlador.ListarCatalogo(Catalogo.Vendedor);
            clientes = nuevosClientes;
            productos = nuevosProductos;
            vendedores = nuevosVendedores;
            ActualizarCombo(cliente, clientes, clienteOriginal);
            ActualizarCombo(producto, productos, productoOriginal);
            ActualizarCombo(vendedor, vendedores, vendedorOriginal);
        }

        protected override void CargarCampos(DataRow fila)
        {
            if (clientes == null)
                return;

            clienteOriginal = fila == null ? 0 : Convert.ToInt32(fila["id_cliente"]);
            productoOriginal = fila == null ? 0 : Convert.ToInt32(fila["id_producto"]);
            vendedorOriginal = fila == null ? 0 : Convert.ToInt32(fila["id_vendedor"]);
            LlenarCombo(cliente, clientes, clienteOriginal, clienteOriginal);
            LlenarCombo(producto, productos, productoOriginal, productoOriginal);
            LlenarCombo(vendedor, vendedores, vendedorOriginal, vendedorOriginal);
            cantidad.Text = fila == null ? "1" : Convert.ToString(fila["cantidad"]);
        }

        protected override void GuardarRegistro()
        {
            int unidades;
            if (!int.TryParse(cantidad.Text, out unidades))
                throw new ArgumentException("Ingrese una cantidad entera válida.");

            controlador.GuardarVenta(IdActual, Seleccion(cliente), Seleccion(producto), Seleccion(vendedor), unidades);
        }

        protected override void EliminarRegistro(int id)
        {
            controlador.EliminarVenta(id);
        }

        private static int Seleccion(ComboBox combo)
        {
            if (!(combo.DataSource is List<Opcion> opciones))
                return 0;

            string texto = combo.Text.Trim();
            bool Coincide(Opcion opcion) => string.Equals(texto, opcion.Nombre, StringComparison.CurrentCultureIgnoreCase);
            if (combo.SelectedItem is Opcion seleccionada && Coincide(seleccionada))
                return seleccionada.Id;

            var porNombre = opciones.FindAll(Coincide);
            return porNombre.Count == 1 ? porNombre[0].Id : 0;
        }

        private static void ActualizarCombo(ComboBox combo, DataTable datos, int original)
        {
            string texto = combo.Text;
            int seleccion = Seleccion(combo);
            LlenarCombo(combo, datos, original, seleccion);
            if (seleccion == 0)
                combo.Text = texto;
        }

        private static void LlenarCombo(ComboBox combo, DataTable datos, int original, int seleccion)
        {
            var opciones = new List<Opcion>();
            foreach (DataRow fila in datos.Rows)
            {
                int id = Convert.ToInt32(fila["id"]);
                bool activo = Convert.ToBoolean(fila["is_active"]);
                if (activo || id == original)
                {
                    string nombre = (string)fila["nombre"];
                    opciones.Add(new Opcion(id, activo ? nombre : nombre + " (inactivo)"));
                }
            }

            combo.DataSource = opciones;
            combo.SelectedIndex = opciones.FindIndex(opcion => opcion.Id == seleccion);
            if (combo.SelectedIndex < 0)
                combo.Text = string.Empty;
        }

        private sealed class Opcion
        {
            public Opcion(int id, string nombre)
            {
                Id = id;
                Nombre = nombre;
            }

            public int Id { get; }
            public string Nombre { get; }
        }
    }
}
