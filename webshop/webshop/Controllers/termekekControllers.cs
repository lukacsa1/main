using Microsoft.AspNetCore.Mvc;
using webshop.Models;

namespace webshop.Controllers
{

    [Route("termekek")]
    [ApiController]
    public class termekekControllers : ControllerBase
    {
        [HttpGet]
        public IActionResult Get()
        {
            using (var context = new WebshopContext())
            {
                try
                {
                    List<Termekek> response = context.Termekeks.ToList();
                    return Ok(response);
                }
                catch (Exception ex)
                {
                    List<Termekek> hiba = new List<Termekek>();
                    hiba.Add(new Termekek()
                    {
                        Id = -1,
                        Kategoria = ex.Message
                    });
                    return BadRequest(hiba);
                }

            }
        }
    }
}
