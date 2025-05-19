using Microsoft.AspNetCore.Mvc; // ✅ Funcionalidad para definir controladores API
using Microsoft.EntityFrameworkCore; // ✅ Manejo de Entity Framework para base de datos
using Microsoft.IdentityModel.Tokens; // ✅ Seguridad para generación de tokens JWT
using SistemaIndicadores.API.Data; // ✅ Importa el contexto de datos del proyecto
using SistemaIndicadores.Shared.Entities; // ✅ Importa las entidades compartidas
using System.IdentityModel.Tokens.Jwt; // ✅ Manejo de JWT para autenticación
using System.Security.Claims; // ✅ Manejo de claims de seguridad
using System.Text; // ✅ Codificación para clave JWT

namespace SistemaIndicadores.API.Controllers; // ✅ Espacio de nombres correcto

[ApiController]
[Route("api/[controller]")]
public class AuthController : ControllerBase
{
    private readonly DataContext _context; // 📌 Instancia del contexto de datos
    private readonly IConfiguration _configuration; // 📌 Manejo de configuración para JWT

    public AuthController(DataContext context, IConfiguration configuration)
    {
        _context = context;
        _configuration = configuration;
    }

    /// <summary>
    /// Autentica un usuario y genera un token JWT
    /// </summary>
    [HttpPost("login")]
    public async Task<ActionResult<AuthResponse>> Login([FromBody] LoginRequest request)
    {
        var usuario = await _context.Usuarios
            .Include(u => u.RolesUsuario)
            .ThenInclude(ru => ru.Rol)
            .FirstOrDefaultAsync(u => u.Email == request.Email);

        if (usuario == null || !BCrypt.Net.BCrypt.Verify(request.Password, usuario.Contrasena))
        {
            return Unauthorized("Credenciales inválidas");
        }

        var roles = usuario.RolesUsuario.Select(ru => ru.Rol.Nombre).ToList();
        var token = GenerateJwtToken(usuario, roles);
        
        return Ok(new AuthResponse 
        { 
            Token = token,
            Usuario = new UserInfo
            {
                Email = usuario.Email,
                Roles = roles
            }
        });
    }

    /// <summary>
    /// Registra un nuevo usuario en el sistema
    /// </summary>
    [HttpPost("register")]
    public async Task<ActionResult<AuthResponse>> Register([FromBody] RegisterRequest request)
    {
        if (await _context.Usuarios.AnyAsync(u => u.Email == request.Email))
        {
            return BadRequest("El email ya está registrado");
        }

        // Crear el usuario
        var usuario = new Usuario
        {
            Email = request.Email,
            Contrasena = BCrypt.Net.BCrypt.HashPassword(request.Password)
        };

        // Obtener el rol de Usuario
        var rolUsuario = await _context.Roles.FirstOrDefaultAsync(r => r.Nombre == "Usuario");
        if (rolUsuario == null)
        {
            return StatusCode(500, "Error al asignar rol de usuario");
        }

        // Crear la relación usuario-rol
        var rolUsuarioRelacion = new RolUsuario
        {
            Usuario = usuario,
            FkEmail = usuario.Email,
            FkIdRol = rolUsuario.Id,
            Rol = rolUsuario
        };

        // Guardar cambios en la base de datos
        _context.Usuarios.Add(usuario);
        _context.RolesUsuario.Add(rolUsuarioRelacion);
        await _context.SaveChangesAsync();

        var roles = new List<string> { "Usuario" };
        var token = GenerateJwtToken(usuario, roles);
        
        return Ok(new AuthResponse 
        { 
            Token = token,
            Usuario = new UserInfo
            {
                Email = usuario.Email,
                Roles = roles
            }
        });
    }

    private string GenerateJwtToken(Usuario usuario, List<string> roles)
    {
        var claims = new List<Claim>
        {
            new Claim(ClaimTypes.Name, usuario.Email),
            new Claim("Email", usuario.Email)
        };

        // Agregar roles como claims
        foreach (var rol in roles)
        {
            claims.Add(new Claim(ClaimTypes.Role, rol));
        }

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

public class LoginRequest
{
    public string Email { get; set; } = null!;
    public string Password { get; set; } = null!;
}

public class RegisterRequest
{
    public string Email { get; set; } = null!;
    public string Password { get; set; } = null!;
}

public class UserInfo
{
    public string Email { get; set; } = null!;
    public List<string> Roles { get; set; } = new();
}

public class AuthResponse
{
    public string Token { get; set; } = null!;
    public UserInfo Usuario { get; set; } = null!;
}