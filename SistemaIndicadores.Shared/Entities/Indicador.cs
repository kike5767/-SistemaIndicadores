using System.ComponentModel.DataAnnotations;

namespace SistemaIndicadores.Shared.Entities
{
    public class Indicador
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "El código es obligatorio")]
        [StringLength(20, ErrorMessage = "El código no puede tener más de 20 caracteres")]
        public string Codigo { get; set; } = string.Empty;

        [Required(ErrorMessage = "El nombre es obligatorio")]
        [StringLength(100, ErrorMessage = "El nombre no puede tener más de 100 caracteres")]
        public string Nombre { get; set; } = string.Empty;

        [Required(ErrorMessage = "La descripción es obligatoria")]
        public string Descripcion { get; set; } = string.Empty;

        public int CategoriaId { get; set; }
        public Categoria? Categoria { get; set; }

        public DateTime UltimaActualizacion { get; set; }
        public bool RequiereActualizacion { get; set; }

        [Required(ErrorMessage = "El valor actual es obligatorio")]
        public decimal ValorActual { get; set; }

        public decimal? MetaAnual { get; set; }
        public string? UnidadMedida { get; set; }
        public string? Frecuencia { get; set; }
        public string? FuenteDatos { get; set; }
        public bool Activo { get; set; } = true;
    }
} 