using System;
using System.Collections.Generic;
using CapaModelo_Pacientes.Entidades;
using CapaModelo_Pacientes.Repositorios;

namespace CapaControlador_Pacientes.Modelos_de_Controladores
{
    public class ClsModeloPaciente
    {
        public int IdProveedor { get; set; }
        public string NombreProveedor { get; set; }
        public string DireccionProveedor { get; set; }

        public string TelefonoProveedor { get; set; }
        public int EstadoProveedor { get; set; }
        public string EstadoTexto
        {
            get { return EstadoProveedor == 1 ? "Activo" : EstadoProveedor == 0 ? "Inactivo" : EstadoProveedor.ToString(); }
        }

        public List<ClsModeloPaciente> PacienteMetObtenerParaReporte()
        {
            var lista = new List<ClsModeloPaciente>();
            var repositorio = new ClsRepositorioPaciente();
            foreach (ClsPaciente item in repositorio.PacientesMetObtenerTodos())
            {
                lista.Add(new ClsModeloPaciente
                {
                    IdProveedor = item.IdProveedor,
                    NombreProveedor = item.NombreProveedor,
                    DireccionProveedor = item.DireccionProveedor,
                    TelefonoProveedor = item.TelefonoProveedor,
                    EstadoProveedor = item.EstadoProveedor
                });
            }
            return lista;
        }
    }
}
