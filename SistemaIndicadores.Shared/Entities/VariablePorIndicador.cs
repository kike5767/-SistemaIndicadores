using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SistemaIndicadores.Shared.Entities;

public class VariablePorIndicador
{
    [Key]
    public int Id { get; set; } // PK autoincremental

    [Required]
    public int FkIdVariable { get; set; } // FK a Variable
    [ForeignKey("FkIdVariable")]
    public Variable Variable { get; set; } = null!;

    [Required]
    public int FkIdIndicador { get; set; } // FK a Indicador
    [ForeignKey("FkIdIndicador")]
    public Indicador Indicador { get; set; } = null!;

    [Required]
    public double Dato { get; set; } // Valor del dato

    [Required]
    [StringLength(100)]
    public string FkEmailUsuario { get; set; } = null!; // FK a Usuario
    [ForeignKey("FkEmailUsuario")]
    public Usuario Usuario { get; set; } = null!;

    public DateTime FechaDato { get; set; } = DateTime.Now; // Fecha del dato
} 