using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SistemaIndicadores.Shared.Entities;

public class FuentePorIndicador
{
    [Required]
    public int FkIdFuente { get; set; } // FK a Fuente
    [ForeignKey("FkIdFuente")]
    public Fuente Fuente { get; set; } = null!;

    [Required]
    public int FkIdIndicador { get; set; } // FK a Indicador
    [ForeignKey("FkIdIndicador")]
    public Indicador Indicador { get; set; } = null!;
} 