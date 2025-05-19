using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SistemaIndicadores.Shared.Entities;

public class Variable
{
    [Key]
    public int Id { get; set; } // PK autoincremental

    [Required]
    [StringLength(200)]
    public string Nombre { get; set; } = null!; // Nombre de la variable

    public DateTime FechaCreacion { get; set; } = DateTime.Now; // Fecha de creación

    [Required]
    [StringLength(100)]
    public string FkEmailUsuario { get; set; } = null!; // FK a Usuario

    [ForeignKey("FkEmailUsuario")]
    public Usuario Usuario { get; set; } = null!;

    // Relación con VariablePorIndicador
    public ICollection<VariablePorIndicador> VariablesPorIndicador { get; set; } = new List<VariablePorIndicador>();
} 