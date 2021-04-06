using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Mark_In_Admin.Login.Domain
{
    public class UserManager
    {
        //Check if Valid StaffId
        public string checkStaffId(int inUserId)
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection cn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();

            string staffId;

            cmd.Connection = cn;
            da.SelectCommand = cmd;
            cmd.CommandText = "Select COUNT(*) From Staff Where StaffId = @inUserId";
            cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;

            cn.ConnectionString =
                ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();

            cn.Open();

            try
            {
                staffId = cmd.ExecuteScalar().ToString();
            }
            catch (SqlException sqlEx)
            {
                throw new System.ArgumentException(sqlEx.Message);
            }

            cn.Close();

            if (staffId != null)
            {
                return staffId.ToString();
            }
            else
            {
                return "0";
            }
        }//end if staffid valid

        //Check if Valid PartId
        public string checkPartId(int inUserId)
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection cn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();

            string partId;

            cmd.Connection = cn;
            da.SelectCommand = cmd;
            cmd.CommandText = "Select COUNT(*) From Participant Where ParticipantId = @inUserId";
            cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;

            cn.ConnectionString =
                ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();

            cn.Open();

            try
            {
                partId = cmd.ExecuteScalar().ToString();
            }
            catch (SqlException sqlEx)
            {
                throw new System.ArgumentException(sqlEx.Message);
            }

            cn.Close();

            if (partId != null)
            {
                return partId.ToString();
            }
            else
            {
                return "0";
            }
        }//end if partid valid

        //CHECK if Admin
        public string checkAdministrator(int inUserId) 
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection cn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();

            string adminBit;

            cmd.Connection = cn;
            da.SelectCommand = cmd; 
            cmd.CommandText = "Select Administrator From Staff Where StaffId = @inUserId";
            cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;

            cn.ConnectionString =
                ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();

            cn.Open();

            try
            {
                adminBit = cmd.ExecuteScalar().ToString();
            }
            catch (SqlException sqlEx)
            {
                throw new System.ArgumentException(sqlEx.Message);
            }

            cn.Close();

            if (adminBit != null)
            {
                return adminBit.ToString();
            }
            else
            {
                return "0";
            }
        }//end if admin



        //Get Participant Name
        public string getParticipantUserNameByUserId(string inUserId) // Get a User by userId
        {
            SqlCommand cmd = new SqlCommand();//To hold the SQL
            SqlConnection cn = new SqlConnection();//To make db connection
            //To retrieve the data and store in dataset
            SqlDataAdapter da = new SqlDataAdapter();
            string userName;
          
            cmd.Connection = cn;// Tell cmd to use cn
            da.SelectCommand = cmd; // tell the da to use the cmd

            cmd.CommandText = "Select ParticipantName From Participant Where ParticipantId = @inUserId";
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
        }//End of getParticipantUserNameByUserId

        //Get Participant PW
        public string getParticipantPWByUserId(string inUserId) // Get a User by userId
        {
            SqlCommand cmd = new SqlCommand();//To hold the SQL
            SqlConnection cn = new SqlConnection();//To make db connection
            //To retrieve the data and store in dataset
            SqlDataAdapter da = new SqlDataAdapter();
            string userPW;

            cmd.Connection = cn;// Tell cmd to use cn
            da.SelectCommand = cmd; // tell the da to use the cmd

            cmd.CommandText = "Select UserPassword From Participant Where ParticipantId = @inUserId";
            cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;

            cn.ConnectionString =
                ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();

            cn.Open();

            try
            {
                userPW = cmd.ExecuteScalar().ToString();
            }
            catch (SqlException sqlEx)
            {
                throw new System.ArgumentException(sqlEx.Message);
            }

            cn.Close();

            if (userPW != null)
            {
                return userPW.ToString();
            }
            else
            {
                return "0";
            }
        }//End of getParticipantUserNameByUserId

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




        //Get Staff PW
        public string getStaffPWByUserId(int inUserId) // Get a User by userId
        {
            SqlCommand cmd = new SqlCommand();//To hold the SQL
            SqlConnection cn = new SqlConnection();//To make db connection
            //To retrieve the data and store in dataset
            SqlDataAdapter da = new SqlDataAdapter();
            string userPW;

            cmd.Connection = cn;// Tell cmd to use cn
            da.SelectCommand = cmd; // tell the da to use the cmd

            cmd.CommandText = "Select Password From Staff Where StaffId = @inUserId";
            cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;

            cn.ConnectionString =
                ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();

            cn.Open();

            try
            {
                userPW = cmd.ExecuteScalar().ToString();
            }
            catch (SqlException sqlEx)
            {
                throw new System.ArgumentException(sqlEx.Message);
            }

            cn.Close();

            if (userPW != null)
            {
                return userPW.ToString();
            }
            else
            {
                return "0";
            }
        }//End of getParticipantUserNameByUserId

        //Get HR PW
        public string getHRPWByUserId(int inUserId) // Get a User by userId
        {
            SqlCommand cmd = new SqlCommand();//To hold the SQL
            SqlConnection cn = new SqlConnection();//To make db connection
            //To retrieve the data and store in dataset
            SqlDataAdapter da = new SqlDataAdapter();
            string userPW;

            cmd.Connection = cn;// Tell cmd to use cn
            da.SelectCommand = cmd; // tell the da to use the cmd

            cmd.CommandText = "Select Password From Staff Where StaffId = @inUserId";
            cmd.Parameters.Add("@inUserId", SqlDbType.Int).Value = inUserId;

            cn.ConnectionString =
                ConfigurationManager.ConnectionStrings["DefaultConnection1"].ToString();

            cn.Open();

            try
            {
                userPW = cmd.ExecuteScalar().ToString();
            }
            catch (SqlException sqlEx)
            {
                throw new System.ArgumentException(sqlEx.Message);
            }

            cn.Close();

            if (userPW != null)
            {
                return userPW.ToString();
            }
            else
            {
                return "0";
            }
        }//End of getParticipantUserNameByUserId



    }

}
