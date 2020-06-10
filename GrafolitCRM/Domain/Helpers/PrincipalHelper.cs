using AnalizaProdaje.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AnalizaProdaje.Domain.Helpers
{
    public static class PrincipalHelper
    {
        public static UserPrincipal GetUserPrincipal()
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                return (UserPrincipal)HttpContext.Current.User;
            }

            return null;
        }

        /*TODO: Add methods for checing which user is signed in*/
        public static bool IsUserSuperAdmin()
        {
            return GetUserPrincipal().IsInRole(Enums.UserRole.SuperAdmin.ToString());
        }

        public static bool IsUserAdmin()
        {
            return GetUserPrincipal().IsInRole(Enums.UserRole.Admin.ToString());
        }

        public static bool IsUserSalesman()
        {
            return GetUserPrincipal().IsInRole(Enums.UserRole.Salesman.ToString());
        }

        public static bool IsUserUser()
        {
            return GetUserPrincipal().IsInRole(Enums.UserRole.User.ToString());
        }
    }
}