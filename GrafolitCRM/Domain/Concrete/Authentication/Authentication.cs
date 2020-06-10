using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AnalizaProdaje.Domain.Concrete;
using AnalizaProdaje.Domain.Helpers;
using DatabaseWebService.Models;
using System.Web.Script.Serialization;
using System.Web.Security;

namespace AnalizaProdaje.Common
{
    public class Authentication
    {
        private DatabaseConnection dbConnection;

        public Authentication()
        {
            dbConnection = new DatabaseConnection();
        }

        public bool Authenticate(string username, string password)
        {
            UserModel user = null;

            user = dbConnection.SignIn(username, password);

            if (user != null)
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();

                string userData = serializer.Serialize(user);

                FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(
                     1,
                     username,
                     DateTime.Now,
                     DateTime.Now.AddHours(24),
                     false,
                     userData);

                string encTicket = FormsAuthentication.Encrypt(authTicket);
                HttpCookie faCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encTicket) { HttpOnly = false, Expires = DateTime.Now.AddMonths(1) };
                HttpContext.Current.Response.Cookies.Add(faCookie);
            }
            else
                throw new Exception("Sing in failed! => UserModel = null");

            return true;
        }
    }
}