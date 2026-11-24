/*
 * ==================================================================
 * Área : ASIS2EF2K26
 * Autor : Oskar Cermeño
 * Carné : 0901-23-15379
 * Fecha : 24/11/2026
 * ==================================================================
 * Propósito :
 *  Punto de entrada del sistema. Abre el login de Seguridad; desde
 *  ahí se entra al MDI de Seguridad o al MDI de Contabilidad con el
 *  usuario autenticado y sus permisos.
 * ===================================================================
*/

using System;
using System.Windows.Forms;
using CapaVista_Seguridad;

namespace Ejecucion_ASIS2EF2K26
{
    internal static class ClsPrograma
    {
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new FrmLogin());
        }
    }
}
