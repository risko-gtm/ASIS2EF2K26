using System;
using System.Data;
using System.Data.Odbc;
using System.IO;
using System.Windows.Forms;
using CapaControlador_Prueba;

namespace CapaVista_Prueba
{
    public sealed partial class FrmVentas : Form
    {
        private readonly ControladorPrueba controlador = new ControladorPrueba();
        private readonly EditorVentas editor;

        public FrmVentas()
        {
            InitializeComponent();

            editor = new EditorVentas(controlador, cboClienteVenta, cboProductoVenta, cboVendedorVenta, txtCantidadVenta);
            editor.Conectar(dgvVentas, lblEstadoVentas, btnNuevaVenta, btnGuardarVenta, btnEliminarVenta, btnActualizarVentas);
        }

        private void FrmVentas_Activated(object sender, EventArgs e)
        {
            editor.Activar();
        }

        private void BtnReporteVentas_Click(object sender, EventArgs e)
        {
            DataTable ventas;
            try
            {
                ventas = controlador.ListarVentas();
            }
            catch (OdbcException error)
            {
                MessageBox.Show(this, error.Message, "No se pudieron consultar las ventas",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            using (ventas)
            using (var reporte = new FrmReporteVentas(ventas))
                reporte.ShowDialog(this);
        }

        private void BtnAyudaVentas_Click(object sender, EventArgs e)
        {
            for (var directorio = new DirectoryInfo(Application.StartupPath); directorio != null; directorio = directorio.Parent)
            {
                string ruta = Path.Combine(directorio.FullName, "ayuda", "modulos", "compras", "ComprasAyudas.chm");
                if (File.Exists(ruta))
                {
                    Help.ShowHelp(this, ruta);
                    return;
                }
            }

            MessageBox.Show(this, "No se encontró el archivo de ayuda de Compras.", "Ayuda",
                MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
    }
}
