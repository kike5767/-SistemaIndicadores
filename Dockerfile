# Etapa de construcción: Usa la imagen oficial del SDK de .NET 8.0
# Esta etapa se usa para compilar la aplicación
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /src

# Copia los archivos de proyecto (.csproj) y restaura las dependencias
# Se hace esto primero para aprovechar la caché de capas de Docker
COPY ["SistemaIndicadores.API/SistemaIndicadores.API.csproj", "SistemaIndicadores.API/"]
COPY ["SistemaIndicadores.Shared/SistemaIndicadores.Shared.csproj", "SistemaIndicadores.Shared/"]
# Restaura los paquetes NuGet basados en los archivos .csproj
RUN dotnet restore "SistemaIndicadores.API/SistemaIndicadores.API.csproj"

# Copia todo el código fuente al contenedor
COPY . .
# Cambia al directorio del proyecto API
WORKDIR "/src/SistemaIndicadores.API"
# Compila la aplicación en modo Release
RUN dotnet build "SistemaIndicadores.API.csproj" -c Release -o /app/build

# Etapa de publicación: Prepara los archivos para producción
FROM build AS publish
# Publica la aplicación en modo Release
RUN dotnet publish "SistemaIndicadores.API.csproj" -c Release -o /app/publish

# Etapa final: Usa la imagen más ligera de ASP.NET Core runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
# Establece el directorio de trabajo para la aplicación
WORKDIR /app
# Copia los archivos publicados desde la etapa anterior
COPY --from=publish /app/publish .

# Configura las variables de entorno necesarias
# Define la URL donde escuchará la aplicación
ENV ASPNETCORE_URLS=http://+:80
# Establece el entorno como Producción
ENV ASPNETCORE_ENVIRONMENT=Production

# Expone los puertos que usará la aplicación
# Puerto HTTP estándar
EXPOSE 80
# Puerto HTTPS para SSL
EXPOSE 443

# Comando que se ejecutará al iniciar el contenedor
# Inicia la aplicación usando el runtime de .NET
ENTRYPOINT ["dotnet", "SistemaIndicadores.API.dll"] 