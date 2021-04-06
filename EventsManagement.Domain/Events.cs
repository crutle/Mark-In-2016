using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mark_In_Admin.EventsManagement.Domain
{
    public class Events
    {
        public int EventId { get; set; }
        public string EventName { get; set; }
        public string EventStart { get; set; }
        public string EventEnd { get; set; }
        public string EventLocation { get; set; }
        public string EventDescription { get; set; }

        public string Present { get; set; }

        public string CreatedBy { get; set; }

    }
}