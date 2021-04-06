using Mark_In_Admin.Login.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Mark_In_Admin.Login
{
    public partial class LoginParticipant : System.Web.UI.Page
    {
        string userId;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Get Entered UserId
                userId = Request.QueryString["ID"];
                //Get Participant Name from Participant Table
                UserManager userManager = new UserManager();
                string participantUserName = userManager.getParticipantUserNameByUserId(userId);

                typeoutputlbl.Text = "Participant";
                useridoutputlbl.Text = userId.ToString();
                nameoutputlbl.Text = participantUserName;
            }else
            {

            }
        }

        public void btnLogin_Click(object sender, EventArgs e)
        {
            string inputPW;

            //Get Entered UserId
            userId = Request.QueryString["ID"];
            UserManager userManager = new UserManager();
            string participantPW = userManager.getParticipantPWByUserId(userId);
            //Check for password
            inputPW = IdInput.Text;

            if (inputPW == participantPW)
            {
                //Redirect
                Response.Redirect("~/Participants/AllEvents.aspx?ID=" + userId);
            }else
            {

                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('Wrong Password');", true);
            }
        }
        }
    }
