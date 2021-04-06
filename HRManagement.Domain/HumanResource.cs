using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FYP_MarkIn.HRManagement.Domain
{
    public class HumanResource
    {
        public int StaffId { get; set; }
        public string StaffName { get; set; }
        public string Position { get; set; }
        public string Salary { get; set; }
        public string Contact { get; set; }
        public string Dateofbirth { get; set; }
        public string Address { get; set; }
        public string Status { get; set; }
        public string Type { get; set; }

        public string TableName { get; set; }
        public string StaffPassword {get;set;}

        public string Date { get; set; }
        public string OutTime { get; set; }
        public string InTime { get; set; }
        public string Present { get; set; }
        public string TotalHours { get; set; }

        public string Day { get; set; }
    }
}