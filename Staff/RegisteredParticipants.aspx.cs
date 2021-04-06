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
    public partial class RegisteredParticipants : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        [WebMethod]
        public static object getRegisteredParticipants(string WebFormData)
        {
            var webFormData = JsonConvert.DeserializeObject<dynamic>(WebFormData);

            string eventId = webFormData.EventId.Value;
            ParticipantsManager participantsManager = new ParticipantsManager();
           
            //Get Registered participants
            List<Participant> participantList = participantsManager.getAllRegisteredParticipant(eventId);
            return participantList;

        }
        
            [WebMethod]
        public static object searchRegisteredParticipantsName(string inEventName, string inEventId)
        {
          
            ParticipantsManager participantsManager = new ParticipantsManager();

            //Get Registered participants
            List<Participant> participantList = participantsManager.searchRegisteredParticipantName(inEventId, inEventName);
            return participantList;

        }
        [WebMethod]
        public static object searchRegisteredParticipants(string inEventName, string inEventPresent,string inEventId)
        {
            
            ParticipantsManager participantsManager = new ParticipantsManager();

            //Get Registered participants
            List<Participant> participantList = participantsManager.searchRegisteredParticipant(inEventId, inEventName, inEventPresent);
            return participantList;

        }




    }
}