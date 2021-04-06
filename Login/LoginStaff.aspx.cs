using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Mark_In_Admin.Login.Domain;

namespace Mark_In_Admin.Login
{
    public partial class LoginStaff : System.Web.UI.Page
    {
        int userId;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Get Entered UserId
                int userId = Int32.Parse(Request.QueryString["ID"]);
                //Get Staff Name from Staff Table
                UserManager userManager = new UserManager();
                string staffUserName = userManager.getStaffUserNameByUserId(userId);

                typeoutputlbl.Text = "Staff";
                useridoutputlbl.Text = userId.ToString();
                nameoutputlbl.Text = staffUserName;
            }
            else
            {

            }
        }

        public void btnLogin_Click(object sender, EventArgs e)
        {
            string inputPW;

            //Get Entered UserId
            userId = Int32.Parse(Request.QueryString["ID"]);
            UserManager userManager = new UserManager();
            string staffPW = userManager.getStaffPWByUserId(userId);
            //Check for password
            inputPW = IdInput.Text;

            if (inputPW == staffPW)
            {
                Response.Redirect("~/Staff/AttendanceList.aspx?ID=" + userId);

            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('Wrong Password');", true);
            }

        }

    }
}