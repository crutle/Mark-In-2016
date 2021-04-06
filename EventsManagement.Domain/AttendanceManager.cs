using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace FYP_MarkIn.EventsManagement.Domain
{
    public class AttendanceManager
    {
        public List<Attendance> getAllAttendance(string tableName)
        {
            DataSet ds = new DataSet();

            List<Attendance> attList = new List<Attendance>();
           
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
                        string cmdString = string.Format("Select convert(varchar, AttendanceDate , 103) as AttendanceDate, e.CheckedInTime, e.CheckedOutTime, e.Present, e.TotalWorkingHours FROM {0} e INNER JOIN Staff s ON e.StaffId = s.StaffId", tableName);
                        
                        cmd.CommandText = cmdString;
                      //  cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;

                        da.Fill(ds, "AttData");
                    }
                    cn.Close();
                }
            }

            foreach (DataRow dr in ds.Tables["AttData"].Rows)
            {

                Attendance att= new Attendance();
                att.Date = dr["AttendanceDate"].ToString();
                att.InTime = dr["CheckedInTime"].ToString();
                att.OutTime = dr["CheckedOutTime"].ToString();
                att.Present = dr["Present"].ToString();
                att.TotalHours = dr["TotalWorkingHours"].ToString();
                //att.StaffName = dr["StaffName"].ToString();

                attList.Add(att);
            }

            return attList;
        } //end of getAllEventsJoinedData()

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

        public List<Attendance> searchAttendance(string inUserId, string tableName, string inEventDate, string inEventPresent)
        {
            DataSet ds = new DataSet();

            List<Attendance> attList = new List<Attendance>();

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
                        string cmdString = string.Format("Select convert(varchar, AttendanceDate , 103) as AttendanceDate, " +
                       " e.CheckedInTime, e.CheckedOutTime, e.Present, e.TotalWorkingHours FROM {0} e INNER JOIN Staff s ON e.StaffId = s.StaffId "+
                       " WHERE e.Present = @inEventPresent OR e.AttendanceDate = @inEventDate", tableName);

                        cmd.CommandText = cmdString;
                        cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;
                        cmd.Parameters.Add("@inEventDate", SqlDbType.DateTime).Value = inEventDate;
                        cmd.Parameters.Add("@inEventPresent", SqlDbType.Bit, 1).Value = inEventPresent;



                        da.Fill(ds, "AttData");
                    }
                    cn.Close();
                }
            }

            foreach (DataRow dr in ds.Tables["AttData"].Rows)
            {

                Attendance att = new Attendance();
                att.Date = dr["AttendanceDate"].ToString();
                att.InTime = dr["CheckedInTime"].ToString();
                att.OutTime = dr["CheckedOutTime"].ToString();
                att.Present = dr["Present"].ToString();
                att.TotalHours = dr["TotalWorkingHours"].ToString();
             

                attList.Add(att);
            }

            return attList;
        } //end of getAllEventsJoinedData()


        public List<Attendance> searchAttendanceDate(string inUserId, string tableName, string inEventDate)
        {
            DataSet ds = new DataSet();

            List<Attendance> attList = new List<Attendance>();

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
                        string cmdString = string.Format("Select convert(varchar, AttendanceDate , 103) as AttendanceDate, " +
                       " e.CheckedInTime, e.CheckedOutTime, e.Present, e.TotalWorkingHours FROM {0} e INNER JOIN Staff s ON e.StaffId = s.StaffId " +
                       " WHERE e.AttendanceDate = @inEventDate", tableName);

                        cmd.CommandText = cmdString;
                        cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;
                        cmd.Parameters.Add("@inEventDate", SqlDbType.DateTime).Value = inEventDate;
                     



                        da.Fill(ds, "AttData");
                    }
                    cn.Close();
                }
            }

            foreach (DataRow dr in ds.Tables["AttData"].Rows)
            {

                Attendance att = new Attendance();
                att.Date = dr["AttendanceDate"].ToString();
                att.InTime = dr["CheckedInTime"].ToString();
                att.OutTime = dr["CheckedOutTime"].ToString();
                att.Present = dr["Present"].ToString();
                att.TotalHours = dr["TotalWorkingHours"].ToString();
              

                attList.Add(att);
            }

            return attList;
        } //end of getAllEventsJoinedData

        public List<Attendance> searchAttendancePresent(string inUserId, string tableName, string inEventPresent)
        {
            DataSet ds = new DataSet();

            List<Attendance> attList = new List<Attendance>();

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
                        string cmdString = string.Format("Select convert(varchar, AttendanceDate , 103) as AttendanceDate, " +
                       " e.CheckedInTime, e.CheckedOutTime, e.Present, e.TotalWorkingHours FROM {0} e INNER JOIN Staff s ON e.StaffId = s.StaffId " +
                       " WHERE e.Present = @inEventPresent ", tableName);

                        cmd.CommandText = cmdString;
                        cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;
                        cmd.Parameters.Add("@inEventPresent", SqlDbType.Bit, 1).Value = inEventPresent;




                        da.Fill(ds, "AttData");
                    }
                    cn.Close();
                }
            }

            foreach (DataRow dr in ds.Tables["AttData"].Rows)
            {

                Attendance att = new Attendance();
                att.Date = dr["AttendanceDate"].ToString();
                att.InTime = dr["CheckedInTime"].ToString();
                att.OutTime = dr["CheckedOutTime"].ToString();
                att.Present = dr["Present"].ToString();
                att.TotalHours = dr["TotalWorkingHours"].ToString();


                attList.Add(att);
            }

            return attList;
        } //end of getAllEventsJoinedData()


        /*
        public Staff GetStaff(int inStaffId)
        {
            /*------------------------------------------------------------------
              Method Name: GetOneAttendance
              Parameters: inCategoryId
              Purpose: Accept the category id from the calling program, to generate
                       a proper SQL to query for one category record from the database.
              Returns: Returns [one] Category object only. And this Category object
                       is filled with the
                       category record obtained from the database 
             -------------------------------------------------------------------*/

        /*

                    DataSet ds = new DataSet();

                    Staff staff = new Staff();
                    using (SqlConnection cn = new SqlConnection())
                    {
                        using (SqlCommand cmd = new SqlCommand())
                        {
                            using (SqlDataAdapter da = new SqlDataAdapter())
                            {

                                cn.ConnectionString =
                                    ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
                                cmd.Connection = cn;

                                cmd.CommandText = "SELECT Date, isnull((CONVERT(varchar(100), CheckedInTime, 103)), 'NA') AS CheckedInTime, isnull((CONVERT(varchar(100), CheckedOutTime, 103)), 'NA') AS CheckedOutTime, Present, TotalWorkingHours FROM Staff1 ; ";
                                cmd.Parameters.Add("@inStaffId", SqlDbType.Int).Value = inStaffId;

                                da.SelectCommand = cmd;

                                cn.Open();
                                //Tell the da, so that the da can tell the cmd to send the SQL
                                //to the database. Database receives the SQL and returns one course record.
                                //The SqlDataAdapter object, da will capture the course record and write them 
                                //into the Dataset(ds). The results are grouped and given a name,
                                //CourseData. (the named results 'CourseData' is also
                                //known as a DataTable)
                                da.Fill(ds, "StaffData"); //Note that, there should only be one row of course info
                                                          //sitting inside the CourseData DataTable.
                                cn.Close();//close the connection

                            }
                        }
                    }
                    //There is only one datarow in the DataTable, ds.Tables["CategoryData"]
                    //Use [0] to that datarow and copy out the category data into the course object.
                    DataRow dr = ds.Tables["StaffData"].Rows[0];
                    staff.StaffId = int.Parse(dr["StaffId"].ToString());
                    staff.Date = dr["Date"].ToString();
                    staff.InTime = dr["Date"].ToString();
                    staff.OutTime = dr["Date"].ToString();
                    staff.Present = int.Parse(dr["Present"].ToString());
                    staff.TotalHours = int.Parse(dr["TotalWorkingHours"].ToString());

                    return staff;
                }//end of GetStaff() method


                public List<Object> GetAllWithInfo(int inPresent)
                {
                    /*------------------------------------------------------------------
                     Method Name: GetAllCategoriesWithInfo
                     Parameters: inVisibility - represents the desired visibility of the records
                     Purpose: Generates a proper SQL to query for all category record from the database
                              which are not marked as deleted.
                     Returns: Returns a List of objects which is filled with the
                              category records obtained from the database. For example, if there
                              are 4 category records obtained from the database, there should be
                              a List of 4 object instances. Each instance contain one category information.
                     -------------------------------------------------------------------*/
        /*
                    string sql = "";
                    if (inPresent == 2)
                    {
                        //All
                        sql = "SELECT Date, isnull((CONVERT(varchar(100), CheckedInTime, 103)), 'NA') AS CheckedInTime, isnull((CONVERT(varchar(100), CheckedOutTime, 103)), 'NA') AS CheckedOutTime, Present, TotalWorkingHours FROM Staff1; ";
                    }
                    else if (inPresent == 1)
                    {
                        //Hidden
                        sql = "SELECT Date, isnull((CONVERT(varchar(100), CheckedInTime, 103)), 'NA') AS CheckedInTime, isnull((CONVERT(varchar(100), CheckedOutTime, 103)), 'NA') AS CheckedOutTime, Present, TotalWorkingHours FROM Staff1 where Present =1; ";
                    }
                    else if (inPresent == 0)
                    {
                        //Visible ignore start and end date
                        sql = "SELECT Date, isnull((CONVERT(varchar(100), CheckedInTime, 103)), 'NA') AS CheckedInTime, isnull((CONVERT(varchar(100), CheckedOutTime, 103)), 'NA') AS CheckedOutTime, Present, TotalWorkingHours FROM Staff1 where Present =0; ";
                    }




                    //Create an empty DataSet object, ds.
                    //This object has the capability to hold information
                    DataSet ds = new DataSet();
                    //Create an empty List, courseList
                    List<Object> staffList = new List<Object>();
                    using (SqlConnection cn = new SqlConnection())
                    {
                        using (SqlCommand cmd = new SqlCommand())
                        {
                            using (SqlDataAdapter da = new SqlDataAdapter())
                            {

                                cn.ConnectionString =
                                    ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
                                cmd.Connection = cn;//tell the cmd to use the cn

                                cmd.CommandText = sql;

                                da.SelectCommand = cmd;

                                cn.Open();
                                //Tell the da, so that the da can tell the cmd to send the SQL
                                //to the database. Database receives the SQL and returns the results.
                                //The SqlDataAdapter object, da will capture the result and write them 
                                //into the Dataset(ds). The results are grouped and given a name,
                                //CategoryData. (the named results 'CategoryData' is also
                                //known as a DataTable)
                                da.Fill(ds, "StaffData");
                                cn.Close();

                            }
                        }
                    }
                    foreach (DataRow dr in ds.Tables["EventData"].Rows)
                    {
                        var genericObject = new
                        {
                            Date = dr["Date"].ToString(),
                            InTime = dr["CheckedInTime"].ToString(),
                            OutTime = dr["CheckedOutTime"].ToString(),
                            Present = dr["Present"].ToString(),
                            TotalHours = dr["TotalWorkingHours"].ToString(),
                        };

                        staffList.Add(genericObject);
                    }

                    return staffList;
                } //end getAllCategories()

        */

    }
}