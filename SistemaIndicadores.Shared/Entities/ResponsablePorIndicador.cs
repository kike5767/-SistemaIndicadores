using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SistemaIndicadores.Shared.Entities;

public class ResponsablePorIndicador
{
    [Required]
    [StringLength(50)]
    public string FkIdResponsable { get; set; } = null!; // FK a Actor
    [ForeignKey("FkIdResponsable")]
    public Actor Responsable { get; set; } = null!;

    [Required]
    public int FkIdIndicador { get; set; } // FK a Indicador
    [ForeignKey("FkIdIndicador")]
    public Indicador Indicador { get; set; } = null!;

    public DateTime FechaAsignacion { get; set; } = DateTime.Now; // Fecha de asignación
} 