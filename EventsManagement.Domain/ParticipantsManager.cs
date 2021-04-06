using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Mark_In_Admin.EventsManagement.Domain
{
    public class ParticipantsManager
    {
        //******************CONTACT******************//
        public List<Participant> getAllContactInformation(string inUserId)
        {

            DataSet ds = new DataSet();

            List<Participant> contactList = new List<Participant>();
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
                        sqlText = "Select p.ParticipantId ,p.ParticipantName, p.ContactNo, p.CompanyName, p.CompanyPosition, p.Email FROM Participant p INNER JOIN ContactInformation c ON p.ParticipantId = c.ContactId WHERE c.ParticipantId = @inUserId";
                        cmd.CommandText = sqlText;
                        cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;

                        da.Fill(ds, "ContactsData");
                    }
                    cn.Close();
                }
            }

            foreach (DataRow dr in ds.Tables["ContactsData"].Rows)
            {

                Participant part = new Participant();
                part.ParticipantId = Int32.Parse(dr["ParticipantId"].ToString());
                part.ParticipantName = dr["ParticipantName"].ToString();
                part.ParticipantContactNo= dr["ContactNo"].ToString();
                part.CompanyName = dr["CompanyName"].ToString();
                part.CompanyPosition = dr["CompanyPosition"].ToString();
                part.ParticipantEmail = dr["Email"].ToString();


                contactList.Add(part);
            }

            return contactList;

        } //end of getAllContactInformation()

        public List<Participant> getSearchContact(string inContactName, string inContactCompany, string inUserId)
        {

            DataSet ds = new DataSet();

            List<Participant> contactList = new List<Participant>();
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
                        sqlText = "Select p.ParticipantId ,p.ParticipantName, p.ContactNo, p.CompanyName, p.CompanyPosition, p.Email " +
                            "FROM Participant p INNER JOIN ContactInformation c ON p.ParticipantId = c.ContactId " +
                            "WHERE c.ParticipantId = @inUserId AND(p.CompanyName = @inContactCompany OR p.ParticipantName = @inContactName)";

                        cmd.CommandText = sqlText;
                        cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;
                        cmd.Parameters.Add("@inContactName", SqlDbType.VarChar, 50).Value = inContactName;
                        cmd.Parameters.Add("@inContactCompany", SqlDbType.VarChar, 50).Value = inContactCompany;


                        da.Fill(ds, "ContactsData");
                    }
                    cn.Close();
                }
            }

            foreach (DataRow dr in ds.Tables["ContactsData"].Rows)
            {

                Participant part = new Participant();
                part.ParticipantId = Int32.Parse(dr["ParticipantId"].ToString());
                part.ParticipantName = dr["ParticipantName"].ToString();
                part.ParticipantContactNo = dr["ContactNo"].ToString();
                part.CompanyName = dr["CompanyName"].ToString();
                part.CompanyPosition = dr["CompanyPosition"].ToString();
                part.ParticipantEmail = dr["Email"].ToString();


                contactList.Add(part);
            }

            return contactList;
        } //end of getSearchEvent()







        //******************PROFILE******************//

        //Get Participant Info
        public Participant getParticipantUserProfileByUserId(int inUserId) // Get a User by userId
        {
            SqlCommand cmd = new SqlCommand();//To hold the SQL
            SqlConnection cn = new SqlConnection();//To make db connection
            //To retrieve the data and store in dataset
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();
            Participant part = new Participant();

            cmd.Connection = cn;// Tell cmd to use cn
            da.SelectCommand = cmd; // tell the da to use the cmd

            cmd.CommandText = "Select ParticipantName, ContactNo, CompanyName, CompanyPosition, Email, UserPassword From Participant Where ParticipantId = @inUserId";
            cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;

            cn.ConnectionString =
                ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();

            cn.Open();

            try
            {
                da.Fill(ds, "UserData");
                DataRow dr = ds.Tables["UserData"].Rows[0];

                part = new Participant
                {
                    ParticipantName = dr["ParticipantName"].ToString(),
                    ParticipantContactNo = dr["ContactNo"].ToString(),
                    CompanyName = dr["CompanyName"].ToString(),
                    CompanyPosition = dr["CompanyPosition"].ToString(),
                    ParticipantEmail = dr["Email"].ToString(),
                    Password = dr["UserPassword"].ToString()
                };

            }
            catch (SqlException sqlEx)
            {
                throw new System.ArgumentException(sqlEx.Message);
            }
            finally
            {
                cn.Close();
            }
            return part;
        }//End of getParticipantUserProfileByUserId


        public bool UpdateOneProfile(int inUserId, string inName, string inContact, string inCompany, string inPosition, string inEmail, string inPassword)
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection cn = new SqlConnection();
            int numOfRecordsAffected = 0;
            cmd.Connection = cn;
            cmd.CommandText = "UPDATE Participant SET ParticipantName = @inName, ContactNo = @inContact, CompanyName = @inCompany, CompanyPosition = @inPosition, Email = @inEmail, UpdatedAt = getdate(), UserPassword= @inPassword WHERE ParticipantId = @inUserId";

            cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;
            cmd.Parameters.Add("@inName", SqlDbType.VarChar, 50).Value = inName;
            cmd.Parameters.Add("@inContact", SqlDbType.Char, 20).Value = inContact;
            cmd.Parameters.Add("@inCompany", SqlDbType.VarChar, 50).Value = inCompany;
            cmd.Parameters.Add("@inPosition", SqlDbType.VarChar, 50).Value = inPosition;
            cmd.Parameters.Add("@inEmail", SqlDbType.VarChar, 50).Value = inEmail;
            cmd.Parameters.Add("@inPassword", SqlDbType.VarChar, 20).Value = inPassword;

            cn.ConnectionString = ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();
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
            if (numOfRecordsAffected == 0)
            {
                return false;

            }
            else
            {
                return true;
            }


        } //end of UpdateOneEvent


        //******************Registered Participants******************//

        public List<Participant> getAllRegisteredParticipant(string inEventId)
        {

            DataSet ds = new DataSet();

            List<Participant> partList = new List<Participant>();
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
                        sqlText = "Select p.ParticipantId ,p.ParticipantName, p.ContactNo, p.CompanyName, p.CompanyPosition, p.Email, pa.Present FROM " +
                            "Participant p INNER JOIN ParticipantAttendance pa " +
                            "ON p.ParticipantId = pa.ParticipantId WHERE pa.EventId = @inEventId";
                        cmd.CommandText = sqlText;
                        cmd.Parameters.Add("@inEventId", SqlDbType.Int).Value = inEventId;

                        da.Fill(ds, "ParticipantData");
                    }
                    cn.Close();
                }
            }

            foreach (DataRow dr in ds.Tables["ParticipantData"].Rows)
            {

                Participant part = new Participant();
                part.ParticipantId = Int32.Parse(dr["ParticipantId"].ToString());
                part.ParticipantName = dr["ParticipantName"].ToString();
                part.ParticipantContactNo = dr["ContactNo"].ToString();
                part.CompanyName = dr["CompanyName"].ToString();
                part.CompanyPosition = dr["CompanyPosition"].ToString();
                part.ParticipantEmail = dr["Email"].ToString();
                part.Present = dr["Present"].ToString();


                partList.Add(part);
            }

            return partList;

        }
      
        //inEventName = participant Name
        public List<Participant> searchRegisteredParticipantName(string inEventId, string inEventName)
        {
            DataSet ds = new DataSet();

            List<Participant> partList = new List<Participant>();

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
                        string cmdString = string.Format("Select p.ParticipantId ,p.ParticipantName, p.ContactNo, p.CompanyName, p.CompanyPosition, p.Email, pa.Present " +
                            "FROM Participant p INNER JOIN ParticipantAttendance pa ON p.ParticipantId = pa.ParticipantId " +
                            "WHERE pa.EventId = @inEventId AND p.ParticipantName= @inEventName");

                        cmd.CommandText = cmdString;
                        cmd.Parameters.Add("@inEventId", SqlDbType.Int).Value = inEventId;
                        cmd.Parameters.Add("@inEventName", SqlDbType.VarChar,50).Value = inEventName;
                       
                        da.Fill(ds, "ParticipantData");
                    }
                    cn.Close();
                }
            }

            foreach (DataRow dr in ds.Tables["ParticipantData"].Rows)
            {

                Participant part = new Participant();
                part.ParticipantId = Int32.Parse(dr["ParticipantId"].ToString());
                part.ParticipantName = dr["ParticipantName"].ToString();
                part.ParticipantContactNo = dr["ContactNo"].ToString();
                part.CompanyName = dr["CompanyName"].ToString();
                part.CompanyPosition = dr["CompanyPosition"].ToString();
                part.ParticipantEmail = dr["Email"].ToString();
                part.Present = dr["Present"].ToString();


                partList.Add(part);
            }

            return partList;
        } //end of getAllEventsJoinedData()

        public List<Participant> searchRegisteredParticipant(string inEventId, string inEventName, string inEventPresent)
        {
            DataSet ds = new DataSet();

            List<Participant> partList = new List<Participant>();

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
                        string cmdString = string.Format("Select p.ParticipantId ,p.ParticipantName, p.ContactNo, p.CompanyName, p.CompanyPosition, p.Email, pa.Present " +
                            "FROM Participant p INNER JOIN ParticipantAttendance pa ON p.ParticipantId = pa.ParticipantId " +
                            "WHERE pa.EventId = @inEventId AND (p.ParticipantName = @inEventName OR pa.Present = @inEventPresent)");

                        cmd.CommandText = cmdString;
                        cmd.Parameters.Add("@inEventId", SqlDbType.Int).Value = inEventId;
                        cmd.Parameters.Add("@inEventName", SqlDbType.VarChar, 50).Value = inEventName;
                        cmd.Parameters.Add("@inEventPresent", SqlDbType.Bit, 1).Value = inEventPresent;



                        da.Fill(ds, "ParticipantData");
                    }
                    cn.Close();
                }
            }

            foreach (DataRow dr in ds.Tables["ParticipantData"].Rows)
            {

                Participant part = new Participant();
                part.ParticipantId = Int32.Parse(dr["ParticipantId"].ToString());
                part.ParticipantName = dr["ParticipantName"].ToString();
                part.ParticipantContactNo = dr["ContactNo"].ToString();
                part.CompanyName = dr["CompanyName"].ToString();
                part.CompanyPosition = dr["CompanyPosition"].ToString();
                part.ParticipantEmail = dr["Email"].ToString();
                part.Present = dr["Present"].ToString();


                partList.Add(part);
            }

            return partList;
        } //end of getAllEventsJoinedData()


        public int AddOnePart(string inName, string inPassword, string inContact, string inCompanyName, string inPosition, string inEmail)
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection cn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();
            int numOfRecordsAffected = 0;
            cmd.Connection = cn;
            da.SelectCommand = cmd;
            cmd.CommandText = "INSERT INTO Participant (ParticipantName, UserPassword, ContactNo, CompanyName, CompanyPosition, Email) VALUES" +
                "(@inName, @inPassword, @inContact, @inCompanyName, @inPosition, @inEmail)";


            cmd.Parameters.Add("@inName", SqlDbType.VarChar, 50).Value = inName;
            cmd.Parameters.Add("@inPassword", SqlDbType.VarChar, 20).Value = inPassword;
            cmd.Parameters.Add("@inContact", SqlDbType.Char, 20).Value = inContact;
            cmd.Parameters.Add("@inCompanyName", SqlDbType.VarChar,50).Value = inCompanyName;
            cmd.Parameters.Add("@inPosition", SqlDbType.VarChar, 50).Value = inPosition;
            cmd.Parameters.Add("@inEmail", SqlDbType.VarChar, 50).Value = inEmail;

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
        
        public int getLatestRegisteredUser()
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection cn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();
            int newUserId = 0;

            cmd.Connection = cn;
            da.SelectCommand = cmd;
            cmd.CommandText = "SELECT MAX(ParticipantId) FROM Participant";

            cn.Open();
            cn.ConnectionString = ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();
            newUserId = Convert.ToInt32(cmd.ExecuteScalar());
            cn.Close();

            return newUserId;
        }

    }
}