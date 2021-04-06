using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Services;

namespace FYP_MarkIn.EmailService
{
    /// <summary>
    /// Summary description for EmailWebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class EmailWebService : System.Web.Services.WebService
    {

        [WebMethod(Description = "Send an SMTP mail message")]
        public string Send(string msgFrom, string msgTo, string msgSubject, string msgBody)
        {
            string functionReturnValue = null;

            try
            {
                SmtpClient SendMailClient = new SmtpClient("smtp.gmail.com");

                MailAddress fromAddress = new MailAddress(msgFrom);
                MailAddress toAddress = new MailAddress(msgTo);
                MailMessage msg = new MailMessage(fromAddress, toAddress);

                SendMailClient.Port = 587;
                SendMailClient.EnableSsl = true;
                SendMailClient.UseDefaultCredentials = false;
                SendMailClient.Credentials = new NetworkCredential("testemailcsc123@gmail.com", "Hello123_");

                msg.Subject = msgSubject;
                msg.Body = msgBody;

                SendMailClient.Send(msg);
                functionReturnValue = "OK";
            }
            catch (Exception ex)
            {
                functionReturnValue = "ERROR";
            }

            return functionReturnValue;
        }
    }
}
