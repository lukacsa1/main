using Microsoft.AspNetCore.Mvc;
using webshop.Models;

namespace webshop.Controllers
{

    [Route("Rendeles")]
    [ApiController]
    public class RendelesControllers : ControllerBase
    {
        [HttpGet]
        public IActionResult Get()
        {
            using (var context = new WebshopContext())
            {
                try
                {
                    List<Rendelesek> response = context.Rendeleseks.ToList();
                    return Ok(response);
                }
                catch (Exception ex)
                {
                    List<Rendelesek> hiba = new List<Rendelesek>();
                    hiba.Add(new Rendelesek()
                    {
                        RendelesSzam = -1,
                        Statusz = ex.Message
                    });
                    return BadRequest(hiba);
                }

            }
        }
    }
}
