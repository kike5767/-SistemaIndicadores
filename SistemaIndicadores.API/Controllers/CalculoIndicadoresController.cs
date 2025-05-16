// Importaciones necesarias para el controlador
using Microsoft.AspNetCore.Authorization; // Para manejo de autorización
using Microsoft.AspNetCore.Mvc; // Para funcionalidad de controlador API
using Microsoft.EntityFrameworkCore; // Para operaciones con Entity Framework
using SistemaIndicadores.API.Data; // Para acceso al contexto de datos
using SistemaIndicadores.Shared.Entities; // Para acceso a las entidades
using System.Security.Claims; // Para acceso a los claims del usuario

namespace SistemaIndicadores.API.Controllers;

// Decoradores del controlador
[ApiController] // Indica que es un controlador de API
[Route("api/[controller]")] // Define la ruta base del controlador
[Authorize] // Requiere autenticación para todos los endpoints
public class CalculoIndicadoresController : ControllerBase
{
    // Inyección de dependencias
    private readonly DataContext _context; // Contexto de base de datos

    // Constructor del controlador
    public CalculoIndicadoresController(DataContext context)
    {
        _context = context;
    }

    /// <summary>
    /// Obtiene todos los cálculos de indicadores
    /// </summary>
    [HttpGet] // Endpoint GET para listar cálculos
    public async Task<ActionResult<IEnumerable<CalculoIndicadores>>> GetCalculos()
    {
        // Obtener ID del usuario actual
        var userId = int.Parse(User.FindFirst("UserId")?.Value ?? "0");
        var esAdmin = User.IsInRole("Administrador");

        // Construir consulta base
        var query = _context.CalculoIndicadores
            .Where(c => c.Activo) // Filtrar solo cálculos activos
            .Include(c => c.Indicador)
            .Include(c => c.Usuario)
            .AsQueryable();

        // Filtrar según el rol del usuario
        if (!esAdmin)
        {
            query = query.Where(c => c.UsuarioId == userId);
        }

        // Ejecutar consulta
        return await query.ToListAsync();
    }

    /// <summary>
    /// Obtiene un cálculo por su ID
    /// </summary>
    [HttpGet("{id}")] // Endpoint GET con parámetro de ruta
    public async Task<ActionResult<CalculoIndicadores>> GetCalculo(int id)
    {
        // Obtener ID del usuario actual
        var userId = int.Parse(User.FindFirst("UserId")?.Value ?? "0");
        var esAdmin = User.IsInRole("Administrador");

        // Buscar cálculo
        var calculo = await _context.CalculoIndicadores
            .Include(c => c.Indicador)
            .Include(c => c.Usuario)
            .FirstOrDefaultAsync(c => c.Id == id && c.Activo);

        if (calculo == null)
        {
            return NotFound();
        }

        // Validar acceso
        if (!esAdmin && calculo.UsuarioId != userId)
        {
            return Forbid();
        }

        return calculo;
    }

    /// <summary>
    /// Obtiene los cálculos de un indicador específico
    /// </summary>
    [HttpGet("indicador/{indicadorId}")] // Endpoint GET con parámetro de ruta para indicador
    public async Task<ActionResult<IEnumerable<CalculoIndicadores>>> GetCalculosPorIndicador(int indicadorId)
    {
        // Validar si el indicador existe y está activo
        var indicador = await _context.Indicadores.FindAsync(indicadorId);
        if (indicador == null || !indicador.Activo)
        {
            return NotFound("Indicador no encontrado o inactivo");
        }

        // Obtener ID del usuario actual
        var userId = int.Parse(User.FindFirst("UserId")?.Value ?? "0");
        var esAdmin = User.IsInRole("Administrador");

        // Construir consulta base
        var query = _context.CalculoIndicadores
            .Where(c => c.IndicadorId == indicadorId && c.Activo)
            .Include(c => c.Usuario);

        // Filtrar según el rol del usuario
        if (!esAdmin)
        {
            query = query.Where(c => c.UsuarioId == userId);
        }

        // Ejecutar consulta
        return await query.ToListAsync();
    }

    /// <summary>
    /// Crea un nuevo cálculo de indicador
    /// </summary>
    [HttpPost] // Endpoint POST para crear cálculo
    public async Task<ActionResult<CalculoIndicadores>> PostCalculo(CalculoIndicadores calculo)
    {
        // Obtener ID del usuario actual
        var userId = int.Parse(User.FindFirst("UserId")?.Value ?? "0");

        // Validar si el indicador existe y está activo
        var indicador = await _context.Indicadores
            .Include(i => i.Categoria)
            .FirstOrDefaultAsync(i => i.Id == calculo.IndicadorId);

        if (indicador == null || !indicador.Activo)
        {
            return BadRequest("El indicador especificado no existe o está inactivo");
        }

        // Preparar cálculo para inserción
        calculo.UsuarioId = userId;
        calculo.FechaCalculo = DateTime.Now;
        calculo.PorcentajeCumplimiento = (calculo.ValorReal / calculo.ValorMeta) * 100;
        calculo.Estado = "Pendiente";
        calculo.Activo = true;

        // Guardar cálculo
        _context.CalculoIndicadores.Add(calculo);
        await _context.SaveChangesAsync();

        // Retornar resultado con ubicación del nuevo recurso
        return CreatedAtAction(nameof(GetCalculo), new { id = calculo.Id }, calculo);
    }

    /// <summary>
    /// Actualiza un cálculo existente
    /// </summary>
    [HttpPut("{id}")] // Endpoint PUT con parámetro de ruta
    public async Task<IActionResult> PutCalculo(int id, CalculoIndicadores calculo)
    {
        // Validar ID de ruta con ID de modelo
        if (id != calculo.Id)
        {
            return BadRequest();
        }

        // Obtener ID del usuario actual
        var userId = int.Parse(User.FindFirst("UserId")?.Value ?? "0");
        var esAdmin = User.IsInRole("Administrador");

        // Buscar cálculo existente
        var calculoExistente = await _context.CalculoIndicadores.FindAsync(id);
        if (calculoExistente == null)
        {
            return NotFound();
        }

        // Validar acceso
        if (!esAdmin && calculoExistente.UsuarioId != userId)
        {
            return Forbid();
        }

        // Validar estado
        if (calculoExistente.Estado != "Pendiente" && !esAdmin)
        {
            return BadRequest("No se puede modificar un cálculo que ya no está pendiente");
        }

        // Actualizar propiedades
        calculoExistente.ValorReal = calculo.ValorReal;
        calculoExistente.ValorMeta = calculo.ValorMeta;
        calculoExistente.PorcentajeCumplimiento = (calculo.ValorReal / calculo.ValorMeta) * 100;
        calculoExistente.Periodo = calculo.Periodo;
        calculoExistente.Observaciones = calculo.Observaciones;
        calculoExistente.FechaModificacion = DateTime.Now;

        // Si es administrador, permitir cambio de estado
        if (esAdmin)
        {
            calculoExistente.Estado = calculo.Estado;
        }

        try
        {
            // Guardar cambios
            await _context.SaveChangesAsync();
        }
        catch (DbUpdateConcurrencyException)
        {
            // Manejar errores de concurrencia
            if (!CalculoExists(id))
            {
                return NotFound();
            }
            else
            {
                throw;
            }
        }

        return NoContent();
    }

    /// <summary>
    /// Elimina un cálculo
    /// </summary>
    [HttpDelete("{id}")] // Endpoint DELETE con parámetro de ruta
    [Authorize(Roles = "Administrador")] // Solo administradores pueden eliminar
    public async Task<IActionResult> DeleteCalculo(int id)
    {
        // Buscar cálculo
        var calculo = await _context.CalculoIndicadores.FindAsync(id);
        if (calculo == null || !calculo.Activo)
        {
            return NotFound();
        }

        // Realizar baja lógica
        calculo.Activo = false;
        calculo.FechaModificacion = DateTime.Now;
        await _context.SaveChangesAsync();

        return NoContent();
    }

    // Método auxiliar para verificar existencia de cálculo
    private bool CalculoExists(int id)
    {
        return _context.CalculoIndicadores.Any(e => e.Id == id);
    }
} 