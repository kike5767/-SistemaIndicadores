using Microsoft.EntityFrameworkCore;
using SistemaIndicadores.Shared.Entities;

namespace SistemaIndicadores.API.Data;

    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {
        }

    public DbSet<Usuario> Usuarios => Set<Usuario>();
    public DbSet<Categoria> Categorias => Set<Categoria>();
    public DbSet<Indicador> Indicadores => Set<Indicador>();
    public DbSet<CalculoIndicadores> CalculoIndicadores => Set<CalculoIndicadores>();

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

        // Configuración de índices y restricciones únicas
        modelBuilder.Entity<Usuario>()
            .HasIndex(u => u.Email)
            .IsUnique();

        modelBuilder.Entity<Categoria>()
            .HasIndex(c => c.Nombre)
            .IsUnique();

        modelBuilder.Entity<Indicador>()
            .HasIndex(i => new { i.Nombre, i.CategoriaId })
            .IsUnique();

        // Configuración de relaciones
            modelBuilder.Entity<Indicador>()
                .HasOne(i => i.Categoria) 
                .WithMany(c => c.Indicadores) 
                .HasForeignKey(i => i.CategoriaId) 
                .OnDelete(DeleteBehavior.Restrict); 

        modelBuilder.Entity<CalculoIndicadores>()
            .HasOne(c => c.Indicador)
            .WithMany(i => i.Calculos)
            .HasForeignKey(c => c.IndicadorId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<CalculoIndicadores>()
            .HasOne(c => c.Usuario)
            .WithMany(u => u.Calculos)
            .HasForeignKey(c => c.UsuarioId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configuración de campos decimales
        modelBuilder.Entity<CalculoIndicadores>()
            .Property(c => c.ValorReal)
            .HasPrecision(18, 2);

        modelBuilder.Entity<CalculoIndicadores>()
            .Property(c => c.ValorMeta)
            .HasPrecision(18, 2);

        modelBuilder.Entity<CalculoIndicadores>()
            .Property(c => c.PorcentajeCumplimiento)
            .HasPrecision(18, 2);

        // Datos semilla para roles de usuario
        modelBuilder.Entity<Usuario>().HasData(
            new Usuario
            {
                Id = 1,
                Nombre = "Administrador",
                Email = "admin@sistemaindicadores.com",
                Password = BCrypt.Net.BCrypt.HashPassword("Admin123!"),
                Rol = "Administrador",
                Activo = true,
                FechaCreacion = DateTime.Now
            }
        );
    }
}