using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using System.Web.Security;
    using System.Web.SessionState;
    using DevExpress.Web;
using System.Web.Script.Serialization;
using DatabaseWebService.Models;
using AnalizaProdaje.Common;
using System.Security.Principal;
using System.Net.Mail;
using System.Net;
using System.Text;
using AnalizaProdaje.Domain.Helpers;

    namespace AnalizaProdaje {
        public class Global_asax : System.Web.HttpApplication {
            void Application_Start(object sender, EventArgs e) {
                DevExpress.Web.ASPxWebControl.CallbackError += new EventHandler(Application_Error);
            }

            void Application_End(object sender, EventArgs e) {
                // Code that runs on application shutdown
            }

            void Application_Error(object sender, EventArgs e) {
                // Code that runs when an unhandled error occurs

                string error = "";
                if (Context != null && Server.GetLastError() != null)
                    getError(Context.Error, ref error);

                //if is there error on client side we need aditional information about error
                error += "\r\n \r\n" + sender.GetType().FullName + "\r\n" + Request.UrlReferrer.AbsoluteUri + "\r\n";
                
                CommonMethods.LogThis(error);
               
                string body = "Pozdravljeni! \r\n Uporabnik " + PrincipalHelper.GetUserPrincipal().firstName + " " +
                    PrincipalHelper.GetUserPrincipal().lastName + " je dne " + DateTime.Now.ToLongDateString() + " ob " + DateTime.Now.ToLongTimeString() +
                    " naletel na napako! \r\n Podrobnosti napake so navedene spodaj: \r\n \r\n" + error + "\r\n";

                bool isSent = CommonMethods.SendEmailToDeveloper("AnalizaProdaja - NAPAKA", "Napaka aplikacije", body);

                Context.ClearError();
                Server.ClearError();
                //Server.Transfer("/Pages/Error/ErrorPage.aspx");
                Response.Redirect("/Pages/Error/ErrorPage.aspx");
            }

            void Session_Start(object sender, EventArgs e) {
                // Code that runs when a new session is started
            }

            void Session_End(object sender, EventArgs e) 
            {
                // Code that runs when a session ends. 
                // Note: The Session_End event is raised only when the sessionstate mode
                // is set to InProc in the Web.config file. If session mode is set to StateServer 
                // or SQLServer, the event is not raised.
            }

            protected void Application_PostAuthenticateRequest(object sender, EventArgs e)
            {
                var authCookie = HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName];

                if (authCookie != null)
                {
                    FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);

                    JavaScriptSerializer serializer = new JavaScriptSerializer();

                    UserModel serializeModel = serializer.Deserialize<UserModel>(authTicket.UserData);

                    UserPrincipal userPrincipal = new UserPrincipal();

                    userPrincipal.Identity = new GenericIdentity(authTicket.Name);
                    userPrincipal.ID = serializeModel.ID;
                    userPrincipal.firstName = serializeModel.firstName;
                    userPrincipal.lastName = serializeModel.lastName;
                    userPrincipal.email = serializeModel.email;
                    userPrincipal.ProfileImage = serializeModel.profileImage;
                    userPrincipal.HasSupervisor = serializeModel.HasSupervisor;

                    userPrincipal.Role = serializeModel.Role;
                    userPrincipal.RoleId = serializeModel.RoleID;
                    userPrincipal.RoleName = serializeModel.RoleName;

                    HttpContext.Current.User = userPrincipal;
                }
            }

            private void getError(Exception e, ref string errors)
            {
                if (e.GetType() != typeof(HttpException)) errors += " -------- " + e.ToString();
                if (e.InnerException != null) getError(e.InnerException, ref errors);
            }
        }
    }