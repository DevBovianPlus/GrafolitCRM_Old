using AnalizaProdaje.Common;
using AnalizaProdaje.Domain.Concrete;
using AnalizaProdaje.Domain.Helpers;
using DatabaseWebService.Models;
using DatabaseWebService.Models.Client;
using DevExpress.Web;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnalizaProdaje.Pages.CodeList.Clients
{
    public partial class Notes_popup : ServerMasterPage
    {
        NotesModel model = null;
        int NotesID = -1;
        int action = -1;
        int clientID = -1;
        protected void Page_Init(object sender, EventArgs e)
        {
            clientID = CommonMethods.ParseInt(GetStringValueFromSession(Enums.ClientSession.ClientId));
            action = CommonMethods.ParseInt(GetStringValueFromSession(Enums.CommonSession.UserActionPopUp));
            NotesID = CommonMethods.ParseInt(GetStringValueFromSession(Enums.ClientSession.NotesPopUpID));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //ComboBoxKategorije.DataBind();                
                if (action == (int)Enums.UserAction.Edit || action == (int)Enums.UserAction.Delete)
                {
                    if (NotesID > 0 && SessionHasValue(Enums.ClientSession.ClientModel))
                    {
                        model = GetClientDataProviderInstance().GetNotesFromClientModelSession(NotesID, clientID);
                        FillForm();
                    }
                }
                else if (action == (int)Enums.UserAction.Add)//acion ADD
                {
                    txtIdStranke.Text = clientID.ToString();
                    // ComboBoxKategorije.SelectedIndex = 0;
                }
                UserActionConfirmBtnUpdate(btnConfirmPopUp, action, true);
            }
        }

        private void FillForm()
        {
            txtNotesID.Text = model.idOpombaStranka.ToString();
            txtIdStranke.Text = model.idStranka.ToString();
            htmlOpomba.Html = model.Opomba;            
        }

        private bool AddOrEditEntityObject(bool add = false)
        {
            if (add)
            {
                model = new NotesModel();

                model.idOpombaStranka = 0;
                model.idStranka = clientID;
                model.tsIDOsebe = PrincipalHelper.GetUserPrincipal().ID;
                model.ts = DateTime.Now;
            }
            else if (model == null && !add)
            {
                model = GetClientDataProviderInstance().GetNotesFromClientModelSession(NotesID, clientID);
            }
            
            model.Opomba = htmlOpomba.Html;

            NotesModel newModel = CheckModelValidation(GetDatabaseConnectionInstance().SaveNotesChanges(model));

            if (newModel != null)//If new record is added we need to refresh aspxgridview. We add new record to session model.
            {
                if (add)
                    return GetClientDataProviderInstance().AddNotesToClientModelSession(newModel);
                else
                    return GetClientDataProviderInstance().UpdateNotesToClientModelSession(newModel);
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
                    isValid = DeletePlanObject();
                    break;
            }

            if (isValid)
                RemoveSessionsAndClosePopUP(true);
            else
                ShowClientPopUp("Something went wrong. Contact administrator", 1);
        }

        private bool DeletePlanObject()
        {
            bool isDeleted = CheckModelValidation(GetDatabaseConnectionInstance().DeleteNotes(NotesID, clientID));

            GetClientDataProviderInstance().DeleteNotesFromClientModelSession(NotesID, clientID);

            return isDeleted;
        }

        private void RemoveSessionsAndClosePopUP(bool confirm = false)
        {
            string confirmCancelAction = "Preklici";

            if (confirm)
                confirmCancelAction = "Potrdi";

            //RemoveSession(Enums.ClientSession.PlanPopUpID);
            RemoveSession(Enums.CommonSession.UserActionPopUp);
            RemoveSession(Enums.ClientSession.ClientId);
            ClientScript.RegisterStartupScript(GetType(), "ANY_KEY", string.Format("window.parent.OnClosePopupEventHandler_Notes('{0}');", confirmCancelAction), true);

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