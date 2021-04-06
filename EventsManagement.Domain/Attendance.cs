using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FYP_MarkIn.EventsManagement.Domain
{
    public class Attendance
    {
        public int AttendanceId { get; set; }
        public int StaffId { get; set; }
        public string Date { get; set; }
        public string OutTime { get; set; }
        public string InTime { get; set; }
        public string Present { get; set; }
        public string TotalHours { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedAt { get; set; }
        public string UpdatedBy { get; set; }
        public DateTime UpdatedAt { get; set; }

        public string StaffName { get; set; }

    }
}