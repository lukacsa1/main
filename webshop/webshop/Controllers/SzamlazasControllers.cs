using Microsoft.AspNetCore.Mvc;
using webshop.Models;

namespace webshop.Controllers
{

    [Route("szamlazas")]
    [ApiController]
    public class SzamlazasControllers : ControllerBase
    {
        [HttpGet]
        public IActionResult Get()
        {
            using (var context = new WebshopContext())
            {
                try
                {
                    List<Szamlazasicimek> response = context.Szamlazasicimeks.ToList();
                    return Ok(response);
                }
                catch (Exception ex)
                {
                    List<Szamlazasicimek> hiba = new List<Szamlazasicimek>();
                    hiba.Add(new Szamlazasicimek()
                    {
                        Id = -1,
                        Utca = ex.Message
                    });
                    return BadRequest(hiba);
                }

            }
        }
    }
}
