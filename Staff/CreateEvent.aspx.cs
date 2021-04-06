using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Mark_In_Admin.EventsManagement.Domain;
using Newtonsoft.Json;

namespace FYP_MarkIn.Staff
{
    public partial class CreateEvent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static object getAllEvent(string WebFormData)
        {
            var webFormData = JsonConvert.DeserializeObject<dynamic>(WebFormData);

            string userId = webFormData.UserId.Value;
            EventsManager eventManager = new EventsManager();
            List<Events> eventList = eventManager.getAllCreatedEvent(userId);
            return eventList;

        }

        [WebMethod]
        public static object AddOneEvent(string WebFormData)
        {
            var webFormData = JsonConvert.DeserializeObject<dynamic>(WebFormData);
            //string userId = webFormData.UserId.Value;

            int newEventId = 0;
            string collectedEventName = webFormData.EventName.Value;
            string collectedEventLocation = webFormData.EventLocation.Value;

            string collectedEventStart=  webFormData.EventStart.Value;

            string collectedEventEnd = webFormData.EventEnd.Value;
       

            string collectedEventDescription = webFormData.EventDescription.Value;
            string userId = webFormData.UserId.Value;

            string message = "";
            try
            {
                EventsManager eventManager = new EventsManager();
                newEventId = eventManager.AddOneEvent(collectedEventName, collectedEventLocation, collectedEventStart, collectedEventEnd, collectedEventDescription, userId);

                if (newEventId > 0)
                {
                    var response = new
                    {
                        newCategoryId = newEventId,
                        status = "success",
                        message = "Created a new events record."
                    };
                    return response;

                }
                else
                {

                    var response = new
                    {
                        newEventId = 0,
                        status = "fail",
                        message = "Unable to save event record."
                    };
                    return response;
                }
            }
            catch (Exception ex)
            {
                var response = new
                {
                    newEventId = 0,
                    status = "fail",
                    message = "Unable to save event record. " + ex.Message
                };
                return response;
            }

        }

        [WebMethod]
        public static object UpdateOneEvent(string WebFormData)
        {
            var webFormData = JsonConvert.DeserializeObject<dynamic>(WebFormData);
            //string userId = webFormData.UserId.Value;

            int newEventId = 0;
            string collectedEventName = webFormData.EventName.Value;
            string collectedEventLocation = webFormData.EventLocation.Value;
            string collectedEventStart = webFormData.EventStart.Value;
            string collectedEventEnd = webFormData.EventEnd.Value;
            string collectedEventDescription = webFormData.EventDescription.Value;
            string userId = webFormData.UserId.Value;
            string eventId = webFormData.EventId.Value;


            string message = "";
            try
            {
                EventsManager eventManager = new EventsManager();
                newEventId = eventManager.UpdateOneEvent(collectedEventName, collectedEventLocation, collectedEventStart, collectedEventEnd, collectedEventDescription, userId, eventId);

                if (newEventId > 0)
                {
                    var response = new
                    {
                        newCategoryId = newEventId,
                        status = "success",
                        message = "Created a new events record."
                    };
                    return response;

                }
                else
                {

                    var response = new
                    {
                        newEventId = 0,
                        status = "fail",
                        message = "Unable to save event record."
                    };
                    return response;
                }
            }
            catch (Exception ex)
            {
                var response = new
                {
                    newEventId = 0,
                    status = "fail",
                    message = "Unable to save event record. " + ex.Message
                };
                return response;
            }

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
        public static object searchEvent(string inEventId, string inEventName, string inUserId)
        {
            // dynamic inWebFormDataObject = JsonConvert.DeserializeObject(inWebFormData);
            EventsManager eventsManager = new EventsManager();
            // Events events = new Events();


            List<Events> eventsList = eventsManager.getSearchCreatedEvent(inEventId, inEventName, inUserId);
            return eventsList;

        }

        [WebMethod]
        public static object searchEventName(string inEventName, string inUserId)
        {
            // dynamic inWebFormDataObject = JsonConvert.DeserializeObject(inWebFormData);
            EventsManager eventsManager = new EventsManager();
            // Events events = new Events();


            List<Events> eventsList = eventsManager.getSearchCreatedEventName(inEventName, inUserId);
            return eventsList;


        }

        [WebMethod]
        public static object deleteEvent(string inEventId, string inUserId)
        {
            try
            {
                EventsManager eventsManager = new EventsManager();
                int result = eventsManager.deleteEvent(inEventId, inUserId);


                if (result > 0)
                {
                    var response = new
                    {
                        newCategoryId = result,
                        status = "success",
                        message = "Deleted event record."
                    };
                    return response;

                }
                else
                {

                    var response = new
                    {
                        newEventId = 0,
                        status = "fail",
                        message = "Unable to delete event record."
                    };
                    return response;
                }
            }

            catch (Exception ex)
            {
                var response = new
                {
                    newEventId = 0,
                    status = "fail",
                    message = "Unable to delete event record. " + ex.Message
                };
                return response;
            }
        }
    }
}