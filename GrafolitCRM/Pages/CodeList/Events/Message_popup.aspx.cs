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

namespace AnalizaProdaje.Pages.CodeList.Events
{
    public partial class Message_popup : ServerMasterPage
    {
        MessageModel model = null;
        int messageID = -1;
        int action = -1;
        int eventID = -1;
        protected void Page_Init(object sender, EventArgs e)
        {
            eventID = CommonMethods.ParseInt(GetStringValueFromSession(Enums.EventSession.EventID));
            action = CommonMethods.ParseInt(GetStringValueFromSession(Enums.CommonSession.UserActionPopUp));
            messageID = CommonMethods.ParseInt(GetStringValueFromSession(Enums.EventSession.MessagePopupID));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {               
                if (action == (int)Enums.UserAction.Edit || action == (int)Enums.UserAction.Delete)
                {
                    if (messageID > 0 && SessionHasValue(Enums.EventSession.EventModel))
                    {
                        model = GetEventDataProviderInstance().GetMessageFromEventModelSession(messageID, eventID);
                        FillForm();
                    }
                }
                else if(action == (int)Enums.UserAction.Add)//acion ADD
                {
                    txtIdDogodek.Text = eventID.ToString();
                }
                UserActionConfirmBtnUpdate(btnConfirmPopUp, action, true);
            }
            //ShowClientPopUp("'TESTINg'", 1);
        }

        private void FillForm()
        {
            txtSporociloID.Text = model.idSporocila.ToString();
            txtIdDogodek.Text = model.IDDogodek.ToString();
            ASPxMemoOpis.Text = model.OpisDel;
        }

        private bool AddOrEditEntityObject(bool add = false)
        {
            if (add)
            {
                model = new MessageModel();

                model.idSporocila = 0;
                model.IDDogodek = eventID;
                model.tsIDOsebe = PrincipalHelper.GetUserPrincipal().ID;
                model.ts = DateTime.Now;
            }
            else if (model == null && !add)
            {
                model = GetEventDataProviderInstance().GetMessageFromEventModelSession(messageID, eventID);
            }

            model.OpisDel = ASPxMemoOpis.Text;

            MessageModel newModel = CheckModelValidation(GetDatabaseConnectionInstance().SaveMessageChanges(model));

            if (newModel != null)//If new record is added we need to refresh aspxgridview. We add new record to session model.
            {
                if (add)
                   return GetEventDataProviderInstance().AddMessageToEventModelSession(newModel);
                else
                    return GetEventDataProviderInstance().UpdateMessageToEventModelSession(newModel);
            }
            else
            {
                return false;
            }
        }

        protected void btnCancelPopUp_Click(object sender, EventArgs e)
        {
            RemoveSessionsAndClosePopUP();
        }

        protected void btnConfirmPopUp_Click(object sender, EventArgs e)
        {
            bool isValid = false;

            switch (action)
            {
                case (int)Enums.UserAction.Add:
                    isValid = AddOrEditEntityObject(true);
                    break;
                case (int)Enums.UserAction.Edit:
                    isValid = AddOrEditEntityObject();
                    break;
                case (int)Enums.UserAction.Delete:
                    isValid = DeleteObject();
                    break;
            }

            if (isValid)
                RemoveSessionsAndClosePopUP(true);
            else
                ShowClientPopUp("Something went wrong. Contact administrator", 1);
        }

        private bool DeleteObject()
        {
            bool isDeleted = CheckModelValidation(GetDatabaseConnectionInstance().DeleteMessage(messageID, eventID));

            GetEventDataProviderInstance().DeletePlanFromClientModelSession(messageID, eventID);

            return isDeleted;
        }

        private void RemoveSessionsAndClosePopUP(bool confirm = false)
        {
            string confirmCancelAction = "Preklici";

            if (confirm)
                confirmCancelAction = "Potrdi";

            //RemoveSession(Enums.EventSession.PlanPopUpID);
            RemoveSession(Enums.CommonSession.UserActionPopUp);
            RemoveSession(Enums.EventSession.EventID);
            ClientScript.RegisterStartupScript(GetType(), "ANY_KEY", string.Format("window.parent.OnClosePopupEventHandler_Message('{0}');", confirmCancelAction), true);

        }
    }
}