using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AnalizaProdaje.Domain.Helpers
{
    public static class InfrastructureHelper
    {
        public static string GetCookieValue(string cookieName)
        {
            if (HttpContext.Current.Request.Cookies[cookieName] != null)
            {
                return HttpContext.Current.Request.Cookies[cookieName].Value;
            }
            else
                return "";
        }

        public static void SetCookieValue(string cookieName, string value)
        {
            if (HttpContext.Current.Request.Cookies[cookieName] != null)
            {
                HttpContext.Current.Request.Cookies[cookieName].Value = value;
            }
            else {
                HttpContext.Current.Response.Cookies.Add(new HttpCookie(cookieName, value)
                {
                    HttpOnly = false,
                    Expires = DateTime.Now.AddMonths(1)
                });
            }
                
        }

        public static void TryRemoveCookie(string cookieName)
        {
            if (HttpContext.Current.Request.Cookies[cookieName] != null)
            {
                HttpCookie myCookie = new HttpCookie(cookieName);
                myCookie.Expires = DateTime.Now.AddDays(-1d);
                HttpContext.Current.Response.Cookies.Add(myCookie);
            }
        }
    }
}