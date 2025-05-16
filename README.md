# Sistema de Indicadores

Sistema web para la gestión y seguimiento de indicadores de desempeño, desarrollado con las últimas tecnologías y mejores prácticas.

## Características Actualizadas

- 🎨 Interfaz moderna y responsiva con MudBlazor
- 🔒 Autenticación y autorización basada en JWT
- 📊 Gestión de indicadores y categorías
- 📈 Cálculo y seguimiento de métricas
- 📱 Diseño adaptativo para dispositivos móviles
- 🌙 Modo oscuro/claro con persistencia
- ⚡ Animaciones y transiciones suaves
- 🔄 Manejo de estados de carga y errores
- 📝 Validaciones en tiempo real
- 🚀 Rendimiento optimizado
- 📦 Backup automático del proyecto

## Tecnologías Implementadas

- .NET 8
- Blazor WebAssembly
- Entity Framework Core 8.0.1
- MudBlazor 6.11.2
- JWT Authentication
- SQL Server
- Swagger/OpenAPI

## Estructura del Proyecto

```
SistemaIndicadores/
├── SistemaIndicadores.API/     # Backend API
│   ├── Controllers/            # Controladores de la API
│   ├── Data/                   # Contexto y configuración de BD
│   └── Properties/             # Configuración del proyecto
├── SistemaIndicadores.Shared/  # Modelos y DTOs compartidos
│   └── Entities/              # Entidades del dominio
├── SistemaIndicadores.WEB/     # Frontend Blazor WebAssembly
│   ├── Auth/                  # Autenticación
│   ├── Shared/               # Componentes compartidos
│   └── Pages/               # Páginas de la aplicación
└── backup/                  # Copia de seguridad del proyecto
```

## Requisitos del Sistema

- .NET 8 SDK
- SQL Server 2019 o superior
- Visual Studio 2022 o superior
- Node.js 14+ (para desarrollo)

## Configuración y Ejecución

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/tu-usuario/SistemaIndicadores.git
   ```

2. Restaurar paquetes NuGet:
   ```bash
   dotnet restore
   ```

3. Configurar la base de datos:
   - Actualizar la cadena de conexión en `appsettings.json`
   - Ejecutar migraciones:
     ```bash
     cd SistemaIndicadores.API
     dotnet ef database update
     ```

4. Ejecutar el proyecto:
   - API (Terminal 1):
     ```bash
     cd SistemaIndicadores.API
     dotnet run
     ```
   - Web (Terminal 2):
     ```bash
     cd SistemaIndicadores.WEB
     dotnet run
     ```

5. Acceder a las aplicaciones:
   - Frontend: https://localhost:7002
   - API/Swagger: https://localhost:7001/swagger

## Credenciales de Prueba

- **Administrador**:
  - Usuario: admin@sistema.com
  - Contraseña: Admin123!

- **Usuario Regular**:
  - Usuario: usuario@sistema.com
  - Contraseña: Usuario123!

## Backup y Restauración

El proyecto incluye un sistema de backup automático en la carpeta `backup/`. Para restaurar:

1. Copiar el contenido de la carpeta `backup/`
2. Pegar en la ubicación deseada
3. Restaurar paquetes y base de datos

## Mejoras Implementadas

- Interfaz de usuario moderna con MudBlazor
- Sistema de autenticación JWT mejorado
- Manejo de estados de carga y errores
- Animaciones y transiciones fluidas
- Tema claro/oscuro personalizable
- Componentes reutilizables
- Validaciones mejoradas
- Mensajes de retroalimentación
- Diseño responsivo optimizado
- Sistema de backup integrado

## Contribuir

1. Fork el proyecto
2. Crear rama de feature (`git checkout -b feature/NuevaFuncionalidad`)
3. Commit cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/NuevaFuncionalidad`)
5. Crear Pull Request

## Licencia

Este proyecto está bajo la Licencia MIT.

## Contacto y Soporte

Para soporte técnico o consultas:
- Email: soporte@sistemaindicadores.com
- GitHub Issues: [Crear Issue](https://github.com/tu-usuario/SistemaIndicadores/issues)
