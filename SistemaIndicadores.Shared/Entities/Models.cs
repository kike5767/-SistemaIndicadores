using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace SistemaIndicadores.Shared.Entities;

/// <summary>
/// Representa un usuario del sistema
/// </summary>
public class Usuario
{
    /// <summary>
    /// Identificador único del usuario
    /// </summary>
    public int Id { get; set; }

    /// <summary>
    /// Nombre completo del usuario
    /// </summary>
    [Required(ErrorMessage = "El nombre es obligatorio")]
    [MaxLength(100, ErrorMessage = "El nombre no puede tener más de 100 caracteres")]
    [RegularExpression(@"^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$", ErrorMessage = "El nombre solo puede contener letras y espacios")]
    public string Nombre { get; set; } = null!;

    /// <summary>
    /// Correo electrónico del usuario (único)
    /// </summary>
    [Required(ErrorMessage = "El correo es obligatorio")]
    [EmailAddress(ErrorMessage = "El formato del correo no es válido")]
    [MaxLength(150, ErrorMessage = "El correo no puede tener más de 150 caracteres")]
    public string Email { get; set; } = null!;

    /// <summary>
    /// Contraseña del usuario (se almacena hasheada)
    /// </summary>
    [Required(ErrorMessage = "La contraseña es obligatoria")]
    [MinLength(6, ErrorMessage = "La contraseña debe tener al menos 6 caracteres")]
    public string Password { get; set; } = null!;

    /// <summary>
    /// Rol del usuario en el sistema
    /// </summary>
    [Required(ErrorMessage = "El rol es obligatorio")]
    [MaxLength(50)]
    public string Rol { get; set; } = "Usuario";

    /// <summary>
    /// Indica si el usuario está activo
    /// </summary>
    public bool Activo { get; set; } = true;

    /// <summary>
    /// Fecha de creación del registro
    /// </summary>
    public DateTime FechaCreacion { get; set; } = DateTime.Now;

    /// <summary>
    /// Fecha de última modificación del registro
    /// </summary>
    public DateTime? FechaModificacion { get; set; }

    /// <summary>
    /// Cálculos de indicadores realizados por el usuario
    /// </summary>
    [JsonIgnore]
    public virtual ICollection<CalculoIndicadores>? Calculos { get; set; }
}

/// <summary>
/// Representa una categoría de indicadores
/// </summary>
public class Categoria
{
    /// <summary>
    /// Identificador único de la categoría
    /// </summary>
    public int Id { get; set; }

    /// <summary>
    /// Nombre de la categoría
    /// </summary>
    [Required(ErrorMessage = "El nombre es obligatorio")]
    [MaxLength(100, ErrorMessage = "El nombre no puede tener más de 100 caracteres")]
    public string Nombre { get; set; } = null!;

    /// <summary>
    /// Descripción detallada de la categoría
    /// </summary>
    [MaxLength(500, ErrorMessage = "La descripción no puede tener más de 500 caracteres")]
    public string? Descripcion { get; set; }

    /// <summary>
    /// Indica si la categoría está activa
    /// </summary>
    public bool Activo { get; set; } = true;

    /// <summary>
    /// Fecha de creación del registro
    /// </summary>
    public DateTime FechaCreacion { get; set; } = DateTime.Now;

    /// <summary>
    /// Fecha de última modificación del registro
    /// </summary>
    public DateTime? FechaModificacion { get; set; }

    /// <summary>
    /// Indicadores que pertenecen a esta categoría
    /// </summary>
    [JsonIgnore]
    public virtual ICollection<Indicador>? Indicadores { get; set; }
}

/// <summary>
/// Representa un indicador del sistema
/// </summary>
public class Indicador
{
    /// <summary>
    /// Identificador único del indicador
    /// </summary>
    public int Id { get; set; }

    /// <summary>
    /// Nombre del indicador
    /// </summary>
    [Required(ErrorMessage = "El nombre es obligatorio")]
    [MaxLength(100, ErrorMessage = "El nombre no puede tener más de 100 caracteres")]
    public string Nombre { get; set; } = null!;

    /// <summary>
    /// Descripción detallada del indicador
    /// </summary>
    [Required(ErrorMessage = "La descripción es obligatoria")]
    [MaxLength(500, ErrorMessage = "La descripción no puede tener más de 500 caracteres")]
    public string Descripcion { get; set; } = null!;

    /// <summary>
    /// Fórmula de cálculo del indicador
    /// </summary>
    [Required(ErrorMessage = "La fórmula es obligatoria")]
    [MaxLength(1000, ErrorMessage = "La fórmula no puede tener más de 1000 caracteres")]
    public string Formula { get; set; } = null!;

    /// <summary>
    /// Unidad de medida del indicador (%, USD, etc.)
    /// </summary>
    [Required(ErrorMessage = "La unidad de medida es obligatoria")]
    [MaxLength(50, ErrorMessage = "La unidad de medida no puede tener más de 50 caracteres")]
    public string UnidadMedida { get; set; } = null!;

    /// <summary>
    /// Frecuencia de medición del indicador
    /// </summary>
    [Required(ErrorMessage = "La frecuencia de medición es obligatoria")]
    [MaxLength(50)]
    public string FrecuenciaMedicion { get; set; } = null!;

    /// <summary>
    /// Responsable del indicador
    /// </summary>
    [Required(ErrorMessage = "El responsable es obligatorio")]
    [MaxLength(100)]
    public string Responsable { get; set; } = null!;

    /// <summary>
    /// Indica si el indicador está activo
    /// </summary>
    public bool Activo { get; set; } = true;

    /// <summary>
    /// Fecha de creación del registro
    /// </summary>
    public DateTime FechaCreacion { get; set; } = DateTime.Now;

    /// <summary>
    /// Fecha de última modificación del registro
    /// </summary>
    public DateTime? FechaModificacion { get; set; }

    /// <summary>
    /// ID de la categoría a la que pertenece el indicador
    /// </summary>
    public int CategoriaId { get; set; }
    
    /// <summary>
    /// Categoría a la que pertenece el indicador
    /// </summary>
    [JsonIgnore]
    [ForeignKey("CategoriaId")]
    public virtual Categoria? Categoria { get; set; }

    /// <summary>
    /// Historial de cálculos del indicador
    /// </summary>
    [JsonIgnore]
    public virtual ICollection<CalculoIndicadores>? Calculos { get; set; }
}

/// <summary>
/// Representa el cálculo de un indicador en un período específico
/// </summary>
public class CalculoIndicadores
{
    /// <summary>
    /// Identificador único del cálculo
    /// </summary>
    public int Id { get; set; }

    /// <summary>
    /// Valor real alcanzado
    /// </summary>
    [Required(ErrorMessage = "El valor real es obligatorio")]
    [Range(0, double.MaxValue, ErrorMessage = "El valor real debe ser mayor o igual a 0")]
    [Column(TypeName = "decimal(18,2)")]
    public decimal ValorReal { get; set; }

    /// <summary>
    /// Valor meta establecido
    /// </summary>
    [Required(ErrorMessage = "El valor meta es obligatorio")]
    [Range(0, double.MaxValue, ErrorMessage = "El valor meta debe ser mayor o igual a 0")]
    [Column(TypeName = "decimal(18,2)")]
    public decimal ValorMeta { get; set; }

    /// <summary>
    /// Porcentaje de cumplimiento
    /// </summary>
    [Column(TypeName = "decimal(18,2)")]
    public decimal PorcentajeCumplimiento { get; set; }

    /// <summary>
    /// Período al que corresponde el cálculo
    /// </summary>
    [Required(ErrorMessage = "El período es obligatorio")]
    public DateTime Periodo { get; set; }

    /// <summary>
    /// Observaciones o notas sobre el cálculo
    /// </summary>
    [MaxLength(1000, ErrorMessage = "Las observaciones no pueden tener más de 1000 caracteres")]
    public string? Observaciones { get; set; }

    /// <summary>
    /// Estado del cálculo (Pendiente, Aprobado, Rechazado)
    /// </summary>
    [Required]
    [MaxLength(50)]
    public string Estado { get; set; } = "Pendiente";

    /// <summary>
    /// Indica si el cálculo está activo
    /// </summary>
    public bool Activo { get; set; } = true;

    /// <summary>
    /// Fecha de realización del cálculo
    /// </summary>
    public DateTime FechaCalculo { get; set; } = DateTime.Now;

    /// <summary>
    /// Fecha de última modificación del registro
    /// </summary>
    public DateTime? FechaModificacion { get; set; }

    /// <summary>
    /// ID del indicador al que pertenece el cálculo
    /// </summary>
    public int IndicadorId { get; set; }
    
    /// <summary>
    /// Indicador al que pertenece el cálculo
    /// </summary>
    [JsonIgnore]
    [ForeignKey("IndicadorId")]
    public virtual Indicador? Indicador { get; set; }

    /// <summary>
    /// ID del usuario que realizó el cálculo
    /// </summary>
    public int UsuarioId { get; set; }
    
    /// <summary>
    /// Usuario que realizó el cálculo
    /// </summary>
    [JsonIgnore]
    [ForeignKey("UsuarioId")]
    public virtual Usuario? Usuario { get; set; }
} 