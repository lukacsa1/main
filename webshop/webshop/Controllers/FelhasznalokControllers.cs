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
                    List<Felhasznalok> response = context.Felhasznaloks.ToList();
                    return Ok(response);
                    //teszteles
                }
                catch (Exception ex)
                {
                    List<Felhasznalok> hiba = new List<Felhasznalok>();
                    hiba.Add(new Felhasznalok()
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
