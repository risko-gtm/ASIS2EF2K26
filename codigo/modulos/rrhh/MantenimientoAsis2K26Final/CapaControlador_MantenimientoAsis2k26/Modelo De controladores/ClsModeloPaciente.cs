using CapaModelo_MantenimientoAsis2k26.Contratos;
using CapaModelo_MantenimientoAsis2k26.Entidades;
using CapaModelo_MantenimientoAsis2k26.Repositorios;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace CapaControlador_MantenimientoAsis2k26.Modelo_De_controladores
{
    public class ClsModeloPaciente
    {
        private int _IdPaciente;
        private string _NombrePaciente;
        private string _ApellidoPaciente;
        private DateTime? _FechaNacimientoPaciente;
        private string _SexoPaciente;
        private string _DireccionPaciente;
        private string _TelefonoPaciente;
        private int? _EstadoPaciente;

        public int IdPaciente { get => _IdPaciente; set => _IdPaciente = value; }
        public string NombrePaciente { get => _NombrePaciente; set => _NombrePaciente = value; }
        public string ApellidoPaciente { get => _ApellidoPaciente; set => _ApellidoPaciente = value; }
        public DateTime? FechaNacimientoPaciente { get => _FechaNacimientoPaciente; set => _FechaNacimientoPaciente = value; }
        public string SexoPaciente { get => _SexoPaciente; set => _SexoPaciente = value; }
        public string DireccionPaciente { get => _DireccionPaciente; set => _DireccionPaciente = value; }
        public string TelefonoPaciente { get => _TelefonoPaciente; set => _TelefonoPaciente = value; }
        public int? EstadoPaciente { get => _EstadoPaciente; set => _EstadoPaciente = value; }

        private ClsRepositorioPaciente _RepositorioPaciente = new ClsRepositorioPaciente();

        public List<ClsModeloPaciente> PacienteMetObtenerParaReporte()
        {
            var Resultado = _RepositorioPaciente.SeguridadMetObtenerTodos();
            var Lista = new List<ClsModeloPaciente>();

            foreach (ClsPaciente Item in Resultado)
            {
                Lista.Add(new ClsModeloPaciente
                {
                    _IdPaciente = Item.IdPaciente,
                    _NombrePaciente = Item.NombrePaciente,
                    _ApellidoPaciente = Item.ApellidoPaciente,
                    _FechaNacimientoPaciente = Item.FechaNacimientoPaciente,
                    _SexoPaciente = Item.SexoPaciente,
                    _DireccionPaciente = Item.DireccionPaciente,
                    _TelefonoPaciente = Item.TelefonoPaciente,
                    _EstadoPaciente = Item.EstadoPaciente
                });
            }

            return Lista;
        }
    }
}
