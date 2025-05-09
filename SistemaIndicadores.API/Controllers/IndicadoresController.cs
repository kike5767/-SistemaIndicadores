using System.Threading.Tasks; // Permite el uso de métodos asíncronos
using Microsoft.AspNetCore.Mvc; // Librería para manejar controladores en una API
using Microsoft.EntityFrameworkCore; // Proporciona funcionalidades de acceso a base de datos con Entity Framework
using SistemaIndicadores.API.Data; // Espacio de nombres donde está el `DataContext`
using SistemaIndicadores.Shared.Entities; // Importación del modelo `Indicador`

namespace SistemaIndicadores.API.Controllers
{
    [ApiController] // Define que este controlador maneja solicitudes HTTP dentro de la API
    [Route("api/indicador")] // Define la ruta base del controlador, `http://localhost:5294/api/indicador`
    public class IndicadorController : ControllerBase // Hereda de `ControllerBase` para manejar solicitudes HTTP
    {
        private readonly DataContext _context; // Instancia de `DataContext` para conectarse a la base de datos

        // Constructor del controlador que inyecta el contexto de base de datos
        public IndicadorController(DataContext context)
        {
            _context = context;
        }

        // ✅ Endpoint GET: Obtiene la lista de todos los indicadores
        [HttpGet] // Define que este método responde a solicitudes GET
        public async Task<IActionResult> Get()
        {
            return Ok(await _context.Indicador.ToListAsync()); // Devuelve la lista completa de indicadores
        }

        // ✅ Endpoint POST: Crea un nuevo indicador
        [HttpPost] // Define que este método responde a solicitudes POST
        public async Task<ActionResult> Post(Indicador indicador)
        {
            try
            {
                _context.Add(indicador); // Agrega el nuevo indicador al contexto
                await _context.SaveChangesAsync(); // Guarda los cambios en la base de datos
                return Ok(indicador); // Devuelve el indicador creado
            }
            catch (DbUpdateException dbUpdateException) // Manejo de errores en la base de datos
            {
                if (dbUpdateException.InnerException != null && dbUpdateException.InnerException.Message.Contains("duplicate"))
                {
                    return BadRequest("Ya existe un indicador con ese código."); // Mensaje personalizado si hay un código duplicado
                }
                return BadRequest(dbUpdateException.Message); // Devuelve el mensaje de error general
            }
            catch (Exception exception) // Manejo de errores generales
            {
                return BadRequest(exception.Message); // Devuelve el mensaje del error ocurrido
            }
        }

        // ✅ Endpoint PUT: Actualiza un indicador existente
        [HttpPut] // Define que este método responde a solicitudes PUT
        public async Task<ActionResult> Put(Indicador indicador)
        {
            try
            {
                _context.Update(indicador); // Marca el indicador como modificado
                await _context.SaveChangesAsync(); // Guarda los cambios en la base de datos
                return Ok(indicador); // Devuelve el indicador actualizado
            }
            catch (DbUpdateException dbUpdateException) // Manejo de errores en la base de datos
            {
                if (dbUpdateException.InnerException != null && dbUpdateException.InnerException.Message.Contains("duplicate"))
                {
                    return BadRequest("Ya existe un indicador con el mismo código."); // Mensaje personalizado si hay un código duplicado
                }
                return BadRequest(dbUpdateException.Message); // Devuelve el mensaje de error general
            }
            catch (Exception exception) // Manejo de errores generales
            {
                return BadRequest(exception.Message); // Devuelve el mensaje del error ocurrido
            }
        }

        // ✅ Endpoint DELETE: Elimina un indicador por ID
        [HttpDelete("{id:int}")] // Define que este método responde a solicitudes DELETE con un ID entero
        public async Task<IActionResult> DeleteAsync(int id)
        {
            var indicador = await _context.Indicador.FirstOrDefaultAsync(x => x.Id == id); // Busca el indicador por ID
            if (indicador == null)
            {
                return NotFound(); // Si no existe, devuelve un error 404
            }

            _context.Remove(indicador); // Elimina el indicador del contexto
            await _context.SaveChangesAsync(); // Guarda los cambios en la base de datos
            return NoContent(); // Devuelve un código 204 (sin contenido) indicando eliminación exitosa
        }
    }
}