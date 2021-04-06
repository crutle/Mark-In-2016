using Mark_In_Admin.EventsManagement.Domain;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Mark_In_Admin.Participants
{
    public partial class ContactInformation : System.Web.UI.Page
    { 
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        [WebMethod]
        public static object getAllContactInformation(string WebFormData)
        {

            var webFormData = JsonConvert.DeserializeObject<dynamic>(WebFormData);

            string userId = webFormData.UserId.Value;
            ParticipantsManager participantsManager = new ParticipantsManager();
            List<Participant> contactList = participantsManager.getAllContactInformation(userId);
            return contactList;

        }

        [WebMethod]
        public static object searchEvent(string inContactName, string inContactCompany,string inUserId)
        {
   
            ParticipantsManager participantsManager = new ParticipantsManager();
            List<Participant> contactList = participantsManager.getSearchContact(inContactName, inContactCompany, inUserId);
            
            return contactList;

        }

}
}