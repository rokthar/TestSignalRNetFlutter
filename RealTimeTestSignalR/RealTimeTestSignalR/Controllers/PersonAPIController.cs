using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using RealTimeTestSignalR.Models;

namespace RealTimeTestSignalR.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PersonAPIController : ControllerBase
    {
        private IHubContext<PersonHub> _hubContext;
        public PersonAPIController(IHubContext<PersonHub> hubContext)
        {
            _hubContext = hubContext;
        }

        [HttpPost]
        public async Task<IActionResult> AddPerson(person person)
        {
            await _hubContext.Clients.All.SendAsync("Recivir", person.Name, person.LastName);
            return Ok();
        }
    }
}
