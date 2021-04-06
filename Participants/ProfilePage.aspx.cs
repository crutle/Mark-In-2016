using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Mark_In_Admin.EventsManagement.Domain;
using ZXing.QrCode;

namespace Mark_In_Admin.Participants
{
    public partial class ProfilePage : System.Web.UI.Page
    {
        int userId;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Get Entered UserId
                userId = Int32.Parse(Request.QueryString["ID"]);
                //Get Participant Name from Participant Table
                ParticipantsManager partManager = new ParticipantsManager();
                Participant part = new Participant();
                part = partManager.getParticipantUserProfileByUserId(userId);

                nameoutput.Text = part.ParticipantName;
                contactsoutput.Text = part.ParticipantContactNo;
                companyoutput.Text = part.CompanyName;
                positionoutput.Text = part.CompanyPosition;
                emailoutput.Text = part.ParticipantEmail;
                passwordoutput.Text = part.Password;
                confirmButton.Visible = false;
                cancelButton.Visible = false;
                messageBox.InnerHtml = "";
                passwordoutput.Attributes["type"] = "password";
                
                QRCodeWriter qr = new QRCodeWriter();

                string vcard = "BEGIN:VCARD" + "\n"
                    + "FN: " + nameoutput.Text + "\n"
                    + "ORG: " + companyoutput.Text + "\n"
                    + "TITLE: " + positionoutput.Text + "\n"
                    + "TEL:" + contactsoutput.Text + "\n"
                    + "EMAIL: " + emailoutput.Text + "\n"
                    + "MEMO: " + userId + "\n"
                    + "END:VCARD";

                var matrix = qr.encode(vcard, ZXing.BarcodeFormat.QR_CODE, 300, 300);

                ZXing.BarcodeWriter w = new ZXing.BarcodeWriter();

                w.Format = ZXing.BarcodeFormat.QR_CODE;

                Bitmap img = w.Write(matrix);

                img.Save(@"C:\temp\myQR.png", System.Drawing.Imaging.ImageFormat.Png);

                MemoryStream ms = new MemoryStream();
                img.Save(ms, ImageFormat.Png);
                var base64Data = Convert.ToBase64String(ms.ToArray());
                displayQr.Src = "data:image/gif;base64," + base64Data;
            }
            else
            {
                
            }
        }

        protected void btnEdit_Click(object sender, System.EventArgs e)
        {
            nameoutput.ReadOnly = false;
            contactsoutput.ReadOnly = false;
            companyoutput.ReadOnly = false;
            positionoutput.ReadOnly = false;
            emailoutput.ReadOnly = false;
            passwordoutput.ReadOnly = false;
            passwordoutput.Attributes["type"] = "textbox";
 
            confirmButton.Visible = true;
            cancelButton.Visible = true;
            messageBox.InnerHtml = "";
        }

        protected void btnSave_Click(object sender, System.EventArgs e)
        {
            string name, contactNo, company, position, email, password;
            bool result;
            userId = Int32.Parse(Request.QueryString["ID"]);
            name = nameoutput.Text;
            contactNo = contactsoutput.Text;
            company = companyoutput.Text;
            position = positionoutput.Text;
            email = emailoutput.Text;
            password = passwordoutput.Text;

            ParticipantsManager pManager = new ParticipantsManager();
            result = pManager.UpdateOneProfile(userId, name, contactNo, company, position, email, password);
           
            //if true
            if(result == true)
            {
                //Get Participant Name from Participant Table
                ParticipantsManager partManager = new ParticipantsManager();
                Participant part = new Participant();
                part = partManager.getParticipantUserProfileByUserId(userId);

                nameoutput.Text = part.ParticipantName;
                contactsoutput.Text = part.ParticipantContactNo;
                companyoutput.Text = part.CompanyName;
                positionoutput.Text = part.CompanyPosition;
                emailoutput.Text = part.ParticipantEmail;
                passwordoutput.Text = part.Password;
                confirmButton.Visible = false;
                cancelButton.Visible = false;               

                nameoutput.ReadOnly = true;
                contactsoutput.ReadOnly = true;
                companyoutput.ReadOnly = true;
                positionoutput.ReadOnly = true;
                emailoutput.ReadOnly = true;
                passwordoutput.ReadOnly = true;
                passwordoutput.Attributes["type"] = "password";

                messageBox.InnerHtml = "Update Successful!!";
             
                //Response.Write("<script>alert('Update successful!');</script>");
            }
            else
            {
                messageBox.InnerHtml = "Update failed.";
            }
            
        }

        protected void btnCancel_Click(object sender, System.EventArgs e)
        {
            //Get Entered UserId
            userId = Int32.Parse(Request.QueryString["ID"]);
            //Get Participant Name from Participant Table
            ParticipantsManager partManager = new ParticipantsManager();
            Participant part = new Participant();
            part = partManager.getParticipantUserProfileByUserId(userId);

            nameoutput.Text = part.ParticipantName;
            contactsoutput.Text = part.ParticipantContactNo;
            companyoutput.Text = part.CompanyName;
            positionoutput.Text = part.CompanyPosition;
            emailoutput.Text = part.ParticipantEmail;
            confirmButton.Visible = false;
            cancelButton.Visible = false;

            nameoutput.ReadOnly = true;
            contactsoutput.ReadOnly = true;
            companyoutput.ReadOnly = true;
            positionoutput.ReadOnly = true;
            emailoutput.ReadOnly = true;
            passwordoutput.ReadOnly = true;
            passwordoutput.Attributes["type"] = "password";
        }
    }
}