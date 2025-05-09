using Microsoft.EntityFrameworkCore;
using SistemaIndicadores.Shared.Entities;

namespace SistemaIndicadores.API.Data
{
    // Contexto de base de datos para conectar las entidades con SQL Server
    public class DataContext : DbContext
    {
        // Constructor para recibir las opciones de configuración
        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {
        }

        // Definición de DbSet para cada entidad que se relaciona con la base de datos
        public DbSet<Indicador> Indicadores { get; set; }
        public DbSet<Categoria> Categorias { get; set; }
        public DbSet<Usuario> Usuarios { get; set; } // Nueva entidad

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Configuración de índice único para 'Codigo' en la entidad Indicador
            modelBuilder.Entity<Indicador>().HasIndex(x => x.Codigo).IsUnique();

            // Relaciones entre entidades
            modelBuilder.Entity<Indicador>()
                .HasOne(i => i.Categoria) // Indicador pertenece a una Categoría
                .WithMany(c => c.Indicadores) // Una Categoría tiene varios Indicadores
                .HasForeignKey(i => i.CategoriaId);

            // Configuración para la entidad Usuario
            modelBuilder.Entity<Usuario>().HasIndex(u => u.Email).IsUnique(); // Email único para cada usuario
        }
    }
}