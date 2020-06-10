using AnalizaProdaje.Common;
using AnalizaProdaje.Domain.Concrete;
using DatabaseWebService.Models;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnalizaProdaje.Pages.Error
{
    public partial class ErrorPage : ServerMasterPage
    {

        protected override void OnPreInit(EventArgs e)
        {
            base.OnPreInit(e);
            if (Request.IsAuthenticated)
                MasterPageFile = "~/MasterPage.Master";
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsAuthenticated)  
                RemoveAllSesions();
        }

        protected void ASPxButtonLogin_Click(object sender, EventArgs e)
        {
            /*((ASPxNavBar)Master.FindControl("ASPxNavBarMainMenu")).Enabled = false;*/
            Session["PreviousPage"] = Request.RawUrl;
            
        }

        protected void btnGoBack_Click(object sender, EventArgs e)
        {
            if(Request.UrlReferrer != null)
                Response.Redirect(Request.UrlReferrer.AbsoluteUri);
        }
    }
}