using Microsoft.AspNetCore.Authorization; // ✅ Manejo de autorización de acceso
using Microsoft.AspNetCore.Mvc; // ✅ Funcionalidad para definir controladores API
using Microsoft.EntityFrameworkCore; // ✅ Manejo de Entity Framework para base de datos
using Microsoft.IdentityModel.Tokens; // ✅ Manejo de seguridad para generación de tokens JWT
using SistemaIndicadores.API.Data; // ✅ Importa el contexto de datos del proyecto
using SistemaIndicadores.Shared.Entities; // ✅ Importa las entidades compartidas
using System.IdentityModel.Tokens.Jwt; // ✅ Manejo de JWT para autenticación
using System.Security.Claims; // ✅ Manejo de claims de seguridad
using System.Text; // ✅ Codificación para clave JWT

namespace SistemaIndicadores.API.Controllers; // ✅ Espacio de nombres correcto

[ApiController]
    [Route("api/[controller]")]
    public class UsuariosController : ControllerBase
    {
    private readonly DataContext _context; // 📌 Instancia del contexto de datos
    private readonly IConfiguration _configuration; // 📌 Manejo de configuración para JWT

    public UsuariosController(DataContext context, IConfiguration configuration)
        {
            _context = context;
        _configuration = configuration;
    }

    /// <summary>
    /// Autentica un usuario y genera un token JWT
    /// </summary>
    [HttpPost("login")]
    public async Task<ActionResult<string>> Login([FromBody] LoginModel loginModel)
    {
        var usuario = await _context.Usuarios
            .FirstOrDefaultAsync(u => u.Email == loginModel.Email && u.Activo);

        if (usuario == null || !BCrypt.Net.BCrypt.Verify(loginModel.Password, usuario.Password))
        {
            return Unauthorized("Credenciales inválidas"); // ⚠️ Verifica si las credenciales son correctas
        }

        var token = GenerateJwtToken(usuario);
        return Ok(new { token });
    }

    /// <summary>
    /// Obtiene todos los usuarios activos
    /// </summary>
    [HttpGet]
    [Authorize(Roles = "Administrador")]
    public async Task<ActionResult<IEnumerable<Usuario>>> GetUsuarios()
    {
        return await _context.Usuarios
            .Where(u => u.Activo)
            .ToListAsync(); // ✅ Filtra usuarios activos
    }

    /// <summary>
    /// Obtiene un usuario por su ID
    /// </summary>
    [HttpGet("{id}")]
    [Authorize(Roles = "Administrador")]
    public async Task<ActionResult<Usuario>> GetUsuario(int id)
    {
        var usuario = await _context.Usuarios.FindAsync(id);
        if (usuario == null || !usuario.Activo) return NotFound(); // ⚠️ Validación si el usuario no existe

        return usuario;
    }

    /// <summary>
    /// Crea un nuevo usuario
    /// </summary>
        [HttpPost]
    [Authorize(Roles = "Administrador")]
    public async Task<ActionResult<Usuario>> PostUsuario(Usuario usuario)
    {
        if (await _context.Usuarios.AnyAsync(u => u.Email == usuario.Email))
        {
            return BadRequest("El email ya está registrado"); // ⚠️ Validación de duplicados
        }

        usuario.Password = BCrypt.Net.BCrypt.HashPassword(usuario.Password); // ✅ Cifrado seguro de contraseña
        usuario.FechaCreacion = DateTime.Now;
        usuario.Activo = true;

                _context.Usuarios.Add(usuario);
                await _context.SaveChangesAsync();

        return CreatedAtAction(nameof(GetUsuario), new { id = usuario.Id }, usuario);
    }

    /// <summary>
    /// Actualiza un usuario existente
    /// </summary>
    [HttpPut("{id}")]
    [Authorize(Roles = "Administrador")]
    public async Task<IActionResult> PutUsuario(int id, Usuario usuario)
    {
        if (id != usuario.Id) return BadRequest();

        var usuarioExistente = await _context.Usuarios.FindAsync(id);
        if (usuarioExistente == null) return NotFound();

        if (await _context.Usuarios.AnyAsync(u => u.Email == usuario.Email && u.Id != id))
        {
            return BadRequest("El email ya está registrado por otro usuario"); // ⚠️ Validación de duplicados
        }

        usuarioExistente.Nombre = usuario.Nombre;
        usuarioExistente.Email = usuario.Email;
        if (!string.IsNullOrEmpty(usuario.Password))
        {
            usuarioExistente.Password = BCrypt.Net.BCrypt.HashPassword(usuario.Password);
        }
        usuarioExistente.Rol = usuario.Rol;
        usuarioExistente.FechaModificacion = DateTime.Now;

                await _context.SaveChangesAsync();
                return NoContent();
    }

    /// <summary>
    /// Elimina un usuario (baja lógica)
    /// </summary>
        [HttpDelete("{id}")]
    [Authorize(Roles = "Administrador")]
        public async Task<IActionResult> DeleteUsuario(int id)
            {
                var usuario = await _context.Usuarios.FindAsync(id);
        if (usuario == null) return NotFound();

        usuario.Activo = false;
        usuario.FechaModificacion = DateTime.Now;
                await _context.SaveChangesAsync();

                return NoContent();
    }

    private bool UsuarioExists(int id)
    {
        return _context.Usuarios.Any(e => e.Id == id);
    }

    private string GenerateJwtToken(Usuario usuario)
    {
        var claims = new List<Claim>
        {
            new Claim(ClaimTypes.Name, usuario.Email),
            new Claim(ClaimTypes.Role, usuario.Rol),
            new Claim("UserId", usuario.Id.ToString())
        };

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]!));
        var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
        var expiration = DateTime.UtcNow.AddMinutes(Convert.ToDouble(_configuration["Jwt:DurationInMinutes"]));

        var token = new JwtSecurityToken(
            issuer: _configuration["Jwt:Issuer"],
            audience: _configuration["Jwt:Audience"],
            claims: claims,
            expires: expiration,
            signingCredentials: creds);

        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}

public class LoginModel
{
    public string Email { get; set; } = null!;
    public string Password { get; set; } = null!;
}