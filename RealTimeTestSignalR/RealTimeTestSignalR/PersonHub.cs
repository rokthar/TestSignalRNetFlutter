using Microsoft.AspNetCore.SignalR;

namespace RealTimeTestSignalR
{
    public class PersonHub: Hub
    {
        public async Task SendPerson(string name, string lastname)
        {
            await Clients.All.SendAsync("Recivir", name, lastname);
        }
    }
}
