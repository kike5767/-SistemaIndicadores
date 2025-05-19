using System.ComponentModel.DataAnnotations;

namespace SistemaIndicadores.Shared.Entities;

public class Usuario
{
    [Key]
    [StringLength(100)]
    public string Email { get; set; } = null!; // ✅ Clave primaria, email del usuario

    [Required]
    [StringLength(100)]
    public string Contrasena { get; set; } = null!; // ✅ Contraseña del usuario (hasheada)

    // ✅ Propiedad de navegación para la relación muchos a muchos con roles
    public ICollection<RolUsuario> RolesUsuario { get; set; } = new List<RolUsuario>();

    // ✅ Propiedad de navegación para variables creadas por el usuario
    public ICollection<Variable> Variables { get; set; } = new List<Variable>();

    // ✅ Propiedad de navegación para datos de variables por indicador
    public ICollection<VariablePorIndicador> VariablesPorIndicador { get; set; } = new List<VariablePorIndicador>();
} 