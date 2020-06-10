using AnalizaProdaje.Common;
using AnalizaProdaje.Domain.Concrete;
using AnalizaProdaje.Domain.Helpers;
using DatabaseWebService.Models;
using DatabaseWebService.Models.Client;
using DatabaseWebService.Models.Event;
using DevExpress.Web;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnalizaProdaje.Pages.Error
{
    public partial class ReportError_popup : ServerMasterPage
    {
        protected void Page_Init(object sender, EventArgs e)
        {
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnCancelPopUp_Click(object sender, EventArgs e)
        {
            RemoveSessionsAndClosePopUP();
        }

        protected void btnConfirmPopUp_Click(object sender, EventArgs e)
        {
            bool isSent = false;
            string displayName = "Uporabnik AnaliziProdaje je poslal sporočilo";
            string body = "Iz Analize Prodaje vam je " + PrincipalHelper.GetUserPrincipal().firstName + " " +
                PrincipalHelper.GetUserPrincipal().lastName + " poslal sporočilo: \r\n\r\n" + ASPxMemoOpis.Text;

            isSent = CommonMethods.SendEmailToDeveloper(displayName, txtEmailZadeva.Text, body);

            if (isSent)
                RemoveSessionsAndClosePopUP();
            else
                ShowClientPopUp("Something went wrong. Contact administrator", 1);
        }

        private void RemoveSessionsAndClosePopUP()
        {
            RemoveAllSesions();

            ClientScript.RegisterStartupScript(GetType(), "ANY_KEY", string.Format("window.parent.OnClosePopupEventHandler_ReportError();"), true);
        }
    }
}