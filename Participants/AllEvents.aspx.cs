using Mark_In_Admin.EventsManagement.Domain;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Mark_In_Admin.Login.Domain;

namespace Mark_In_Admin.Participants
{
    public partial class AllEvents : System.Web.UI.Page
    {

        [WebMethod]
        public static object getAllEventsData(string inWebFormData)
        {
            dynamic inWebFormDataObject = JsonConvert.DeserializeObject(inWebFormData);
            EventsManager eventsManager = new EventsManager();
            List<Events> eventsList = eventsManager.getAllEventsData();
            return eventsList;

        }

        [WebMethod(EnableSession = true)]
        public static object getOneEventsData(string eventId)
        {
           // dynamic inWebFormDataObject = JsonConvert.DeserializeObject(inWebFormData);
            EventsManager eventsManager = new EventsManager();
            Events events = new Events();

            int eventSelectedId = Int32.Parse(eventId);
            events = eventsManager.getOneEventData(eventSelectedId.ToString());
            return events;    

    }
       [WebMethod]
        public static object searchEvent(string inEventName, string inEventId)
        {
          // dynamic inWebFormDataObject = JsonConvert.DeserializeObject(inWebFormData);
            EventsManager eventsManager = new EventsManager();
           // Events events = new Events();
            
         
            List<Events> eventsList = eventsManager.getSearchEvent(inEventId, inEventName);
            return eventsList;

        }


        [WebMethod]
        public static object searchEventName(string inEventName)
        {
            // dynamic inWebFormDataObject = JsonConvert.DeserializeObject(inWebFormData);
            EventsManager eventsManager = new EventsManager();
            // Events events = new Events();

            List<Events> eventsList = eventsManager.getSearchEventName(inEventName);
            return eventsList;


        }

        [WebMethod]
        public static object joinEvent(string inUserId, string inEventId)
        {
            string response = "";
            UserManager userManager = new UserManager();
            string name = userManager.getParticipantUserNameByUserId(inUserId);
            EventsManager eManager = new EventsManager();
            string eventName = eManager.getEventNameById(inEventId);

            //Checked if joined
            string result = eManager.checkEventParticipation(inUserId, inEventId);

            if (result == "0")
            {
                //INSERT
                int resultJoin = eManager.joinOneEvent(inUserId, name, inEventId, eventName);

                if (resultJoin > 0)
                {
                    response = "success";
                    return response;
                }
                else
                {
                    response = "failed";
                    return response;
                }

            }
            
            else
           {
                response = "exists";
                return response;
            }
        }


    }
}