using Microsoft.AspNetCore.Mvc;

namespace ProjectDunyam.Controllers
{
    public class AdminController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
