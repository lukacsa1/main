using Microsoft.AspNetCore.Mvc;
using webshop.Models;

namespace webshop.Controllers
{

    [Route("felhasznalok")]
    [ApiController]
    public class FelhasznalokControllers : ControllerBase
    {
        [HttpGet]
        public IActionResult Get()
        {
            using (var context = new WebshopContext())
            {
                try
                {
                    List<User> response = context.Users.ToList();
                    return Ok(response);
                }
                catch (Exception ex)
                {
                    List<User> hiba = new List<User>();
                    hiba.Add(new User()
                    {
                        Id = -1,
                        Email = ex.Message
                    });
                    return BadRequest(hiba);
                }

            }
        }
    }
}
