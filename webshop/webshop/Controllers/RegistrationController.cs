using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using webshop.Models;

namespace webshop.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RegistrationController : ControllerBase
    {
        [HttpPost("UserRegistration")]
        public async Task<IActionResult> UserRegistration(User user)
        {
            using (var context = new WebshopContext())
            {
                try
                {
                    if(context.Users.FirstOrDefault(u => u.LoginName == user.LoginName) is not null)
                    {
                        return BadRequest("Ez a felhasználónév már foglalt!");
                    }
                    if(context.Users.FirstOrDefault(u => u.Email == user.Email) is not null)
                    {
                        return BadRequest("Ez az E-mail cím már foglalt!");
                    }

                    user.PermissionLevel = 0;
                    user.Active = 0;
                    user.Hash = Manager.CreateSHA256(user.Hash);
                    await context.AddAsync(user);
                    await context.SaveChangesAsync();

                    //TODO: send Email

                    return Ok("A regisztráció véglegesítéséhez ellenőrizd az Emailjeid!");
                }
                catch (Exception ex)
                {
                    return BadRequest("Valami nagyon nem jó :((( " + ex.Message);
                }
            }
        }

        [HttpGet("GetNewSalt")]
        public IActionResult GenerateNewSalt()
        {
            return Ok(Manager.GenerateSalt());
        }
    }
}
