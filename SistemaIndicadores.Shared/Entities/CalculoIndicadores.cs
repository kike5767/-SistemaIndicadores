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
        [ForeignKey("Indicador")]
        public int FkIdIndicador { get; set; }

        // 🔹 Resultado del cálculo numérico
        [Required]
        public decimal Resultado { get; set; }

        // 🔹 Fecha en la que se realizó el cálculo
        [Required]
        public DateTime FechaCalculo { get; set; } = DateTime.Now;

        // 🔹 Observaciones adicionales sobre el cálculo
        public string? Observaciones { get; set; }
    }
}