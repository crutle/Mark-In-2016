using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using FYP_MarkIn.EventsManagement.Domain;
using Newtonsoft.Json;

namespace FYP_MarkIn.Staff
{
    public partial class AttendanceList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static object getAllAttendance(string WebFormData)
        {
            var webFormData = JsonConvert.DeserializeObject<dynamic>(WebFormData);

            string userId = webFormData.UserId.Value;
            AttendanceManager atsManager = new AttendanceManager();
            //Get TableName
            string tableName = atsManager.getTableName(userId);
            //Get Attendance
            List<Attendance> attList = atsManager.getAllAttendance(tableName);
            return attList;
        }

        [WebMethod]
        public static object getStaffDetails(string WebFormData)
        {
            var webFormData = JsonConvert.DeserializeObject<dynamic>(WebFormData);

            string userId = webFormData.UserId.Value;
            AttendanceManager atsManager = new AttendanceManager();
            //Get Attendance
           // Attendance name = new Attendance();
            string name = atsManager.getStaff(userId);
            return name;
        }

        [WebMethod]
        public static object searchAttendance(string inEventDate,string inEventPresent,string inUserId)
        {

            AttendanceManager atsManager = new AttendanceManager();
            //Get TableName
            string tableName = atsManager.getTableName(inUserId);
            //Get Attendance
            List<Attendance> attList = atsManager.searchAttendance(inUserId, tableName, inEventDate, inEventPresent);
            return attList; 
        }

        [WebMethod]
        public static object searchAttendanceDate(string inEventDate, string inUserId)
        {
                        
            AttendanceManager atsManager = new AttendanceManager();
            //Get TableName
            string tableName = atsManager.getTableName(inUserId);
            //Get Attendance
            List<Attendance> attList = atsManager.searchAttendanceDate(inUserId, tableName, inEventDate);
            return attList;
        }

        [WebMethod]
        public static object searchAttendancePresent(string inEventPresent, string inUserId)
        {

            AttendanceManager atsManager = new AttendanceManager();
            //Get TableName
            string tableName = atsManager.getTableName(inUserId);
            //Get Attendance
            List<Attendance> attList = atsManager.searchAttendancePresent(inUserId, tableName, inEventPresent);
            return attList;
        }
    }
}