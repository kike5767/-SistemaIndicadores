using System.ComponentModel.DataAnnotations;

namespace SistemaIndicadores.Shared.Entities;

public class Fuente
{
    [Key]
    public int Id { get; set; } // PK autoincremental

    [Required]
    [StringLength(2000)]
    public string Nombre { get; set; } = null!; // Nombre de la fuente

    // Relación con FuentesPorIndicador
    public ICollection<FuentePorIndicador> FuentesPorIndicador { get; set; } = new List<FuentePorIndicador>();
} 