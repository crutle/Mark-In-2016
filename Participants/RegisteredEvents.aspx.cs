using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Mark_In_Admin.EventsManagement.Domain;

namespace Mark_In_Admin.Participants
{
    public partial class RegisteredEvents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [WebMethod]
        public static object getAllJoinedEventsData(string WebFormData)
        {
            // dynamic inWebFormDataObject = JsonConvert.DeserializeObject(inWebFormData);
            var webFormData = JsonConvert.DeserializeObject<dynamic>(WebFormData);

            string userId = webFormData.UserId.Value; 
            EventsManager eventsManager = new EventsManager();
            List<Events> eventsList = eventsManager.getAllJoinedEventsData(userId);
            return eventsList;

        }

        [WebMethod]
        public static object searchEventName(string inEventName,string inUserId)
        {
            // dynamic inWebFormDataObject = JsonConvert.DeserializeObject(inWebFormData);
            EventsManager eventsManager = new EventsManager();
            // Events events = new Events();


            List<Events> eventsList = eventsManager.getSearchRegisteredEventName(inEventName, inUserId);
            return eventsList;


        }

            [WebMethod]
        public static object searchEvent(string inEventName, string inEventPresent, string inUserId)
        {
            // dynamic inWebFormDataObject = JsonConvert.DeserializeObject(inWebFormData);
            EventsManager eventsManager = new EventsManager();
            // Events events = new Events();


            List<Events> eventsList = eventsManager.getSearchRegisteredEvent(inEventPresent, inEventName, inUserId);
            return eventsList;

        }
    }
}
