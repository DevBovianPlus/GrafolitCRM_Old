using AnalizaProdaje.Common;
using AnalizaProdaje.Domain.Concrete;
using AnalizaProdaje.Domain.Helpers;
using DatabaseWebService.Models;
using DatabaseWebService.Models.Employee;
using DevExpress.Web;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnalizaProdaje.Pages.Testing
{
    public partial class MailTest : ServerMasterPage
    {
        EmployeeFullModel model = null;
        int employeeID = -1;
        int action = -1;
        bool pasOrUsernameChanged = false;

        protected void Page_Init(object sender, EventArgs e)
        {
            action = 2;
            employeeID = PrincipalHelper.GetUserPrincipal().ID;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            txtUsername.ClientEnabled = false;
            txtPassword.ClientEnabled = false;
        }

        protected void SendCallback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            try
            {
                SmtpClient client = new SmtpClient();
                client.Host = txtHost.Text;
                client.Port = CommonMethods.ParseInt(txtPort.Text);//Port 465 (SSL required)
                client.EnableSsl = EnableSSLCheckBox.Checked;
                client.DeliveryMethod = SmtpDeliveryMethod.Network;

                if (CredentialExistCheckBox.Checked)
                {    
                    client.Credentials = new NetworkCredential(txtUsername.Text, txtPassword.Text);
                }
                else
                    client.UseDefaultCredentials = true;
                
                client.Timeout = 6000;
                MailMessage message;

                message = new MailMessage();
                message.To.Add(new MailAddress(txtMailTo.Text));

                message.Sender = new MailAddress(txtSender.Text);
                message.From = new MailAddress(txtSender.Text, "Test sending email");
                message.Subject = txtSubject.Text;
                message.IsBodyHtml = false;
                message.Body = txtBody.Text;
                message.BodyEncoding = Encoding.UTF8;

                client.Send(message);

                SendCallback.JSProperties["cpMailSendError"] = "Elektornska pošta poslana ne " + txtMailTo.Text;
            }
            catch (SmtpFailedRecipientsException ex)
            {
                SendCallback.JSProperties["cpMailSendError"] = "SmtpFailedRecipientsException \r\n" + ex.Message + "\r\n " + ex.Source + "\r\n " + ex.StackTrace;
                CommonMethods.LogThis("SmtpFailedRecipientsException \r\n" + ex.Message + "\r\n " + ex.Source + "\r\n " + ex.StackTrace);
            }
            catch (SmtpException ex)
            {
                SendCallback.JSProperties["cpMailSendError"] = "SmtpException \r\n" + ex.Message + "\r\n " + ex.Source + "\r\n " + ex.StackTrace;
                CommonMethods.LogThis("SmtpException \r\n" + ex.Message + "\r\n " + ex.Source + "\r\n " + ex.StackTrace);
            }
            catch (Exception ex)
            {
                SendCallback.JSProperties["cpMailSendError"] = "Exception \r\n" + ex.Message + "\r\n " + ex.Source + "\r\n " + ex.StackTrace;
                CommonMethods.LogThis("Exception \r\n" + ex.Message + "\r\n " + ex.Source + "\r\n " + ex.StackTrace);
            }
        }

    }
}