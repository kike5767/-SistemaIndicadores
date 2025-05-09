using Microsoft.AspNetCore.Builder;  
using Microsoft.AspNetCore.Hosting;  
using Microsoft.Extensions.DependencyInjection;  
using Microsoft.Extensions.Hosting;  
using Microsoft.EntityFrameworkCore;  
using SistemaIndicadores.API.Data;  

// 🔥 1️⃣ Crear el `builder` para configurar la aplicación
var builder = WebApplication.CreateBuilder(args);

// 🔥 2️⃣ Agregar servicios necesarios para la API
builder.Services.AddControllers(); // Habilita los controladores de la API
builder.Services.AddEndpointsApiExplorer(); // Permite explorar los endpoints en Swagger
builder.Services.AddSwaggerGen(); // Agrega la documentación de Swagger

// 🔥 3️⃣ Configuración de la base de datos con verificación de la cadena de conexión
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
if (string.IsNullOrEmpty(connectionString))  
{  
    throw new Exception("⚠️ La cadena de conexión 'DefaultConnection' no está configurada en appsettings.json");  
}

// 🔹 Agregar soporte para Entity Framework y la conexión a SQL Server
builder.Services.AddDbContext<DataContext>(options =>  
    options.UseSqlServer(connectionString));  

// 🔥 4️⃣ Construcción de la aplicación
var app = builder.Build();

// 🔥 5️⃣ Manejo de errores en modo desarrollo
if (app.Environment.IsDevelopment())  
{  
    app.UseDeveloperExceptionPage(); // 🔥 Muestra errores detallados en `Development`
    app.UseSwagger(); // Activa la documentación Swagger
    app.UseSwaggerUI(); // Muestra la interfaz de Swagger en el navegador
}

// 🔥 6️⃣ Configuración de middlewares esenciales
app.UseHttpsRedirection(); // 🔹 Fuerza redirección HTTPS para mayor seguridad
app.UseRouting(); // 🔹 Habilita el sistema de rutas de la API
app.UseAuthorization(); // 🔹 Habilita autorización (si la API usa autenticación)

// 🔥 7️⃣ Mapeo de controladores para manejar las solicitudes
app.MapControllers(); // 📌 Registra automáticamente los endpoints definidos en la API

// 🔥 8️⃣ Arrancar la aplicación
app.Run(); // 🚀 Inicia la API y la deja lista para recibir solicitudes