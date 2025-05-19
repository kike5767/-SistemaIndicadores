using Microsoft.AspNetCore.Authorization; // ✅ Manejo de autorización de acceso
using Microsoft.AspNetCore.Mvc; // ✅ Funcionalidad para definir controladores API
using Microsoft.EntityFrameworkCore; // ✅ Manejo de Entity Framework para base de datos
using SistemaIndicadores.API.Data; // ✅ Importa el contexto de datos del proyecto
using SistemaIndicadores.Shared.Entities; // ✅ Importa las entidades compartidas del sistema
using System.Security.Claims; // ✅ Manejo de claims para autenticación

namespace SistemaIndicadores.API.Controllers // ✅ Define correctamente el espacio de nombres
{
    /// <summary>
    /// Controlador para gestionar cálculos de indicadores
    /// </summary>
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class CalculoIndicadoresController : ControllerBase
    {
        private readonly DataContext _context; // 📌 Instancia del contexto de datos para acceder a la BD

        public CalculoIndicadoresController(DataContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Obtiene todos los cálculos de indicadores activos
        /// </summary>
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CalculoIndicadores>>> GetCalculos()
        {
            var userId = int.Parse(User.FindFirst("UserId")?.Value ?? "0");
            var esAdmin = User.IsInRole("Administrador");

            var query = _context.CalculoIndicadores
                .Where(c => c.Activo)
                .Include(c => c.Indicador)
                .Include(c => c.Usuario)
                .AsQueryable();

            if (!esAdmin)
            {
                query = query.Where(c => c.UsuarioId == userId);
            }

            return await query.ToListAsync();
        }

        /// <summary>
        /// Obtiene un cálculo por su ID
        /// </summary>
        [HttpGet("{id}")]
        public async Task<ActionResult<CalculoIndicadores>> GetCalculo(int id)
        {
            var userId = int.Parse(User.FindFirst("UserId")?.Value ?? "0");
            var esAdmin = User.IsInRole("Administrador");

            var calculo = await _context.CalculoIndicadores
                .Include(c => c.Indicador)
                .Include(c => c.Usuario)
                .FirstOrDefaultAsync(c => c.Id == id && c.Activo);

            if (calculo == null) return NotFound();

            if (!esAdmin && calculo.UsuarioId != userId) return Forbid();

            return calculo;
        }

        /// <summary>
        /// Crea un nuevo cálculo de indicador
        /// </summary>
        [HttpPost]
        public async Task<ActionResult<CalculoIndicadores>> PostCalculo(CalculoIndicadores calculo)
        {
            var userId = int.Parse(User.FindFirst("UserId")?.Value ?? "0");

            var indicador = await _context.Indicadores
                .Include(i => i.Categoria)
                .FirstOrDefaultAsync(i => i.Id == calculo.IndicadorId);

            if (indicador == null || !indicador.Activo) return BadRequest("El indicador especificado no existe o está inactivo");

            // 📌 Se inicializan valores del cálculo correctamente
            calculo.UsuarioId = userId;
            calculo.FechaCalculo = DateTime.Now;
            calculo.PorcentajeCumplimiento = calculo.ValorMeta > 0 ? (calculo.ValorReal / calculo.ValorMeta) * 100 : 0;
            calculo.Estado = "Pendiente";
            calculo.Periodo ??= "Mensual"; // ⚠️ Validación para evitar valores nulos
            calculo.Observaciones ??= ""; // ⚠️ Asegura que no haya problemas con cadenas vacías
            calculo.Activo = true;

            _context.CalculoIndicadores.Add(calculo);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetCalculo), new { id = calculo.Id }, calculo);
        }

        /// <summary>
        /// Actualiza un cálculo existente
        /// </summary>
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCalculo(int id, CalculoIndicadores calculo)
        {
            if (id != calculo.Id) return BadRequest();

            var userId = int.Parse(User.FindFirst("UserId")?.Value ?? "0");
            var esAdmin = User.IsInRole("Administrador");

            var calculoExistente = await _context.CalculoIndicadores.FindAsync(id);
            if (calculoExistente == null) return NotFound();

            if (!esAdmin && calculoExistente.UsuarioId != userId) return Forbid();
            if (calculoExistente.Estado != "Pendiente" && !esAdmin) return BadRequest("No se puede modificar un cálculo que ya no está pendiente");

            // 📌 Se actualizan valores correctamente
            calculoExistente.ValorReal = calculo.ValorReal;
            calculoExistente.ValorMeta = calculo.ValorMeta;
            calculoExistente.PorcentajeCumplimiento = calculo.ValorMeta > 0 ? (calculo.ValorReal / calculo.ValorMeta) * 100 : 0;
            calculoExistente.Periodo = calculo.Periodo;
            calculoExistente.Observaciones = calculo.Observaciones;
            calculoExistente.FechaModificacion = DateTime.Now;

            if (esAdmin)
            {
                calculoExistente.Estado = calculo.Estado;
            }

            await _context.SaveChangesAsync();
            return NoContent();
        }

        /// <summary>
        /// Elimina un cálculo de manera lógica
        /// </summary>
        [HttpDelete("{id}")]
        [Authorize(Roles = "Administrador")]
        public async Task<IActionResult> DeleteCalculo(int id)
        {
            var calculo = await _context.CalculoIndicadores.FindAsync(id);
            if (calculo == null || !calculo.Activo) return NotFound();

            calculo.Activo = false;
            calculo.FechaModificacion = DateTime.Now;
            await _context.SaveChangesAsync();

            return NoContent();
        }

        /// <summary>
        /// Verifica si un cálculo existe
        /// </summary>
        private bool CalculoExists(int id)
        {
            return _context.CalculoIndicadores.Any(e => e.Id == id);
        }
    }
}