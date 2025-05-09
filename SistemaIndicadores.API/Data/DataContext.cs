using Microsoft.EntityFrameworkCore;
using SistemaIndicadores.Shared.Entities;

namespace SistemaIndicadores.API.Data
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {
        }

        public DbSet<Indicador> Indicadores { get; set; }
        public DbSet<Categoria> Categorias { get; set; }
        public DbSet<Usuario> Usuarios { get; set; }
        public DbSet<CalculoIndicadores> CalculoIndicadores { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Indicador>().HasIndex(x => x.Codigo).IsUnique();

            // 🔥 Corregimos la relación entre Indicador y Categoria
            modelBuilder.Entity<Indicador>()
                .HasOne(i => i.Categoria) 
                .WithMany(c => c.Indicadores) 
                .HasForeignKey(i => i.CategoriaId) 
                .OnDelete(DeleteBehavior.Restrict); 

            // 🔥 Asegurar que Usuario tiene clave primaria
            modelBuilder.Entity<Usuario>().HasKey(u => u.Id);
            modelBuilder.Entity<Usuario>().HasIndex(u => u.Email).IsUnique();
        }
    }
}