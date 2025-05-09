using System.Threading.Tasks; // Permite el uso de métodos asíncronos
using Microsoft.AspNetCore.Mvc; // Librería para manejar controladores en una API
using Microsoft.EntityFrameworkCore; // Proporciona funcionalidades de acceso a base de datos con Entity Framework
using SistemaIndicadores.API.Data; // Espacio de nombres donde está el `DataContext`
using SistemaIndicadores.Shared.Entities; // Importación del modelo `Indicador`

namespace SistemaIndicadores.API.Controllers
{
    [ApiController] // Define que este controlador maneja solicitudes HTTP dentro de la API
    [Route("api/indicadores")] // Define la ruta base del controlador, `http://localhost:5294/api/indicadores`
    public class IndicadoresController : ControllerBase // Hereda de `ControllerBase` para manejar solicitudes HTTP
    {
        private readonly DataContext _context; // Instancia de `DataContext` para conectarse a la base de datos

        // Constructor del controlador que inyecta el contexto de base de datos
        public IndicadoresController(DataContext context)
        {
            _context = context;
        }

        // ✅ Endpoint GET: Obtiene la lista de todos los indicadores
        [HttpGet] 
        public async Task<IActionResult> Get()
        {
            return Ok(await _context.Indicadores.ToListAsync()); // Devuelve la lista completa de indicadores
        }

        // ✅ Endpoint POST: Crea un nuevo indicador con validación de duplicados
        [HttpPost] 
        public async Task<ActionResult> Post(Indicador indicador)
        {
            try
            {
                _context.Add(indicador);
                await _context.SaveChangesAsync();
                return CreatedAtAction(nameof(Get), new { id = indicador.Id }, indicador); // Devuelve el objeto con ubicación creada
            }
            catch (DbUpdateException dbUpdateException) 
            {
                if (dbUpdateException.InnerException?.Message.Contains("duplicate") == true)
                {
                    return Conflict("Ya existe un indicador con ese código."); // Devuelve un error 409 en caso de duplicado
                }
                return BadRequest(dbUpdateException.Message);
            }
            catch (Exception exception) 
            {
                return BadRequest(exception.Message);
            }
        }

        // ✅ Endpoint PUT: Actualiza un indicador existente
        [HttpPut("{id:int}")] 
        public async Task<ActionResult> Put(int id, Indicador indicador)
        {
            if (id != indicador.Id) return BadRequest("El ID no coincide con el objeto enviado."); // Validación de ID

            try
            {
                _context.Update(indicador);
                await _context.SaveChangesAsync();
                return Ok(indicador);
            }
            catch (DbUpdateException dbUpdateException) 
            {
                if (dbUpdateException.InnerException?.Message.Contains("duplicate") == true)
                {
                    return Conflict("Ya existe un indicador con el mismo código.");
                }
                return BadRequest(dbUpdateException.Message);
            }
            catch (Exception exception) 
            {
                return BadRequest(exception.Message);
            }
        }

        // ✅ Endpoint DELETE: Elimina un indicador por ID
        [HttpDelete("{id:int}")] 
        public async Task<IActionResult> DeleteAsync(int id)
        {
            var indicador = await _context.Indicadores.FindAsync(id); // Uso de `FindAsync` para mejorar eficiencia
            if (indicador == null)
            {
                return NotFound("El indicador no existe."); // Mensaje de error más claro
            }

            _context.Remove(indicador);
            await _context.SaveChangesAsync();
            return NoContent(); // Código 204 (sin contenido) indicando éxito
        }
    }
}