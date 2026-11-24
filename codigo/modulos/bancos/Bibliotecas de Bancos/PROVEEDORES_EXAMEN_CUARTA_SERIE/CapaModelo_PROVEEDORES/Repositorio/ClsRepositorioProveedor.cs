/*Oscar Emilio Morales Lemus; 9959-23-3070*/
using CapaModelo_PROVEEDORES.Contratos;
using CapaModelo_PROVEEDORES.Entidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaModelo_PROVEEDORES.Repositorio
{
    public class ClsRepositorioProveedor : ClsSentencias, IRepositorioProveedor
    {
        private string _SelectAll;
        private string _Insert;
        private string _Update;
        private string _Delete;

        public ClsRepositorioProveedor()
        {
            _SelectAll = "SELECT * FROM tbl_proveedor";
            _Insert = "INSERT INTO tbl_proveedor (pk_idProveedor, nombreProveedor, direccionProveedor, telefonoProveedor, estadoProveedor) VALUES (?, ?, ?, ?, ?)";
            _Update = "UPDATE tbl_proveedor SET nombreProveedor=?, direccionProveedor=?, telefonoProveedor=?, estadoProveedor=? WHERE pk_idProveedor=?";
            _Delete = "DELETE FROM tbl_proveedor WHERE pk_idProveedor=?";
        }

        public int BancosMetAgregar(ClsProveedor Entidad)
        {
            var Parametros = new List<OdbcParameter>();
            Parametros.Add(new OdbcParameter("p_idProveedor", Entidad.pk_idProveedor));
            Parametros.Add(new OdbcParameter("p_nombreProveedor", Entidad.nombreProveedor));
            Parametros.Add(new OdbcParameter("p_direccionProveedor", Entidad.direccionProveedor));
            Parametros.Add(new OdbcParameter("p_telefonoProveedor", Entidad.telefonoProveedor));
            Parametros.Add(new OdbcParameter("p_estadoProveedor", Entidad.estadoProveedor));

            return BancosMetEjecucionNonQuery(_Insert, Parametros, CommandType.Text);
        }

        public int BancosMetEditar(ClsProveedor Entidad)
        {
            var Parametros = new List<OdbcParameter>();
            Parametros.Add(new OdbcParameter("p_nombreProveedor", Entidad.nombreProveedor));
            Parametros.Add(new OdbcParameter("p_direccionProveedor", Entidad.direccionProveedor));
            Parametros.Add(new OdbcParameter("p_telefonoProveedor", Entidad.telefonoProveedor));
            Parametros.Add(new OdbcParameter("p_estadoProveedor", Entidad.estadoProveedor));
            Parametros.Add(new OdbcParameter("p_idProveedor", Entidad.pk_idProveedor));

            return BancosMetEjecucionNonQuery(_Update, Parametros, CommandType.Text);
        }

        public int BancosMetRemover(ClsProveedor Entidad)
        {
            var Parametros = new List<OdbcParameter>();
            Parametros.Add(new OdbcParameter("p_idProveedor", Entidad.pk_idProveedor));

            return BancosMetEjecucionNonQuery(_Delete, Parametros, CommandType.Text);
        }

        public IEnumerable<ClsProveedor> BancosMetObtenerTodos()
        {
            var ListaPaciente = new List<ClsProveedor>();
            var TablaDatos = BancosMetEjecucionConsulta(_SelectAll, CommandType.Text);
            foreach (DataRow Fila in TablaDatos.Rows)
            {
                var Proveedor = new ClsProveedor();
                Proveedor.pk_idProveedor = Convert.ToInt32(Fila[0]);
                Proveedor.nombreProveedor = Fila[1].ToString();
                Proveedor.direccionProveedor = Fila[2].ToString();
                Proveedor.telefonoProveedor = Fila[3].ToString();
                Proveedor.estadoProveedor = Fila[4] == DBNull.Value ? 0 : Convert.ToInt32(Fila[4]);
                ListaPaciente.Add(Proveedor);
            }
            TablaDatos.Clear();
            TablaDatos = null;
            return ListaPaciente;
        }
    }
}
