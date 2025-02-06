using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using webshop.DTOs;
using webshop.Models;

namespace webshop.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        [HttpPost("GetSalt/{userName}")]
        public async Task<IActionResult> GetSalt(string username)
        {
            using (var context = new WebshopContext())
            {
                try
                {
                    Felhasznalok response = await context.Felhasznaloks.FirstOrDefaultAsync(x => x.LoginName == username);
                    if (response == null)
                    {
                        return NotFound("Nem található felhasználó ezzel a felhasználónévvel.");
                    }
                    else
                    {
                        return Ok(response.Salt);
                    }
                }
                catch (Exception ex)
                {
                    return BadRequest(ex.Message);
                }
            }
        }

        public async Task<IActionResult> Login(LoginDTO loginDTO)
        {
            using (var context = new WebshopContext())
            {
                try
                {
                    string Hash = Manager.CreateSHA256(loginDTO.TmpHash);
                    Felhasznalok loggedUser = await context.Felhasznaloks.FirstOrDefaultAsync(u => u.LoginName == loginDTO.LoginName && u.Hash == Hash);
                    if (loggedUser != null)
                    {
                        string token = Guid.NewGuid().ToString();
                        lock (Manager.LoggedInUsers)
                        {
                            Manager.LoggedInUsers.Add(token, loggedUser);
                        }
                        return Ok(new LoggedUser
                        {
                            LoginName = loginDTO.LoginName,
                            Email = loggedUser.Email
                        });
                    }
                    else
                    {
                        return NotFound("Nem található felhasználó ezzel a felhasználónévvel.");
                    }
                }
                catch (Exception ex)
                {
                    return BadRequest(ex.Message);
                }
            }
        }
    }
}
