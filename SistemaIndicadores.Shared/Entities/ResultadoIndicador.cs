using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SistemaIndicadores.Shared.Entities;

public class ResultadoIndicador
{
    [Key]
    public int Id { get; set; } // PK autoincremental

    [Required]
    public double Resultado { get; set; } // Valor del resultado

    public DateTime FechaCalculo { get; set; } = DateTime.Now; // Fecha de cálculo

    [Required]
    public int FkIdIndicador { get; set; } // FK a Indicador
    [ForeignKey("FkIdIndicador")]
    public Indicador Indicador { get; set; } = null!;
} 