using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Mark_In_Admin.EventsManagement.Domain
{
    public class EventsManager
    {

        public List<Events> getAllEventsData()
        {
           
            DataSet ds = new DataSet();

            List<Events> eventsList = new List<Events>();
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
                        sqlText = "Select e.EventId, e.EventName, e.EventStartDate, e.EventEndDate, s.StaffName FROM Event e INNER JOIN Staff s ON e.CreatedBy = s.StaffId WHERE e.MarkedDeleted = 0";




                        cmd.CommandText = sqlText;

                        da.Fill(ds, "EventsData");
                        cmd.CommandText = sqlText;
                    }//using SqlDataAdapter da
                    cn.Close();

                }//using SQLCommand cmd
            }//using SQLConnection cn

            foreach (DataRow dr in ds.Tables["EventsData"].Rows)
            {

                Events events = new Events();
                events.EventId = Int32.Parse(dr["EventId"].ToString());
                events.EventName = dr["EventName"].ToString();
                events.EventStart = dr["EventStartDate"].ToString();
                events.EventEnd = dr["EventEndDate"].ToString();
                events.CreatedBy = dr["StaffName"].ToString();


                eventsList.Add(events);
            }


            return eventsList;
        } //end of getAllEventsData()

        public Events getOneEventData(string inEventId)
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection connection = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();
            Events events;
            cmd.Connection = connection;
            da.SelectCommand = cmd;

            String sqlText = "SELECT EventId, EventName, EventLocation, EventDescription, EventStartDate, EventEndDate ";
            //    sqlText+= "CONVERT(VARCHAR(10), EventStartDate, 101) + ' ' + LTRIM(RIGHT(CONVERT(CHAR(20), EventStartDate, 22), 11)),";
            // EventStartDate, EventEndDate
            sqlText += " FROM Event Where EventId = @inEventId AND MarkedDeleted = 0";
            cmd.CommandText = sqlText;
            cmd.Parameters.Add("@inEventId", SqlDbType.Int).Value = inEventId;

            connection.ConnectionString = ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();
            connection.Open();

            try
            {
                da.Fill(ds, "EventsData");
                DataRow dr = ds.Tables["EventsData"].Rows[0];

                events = new Events();
                {
                    events.EventId = Int32.Parse(dr["EventId"].ToString());
                    events.EventName = dr["EventName"].ToString();
                    events.EventStart = dr["EventStartDate"].ToString();
                    events.EventEnd = dr["EventEndDate"].ToString();
                    events.EventLocation = dr["EventLocation"].ToString();
                    events.EventDescription = dr["EventDescription"].ToString();
                }// end of Events class object, Events creation
            }// end of Try block

            catch (SqlException sqlEx)
            {
                throw new System.ArgumentException(sqlEx.Message);
            }//end of catch block

            finally
            {
                connection.Close();
            }//end of finally block

            return events;
        } //end of getOneEventData()

       

        public List<Events> getSearchEvent(string inEventId, string inEventName)
        {

            DataSet ds = new DataSet();

            List<Events> eventsList = new List<Events>();
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
                        sqlText = "Select e.EventId, e.EventName, e.EventStartDate, e.EventEndDate, s.StaffName " +
                            "FROM Event e INNER JOIN Staff s ON e.CreatedBy = s.StaffId " +
                            "WHERE e.MarkedDeleted = 0 AND (e.EventId = @inEventId or e.EventName = @inEventName)";

                        cmd.CommandText = sqlText;
                        cmd.Parameters.Add("@inEventId", SqlDbType.Int).Value = inEventId;
                        cmd.Parameters.Add("@inEventName", SqlDbType.VarChar, 50).Value = inEventName;


                        da.Fill(ds, "EventsData");
                    }
                    cn.Close();
                }
            }

            foreach (DataRow dr in ds.Tables["EventsData"].Rows)
            {

                Events events = new Events();
                events.EventId = Int32.Parse(dr["EventId"].ToString());
                events.EventName = dr["EventName"].ToString();
                events.EventStart = dr["EventStartDate"].ToString();
                events.EventEnd = dr["EventEndDate"].ToString();
                events.CreatedBy = dr["StaffName"].ToString();



                eventsList.Add(events);
            }

            return eventsList;
        } //end of getSearchEvent()

        public List<Events> getAllJoinedEventsData(string inUserId)
        {
            DataSet ds = new DataSet();

            List<Events> eventsList = new List<Events>();
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
                        sqlText = "Select e.EventId, e.EventName, e.EventStartDate, e.EventEndDate, p.Present FROM Event e INNER JOIN ParticipantAttendance p ON p.EventId = e.EventId WHERE p.ParticipantId=@inUserId AND e.MarkedDeleted = 0";

                        cmd.CommandText = sqlText;
                        cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;

                        da.Fill(ds, "EventsData");
                    }
                    cn.Close();
                }
            }

            foreach (DataRow dr in ds.Tables["EventsData"].Rows)
            {

                Events events = new Events();
                events.EventId = Int32.Parse(dr["EventId"].ToString());
                events.EventName = dr["EventName"].ToString();
                events.EventStart = dr["EventStartDate"].ToString();
                events.EventEnd = dr["EventEndDate"].ToString();
                events.Present = dr["Present"].ToString();


                eventsList.Add(events);
            }

            return eventsList;
        } //end of getAllEventsJoinedData()

        public List<Events> getSearchRegisteredEvent(string inEventPresent, string inEventName, string inUserId)
        {

            DataSet ds = new DataSet();

            List<Events> eventsList = new List<Events>();
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
                        sqlText = " SELECT e.EventId, e.EventName, e.EventStartDate, e.EventEndDate, p.Present FROM Event e " +
                            "INNER JOIN ParticipantAttendance p ON p.EventId = e.EventId WHERE p.ParticipantId = @inUserId AND e.MarkedDeleted = 0 AND (e.EventName = @inEventName OR p.Present = @inEventPresent)";
                        cmd.CommandText = sqlText;
                        cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;
                        cmd.Parameters.Add("@inEventPresent", SqlDbType.Bit, 1).Value = inEventPresent;
                        cmd.Parameters.Add("@inEventName", SqlDbType.VarChar, 50).Value = inEventName;


                        da.Fill(ds, "EventsData");
                    }
                    cn.Close();
                }

            }
            foreach (DataRow dr in ds.Tables["EventsData"].Rows)
            {

                Events events = new Events();
                events.EventId = Int32.Parse(dr["EventId"].ToString());
                events.EventName = dr["EventName"].ToString();
                events.EventStart = dr["EventStartDate"].ToString();
                events.EventEnd = dr["EventEndDate"].ToString();
                events.Present = dr["Present"].ToString();


                eventsList.Add(events);
            }

            return eventsList;
        } //end of getSearchEvent()

        public List<Events> getSearchRegisteredEventName(string inEventName, string inUserId)
        {

            DataSet ds = new DataSet();

            List<Events> eventsList = new List<Events>();
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
                        sqlText = "Select e.EventId, e.EventName, e.EventStartDate, e.EventEndDate, p.Present FROM Event e INNER JOIN ParticipantAttendance p ON p.EventId = e.EventId WHERE p.ParticipantId = @inUserId AND e.EventName = @inEventName AND e.MarkedDeleted = 0";

                        cmd.CommandText = sqlText;

                        cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;
                        cmd.Parameters.Add("@inEventName", SqlDbType.VarChar, 50).Value = inEventName;


                        da.Fill(ds, "EventsData");
                    }
                    cn.Close();
                }

            }
            foreach (DataRow dr in ds.Tables["EventsData"].Rows)
            {

                Events events = new Events();
                events.EventId = Int32.Parse(dr["EventId"].ToString());
                events.EventName = dr["EventName"].ToString();
                events.EventStart = dr["EventStartDate"].ToString();
                events.EventEnd = dr["EventEndDate"].ToString();
                events.Present = dr["Present"].ToString();


                eventsList.Add(events);
            }

            return eventsList;
        } //end of getSearchEvent()

        public List<Events> getSearchEventName(string inEventName)
        {

            DataSet ds = new DataSet();

            List<Events> eventsList = new List<Events>();
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
                        sqlText = " Select e.EventId, e.EventName, e.EventStartDate, e.EventEndDate, s.StaffName " +
                            "FROM Event e INNER JOIN Staff s ON e.CreatedBy = s.StaffId " +
                            "WHERE e.EventName = @inEventName AND e.MarkedDeleted = 0";

                        cmd.CommandText = sqlText;

                        cmd.Parameters.Add("@inEventName", SqlDbType.VarChar, 50).Value = inEventName;


                        da.Fill(ds, "EventsData");
                    }
                    cn.Close();
                }

            }
            foreach (DataRow dr in ds.Tables["EventsData"].Rows)
            {

                Events events = new Events();
                events.EventId = Int32.Parse(dr["EventId"].ToString());
                events.EventName = dr["EventName"].ToString();
                events.EventStart = dr["EventStartDate"].ToString();
                events.EventEnd = dr["EventEndDate"].ToString();
                // events.Present = dr["Present"].ToString();
                events.CreatedBy = dr["StaffName"].ToString();


                eventsList.Add(events);
            }

            return eventsList;

        }



        public int AddOneEvent(string inEventName, string inEventLocation, string inEventStart, string inEventEnd, string inEventDescription, string inUserId)
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection cn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();
            int numOfRecordsAffected = 0;
            cmd.Connection = cn;
            da.SelectCommand = cmd;
            cmd.CommandText = "USE [FYP_MarkIn_DB] INSERT INTO Event(EventName, EventLocation, EventStartDate, EventEndDate, EventDescription, CreatedBy, MarkedDeleted) VALUES" +
                "(@inEventName, @inEventLocation, @inEventStart , @inEventEnd , @inEventDescription, @inUserId, 0)";


            cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;
            cmd.Parameters.Add("@inEventName", SqlDbType.VarChar, 50).Value = inEventName;
            cmd.Parameters.Add("@inEventLocation", SqlDbType.VarChar, 50).Value = inEventLocation;
            cmd.Parameters.Add("@inEventStart", SqlDbType.DateTime).Value = inEventStart;
            cmd.Parameters.Add("@inEventEnd", SqlDbType.DateTime).Value = inEventEnd;
            cmd.Parameters.Add("@inEventDescription", SqlDbType.VarChar, 100).Value = inEventDescription;

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

        public int UpdateOneEvent(string inEventName, string inEventLocation, string inEventStart, string inEventEnd, string inEventDescription, string inUserId, string inEventId)
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection cn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();
            int numOfRecordsAffected = 0;
            cmd.Connection = cn;
            da.SelectCommand = cmd;
            cmd.CommandText = "UPDATE Event SET EventName = @inEventName, EventLocation = @inEventLocation, EventStartDate = @inEventStart, " +
                              "EventEndDate = @inEventEnd, EventDescription = @inEventDescription, UpdatedBy = @inUserId, UpdatedAt = getdate() WHERE EventId = @inEventId";


            cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;
            cmd.Parameters.Add("@inEventId", SqlDbType.Int).Value = inEventId;
            cmd.Parameters.Add("@inEventName", SqlDbType.VarChar, 50).Value = inEventName;
            cmd.Parameters.Add("@inEventLocation", SqlDbType.VarChar, 50).Value = inEventLocation;
            cmd.Parameters.Add("@inEventStart", SqlDbType.DateTime).Value = inEventStart;
            cmd.Parameters.Add("@inEventEnd", SqlDbType.DateTime).Value = inEventEnd;
            cmd.Parameters.Add("@inEventDescription", SqlDbType.VarChar, 100).Value = inEventDescription;

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

        public List<Events> getAllCreatedEvent(string inUserId)
        {
            DataSet ds = new DataSet();

            List<Events> eventsList = new List<Events>();
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
                        sqlText = "SELECT EventId,EventName,EventStartDate,EventEndDate FROM Event WHERE CreatedBy = @inUserId AND MarkedDeleted = 0";

                        cmd.CommandText = sqlText;
                        cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;

                        da.Fill(ds, "EventsData");
                    }
                    cn.Close();
                }
            }

            foreach (DataRow dr in ds.Tables["EventsData"].Rows)
            {

                Events events = new Events();
                events.EventId = Int32.Parse(dr["EventId"].ToString());
                events.EventName = dr["EventName"].ToString();
                events.EventStart = dr["EventStartDate"].ToString();
                events.EventEnd = dr["EventEndDate"].ToString();
         
                eventsList.Add(events);
            }

            return eventsList;
        } //end of getAllEventsJoinedData()


        public List<Events> getSearchCreatedEvent(string inEventId, string inEventName, string inUserId)
        {

            DataSet ds = new DataSet();

            List<Events> eventsList = new List<Events>();
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
                        sqlText = "SELECT EventId, EventName, EventStartDate, EventEndDate FROM Event WHERE CreatedBy = @inUserId AND MarkedDeleted = 0 AND (EventId = @inEventId OR EventName = @inEventName)";
                        cmd.CommandText = sqlText;
                        cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;
                        cmd.Parameters.Add("@inEventId", SqlDbType.Int).Value = inEventId;
                        cmd.Parameters.Add("@inEventName", SqlDbType.VarChar, 50).Value = inEventName;


                        da.Fill(ds, "EventsData");
                    }
                    cn.Close();
                }

            }
            foreach (DataRow dr in ds.Tables["EventsData"].Rows)
            {

                Events events = new Events();
                events.EventId = Int32.Parse(dr["EventId"].ToString());
                events.EventName = dr["EventName"].ToString();
                events.EventStart = dr["EventStartDate"].ToString();
                events.EventEnd = dr["EventEndDate"].ToString();
               

                eventsList.Add(events);
            }

            return eventsList;
        } //end of getSearchEvent()

        public List<Events> getSearchCreatedEventName(string inEventName, string inUserId)
        {

            DataSet ds = new DataSet();

            List<Events> eventsList = new List<Events>();
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
                        sqlText = "SELECT EventId,EventName,EventStartDate,EventEndDate FROM Event WHERE CreatedBy = @inUserId AND EventName= @inEventName AND MarkedDeleted = 0";
                        cmd.CommandText = sqlText;

                        cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;
                        cmd.Parameters.Add("@inEventName", SqlDbType.VarChar, 50).Value = inEventName;


                        da.Fill(ds, "EventsData");
                    }
                    cn.Close();
                }

            }
            foreach (DataRow dr in ds.Tables["EventsData"].Rows)
            {

                Events events = new Events();
                events.EventId = Int32.Parse(dr["EventId"].ToString());
                events.EventName = dr["EventName"].ToString();
                events.EventStart = dr["EventStartDate"].ToString();
                events.EventEnd = dr["EventEndDate"].ToString();
               

                eventsList.Add(events);
            }

            return eventsList;
        } //end of getSearchEvent()


        public int deleteEvent(string inEventId, string inUserId)
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection cn = new SqlConnection();
            int eventId = 0;
            cmd.Connection = cn;
            cmd.CommandText = "UPDATE Event SET MarkedDeleted = 1, UpdatedBy = @inUserId, UpdatedAt = getdate(), MarkedDeletedBy = @inUserId, MarkedDeletedAt = getdate() WHERE CreatedBy = @inUserId AND EventId = @inEventId";
            cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;
            cmd.Parameters.Add("@inEventId", SqlDbType.Int).Value = inEventId;


            cn.ConnectionString = ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();
            cn.Open();
            try
            {
                eventId = Int32.Parse(cmd.ExecuteScalar().ToString());
            }

            catch (SqlException sqlEx)
            {
                throw new System.ArgumentException(sqlEx.Message);
            }

            cn.Close();
            return eventId;

        } //end 


        //Get Participant Name
        public string getEventNameById(string inEventId) // Get a User by userId
        {
            SqlCommand cmd = new SqlCommand();//To hold the SQL
            SqlConnection cn = new SqlConnection();//To make db connection
            //To retrieve the data and store in dataset
            SqlDataAdapter da = new SqlDataAdapter();
            string eName;

            cmd.Connection = cn;// Tell cmd to use cn
            da.SelectCommand = cmd; // tell the da to use the cmd

            cmd.CommandText = "Select EventName FROM Event WHERE EventId = @inEventId";
            cmd.Parameters.Add("@inEventId", SqlDbType.Int).Value = inEventId;

            cn.ConnectionString =
                ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();

            cn.Open();

            try
            {
                eName = cmd.ExecuteScalar().ToString();
            }
            catch (SqlException sqlEx)
            {
                throw new System.ArgumentException(sqlEx.Message);
            }

            cn.Close();

            if (eName != null)
            {
                return eName.ToString();
            }
            else
            {
                return "0";
            }
        }//end


     

        public int joinOneEvent(string inUserId, string inName, string inEventId, string inEventName)
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection cn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();
            int numOfRecordsAffected = 0;
            cmd.Connection = cn;
            da.SelectCommand = cmd;
            cmd.CommandText = "INSERT INTO ParticipantAttendance(Date, ParticipantId, ParticipantName, EventId, EventName, Present) VALUES" +
                "(getdate(), @inUserId, @inName, @inEventId, @inEventName, 0)";


            cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;
            cmd.Parameters.Add("@inName", SqlDbType.VarChar, 50).Value = inName;
            cmd.Parameters.Add("@inEventId", SqlDbType.Int).Value = inEventId;
            cmd.Parameters.Add("@inEventName", SqlDbType.VarChar, 50).Value = inEventName;

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


        public string checkEventParticipation(string inUserId, string inEventId)
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection cn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();

            string count;

            cmd.Connection = cn;
            da.SelectCommand = cmd;
            cmd.CommandText = " Select COUNT(*) FROM ParticipantAttendance WHERE ParticipantId = @inUserId AND EventId = @inEventId";
            cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;
            cmd.Parameters.Add("@inEventId", SqlDbType.Int).Value = inEventId;

            cn.ConnectionString =
                ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();

            cn.Open();

            try
            {
                count = cmd.ExecuteScalar().ToString();
            }
            catch (SqlException sqlEx)
            {
                throw new System.ArgumentException(sqlEx.Message);
            }

            cn.Close();

            if (count != null)
            {
                return count.ToString();
            }
            else
            {
                return "0";
            }
        }//end if staffid valid
       
    }
}