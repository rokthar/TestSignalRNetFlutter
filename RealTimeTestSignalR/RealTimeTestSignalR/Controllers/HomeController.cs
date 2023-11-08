using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using RealTimeTestSignalR.Models;
using System.Diagnostics;

namespace RealTimeTestSignalR.Controllers
{
    public class HomeController : Controller
    {
        private IHubContext<PersonHub> _hubContext;
        public HomeController(IHubContext<PersonHub> hubContext)
        {
            _hubContext = hubContext;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult PersonForm()
        {
            return View();
        }

        public async Task<IActionResult> AddPerson(person person)
        {
            await _hubContext.Clients.All.SendAsync("Recivir", person.Name, person.LastName);
            return View("PersonForm");
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}