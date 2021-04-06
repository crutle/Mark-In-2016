using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace FYP_MarkIn.StaffManagement.Domain
{
    public class AttendanceManager
    {
        //Get Staff Name
        public string getStaffUserNameByUserId(int inUserId) // Get a User by userId
        {
            SqlCommand cmd = new SqlCommand();//To hold the SQL
            SqlConnection cn = new SqlConnection();//To make db connection
            //To retrieve the data and store in dataset
            SqlDataAdapter da = new SqlDataAdapter();
            string userName;

            cmd.Connection = cn;// Tell cmd to use cn
            da.SelectCommand = cmd; // tell the da to use the cmd

            cmd.CommandText = "Select StaffName From Staff Where StaffId = @inUserId";
            cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;

            cn.ConnectionString =
                ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();

            cn.Open();

            try
            {
                userName = cmd.ExecuteScalar().ToString();
            }
            catch (SqlException sqlEx)
            {
                throw new System.ArgumentException(sqlEx.Message);
            }

            cn.Close();

            if (userName != null)
            {
                return userName.ToString();
            }
            else
            {
                return "0";
            }
        }//End of getStaffUserNameByUserId

        //get all rows
        public List<Attendance> getAllRows(string tableName)
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection cn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();
            cmd.Connection = cn;

            var cmdString = string.Format("Select AttendanceDate, AttendanceDay, CheckedInTime, CheckedOutTime, Present, TotalWorkingHours FROM {0}", tableName);
            cmd.CommandText = cmdString;

            cn.ConnectionString =
                 ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();

            List<Attendance> attendanceList = new List<Attendance>();
            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            try
            {
                Attendance staff;

                while (dr.Read())
                {
                    staff = new Attendance();
                    staff.StaffId = int.Parse(dr["StaffId"].ToString());
                    staff.Date = dr["AttendanceDate"].ToString();
                    staff.Day= dr["AttendanceDay"].ToString();
                    staff.InTime = dr["CheckedInTime"].ToString();
                    staff.OutTime = dr["CheckedOutTime"].ToString();          
                    staff.Present = int.Parse(dr["Present"].ToString());
                    staff.TotalHours = int.Parse(dr["TotalWorkingHours"].ToString());

                    attendanceList.Add(staff);
                }

                /*da.Fill(ds, "StaffData");
                foreach (DataRow dr in ds.Tables["StaffData"].Rows)
                {
                    Staff staff = new Staff();
                    staff.StaffId = Int32.Parse(dr["StaffId"].ToString());
                    staffList.Add(staff);
                }*/

            }
            catch (SqlException sqlEx)
            {
                throw new System.ArgumentException(sqlEx.Message);
            }

            //Send the Sql to the database for processing
            cn.Close();
            return attendanceList;



        }//end Get All StaffId From Staff
    }
}