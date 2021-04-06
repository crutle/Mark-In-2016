using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using FYP_MarkIn.HRManagement.Domain;
using Newtonsoft.Json;

namespace FYP_MarkIn.HR
{
    public partial class Homepage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static object getAllStaff(string WebFormData)
        {
            dynamic inWebFormDataObject = JsonConvert.DeserializeObject(WebFormData);
            //HRManager hrManager = new HRManager();
            // string userId = webFormData.UserId.Value;
            HRManager hrManager = new HRManager();
            List<HumanResource> hrList = hrManager.getAllStaff();
            return hrList;

        }

        [WebMethod]
        public static object AddOneStaff(string WebFormData)
        {
            var webFormData = JsonConvert.DeserializeObject<dynamic>(WebFormData);

            int newCategoryId = 0;
            int addTable = 0;
            string collectedName = webFormData.Name.Value;
            string collectedTableName = webFormData.TableName.Value;
            string collectedStaffPW = webFormData.StaffPassword.Value;
            string collectedType = webFormData.Type.Value;
            string collectedPosition = webFormData.Position.Value;
            string collectedSalary = webFormData.Salary.Value;
            string collectedContact = webFormData.Contact.Value;
            string collectedDateofbirth = webFormData.Dateofbirth.Value;
            string collectedAddress = webFormData.Address.Value;
            string collectedStatus = webFormData.Status.Value;

            string userId = webFormData.UserId.Value;


            string message = "";
            try
            {
                HRManager hrManager = new HRManager();
                addTable = hrManager.AddStaffTable(collectedTableName);
                newCategoryId = hrManager.AddOneStaff(collectedName, collectedTableName, collectedStaffPW, collectedType, collectedPosition, collectedSalary, collectedContact, collectedDateofbirth, collectedAddress, collectedStatus, userId);
                

                if (newCategoryId > 0 && addTable == -1)
                {
                    var response = new
                    {
                        newCategoryId = newCategoryId,
                        status = "success",
                        message = "Created a new Staff record."
                    };
                    return response;

                    //--- The following code is not needed. 
                    //--- because the function is configured to return an object (not a string)
                    //string response = JsonConvert.SerializeObject(successResponse);

                }
                else
                {
                    //Due to the simplicity of this example, this section is rarely tested.
                    var response = new
                    {
                        newCategoryId = 0,
                        status = "fail",
                        message = "Unable to create Staff record."
                    };
                    return response;

                }

            }
            catch (Exception ex)
            {
                var response = new
                {
                    newCategoryId = 0,
                    status = "fail",
                    message = "Unable to create Staff record. " + ex.Message
                };
                return response;
            }

        }

        [WebMethod(EnableSession = true)]
        public static object getStaffInfo(string staffId)
        {
            HRManager hrManager = new HRManager();
            HumanResource hr = new HumanResource();

            hr = hrManager.GetStaffInfo(staffId);


            return hr;
        }//end of static web method


        [WebMethod]
        public static object UpdateOneStaff(string WebFormData)
        {
            var webFormData = JsonConvert.DeserializeObject<dynamic>(WebFormData);

            int newCategoryId = 0;
            string collectedName = webFormData.Name.Value;
            string collectedTableName = webFormData.TableName.Value;
            string collectedStaffPW = webFormData.StaffPassword.Value;
            string collectedType = webFormData.Type.Value;
            string collectedPosition = webFormData.Position.Value;
            string collectedSalary = webFormData.Salary.Value;
            string collectedContact = webFormData.Contact.Value;
            string collectedDateofbirth = webFormData.Dateofbirth.Value;
            string collectedAddress = webFormData.Address.Value;
            string collectedStatus = webFormData.Status.Value;
            string collectStaffId = webFormData.StaffId.Value;
            string userId = webFormData.UserId.Value;


            string message = "";
            try
            {
                HRManager hrManager = new HRManager();
                newCategoryId = hrManager.UpdateOneStaff(collectedName, collectedTableName, collectedStaffPW, collectedType, collectedPosition, collectedSalary, collectedContact, collectedDateofbirth, collectedAddress, collectedStatus, collectStaffId, userId);

                if (newCategoryId > 0)
                {
                    var response = new
                    {
                        newCategoryId = newCategoryId,
                        status = "success",
                        message = "Updated Staff record."
                    };
                    return response;

                    //--- The following code is not needed. 
                    //--- because the function is configured to return an object (not a string)
                    //string response = JsonConvert.SerializeObject(successResponse);

                }
                else
                {
                    //Due to the simplicity of this example, this section is rarely tested.
                    var response = new
                    {
                        newCategoryId = 0,
                        status = "fail",
                        message = "Unable to update Staff record."
                    };
                    return response;

                }

            }
            catch (Exception ex)
            {
                var response = new
                {
                    newCategoryId = 0,
                    status = "fail",
                    message = "Unable to update Staff record. " + ex.Message
                };
                return response;
            }

        }


        [WebMethod]
        public static object searchStaff(string inStaffId, string inStaffName)
        {
           
            HRManager hrManager = new HRManager();
            List<HumanResource> hrList = hrManager.searchStaff(inStaffId,inStaffName);
            return hrList;
        }


        [WebMethod]
        public static object searchStaffName(string inStaffName)
        {

            HRManager hrManager = new HRManager();
            List<HumanResource> hrList = hrManager.searchStaffName(inStaffName);
            return hrList;
        }




    }
}