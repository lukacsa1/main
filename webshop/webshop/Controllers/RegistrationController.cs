using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using webshop.Models;

namespace webshop.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RegistrationController : ControllerBase
    {
        

        [HttpGet("GetNewSalt")]
        public IActionResult GenerateNewSalt()
        {
            return Ok(Manager.GenerateSalt());
        }
    }
}
