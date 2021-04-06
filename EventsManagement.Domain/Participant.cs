using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mark_In_Admin.EventsManagement.Domain
{
    public class Participant
    {
        public int ParticipantId { get; set; }
        public string ParticipantName { get; set; }
        public string ParticipantContactNo { get; set; }
        public string CompanyName { get; set; }
        public string CompanyPosition { get; set; }
        public string ParticipantEmail { get; set; }
        public int QRImage { get; set; }

        public string Present { get; set; }
        public string Password { get; set; }
    }

  
}