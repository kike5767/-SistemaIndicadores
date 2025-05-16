# Sistema de Indicadores

Sistema web para la gestión y seguimiento de indicadores de desempeño.

## Características

- 🎨 Interfaz moderna y responsiva con MudBlazor
- 🔒 Autenticación y autorización basada en JWT
- 📊 Gestión de indicadores y categorías
- 📈 Cálculo y seguimiento de métricas
- 📱 Diseño adaptativo para dispositivos móviles
- 🌙 Modo oscuro/claro
- ⚡ Animaciones y transiciones suaves
- 🔄 Manejo de estados de carga y errores
- 📝 Validaciones en tiempo real

## Tecnologías

- .NET 8
- Blazor WebAssembly
- Entity Framework Core
- MudBlazor
- JWT Authentication
- SQL Server

## Estructura del Proyecto

```
SistemaIndicadores/
├── SistemaIndicadores.API/     # Backend API
├── SistemaIndicadores.Shared/  # Modelos y DTOs compartidos
└── SistemaIndicadores.WEB/     # Frontend Blazor WebAssembly
```

## Requisitos

- .NET 8 SDK
- SQL Server
- Visual Studio 2022 o superior

## Instalación

1. Clonar el repositorio
2. Restaurar paquetes NuGet
3. Configurar la cadena de conexión en `appsettings.json`
4. Ejecutar migraciones de Entity Framework
5. Compilar y ejecutar el proyecto

## Mejoras Implementadas

- Interfaz de usuario moderna con MudBlazor
- Sistema de autenticación JWT
- Manejo de estados de carga y errores
- Animaciones y transiciones
- Tema claro/oscuro
- Componentes reutilizables
- Validaciones mejoradas
- Mensajes de retroalimentación
- Diseño responsivo

## Contribuir

1. Fork el proyecto
2. Crear una rama (`git checkout -b feature/mejora`)
3. Commit los cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/mejora`)
5. Crear un Pull Request

## Licencia

Este proyecto está bajo la Licencia MIT.
