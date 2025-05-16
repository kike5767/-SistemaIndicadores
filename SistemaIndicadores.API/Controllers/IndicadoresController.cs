using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SistemaIndicadores.API.Data;
using SistemaIndicadores.Shared.Entities;

namespace SistemaIndicadores.API.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class IndicadoresController : ControllerBase
{
    private readonly DataContext _context;

    public IndicadoresController(DataContext context)
    {
        _context = context;
    }

    /// <summary>
    /// Obtiene todos los indicadores activos
    /// </summary>
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Indicador>>> GetIndicadores()
    {
        return await _context.Indicadores
            .Where(i => i.Activo)
            .Include(i => i.Categoria)
            .Include(i => i.Calculos!.Where(c => c.Activo))
            .ToListAsync();
    }

    /// <summary>
    /// Obtiene un indicador por su ID
    /// </summary>
    [HttpGet("{id}")]
    public async Task<ActionResult<Indicador>> GetIndicador(int id)
    {
        var indicador = await _context.Indicadores
            .Include(i => i.Categoria)
            .Include(i => i.Calculos!.Where(c => c.Activo))
            .FirstOrDefaultAsync(i => i.Id == id && i.Activo);

        if (indicador == null)
        {
            return NotFound();
        }

        return indicador;
    }

    /// <summary>
    /// Obtiene los indicadores por categoría
    /// </summary>
    [HttpGet("categoria/{categoriaId}")]
    public async Task<ActionResult<IEnumerable<Indicador>>> GetIndicadoresPorCategoria(int categoriaId)
    {
        var categoria = await _context.Categorias.FindAsync(categoriaId);
        if (categoria == null || !categoria.Activo)
        {
            return NotFound("Categoría no encontrada");
        }

        return await _context.Indicadores
            .Where(i => i.CategoriaId == categoriaId && i.Activo)
            .Include(i => i.Calculos!.Where(c => c.Activo))
            .ToListAsync();
    }

    /// <summary>
    /// Crea un nuevo indicador
    /// </summary>
    [HttpPost]
    [Authorize(Roles = "Administrador")]
    public async Task<ActionResult<Indicador>> PostIndicador(Indicador indicador)
    {
        var categoria = await _context.Categorias.FindAsync(indicador.CategoriaId);
        if (categoria == null || !categoria.Activo)
        {
            return BadRequest("La categoría especificada no existe o está inactiva");
        }

        if (await _context.Indicadores.AnyAsync(i => i.Nombre == indicador.Nombre && i.CategoriaId == indicador.CategoriaId && i.Activo))
        {
            return BadRequest("Ya existe un indicador con ese nombre en la categoría especificada");
        }

        indicador.FechaCreacion = DateTime.Now;
        indicador.Activo = true;

        _context.Indicadores.Add(indicador);
        await _context.SaveChangesAsync();

        return CreatedAtAction(nameof(GetIndicador), new { id = indicador.Id }, indicador);
    }

    /// <summary>
    /// Actualiza un indicador existente
    /// </summary>
    [HttpPut("{id}")]
    [Authorize(Roles = "Administrador")]
    public async Task<IActionResult> PutIndicador(int id, Indicador indicador)
    {
        if (id != indicador.Id)
        {
            return BadRequest();
        }

        var indicadorExistente = await _context.Indicadores.FindAsync(id);
        if (indicadorExistente == null)
        {
            return NotFound();
        }

        var categoria = await _context.Categorias.FindAsync(indicador.CategoriaId);
        if (categoria == null || !categoria.Activo)
        {
            return BadRequest("La categoría especificada no existe o está inactiva");
        }

        if (await _context.Indicadores.AnyAsync(i => 
            i.Nombre == indicador.Nombre && 
            i.CategoriaId == indicador.CategoriaId && 
            i.Id != id && 
            i.Activo))
        {
            return BadRequest("Ya existe otro indicador con ese nombre en la categoría especificada");
        }

        indicadorExistente.Nombre = indicador.Nombre;
        indicadorExistente.Descripcion = indicador.Descripcion;
        indicadorExistente.UnidadMedida = indicador.UnidadMedida;
        indicadorExistente.FrecuenciaMedicion = indicador.FrecuenciaMedicion;
        indicadorExistente.Responsable = indicador.Responsable;
        indicadorExistente.Formula = indicador.Formula;
        indicadorExistente.CategoriaId = indicador.CategoriaId;
        indicadorExistente.FechaModificacion = DateTime.Now;

        try
        {
            await _context.SaveChangesAsync();
        }
        catch (DbUpdateConcurrencyException)
        {
            if (!IndicadorExists(id))
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
    /// Elimina un indicador (baja lógica)
    /// </summary>
    [HttpDelete("{id}")]
    [Authorize(Roles = "Administrador")]
    public async Task<IActionResult> DeleteIndicador(int id)
    {
        var indicador = await _context.Indicadores
            .Include(i => i.Calculos)
            .FirstOrDefaultAsync(i => i.Id == id);

        if (indicador == null)
        {
            return NotFound();
        }

        if (indicador.Calculos?.Any(c => c.Activo) == true)
        {
            return BadRequest("No se puede eliminar el indicador porque tiene cálculos activos asociados");
        }

        indicador.Activo = false;
        indicador.FechaModificacion = DateTime.Now;
        await _context.SaveChangesAsync();

        return NoContent();
    }

    private bool IndicadorExists(int id)
    {
        return _context.Indicadores.Any(e => e.Id == id);
    }
} 