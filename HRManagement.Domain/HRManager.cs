using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace FYP_MarkIn.HRManagement.Domain
{
    public class HRManager
    {
        public int AddOneStaff(string inName, string inTableName, string inPassword, string inType, string inPosition, string inSalary, string inContact, string inDateofbirth, string inAddress, string inStatus, string inUserId)
        {
          

            SqlCommand cmd = new SqlCommand();
            SqlConnection cn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();
            int numOfRecordsAffected = 0;
            cmd.Connection = cn;
            da.SelectCommand = cmd;
            cmd.CommandText = "INSERT INTO Staff (StaffName, TableName, Password, Administrator, Position, Salary, ContactNo, DateOfBirth, Address, Status, CreatedBy) VALUES " +
                "(@inName, @inTableName, @inPassword, @inType, @inPosition, @inSalary, @inContact, @inDateofbirth, @inAddress, @inStatus, @inUserId)";

            cmd.Parameters.Add("@inName", SqlDbType.VarChar, 50).Value = inName;
            cmd.Parameters.Add("@inPosition", SqlDbType.VarChar, 50).Value = inPosition;
            cmd.Parameters.Add("@inType", SqlDbType.VarChar, 50).Value = inType;
            cmd.Parameters.Add("@inSalary", SqlDbType.Decimal).Value = inSalary;
            cmd.Parameters.Add("@inContact", SqlDbType.Int).Value = inContact;
            cmd.Parameters.Add("@inDateofbirth", SqlDbType.DateTime).Value = inDateofbirth;
            cmd.Parameters.Add("@inAddress", SqlDbType.VarChar, 1000).Value = inAddress;
            cmd.Parameters.Add("@inTableName", SqlDbType.VarChar, 50).Value = inTableName;
            cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;
            cmd.Parameters.Add("@inPassword", SqlDbType.VarChar, 20).Value = inPassword;
            cmd.Parameters.Add("@inStatus", SqlDbType.VarChar, 20).Value = inStatus;

            cn.ConnectionString =
              ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();
            cn.Open();
            try
            {
                numOfRecordsAffected = cmd.ExecuteNonQuery();
            }

            catch (SqlException sqlEx)
            {

            }


            cn.Close();

            return numOfRecordsAffected;


        }

        public List<HumanResource> getAllStaff()
        {

            DataSet ds = new DataSet();

            List<HumanResource> hrList = new List<HumanResource>();
            string sqlText = "";
            using (SqlConnection cn = new SqlConnection())
            {
                cn.ConnectionString =
              ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = cn; //setup the 
                    cn.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        sqlText = "Select StaffId, StaffName, Position, Salary, Status, Administrator FROM Staff";

                        cmd.CommandText = sqlText;

                        da.Fill(ds, "StaffData");
                        cmd.CommandText = sqlText;
                    }//using SqlDataAdapter da
                    cn.Close();

                }//using SQLCommand cmd
            }//using SQLConnection cn

            foreach (DataRow dr in ds.Tables["StaffData"].Rows)
            {

                HumanResource hr = new HumanResource();
                hr.StaffId = Int32.Parse(dr["StaffId"].ToString());
                hr.StaffName = dr["StaffName"].ToString();
                hr.Position = dr["Position"].ToString();
                hr.Salary = dr["Salary"].ToString();
                hr.Status = dr["Status"].ToString();
                hr.Type = dr["Administrator"].ToString();
                hrList.Add(hr);
            }


            return hrList;
        }


        
        //Retrieve 1 record
        public HumanResource GetStaffInfo(string inStaffId)
        {
            DataSet ds = new DataSet();
            HumanResource humanresource = new HumanResource();
            using (SqlConnection cn = new SqlConnection())
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    using (SqlDataAdapter da = new SqlDataAdapter())
                    {
                        cn.ConnectionString =
                            ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();
                        cmd.Connection = cn;
                        cmd.CommandText = "Select StaffName, TableName, Password, Administrator, Position, Salary, ContactNo, DateOfBirth, Address, Status FROM Staff WHERE StaffId = @inStaffId";
                        cmd.Parameters.Add("@inStaffId", SqlDbType.Int).Value = inStaffId;
                        da.SelectCommand = cmd;

                        cn.Open();
                        da.Fill(ds, "StaffData");

                        cn.Close();
                    }
                }
            }

            DataRow dr = ds.Tables["StaffData"].Rows[0];

            //humanresource.StaffId = int.Parse(dr["StaffId"].ToString());
            humanresource.StaffName = dr["StaffName"].ToString();
            humanresource.StaffPassword = dr["Password"].ToString();
            humanresource.Type = dr["Administrator"].ToString();
            humanresource.Position = dr["Position"].ToString();
            humanresource.Salary = dr["Salary"].ToString();
            humanresource.Contact = dr["ContactNo"].ToString();
            humanresource.Dateofbirth = dr["DateofBirth"].ToString();
            humanresource.Address = dr["Address"].ToString();
            humanresource.Status = dr["Status"].ToString();
            humanresource.TableName = dr["TableName"].ToString();
         
            return humanresource;
        }
        public int UpdateOneStaff(string inName, string inTableName, string inPassword, string inType, string inPosition, string inSalary, string inContact, string inDateofbirth, string inAddress, string inStatus, string inStaffId, string inUserId)
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection cn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();
            int numOfRecordsAffected = 0;
            cmd.Connection = cn;
            da.SelectCommand = cmd;
            cmd.CommandText = "UPDATE Staff SET StaffName = @inName, TableName = @inTableName, Password = @inPassword, Administrator = @inType, Position = @inPosition, " +
                "Salary = @inSalary, ContactNo = @inContact, DateOfBirth = @inDateofbirth, Address = @inAddress, Status = @inStatus, UpdatedBy = @inUserId, UpdatedAt = getdate() " +
                "WHERE StaffId = @inStaffId";

            cmd.Parameters.Add("@inName", SqlDbType.VarChar, 50).Value = inName;
            cmd.Parameters.Add("@inPosition", SqlDbType.VarChar, 50).Value = inPosition;
            cmd.Parameters.Add("@inType", SqlDbType.VarChar, 50).Value = inType;
            cmd.Parameters.Add("@inSalary", SqlDbType.Decimal).Value = inSalary;
            cmd.Parameters.Add("@inContact", SqlDbType.Int).Value = inContact;
            cmd.Parameters.Add("@inDateofbirth", SqlDbType.DateTime).Value = inDateofbirth;
            cmd.Parameters.Add("@inAddress", SqlDbType.VarChar, 1000).Value = inAddress;
            cmd.Parameters.Add("@inTableName", SqlDbType.VarChar, 50).Value = inTableName;
            cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;
            cmd.Parameters.Add("@inPassword", SqlDbType.VarChar, 20).Value = inPassword;
            cmd.Parameters.Add("@inStatus", SqlDbType.VarChar, 20).Value = inStatus;
            cmd.Parameters.Add("@inStaffId", SqlDbType.Int).Value = inStaffId;

            cn.ConnectionString =
              ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();
            cn.Open();
            try
            {
                numOfRecordsAffected = cmd.ExecuteNonQuery();
            }

            catch (SqlException sqlEx)
            {

            }


            cn.Close();

            return numOfRecordsAffected;


        }

        public int AddStaffTable(string tableName) { 
            SqlCommand cmd = new SqlCommand();
            SqlConnection cn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();
            int numOfRecordsAffected = 0;
            cmd.Connection = cn;
            da.SelectCommand = cmd;

            var cmdString = string.Format("USE [FYP_MarkIn_DB]" +

                                " SET ANSI_NULLS ON SET QUOTED_IDENTIFIER ON SET ANSI_PADDING ON " +

                                " CREATE TABLE[dbo].{0}( " +

                                " [AttendanceId][int] IDENTITY(1, 1) NOT NULL, " +

                                " [StaffId][int] NOT NULL, " +

                               " [AttendanceDate][date] NOT NULL, " +

                               " [AttendanceDay][varchar](20) NOT NULL, " +

                               " [CheckedInTime][datetime] NULL, " +

                                " [CheckedOutTime][datetime] NULL, " +

                               " [Present][bit] NOT NULL, " +

                               " [TotalWorkingHours][varchar](50) NULL, " +

                               " [CreatedAt][datetime] NULL DEFAULT(getdate()), " +

                               " [UpdatedAt][datetime] NULL " +
                               " ) ON[PRIMARY] " +

                               " SET ANSI_PADDING OFF",tableName );

            cmd.CommandText = cmdString;

            
            cn.ConnectionString =
              ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();
            cn.Open();
            try
            {
                numOfRecordsAffected = cmd.ExecuteNonQuery();
            }

            catch (SqlException sqlEx)
            {
                throw new System.ArgumentException(sqlEx.Message);
            }


            cn.Close();

            return numOfRecordsAffected;

        }





        public string getStaff(string inUserId)
        {
            string staffName;
            SqlCommand cmd = new SqlCommand();
            SqlConnection cn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();

            cmd.Connection = cn;

            string sqlText = "";

            sqlText = "Select StaffName FROM Staff WHERE StaffId = @inUserId";

            cmd.CommandText = sqlText;
            cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;

            cn.ConnectionString = "server=DIT-NB1431533\\SQLEXPRESS; database=FYP_MarkIn_DB;";
            cn.ConnectionString += "integrated security=true;";

            cn.Open();

            try
            {
                staffName = cmd.ExecuteScalar().ToString();
            }
            catch (SqlException sqlEx)
            {
                throw new System.ArgumentException(sqlEx.Message);
            }

            //Send the Sql to the database for processing
            cn.Close();

            if (staffName != null)
            {
                return staffName.ToString();
            }
            else
            {
                return "0";
            }

        }

        public List<HumanResource> searchStaff(string inStaffId, string inStaffName)
        {
            DataSet ds = new DataSet();

            List<HumanResource> hrList = new List<HumanResource>();
            string sqlText = "";
            using (SqlConnection cn = new SqlConnection())
            {
                cn.ConnectionString =
              ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = cn; //setup the 
                    cn.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        sqlText = "Select StaffId, StaffName, Position, Salary, Status, Administrator FROM Staff WHERE StaffId = @inStaffId OR StaffName = @inStaffName";

                        cmd.CommandText = sqlText;

                        cmd.Parameters.Add("@inStaffId", SqlDbType.Int).Value = inStaffId;
                        cmd.Parameters.Add("@inStaffName", SqlDbType.VarChar, 50).Value = inStaffName;

                        da.Fill(ds, "StaffData");
                        cmd.CommandText = sqlText;
                    }//using SqlDataAdapter da
                    cn.Close();

                }//using SQLCommand cmd
            }//using SQLConnection cn

            foreach (DataRow dr in ds.Tables["StaffData"].Rows)
            {

                HumanResource hr = new HumanResource();
                hr.StaffId = Int32.Parse(dr["StaffId"].ToString());
                hr.StaffName = dr["StaffName"].ToString();
                hr.Position = dr["Position"].ToString();
                hr.Salary = dr["Salary"].ToString();
                hr.Status = dr["Status"].ToString();
                hr.Type = dr["Administrator"].ToString();
                hrList.Add(hr);
            }


            return hrList;
        }

        public List<HumanResource> searchStaffName(string inStaffName)
        {
            DataSet ds = new DataSet();

            List<HumanResource> hrList = new List<HumanResource>();
            string sqlText = "";
            using (SqlConnection cn = new SqlConnection())
            {
                cn.ConnectionString =
              ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = cn; //setup the 
                    cn.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        sqlText = "Select StaffId, StaffName, Position, Salary, Status, Administrator FROM Staff WHERE StaffName = @inStaffName";

                        cmd.CommandText = sqlText;

                        
                        cmd.Parameters.Add("@inStaffName", SqlDbType.VarChar, 50).Value = inStaffName;

                        da.Fill(ds, "StaffData");
                        cmd.CommandText = sqlText;
                    }//using SqlDataAdapter da
                    cn.Close();

                }//using SQLCommand cmd
            }//using SQLConnection cn

            foreach (DataRow dr in ds.Tables["StaffData"].Rows)
            {

                HumanResource hr = new HumanResource();
                hr.StaffId = Int32.Parse(dr["StaffId"].ToString());
                hr.StaffName = dr["StaffName"].ToString();
                hr.Position = dr["Position"].ToString();
                hr.Salary = dr["Salary"].ToString();
                hr.Status = dr["Status"].ToString();
                hr.Type = dr["Administrator"].ToString();
                hrList.Add(hr);
            }


            return hrList;
        }




        //ATTENDANCE
        public string getTableName(string inUserId)
        {
            string tableName;
            SqlCommand cmd = new SqlCommand();
            SqlConnection cn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();

            cmd.Connection = cn;

            string sqlText = "";

            sqlText = "Select TableName FROM Staff WHERE StaffId = @inUserId";

            cmd.CommandText = sqlText;
            cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;

            cn.ConnectionString = "server=DIT-NB1431533\\SQLEXPRESS; database=FYP_MarkIn_DB;";
            cn.ConnectionString += "integrated security=true;";

            cn.Open();

            try
            {
                tableName = cmd.ExecuteScalar().ToString();
            }
            catch (SqlException sqlEx)
            {
                throw new System.ArgumentException(sqlEx.Message);
            }

            //Send the Sql to the database for processing
            cn.Close();

            if (tableName != null)
            {
                return tableName.ToString();
            }
            else
            {
                return "0";
            }

        }


        public List<HumanResource> getAllAttendance(string tableName)
        {
            DataSet ds = new DataSet();

            List<HumanResource> attList = new List<HumanResource>();

            using (SqlConnection cn = new SqlConnection())
            {
                cn.ConnectionString =
              ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = cn; //setup the 
                    cn.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        string cmdString = string.Format("Select convert(varchar, AttendanceDate, 103) as AttendanceDate, AttendanceDay, CheckedInTime, CheckedOutTime, Present, TotalWorkingHours FROM {0}", tableName);

                        cmd.CommandText = cmdString;
                        //  cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;

                        da.Fill(ds, "AttData");
                    }
                    cn.Close();
                }
            }

            foreach (DataRow dr in ds.Tables["AttData"].Rows)
            {

                HumanResource att = new HumanResource();
                att.Date = dr["AttendanceDate"].ToString();
                att.Day = dr["AttendanceDay"].ToString();
                att.InTime = dr["CheckedInTime"].ToString();
                att.OutTime = dr["CheckedOutTime"].ToString();
                att.Present = dr["Present"].ToString();
                att.TotalHours = dr["TotalWorkingHours"].ToString();
                //att.StaffName = dr["StaffName"].ToString();

                attList.Add(att);
            }

            return attList;
        } //end of getAllEventsJoinedData()

        public List<HumanResource> searchAttendance(string tableName, string inEventDate, string inEventPresent)
        {
            DataSet ds = new DataSet();

            List<HumanResource> attList = new List<HumanResource>();

            using (SqlConnection cn = new SqlConnection())
            {
                cn.ConnectionString =
              ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = cn; //setup the 
                    cn.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        string cmdString = string.Format("Select convert(varchar, AttendanceDate, 103) as AttendanceDate, AttendanceDay, CheckedInTime, CheckedOutTime, Present, TotalWorkingHours FROM {0} WHERE Present = @inEventPresent OR AttendanceDate = @inEventDate", tableName);

                        cmd.CommandText = cmdString;
                      // cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;
                        cmd.Parameters.Add("@inEventDate", SqlDbType.DateTime).Value = inEventDate;
                        cmd.Parameters.Add("@inEventPresent", SqlDbType.Bit, 1).Value = inEventPresent;



                        da.Fill(ds, "AttData");
                    }
                    cn.Close();
                }
            }

            foreach (DataRow dr in ds.Tables["AttData"].Rows)
            {

                HumanResource att = new HumanResource();
                att.Date = dr["AttendanceDate"].ToString();
                att.Day = dr["AttendanceDay"].ToString();
                att.InTime = dr["CheckedInTime"].ToString();
                att.OutTime = dr["CheckedOutTime"].ToString();
                att.Present = dr["Present"].ToString();
                att.TotalHours = dr["TotalWorkingHours"].ToString();


                attList.Add(att);
            }

            return attList;
        } //end of getAllEventsJoinedData()


        public List<HumanResource> searchAttendanceDate(string tableName, string inEventDate)
        {
            DataSet ds = new DataSet();

            List<HumanResource> attList = new List<HumanResource>();

            using (SqlConnection cn = new SqlConnection())
            {
                cn.ConnectionString =
              ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = cn; //setup the 
                    cn.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        string cmdString = string.Format("Select convert(varchar, AttendanceDate, 103) as AttendanceDate, AttendanceDay, CheckedInTime, CheckedOutTime, Present, TotalWorkingHours FROM {0} " +
                                                           " WHERE AttendanceDate = @inEventDate", tableName);

                        cmd.CommandText = cmdString;
                       // cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;
                        cmd.Parameters.Add("@inEventDate", SqlDbType.DateTime).Value = inEventDate;




                        da.Fill(ds, "AttData");
                    }
                    cn.Close();
                }
            }

            foreach (DataRow dr in ds.Tables["AttData"].Rows)
            {

                HumanResource att = new HumanResource();
                att.Date = dr["AttendanceDate"].ToString();
                att.Day = dr["AttendanceDay"].ToString();
                att.InTime = dr["CheckedInTime"].ToString();
                att.OutTime = dr["CheckedOutTime"].ToString();
                att.Present = dr["Present"].ToString();
                att.TotalHours = dr["TotalWorkingHours"].ToString();

                attList.Add(att);
            }

            return attList;
        } //end of getAllEventsJoinedData

        public List<HumanResource> searchAttendancePresent(string tableName, string inEventPresent)
        {
            DataSet ds = new DataSet();

            List<HumanResource> attList = new List<HumanResource>();

            using (SqlConnection cn = new SqlConnection())
            {
                cn.ConnectionString =
              ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = cn; //setup the 
                    cn.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        string cmdString = string.Format("Select convert(varchar, AttendanceDate, 103) as AttendanceDate, AttendanceDay, CheckedInTime, CheckedOutTime, Present, TotalWorkingHours FROM {0}" +
                                                        " WHERE Present = @inEventPresent ", tableName);


                        cmd.CommandText = cmdString;
                       // cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;
                        cmd.Parameters.Add("@inEventPresent", SqlDbType.Bit, 1).Value = inEventPresent;

                        da.Fill(ds, "AttData");
                    }
                    cn.Close();
                }
            }

            foreach (DataRow dr in ds.Tables["AttData"].Rows)
            {

                HumanResource att = new HumanResource();
                att.Date = dr["AttendanceDate"].ToString();
                att.Day = dr["AttendanceDay"].ToString();
                att.InTime = dr["CheckedInTime"].ToString();
                att.OutTime = dr["CheckedOutTime"].ToString();
                att.Present = dr["Present"].ToString();
                att.TotalHours = dr["TotalWorkingHours"].ToString();
                attList.Add(att);
            }

            return attList;
        } //end of getAllEventsJoinedData()


    }
}
