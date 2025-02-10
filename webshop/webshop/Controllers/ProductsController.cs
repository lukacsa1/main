using Microsoft.AspNetCore.Mvc;
using webshop.Models;

namespace webshop.Controllers
{

    [Route("termekek")]
    [ApiController]
    public class ProductsController : ControllerBase
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

        [HttpPost("CreateNewProduct")]
        public async Task<IActionResult> CreateNewProduct(string token, Termekek termek)
        {
            if(Manager.CheckPermission(token, 9))
            {
                using (var context = new WebshopContext())
                {
                    try
                    {
                        context.Termekeks.Add(termek);
                        await context.SaveChangesAsync();
                        return Ok("Az új termék sikeresen hozzáadva!");
                    }
                    catch (Exception ex)
                    {
                        return BadRequest("Nem sikerült hozzáadni az új terméket! " + ex.Message);
                    }
                }
            }
            else
            {
                return BadRequest(Manager.UserNotEligableMessage);
            }
        }
    }
}
