using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SistemaIndicadores.API.Data;
using SistemaIndicadores.Shared.Entities;

namespace SistemaIndicadores.API.Controllers
{

    [ApiController]
    [Route("api/indicadores")]
    public class IndicadoresController : ControllerBase
    {

        private readonly DataContext _context;
        public IndicadoresController(DataContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            return Ok(await _context.Indicadores.ToListAsync());
        }

        [HttpPost]
        public async Task<ActionResult> Post(Indicador indicador)
        {
            try
            {
                _context.Add(indicador);
                await _context.SaveChangesAsync();
                return Ok(indicador);
            }
            catch(DbUpdateException dbUpdateException)
            {
                if (dbUpdateException.InnerException!.Message.Contains("duplicate"))
                {
                    return BadRequest("Ya existe un indicador con ese codigo.");
                }

                return BadRequest(dbUpdateException.Message);
            }
             catch(Exception exception) 
            {
                return BadRequest(exception.Message);
            }
        }

        [HttpPut]
        public async Task<ActionResult> Put(Indicador indicador)
        {
             try
            {
                _context.Update(indicador);
                await _context.SaveChangesAsync();
                return Ok(indicador);
            }
            catch (DbUpdateException dbUpdateException)
            {
                if (dbUpdateException.InnerException!.Message.Contains("duplicate"))
                {
                    return BadRequest("Ya existe un Indicador con el mismo codigo.");
                }

                return BadRequest(dbUpdateException.Message);
            }
            catch (Exception exception)
            {
                return BadRequest(exception.Message);
            }
        }

        [HttpDelete("{id:int}")]
        public async Task<IActionResult> DeleteAsync(int id)
        {
            var indicador = await _context.Indicadores.FirstOrDefaultAsync(x => x.Id == id);
            if (indicador == null)
            {
                return NotFound();
            }

            _context.Remove(indicador);
            await _context.SaveChangesAsync();
            return NoContent();
        }
    }
}