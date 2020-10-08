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
    public partial class EventMeeting_popup : ServerMasterPage
    {
        EventMeetingModel model = null;
        int eventID = -1;
        int action = -1;
        int clientID = -1;
        int eventMeetingID = -1;
        int statusID = -1;
        protected void Page_Init(object sender, EventArgs e)
        {
            clientID = CommonMethods.ParseInt(GetStringValueFromSession(Enums.ClientSession.ClientId));
            action = CommonMethods.ParseInt(GetStringValueFromSession(Enums.CommonSession.UserActionPopUp));
            eventMeetingID = CommonMethods.ParseInt(GetStringValueFromSession(Enums.EventSession.EventMeetingID));
            eventID = CommonMethods.ParseInt(GetStringValueFromSession(Enums.EventSession.EventID));
            statusID = CommonMethods.ParseInt(GetStringValueFromSession(Enums.EventSession.EventStatusID));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //ComboBoxKategorije.DataBind();                
                if (action == (int)Enums.UserAction.Edit || action == (int)Enums.UserAction.Delete)
                {
                    if (eventMeetingID > 0 && eventMeetingID > 0)
                    {
                        model = GetEventDataProviderInstance().GetEventMeetingFromEventModelSession(eventMeetingID, eventID);
                        FillForm();
                    }
                }
                else if (action == (int)Enums.UserAction.Add)//acion ADD
                {
                    //txtIdStranke.Text = clientID.ToString();
                    // ComboBoxKategorije.SelectedIndex = 0;
                }
                UserActionConfirmBtnUpdate(btnConfirmPopUp, action, true);
            }
        }

        private void FillForm()
        {
            txtNotesID.Text = model.DogodekSestanekID.ToString();

            htmlOpombaSestanek.Html = model.Opis;

            if (statusID == 2)
            {
                btnConfirmPopUp.ClientEnabled = false;
            }
        }

        private bool AddOrEditEntityObject(bool add = false)
        {
            if (add)
            {
                model = new EventMeetingModel();

                model.DogodekSestanekID = 0;
                
                model.tsIDOsebe = PrincipalHelper.GetUserPrincipal().ID;
                model.ts = DateTime.Now;
            }
            else if (model == null && !add)
            {
                model = GetEventDataProviderInstance().GetEventMeetingFromEventModelSession(eventMeetingID, eventID);
            }
            model.ts = DateTime.Now;
            model.tsIDOsebe = PrincipalHelper.GetUserPrincipal().ID;
            model.Opis = htmlOpombaSestanek.Html;

            model = CheckModelValidation(GetDatabaseConnectionInstance().SaveEventMeetingChanges(model));

            //if (newModel != null)//If new record is added we need to refresh aspxgridview. We add new record to session model.
            //{
            //    if (add)
            //        return GetClientDataProviderInstance().AddNotesToClientModelSession(newModel);
            //    else
            //        return GetClientDataProviderInstance().UpdateNotesToClientModelSession(newModel);
            //}
            //else
            //{
            //    return false;
            //}
            return true;
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
                    //isValid = DeletePlanObject();
                    break;
            }

            if (isValid)
                RemoveSessionsAndClosePopUP(true);
            else
                ShowClientPopUp("Something went wrong. Contact administrator", 1);
        }

        //private bool DeletePlanObject()
        //{
        //    bool isDeleted = CheckModelValidation(GetDatabaseConnectionInstance().DeleteNotes(NotesID, clientID));

        //    GetClientDataProviderInstance().DeleteNotesFromClientModelSession(NotesID, clientID);

        //    return isDeleted;
        //}

        private void RemoveSessionsAndClosePopUP(bool confirm = false)
        {
            string confirmCancelAction = "Preklici";

            if (confirm)
                confirmCancelAction = "Potrdi";

            //RemoveSession(Enums.ClientSession.PlanPopUpID);
            RemoveSession(Enums.CommonSession.UserActionPopUp);
            RemoveSession(Enums.ClientSession.ClientId);
            RemoveSession(Enums.EventSession.EventMeetingID);
            ClientScript.RegisterStartupScript(GetType(), "ANY_KEY", string.Format("window.parent.OnClosePopupEventHandler_EventMeeting_popup('{0}');", confirmCancelAction), true);

        }

        protected void ComboBoxKategorije_DataBinding(object sender, EventArgs e)
        {
            /*List<CategorieModel> categories = CheckModelValidation<List<CategorieModel>>(GetDatabaseConnectionInstance().GetAllCategories());
            DataTable dt = new DataTable();
            
            if (categories != null)
            {
                string listCat = JsonConvert.SerializeObject(categories);
                dt = JsonConvert.DeserializeObject<DataTable>(listCat);
            }

            (sender as ASPxComboBox).DataSource = dt;*/
        }
    }
}