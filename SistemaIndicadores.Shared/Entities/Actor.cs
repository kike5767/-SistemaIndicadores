using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SistemaIndicadores.Shared.Entities;

public class Actor
{
    [Key]
    [StringLength(50)]
    public string Id { get; set; } = null!; // PK

    [Required]
    [StringLength(200)]
    public string Nombre { get; set; } = null!; // Nombre del actor

    [Required]
    public int FkIdTipoActor { get; set; } // FK a TipoActor
    // Relación con TipoActor (no implementada aquí, pero se puede agregar luego)

    // Relación con ResponsablesPorIndicador
    public ICollection<ResponsablePorIndicador> ResponsablesPorIndicador { get; set; } = new List<ResponsablePorIndicador>();
} 