using Mark_In_Admin.Login.Domain;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Mark_In_Admin.Login
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod(EnableSession = true)]
        public static object CheckUserData(string WebFormData)
        {
            var webFormData = JsonConvert.DeserializeObject<dynamic>(WebFormData);

            int collectedUserId = Int32.Parse(webFormData.UserId.Value);        
            string ifAdmin, ifStaffExists, ifPartExists;

            //Check id length
            int idLength = collectedUserId.ToString().Length;
           
            UserManager userManager = new UserManager();

            var HRresponse = new
            {
                status = "HR",
                message = "Logged in as HR."
            };

            var Staffresponse = new
            {
                status = "STAFF",
                message = "Logged in as Staff."
            };

            var Partresponse = new
            {
                status = "PARTICIPANT",
                message = "Logged in as Participant."
            };

            //Record does not exist
            var StaffErrorresponse = new
            {
                status = "ERROR",
                message = "Invalid User Id"
            };

            var PartErrorresponse = new
            {
                status = "ERROR",
                message = "Invalid User Id"
            };

            //Staff row count Returns 2 or other numbers
            var StaffError = new
            {
                status = "ERROR",
                message = "Invalid User Id, Staff Error"
            };

            var HRError = new
            {
                status = "ERROR",
                message = "Invalid User Id, HR Error"
            };

            var PartError = new
            {
                status = "ERROR",
                message = "Invalid User Id, Participant Error"
            };


            //If Staff
            if (idLength == 6)
            {
                //Check if Staff Id Exists
                ifStaffExists = userManager.checkStaffId(collectedUserId);
                //Staff Exists
                if (ifStaffExists == "1")
                {
                    //Check if HR
                    ifAdmin = userManager.checkAdministrator(collectedUserId);
                    //if HR
                    if (ifAdmin == "True")
                    {
                        return HRresponse;
                    }

                    //not HR
                    else if (ifAdmin == "False")
                    {
                        return Staffresponse;
                    }
                    //HR ERROR
                    else
                    {
                        return HRError;
                    }
                }

                //Does not exist
                else if(ifStaffExists == "0")
                {
                    return StaffErrorresponse;
                }
                //Staff Error 
                else
                {
                    return StaffError;

                }
              
            }
            //if Participant
            if (idLength == 7)
            {
                //Check if Participant Id Exists
                ifPartExists = userManager.checkPartId(collectedUserId);
                //Participant Exist
                if (ifPartExists == "1")
                {
                    return Partresponse;
                }
                //Does not exist
                else if(ifPartExists == "0")
                {
                    return PartErrorresponse;
                }
                //Participant Error
                else
                {
                    return PartError;
                }
               
                
            }
            //Invalid
            else
            {
                return StaffError;
            }

        }//end of web method
    }
}
