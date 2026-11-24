using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

/*
 * ==================================================================
 * Área   : Bancos
 * Autor  : Victor Josue Ortiz Samayoa
 * Carné  : 0901-23-3424
 * Fecha  : 24/11/2026
 * Objetivo: exponer el CRUD de tbl_vendedor mediante el componente
 *           Navegador, incluyendo permisos, bitácora, ayuda y reporte.
 * ==================================================================
 */




namespace CapaVista_DisponibilidadDiaria.Formularios
{
    public partial class FrmVendedores : Form
    {

        public FrmVendedores()
        {
            InitializeComponent();
            Text = "8000 - Catálogo de vendedores";
            StartPosition = FormStartPosition.CenterParent;
            navegador1.NavegadorMetConfigurar("tbl_vendedor", 8000, 8014);
        }

        private void navegador1_Load(object sender, EventArgs e)
        {
            navegador1.Location = new Point(12, 12);
            navegador1.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
        }
    }
}
