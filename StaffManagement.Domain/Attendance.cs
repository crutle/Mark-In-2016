using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FYP_MarkIn.StaffManagement.Domain
{
    public class Attendance
    {
        public int AttendanceId { get; set; }
        public int StaffId { get; set; }
        public string Date { get; set; }
        public string Day{ get; set; }
        public string OutTime { get; set; }
        public string InTime { get; set; }
        public int Present { get; set; }
        public int TotalHours { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
    }
}