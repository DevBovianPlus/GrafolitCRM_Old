using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;

namespace AnalizaProdaje.Common
{
    public class UserPrincipal : IPrincipal
    {
        public int ID { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string email { get; set; }
        public string Role { get; set; }

        public string RoleName { get; set; }
        public string ProfileImage { get; set; }
        public bool HasSupervisor { get; set; }

        public int RoleId { get; set; }
        public IIdentity Identity { get; set; }

        public bool IsInRole(string role)
        {
            return Role == role;
        } 
    }
}