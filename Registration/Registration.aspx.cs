using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using FYP_MarkIn.EmailService;
using Mark_In_Admin.EventsManagement.Domain;
using Newtonsoft.Json;
using ZXing.QrCode;

namespace Mark_In_Admin.Registration
{
    public partial class Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        [WebMethod]
        public static object AddOnePart(string WebFormData)
        {
            var webFormData = JsonConvert.DeserializeObject<dynamic>(WebFormData);
            //string userId = webFormData.UserId.Value;

            int newEventId = 0;
            string collectedName = webFormData.Name.Value;
            string collectedPassword= webFormData.Password.Value;
            string collectedContact= webFormData.Contact.Value;
            string collectedCompanyName= webFormData.CompanyName.Value;
            string collectedPosition = webFormData.Position.Value;
            string collectedEmail = webFormData.Email.Value;



            string message = "";
            try
            {
                ParticipantsManager pManager = new ParticipantsManager();
                newEventId = pManager.AddOnePart(collectedName, collectedPassword, collectedContact, collectedCompanyName, collectedPosition, collectedEmail);

                if (newEventId > 0)
                {
                    var response = new
                    {
                        newCategoryId = newEventId,
                        status = "success",
                        message = "Created a new events record."
                    };
                    return response;

                }
                else
                {

                    var response = new
                    {
                        newEventId = 0,
                        status = "fail",
                        message = "Unable to save event record."
                    };
                    return response;
                }
            }
            catch (Exception ex)
            {
                var response = new
                {
                    newEventId = 0,
                    status = "fail",
                    message = "Unable to save event record. " + ex.Message
                };
                return response;
            }

        }


        protected void btnRegister_Click(object sender, EventArgs e)
        {
            //ParticipantsManager pm = new ParticipantsManager();

            //QRCodeWriter qr = new QRCodeWriter();

            //string vcard = "BEGIN:VCARD" + "\n"
            //    + "FN: " + name.Value + "\n"
            //    + "ORG: " + company.Value + "\n"
            //    + "TITLE: " + position.Value + "\n"
            //    + "TEL:" + contact.Value + "\n"
            //    + "EMAIL: " + email.Value + "\n"
            //    + "END:VCARD";

            //var matrix = qr.encode(vcard, ZXing.BarcodeFormat.QR_CODE, 300, 300);

            //ZXing.BarcodeWriter w = new ZXing.BarcodeWriter();

            //w.Format = ZXing.BarcodeFormat.QR_CODE;

            //Bitmap img = w.Write(matrix);

            //img.Save(@"C:\temp\myQR.png", System.Drawing.Imaging.ImageFormat.Png);

            //MemoryStream ms = new MemoryStream();
            //img.Save(ms, ImageFormat.Png);
            //var base64Data = Convert.ToBase64String(ms.ToArray());
            //displayQr.Src = "data:image/gif;base64," + base64Data;


            //EmailWebService emailService = new EmailWebService();

            //if (emailService == null)
            //    email.Value = "Error";

            //emailService.Send("testemailcsc123@gmail.com", email.Value, "Registration Confirmed", "Your User ID is " + pm.getLatestRegisteredUser() + ". Click <a href=\"localhost/Login/Login.aspx\">here to login.</a>");

        }
    }
}