using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using SistemaIndicadores.API.Data;
using SistemaIndicadores.Shared.Entities;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace SistemaIndicadores.API.Controllers;

[ApiController]
    [Route("api/[controller]")]
    public class UsuariosController : ControllerBase
{
    private readonly DataContext _context;
    private readonly IConfiguration _configuration;

    public UsuariosController(DataContext context, IConfiguration configuration)
    {
        _context = context;
        _configuration = configuration;
    }

    /// <summary>
    /// Autentica un usuario y genera un token JWT
    /// </summary>
    /// <param name="loginModel">Credenciales del usuario</param>
    /// <returns>Token JWT si la autenticación es exitosa</returns>
    [HttpPost("login")]
    public async Task<ActionResult<string>> Login([FromBody] LoginModel loginModel)
    {
        var usuario = await _context.Usuarios
            .FirstOrDefaultAsync(u => u.Email == loginModel.Email && u.Activo);

        if (usuario == null || !BCrypt.Net.BCrypt.Verify(loginModel.Password, usuario.Password))
        {
            return Unauthorized("Credenciales inválidas");
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
                    .ToListAsync();
    }

    /// <summary>
    /// Obtiene un usuario por su ID
    /// </summary>
        [HttpGet("{id}")]
    [Authorize(Roles = "Administrador")]
    public async Task<ActionResult<Usuario>> GetUsuario(int id)
    {
        var usuario = await _context.Usuarios.FindAsync(id);

        if (usuario == null || !usuario.Activo)
        {
            return NotFound();
        }

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
            return BadRequest("El email ya está registrado");
        }

        usuario.Password = BCrypt.Net.BCrypt.HashPassword(usuario.Password);
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
        if (id != usuario.Id)
        {
            return BadRequest();
        }

        var usuarioExistente = await _context.Usuarios.FindAsync(id);
        if (usuarioExistente == null)
        {
            return NotFound();
        }

        if (await _context.Usuarios.AnyAsync(u => u.Email == usuario.Email && u.Id != id))
        {
            return BadRequest("El email ya está registrado por otro usuario");
        }

        usuarioExistente.Nombre = usuario.Nombre;
        usuarioExistente.Email = usuario.Email;
        if (!string.IsNullOrEmpty(usuario.Password))
        {
            usuarioExistente.Password = BCrypt.Net.BCrypt.HashPassword(usuario.Password);
        }
        usuarioExistente.Rol = usuario.Rol;
        usuarioExistente.FechaModificacion = DateTime.Now;

        try
        {
                await _context.SaveChangesAsync();
        }
        catch (DbUpdateConcurrencyException)
        {
            if (!UsuarioExists(id))
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
    /// Elimina un usuario (baja lógica)
    /// </summary>
    [HttpDelete("{id}")]
    [Authorize(Roles = "Administrador")]
    public async Task<IActionResult> DeleteUsuario(int id)
    {
        var usuario = await _context.Usuarios.FindAsync(id);
        if (usuario == null)
        {
            return NotFound();
        }

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