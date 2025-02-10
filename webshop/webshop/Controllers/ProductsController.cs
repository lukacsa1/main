using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.FileProviders;
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
                return Unauthorized(Manager.UserNotEligableMessage);
            }
        }

        [HttpPut("UpdateProduct")]
        public async Task<IActionResult> UpdateProduct(string token, Termekek product)
        {
            if(Manager.CheckPermission(token, 9))
            {
                using (var context = new WebshopContext())
                {
                    try
                    {
                        if(context.Termekeks.Where(p => p.Id == product.Id) is not null)
                        {
                            var result = context.Termekeks.Update(product);
                            await context.SaveChangesAsync();
                            return Ok("Sikeres módosítás!");
                        } 
                        else
                        {
                            return NotFound("Nincs ilyen termék!");
                        }
                    }
                    catch (Exception ex)
                    {
                        return BadRequest("Nem sikerült módosítani a terméket! " + ex.Message);
                    }
                }
            }
            else
            {
                return Unauthorized(Manager.UserNotEligableMessage);
            }
        }

        [HttpDelete("DeleteProduct/{Id}")]
        public async Task<IActionResult> DeleteProduct(string token, int Id)
        {
            if(Manager.CheckPermission(token, 9))
            {
                using (var context = new WebshopContext())
                {
                    try
                    {
                        var deleteProduct = context.Termekeks.FirstOrDefault(p => p.Id == Id);
                        if (deleteProduct is not null)
                        {
                            context.Remove(deleteProduct);
                            await context.SaveChangesAsync();
                            return Ok("Termék sikeresen törölve!");
                        }
                        else
                        {
                            return NotFound("Nem található a termék!");
                        }
                    }
                    catch (Exception ex)
                    {
                        return BadRequest("Nem sikerült törölni a terméket! " + ex.Message);
                    }
                }
            }
            else
            {
                return Unauthorized(Manager.UserNotEligableMessage);
            }
        }
    }
}
