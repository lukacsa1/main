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
        public IActionResult UploadProductImage(string token)
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

        [Route("ProductImages/GetImageByName/{fileName}")]
        [HttpGet]
        public IActionResult GetProductImageByName(string fileName)
        {
            string _productImageDirectory = Path.Combine(Directory.GetCurrentDirectory(), "Images", "ProductImages");

            var filePath = Path.Combine(_productImageDirectory, fileName);

            if (!System.IO.File.Exists(filePath))
            {
                return NotFound("Image not found " + filePath);
            }

            var fileStream = new FileStream(filePath, FileMode.Open, FileAccess.Read);
            var mimeType = GetImageType(fileName);
            return File(fileStream, mimeType);
        }
        private string GetImageType(string fileName)
        {
            var extension = Path.GetExtension(fileName).ToLower();
            return extension switch
            {
                ".jpg" or ".jpeg" => "image/jpeg",
                ".png" => "image/png",
                ".gif" => "image/gif",
                ".bmp" => "image/bmp",
                ".webp" => "image/webp",
                _ => "application/octet-stream"
            };
        }
    }
}
