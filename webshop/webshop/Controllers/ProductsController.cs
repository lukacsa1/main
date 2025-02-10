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
                        return Ok("Az �j term�k sikeresen hozz�adva!");
                    }
                    catch (Exception ex)
                    {
                        return BadRequest("Nem siker�lt hozz�adni az �j term�ket! " + ex.Message);
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
                            return Ok("Sikeres m�dos�t�s!");
                        } 
                        else
                        {
                            return NotFound("Nincs ilyen term�k!");
                        }
                    }
                    catch (Exception ex)
                    {
                        return BadRequest("Nem siker�lt m�dos�tani a term�ket! " + ex.Message);
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
                            return Ok("Term�k sikeresen t�r�lve!");
                        }
                        else
                        {
                            return NotFound("Nem tal�lhat� a term�k!");
                        }
                    }
                    catch (Exception ex)
                    {
                        return BadRequest("Nem siker�lt t�r�lni a term�ket! " + ex.Message);
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
