

using System;
using System.Collections.Generic;
using System.Windows.Forms;

using CapaContralador_Enlace_Logistica;

namespace CapaVista_Enlace_Logistica.Formularios
{
    public partial class Frm_MantenimientoVenta : Form
    {
        // =====================================================
        // CONTROLADOR
        // =====================================================

        private readonly ClsMantenimientoVentas_Logistica
            _DatosVendedor =
                new ClsMantenimientoVentas_Logistica();

        // =====================================================
        // FUENTES PARA EL REPORTE
        // =====================================================

        private readonly Dictionary<string, object>
            _FuentesReporteVendedor =
                new Dictionary<string, object>();

        // =====================================================
        // CONFIGURACIÓN DEL MÓDULO
        // =====================================================

        private const string TABLA_VENDEDOR = "tbl_vendedor";

        private const int ID_MODULO_LOGISTICA = 1016;

        // IMPORTANTE:
        // Sustituye 0 por el ID real del submódulo Vendedores.
        private const int ID_SUBMODULO_VENDEDOR = 5999;

        // =====================================================
        // CONSTRUCTOR
        // =====================================================

        public Frm_MantenimientoVenta()
        {
            InitializeComponent();

            // Obtener los registros de tipos de transporte.
            List<ClsMantenimientoVentas_Logistica> ListaTipos =
                _DatosVendedor.LogisticaMetObtenerTodos();

            // Asignar los datos al reporte.
            _FuentesReporteVendedor.Add(
                "DsReporteVenta",
                ListaTipos);

            // Configurar el Navegador.
            LogisticaNavVendedor.NavegadorMetConfigurar(
                "tbl_vendedor",
                5000,
                5016,
                _FuentesReporteVendedor);
        }

    }
}