using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Net.Http;
using System.Threading.Tasks;
using System.IO;
using System.Net;
using System.Web.Script.Serialization;
using Newtonsoft.Json.Linq;

using AnalizaProdaje.Domain.Concrete;

using DatabaseWebService.Domain;
using DatabaseWebService.Models;
using AnalizaProdaje.Domain.Helpers;
using System.Web.Security;
using System.Web;
using AnalizaProdaje.Common;

namespace AnalizaProdaje
{
    public partial class Prijava_popup : ServerMasterPage
    {
        private DatabaseConnection dbConnection;

        protected void Page_Init(object sender, EventArgs e)
        {
            ErrorTableRow.Style.Add("display", "none");
            signInBtnWrap.Style.Add("margin-top", "10px");

            //User pass is set on the client side because of devexpress restrictions of texbox attribute password

            VnosUporabnik.Text = InfrastructureHelper.GetCookieValue(Enums.UserCredentialCookie.User.ToString());
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            dbConnection = new DatabaseConnection();
            
        }

        protected void ASPxButton_Potrdi(object sender, EventArgs e)
        {
            Authentication auth = new Authentication();
            bool signInSuccess = false;
            string message = "";
            string username = CommonMethods.Trim(VnosUporabnik.Text);
            string password = CommonMethods.Trim(VnosGeslo.Text);
            
            try 
            {
                if (username != "" && password != "")
                {
                    signInSuccess = auth.Authenticate(username, password);
                }

            }
            catch (Exception ex)
            {
                message = ex.Message;
            }

         
            string url = Session["PreviousPage"].ToString();
            if (signInSuccess)
            {
                ClientScript.RegisterStartupScript(GetType(), "ANY_KEY", string.Format("window.parent.OnClosePopupEventHandler_Prijava('{0}','{1}');", "Potrdi", url), true);
                ClientScript.RegisterStartupScript(GetType(), "ANY_KEY", "clientLoadingPanel.Hide();", true);
                
                InfrastructureHelper.SetCookieValue(Enums.UserCredentialCookie.User.ToString(), VnosUporabnik.Text);
                if (RememberMe.Checked)
                    InfrastructureHelper.SetCookieValue(Enums.UserCredentialCookie.UserPass.ToString(), VnosGeslo.Text);
                else//if we don't want to system to save our pass we uncheck checkbox and the cookie will be removed
                    InfrastructureHelper.TryRemoveCookie(Enums.UserCredentialCookie.UserPass.ToString());
                
                Session.Remove("PreviousPage");
            }
            else
            {
                txtError.Text = "Napačna prijava! Pnovno vnesi geslo in uporabniško ime!";
                ErrorTableRow.Style.Add("display", "block");
                signInBtnWrap.Style.Add("margin-top", "0");
            }
        }

        protected void ASPxButton_Preklici(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(GetType(), "ANY_KEY", string.Format("window.parent.OnClosePopupEventHandler_Prijava('{0}');", "Prekliči"), true);
        }

    }
}