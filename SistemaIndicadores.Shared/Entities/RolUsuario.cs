using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SistemaIndicadores.Shared.Entities;

public class RolUsuario
{
    [Required]
    [StringLength(100)]
    public string FkEmail { get; set; } = null!; // ✅ Parte de la clave primaria compuesta, FK a Usuario

    public int FkIdRol { get; set; } // ✅ Parte de la clave primaria compuesta, FK a Rol

    // ✅ Propiedades de navegación
    [ForeignKey("FkEmail")]
    public Usuario Usuario { get; set; } = null!;

    [ForeignKey("FkIdRol")]
    public Rol Rol { get; set; } = null!;
} 