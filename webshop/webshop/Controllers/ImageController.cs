using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace webshop.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ImageController : ControllerBase
    {
        IWebHostEnvironment _env;

        public ImageController(IWebHostEnvironment env)
        {
            _env = env;
        }

        [Route("ProductImages/UploadImage")]
        [HttpPost]
        public IActionResult UploadImage(string token)
        {
            if (Manager.CheckPermission(token, 9))
            {
                try
                {
                    IFormCollection httpRequest = Request.Form;
                    IFormFile postedFile = httpRequest.Files[0];
                    string fileName = postedFile.FileName;
                    string filePath = _env.ContentRootPath + "/Images/ProductImages/" + fileName;
                    using (FileStream stream = new FileStream(filePath, FileMode.Create))
                    {
                        postedFile.CopyTo(stream);
                    }
                    return Ok($"Sikeres feltöltés {fileName}");
                }
                catch (Exception ex)
                {
                    return BadRequest("A feltöltés sikertelen" + ex.Message);
                }
            }
            else
            {
                return Unauthorized(Manager.UserNotEligableMessage);
            }
        }
    }
}
