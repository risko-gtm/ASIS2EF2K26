using System;
using System.Windows.Forms;
using CapaVista_Prueba;
using CapaVista_Seguridad;

namespace Ejecucion_Prueba
{
    internal static class Program
    {
        [STAThread]
        private static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new FrmLogin());
        }
    }
}
