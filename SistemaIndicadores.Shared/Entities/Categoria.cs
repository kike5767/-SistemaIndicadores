using System.ComponentModel.DataAnnotations;

namespace SistemaIndicadores.Shared.Entities
{
    public class Categoria
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "El nombre es requerido")]
        [StringLength(100, ErrorMessage = "El nombre no puede tener más de 100 caracteres")]
        public string Nombre { get; set; } = string.Empty;

        [StringLength(500, ErrorMessage = "La descripción no puede tener más de 500 caracteres")]
        public string? Descripcion { get; set; }

        public virtual ICollection<Indicador>? Indicadores { get; set; }
    }
} 