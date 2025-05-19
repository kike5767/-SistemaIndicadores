using Microsoft.AspNetCore.Authorization; // ✅ Manejo de autorización de acceso
using Microsoft.AspNetCore.Mvc; // ✅ Funcionalidad para definir controladores API
using Microsoft.EntityFrameworkCore; // ✅ Manejo de Entity Framework para base de datos
using SistemaIndicadores.API.Data; // ✅ Importa el contexto de datos del proyecto
using SistemaIndicadores.Shared.Entities; // ✅ Importa las entidades compartidas

namespace SistemaIndicadores.API.Controllers; // ✅ Espacio de nombres correcto

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class CategoriasController : ControllerBase
{
    private readonly DataContext _context; // 📌 Instancia del contexto de datos para acceso a BD

    public CategoriasController(DataContext context)
    {
        _context = context;
    }

    /// <summary>
    /// Obtiene todas las categorías activas
    /// </summary>
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Categoria>>> GetCategorias()
    {
        return await _context.Categorias
            .Where(c => c.Activo) // 🔹 Filtra solo categorías activas
            .Include(c => c.Indicadores.Where(i => i.Activo)) // 🔹 Carga indicadores activos relacionados
            .ToListAsync();
    }

    /// <summary>
    /// Obtiene una categoría por su ID
    /// </summary>
    [HttpGet("{id}")]
    public async Task<ActionResult<Categoria>> GetCategoria(int id)
    {
        var categoria = await _context.Categorias
            .Include(c => c.Indicadores.Where(i => i.Activo)) 
            .FirstOrDefaultAsync(c => c.Id == id && c.Activo);

        if (categoria == null) return NotFound(); // ⚠️ Retorna 404 si no se encuentra la categoría

        return categoria;
    }

    /// <summary>
    /// Crea una nueva categoría
    /// </summary>
    [HttpPost]
    [Authorize(Roles = "Administrador")]
    public async Task<ActionResult<Categoria>> PostCategoria(Categoria categoria)
    {
        if (await _context.Categorias.AnyAsync(c => c.Nombre == categoria.Nombre && c.Activo))
        {
            return BadRequest("Ya existe una categoría con ese nombre");
        }

        categoria.FechaCreacion = DateTime.Now;
        categoria.Activo = true;

        _context.Categorias.Add(categoria);
        await _context.SaveChangesAsync();

        return CreatedAtAction(nameof(GetCategoria), new { id = categoria.Id }, categoria);
    }

    /// <summary>
    /// Actualiza una categoría existente
    /// </summary>
    [HttpPut("{id}")]
    [Authorize(Roles = "Administrador")]
    public async Task<IActionResult> PutCategoria(int id, Categoria categoria)
    {
        if (id != categoria.Id) return BadRequest();

        var categoriaExistente = await _context.Categorias.FindAsync(id);
        if (categoriaExistente == null) return NotFound();

        if (await _context.Categorias.AnyAsync(c => c.Nombre == categoria.Nombre && c.Id != id && c.Activo))
        {
            return BadRequest("Ya existe otra categoría con ese nombre");
        }

        // 📌 Se actualizan valores correctamente
        categoriaExistente.Nombre = categoria.Nombre;
        categoriaExistente.Descripcion = categoria.Descripcion;
        categoriaExistente.FechaModificacion = DateTime.Now;

        await _context.SaveChangesAsync();
        return NoContent();
    }

    /// <summary>
    /// Elimina una categoría (baja lógica)
    /// </summary>
    [HttpDelete("{id}")]
    [Authorize(Roles = "Administrador")]
    public async Task<IActionResult> DeleteCategoria(int id)
    {
        var categoria = await _context.Categorias
            .Include(c => c.Indicadores)
            .FirstOrDefaultAsync(c => c.Id == id);

        if (categoria == null) return NotFound();
        if (categoria.Indicadores?.Any(i => i.Activo) == true)
        {
            return BadRequest("No se puede eliminar la categoría porque tiene indicadores activos asociados");
        }

        categoria.Activo = false;
        categoria.FechaModificacion = DateTime.Now;
        await _context.SaveChangesAsync();

        return NoContent();
    }

    private bool CategoriaExists(int id)
    {
        return _context.Categorias.Any(e => e.Id == id);
    }
}