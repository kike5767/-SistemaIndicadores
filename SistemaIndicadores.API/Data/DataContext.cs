using Microsoft.EntityFrameworkCore; // ✅ Importa Entity Framework Core
using SistemaIndicadores.Shared.Entities; // ✅ Referencia a las entidades compartidas

namespace SistemaIndicadores.API.Data
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options) {}

        // 📌 Definición de las tablas en la base de datos mediante DbSet
        public DbSet<Usuario> Usuarios => Set<Usuario>();
        public DbSet<Rol> Roles => Set<Rol>();
        public DbSet<RolUsuario> RolesUsuario => Set<RolUsuario>();
        public DbSet<Categoria> Categorias { get; set; } // ✅ Representa la tabla 'Categorias'
        public DbSet<Indicador> Indicadores { get; set; } // ✅ Representa la tabla 'Indicadores'
        public DbSet<CalculoIndicadores> CalculoIndicadores { get; set; } // ✅ Representa la tabla 'CalculoIndicadores'
        public DbSet<Variable> Variables => Set<Variable>();
        public DbSet<VariablePorIndicador> VariablesPorIndicador => Set<VariablePorIndicador>();
        public DbSet<ResultadoIndicador> ResultadosIndicador => Set<ResultadoIndicador>();
        public DbSet<Fuente> Fuentes => Set<Fuente>();
        public DbSet<FuentePorIndicador> FuentesPorIndicador => Set<FuentePorIndicador>();
        public DbSet<Actor> Actores => Set<Actor>();
        public DbSet<ResponsablePorIndicador> ResponsablesPorIndicador => Set<ResponsablePorIndicador>();

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // 📌 Índices y restricciones únicas para evitar datos duplicados
            modelBuilder.Entity<Usuario>()
                .HasIndex(u => u.Email)
                .IsUnique(); // ⚠️ Evita correos duplicados

            modelBuilder.Entity<Categoria>()
                .HasIndex(c => c.Nombre)
                .IsUnique(); // ⚠️ Los nombres de categorías deben ser únicos

            modelBuilder.Entity<Indicador>()
                .HasIndex(i => new { i.Nombre, i.CategoriaId })
                .IsUnique(); // ⚠️ Evita nombres repetidos dentro de una categoría

            // 📌 Relaciones entre entidades en Entity Framework
            modelBuilder.Entity<Indicador>()
                .HasOne(i => i.Categoria) // 🔗 Indicador pertenece a una categoría
                .WithMany(c => c.Indicadores) // 🔗 Una categoría tiene múltiples indicadores
                .HasForeignKey(i => i.CategoriaId) 
                .OnDelete(DeleteBehavior.Restrict); // ⚠️ Evita eliminación en cascada accidental

            modelBuilder.Entity<CalculoIndicadores>()
                .HasOne(c => c.Indicador) // 🔗 Cada cálculo pertenece a un indicador
                .WithMany(i => i.Calculos) 
                .HasForeignKey(c => c.IndicadorId)
                .OnDelete(DeleteBehavior.Restrict); // ⚠️ Protección contra eliminaciones inesperadas

            modelBuilder.Entity<CalculoIndicadores>()
                .HasOne(c => c.Usuario) // 🔗 Cada cálculo está asociado a un usuario
                .WithMany(u => u.Calculos) 
                .HasForeignKey(c => c.UsuarioId)
                .OnDelete(DeleteBehavior.Restrict); // ⚠️ Protección contra eliminaciones erróneas

            // 📌 Configuración de precisión para campos decimales
            modelBuilder.Entity<CalculoIndicadores>()
                .Property(c => c.ValorReal)
                .HasPrecision(18, 2); // ✅ Valores financieros con 2 decimales

            modelBuilder.Entity<CalculoIndicadores>()
                .Property(c => c.ValorMeta)
                .HasPrecision(18, 2);

            modelBuilder.Entity<CalculoIndicadores>()
                .Property(c => c.PorcentajeCumplimiento)
                .HasPrecision(18, 2);

            // 📌 Inserción de usuario administrador por defecto
            modelBuilder.Entity<Usuario>().HasData(
                new Usuario
                {
                    Id = 1,
                    Nombre = "Administrador",
                    Email = "admin@sistemaindicadores.com",
                    Password = BCrypt.Net.BCrypt.HashPassword("Admin123!"), // ✅ Contraseña cifrada con seguridad
                    Rol = "Administrador",
                    Activo = true,
                    FechaCreacion = DateTime.Now
                }
            );

            // Configuración de Usuario
            modelBuilder.Entity<Usuario>(entity =>
            {
                entity.ToTable("usuario");
                entity.HasKey(e => e.Email);
                entity.Property(e => e.Email).HasColumnName("email");
                entity.Property(e => e.Contrasena).HasColumnName("contrasena");
            });

            // Configuración de Rol
            modelBuilder.Entity<Rol>(entity =>
            {
                entity.ToTable("rol");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasColumnName("id");
                entity.Property(e => e.Nombre).HasColumnName("nombre");
            });

            // Configuración de RolUsuario
            modelBuilder.Entity<RolUsuario>(entity =>
            {
                entity.ToTable("rol_usuario");
                entity.HasKey(e => new { e.FkEmail, e.FkIdRol });
                
                entity.Property(e => e.FkEmail).HasColumnName("fkemail");
                entity.Property(e => e.FkIdRol).HasColumnName("fkidrol");

                // Configuración de relaciones
                entity.HasOne(e => e.Usuario)
                    .WithMany(e => e.RolesUsuario)
                    .HasForeignKey(e => e.FkEmail)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(e => e.Rol)
                    .WithMany(e => e.RolesUsuario)
                    .HasForeignKey(e => e.FkIdRol);
            });

            // Datos iniciales
            modelBuilder.Entity<Rol>().HasData(
                new Rol { Id = 1, Nombre = "Administrador" },
                new Rol { Id = 2, Nombre = "Usuario" }
            );

            // Configuración de Variable
            modelBuilder.Entity<Variable>(entity =>
            {
                entity.ToTable("variable");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasColumnName("id");
                entity.Property(e => e.Nombre).HasColumnName("nombre");
                entity.Property(e => e.FechaCreacion).HasColumnName("fechacreacion");
                entity.Property(e => e.FkEmailUsuario).HasColumnName("fkemailusuario");
                entity.HasOne(e => e.Usuario)
                    .WithMany(u => u.Variables)
                    .HasForeignKey(e => e.FkEmailUsuario);
            });

            // Configuración de VariablePorIndicador
            modelBuilder.Entity<VariablePorIndicador>(entity =>
            {
                entity.ToTable("variablesporindicador");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasColumnName("id");
                entity.Property(e => e.FkIdVariable).HasColumnName("fkidvariable");
                entity.Property(e => e.FkIdIndicador).HasColumnName("fkidindicador");
                entity.Property(e => e.Dato).HasColumnName("dato");
                entity.Property(e => e.FkEmailUsuario).HasColumnName("fkemailusuario");
                entity.Property(e => e.FechaDato).HasColumnName("fechadato");
                entity.HasOne(e => e.Variable)
                    .WithMany(v => v.VariablesPorIndicador)
                    .HasForeignKey(e => e.FkIdVariable);
                entity.HasOne(e => e.Usuario)
                    .WithMany(u => u.VariablesPorIndicador)
                    .HasForeignKey(e => e.FkEmailUsuario);
            });

            // Configuración de ResultadoIndicador
            modelBuilder.Entity<ResultadoIndicador>(entity =>
            {
                entity.ToTable("resultadoindicador");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasColumnName("id");
                entity.Property(e => e.Resultado).HasColumnName("resultado");
                entity.Property(e => e.FechaCalculo).HasColumnName("fechacalculo");
                entity.Property(e => e.FkIdIndicador).HasColumnName("fkidindicador");
                entity.HasOne(e => e.Indicador)
                    .WithMany()
                    .HasForeignKey(e => e.FkIdIndicador);
            });

            // Configuración de Fuente
            modelBuilder.Entity<Fuente>(entity =>
            {
                entity.ToTable("fuente");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasColumnName("id");
                entity.Property(e => e.Nombre).HasColumnName("nombre");
            });

            // Configuración de FuentePorIndicador
            modelBuilder.Entity<FuentePorIndicador>(entity =>
            {
                entity.ToTable("fuentesporindicador");
                entity.HasKey(e => new { e.FkIdFuente, e.FkIdIndicador });
                entity.Property(e => e.FkIdFuente).HasColumnName("fkidfuente");
                entity.Property(e => e.FkIdIndicador).HasColumnName("fkidindicador");
                entity.HasOne(e => e.Fuente)
                    .WithMany(f => f.FuentesPorIndicador)
                    .HasForeignKey(e => e.FkIdFuente);
                entity.HasOne(e => e.Indicador)
                    .WithMany()
                    .HasForeignKey(e => e.FkIdIndicador);
            });

            // Configuración de Actor
            modelBuilder.Entity<Actor>(entity =>
            {
                entity.ToTable("actor");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasColumnName("id");
                entity.Property(e => e.Nombre).HasColumnName("nombre");
                entity.Property(e => e.FkIdTipoActor).HasColumnName("fkidtipoactor");
            });

            // Configuración de ResponsablePorIndicador
            modelBuilder.Entity<ResponsablePorIndicador>(entity =>
            {
                entity.ToTable("responsablesporindicador");
                entity.HasKey(e => new { e.FkIdResponsable, e.FkIdIndicador });
                entity.Property(e => e.FkIdResponsable).HasColumnName("fkidresponsable");
                entity.Property(e => e.FkIdIndicador).HasColumnName("fkidindicador");
                entity.Property(e => e.FechaAsignacion).HasColumnName("fechaasignacion");
                entity.HasOne(e => e.Responsable)
                    .WithMany(a => a.ResponsablesPorIndicador)
                    .HasForeignKey(e => e.FkIdResponsable);
                entity.HasOne(e => e.Indicador)
                    .WithMany()
                    .HasForeignKey(e => e.FkIdIndicador);
            });
        }
    }
}