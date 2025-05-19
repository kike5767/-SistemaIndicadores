using System.ComponentModel.DataAnnotations;  // ✅ Importa validaciones de datos
using System.ComponentModel.DataAnnotations.Schema; // ✅ Define claves foráneas y estructura de BD
using System.Text.Json.Serialization; // ✅ Evita referencias circulares en JSON

namespace SistemaIndicadores.Shared.Entities // ✅ Espacio de nombres correcto
{
    /// <summary> Representa una categoría en la BD </summary>
    public class Categoria
    {
        [Key] // 🔹 Clave primaria
        public int Id { get; set; }

        [Required, MaxLength(100)] 
        public string Nombre { get; set; } = null!;

        [MaxLength(500)]
        public string? Descripcion { get; set; } // 🔹 Descripción opcional

        public bool Activo { get; set; } = true; // 🔹 Estado de categoría

        public DateTime FechaCreacion { get; set; } = DateTime.Now;
        public DateTime? FechaModificacion { get; set; }

        [JsonIgnore] // 🔹 Relación con indicadores
        public virtual ICollection<Indicador>? Indicadores { get; set; }
    }

    /// <summary> Representa un indicador en la BD </summary>
    public class Indicador
    {
        [Key]
        public int Id { get; set; }

        [Required, MaxLength(100)]
        public string Nombre { get; set; } = null!;

        public bool Activo { get; set; } = true;
        public DateTime FechaCreacion { get; set; } = DateTime.Now;
        public DateTime? FechaModificacion { get; set; }

        [Required, MaxLength(50)]
        public string FrecuenciaMedicion { get; set; } = null!; // 🔹 Define periodicidad de medición

        [Required, MaxLength(1000)]
        public string Formula { get; set; } = null!; // 🔹 Almacena el cálculo

        [Required, MaxLength(50)]
        public string UnidadMedida { get; set; } = null!; // 🔹 Ejemplo: %, USD, Kg

        public int CategoriaId { get; set; }
        [ForeignKey("CategoriaId")]
        [JsonIgnore] 
        public virtual Categoria? Categoria { get; set; } // 🔹 Relación con categoría

        [JsonIgnore]
        public virtual ICollection<CalculoIndicadores>? Calculos { get; set; } // 🔹 Relación con cálculos
    }
}