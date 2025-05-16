using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SistemaIndicadores.Shared.Entities
{
    /// <summary>
    /// Representa los cálculos asociados a los indicadores en la base de datos.
    /// </summary>
    public class CalculoIndicadores
    {
        // 🔹 Identificador único del cálculo
        [Key]
        public int Id { get; set; }

        // 🔹 Identificador del indicador al que pertenece el cálculo
        [Required]
        public int IndicadorId { get; set; }
        public required Indicador Indicador { get; set; }

        // 🔹 Resultado del cálculo numérico
        [Required]
        [Range(0, double.MaxValue, ErrorMessage = "El resultado debe ser positivo.")]
        public double Resultado { get; set; }

        // 🔹 Fecha en la que se realizó el cálculo
        public DateTime FechaCalculo { get; set; } = DateTime.UtcNow;

        // 🔹 Observaciones adicionales sobre el cálculo
        public string? Observaciones { get; set; }
    }
}