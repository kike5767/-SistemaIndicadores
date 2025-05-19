using System.ComponentModel.DataAnnotations;

namespace SistemaIndicadores.Shared.Entities;

public class Rol
{
    [Key]
    public int Id { get; set; } // ✅ Clave primaria autoincremental

    [Required]
    [StringLength(100)]
    public string Nombre { get; set; } = null!; // ✅ Nombre del rol

    // ✅ Propiedad de navegación para la relación muchos a muchos con usuarios
    public ICollection<RolUsuario> RolesUsuario { get; set; } = new List<RolUsuario>();
} 