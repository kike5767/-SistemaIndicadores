using Microsoft.AspNetCore.Authorization; // ✅ Importa funcionalidades de autorización
using Microsoft.AspNetCore.Mvc; // ✅ Importa clases para manejar respuestas HTTP y definir un controlador de API
using Microsoft.EntityFrameworkCore; // ✅ Importa funciones de Entity Framework para manipulación de datos
using SistemaIndicadores.API.Data; // ✅ Importa el contexto de datos del proyecto
using SistemaIndicadores.Shared.Entities; // ✅ Importa las entidades compartidas utilizadas en la API

namespace SistemaIndicadores.API.Controllers // ✅ Define el espacio de nombres del controlador
{
    /// <summary>
    /// Controlador para gestionar indicadores en el sistema.
    /// </summary>
    [ApiController] // 🛠 Indica que este controlador maneja respuestas automáticas de errores HTTP
    [Route("api/[controller]")] // 🛠 Define la ruta base como `/api/indicadores`
    [Authorize] // ⚠️ Requiere autenticación para acceder a los métodos
    public class IndicadoresController : ControllerBase
    {
        private readonly DataContext _context; // 📌 Instancia del contexto de datos para interactuar con la BD

        /// <summary>
        /// Constructor que inicializa el contexto de la base de datos.
        /// </summary>
        /// <param name="context">Contexto de datos de Entity Framework</param>
        public IndicadoresController(DataContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Obtiene todos los indicadores activos con sus categorías y cálculos relacionados.
        /// </summary>
        /// <returns>Lista de indicadores activos</returns>
        [HttpGet] // 🛠 Define una solicitud HTTP GET
        public async Task<ActionResult<IEnumerable<Indicador>>> GetIndicadores()
        {
            return await _context.Indicadores
                .Where(i => i.Activo) // 🔹 Filtra solo indicadores activos
                .Include(i => i.Categoria) // 🔹 Carga la relación con Categoría
                .Include(i => i.Calculos.Where(c => c.Activo)) // 🔹 Filtra cálculos activos correctamente
                .ToListAsync(); // ✅ Convierte la consulta en una lista
        }

        /// <summary>
        /// Obtiene un indicador por su ID, incluyendo su categoría y cálculos activos.
        /// </summary>
        [HttpGet("{id}")] // 🛠 Define una solicitud HTTP GET con parámetro ID
        public async Task<ActionResult<Indicador>> GetIndicador(int id)
        {
            var indicador = await _context.Indicadores
                .Include(i => i.Categoria)
                .Include(i => i.Calculos.Where(c => c.Activo))
                .FirstOrDefaultAsync(i => i.Id == id && i.Activo);

            if (indicador == null) return NotFound(); // ⚠️ Retorna 404 si no se encuentra el indicador

            return indicador;
        }

        /// <summary>
        /// Crea un nuevo indicador en una categoría.
        /// </summary>
        [HttpPost] // 🛠 Define una solicitud HTTP POST
        [Authorize(Roles = "Administrador")] // ⚠️ Solo los administradores pueden crear indicadores
        public async Task<ActionResult<Indicador>> PostIndicador(Indicador indicador)
        {
            var categoria = await _context.Categorias.FindAsync(indicador.CategoriaId); // 📌 Verifica que la categoría existe

            if (categoria == null || !categoria.Activo) return BadRequest("La categoría especificada no existe o está inactiva");

            if (await _context.Indicadores.AnyAsync(i => i.Nombre == indicador.Nombre && i.CategoriaId == indicador.CategoriaId && i.Activo))
            {
                return BadRequest("Ya existe un indicador con ese nombre en la categoría especificada");
            }

            indicador.FechaCreacion = DateTime.Now;
            indicador.FechaModificacion = DateTime.Now;
            indicador.Activo = true;

            _context.Indicadores.Add(indicador);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetIndicador), new { id = indicador.Id }, indicador);
        }

        /// <summary>
        /// Elimina un indicador de manera lógica.
        /// </summary>
        [HttpDelete("{id}")] // 🛠 Define una solicitud HTTP DELETE
        [Authorize(Roles = "Administrador")] // ⚠️ Solo los administradores pueden eliminar indicadores
        public async Task<IActionResult> DeleteIndicador(int id)
        {
            var indicador = await _context.Indicadores
                .Include(i => i.Calculos)
                .FirstOrDefaultAsync(i => i.Id == id);

            if (indicador == null) return NotFound();
            if (indicador.Calculos?.Any(c => c.Activo) == true) return BadRequest("No se puede eliminar porque tiene cálculos activos");

            indicador.Activo = false;
            indicador.FechaModificacion = DateTime.Now;
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}