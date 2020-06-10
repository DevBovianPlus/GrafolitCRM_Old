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
    public partial class Plan_popup : ServerMasterPage
    {
        PlanModel model = null;
        int planID = -1;
        int action = -1;
        int clientID = -1;
        protected void Page_Init(object sender, EventArgs e)
        {
            clientID = CommonMethods.ParseInt(GetStringValueFromSession(Enums.ClientSession.ClientId));
            action = CommonMethods.ParseInt(GetStringValueFromSession(Enums.CommonSession.UserActionPopUp));
            planID = CommonMethods.ParseInt(GetStringValueFromSession(Enums.ClientSession.PlanPopUpID));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ComboBoxKategorije.DataBind();                
                if (action == (int)Enums.UserAction.Edit || action == (int)Enums.UserAction.Delete)
                {
                    if (planID > 0 && SessionHasValue(Enums.ClientSession.ClientModel))
                    {
                        model = GetClientDataProviderInstance().GetPlanFromClientModelSession(planID, clientID);
                        FillForm();
                    }
                }
                else if(action == (int)Enums.UserAction.Add)//acion ADD
                {
                    txtIdStranke.Text = clientID.ToString();
                    ComboBoxKategorije.SelectedIndex = 0;
                }
                UserActionConfirmBtnUpdate(btnConfirmPopUp, action, true);
            }
            Initialize();
        }

        private void FillForm()
        {
            txtPlanID.Text = model.idPlan.ToString();
            txtIdStranke.Text = model.IDStranka.ToString();
            txtLetnoZnesek.Text = model.LetniZnesek.ToString();
            txtLeto.Text = model.Leto.ToString();
            ComboBoxKategorije.Value = model.idKategorija;
            ComboBoxKategorije.Text = model.Kategorija;
        }

        private bool AddOrEditEntityObject(bool add = false)
        {
            if (add)
            {
                model = new PlanModel();

                model.idPlan = 0;
                model.IDStranka = clientID;
            }
            else if (model == null && !add)
            {
                model = GetClientDataProviderInstance().GetPlanFromClientModelSession(planID, clientID);
            }

            model.idKategorija = CommonMethods.ParseInt(ComboBoxKategorije.Value.ToString());
            model.Kategorija = ComboBoxKategorije.Text;
            model.LetniZnesek = CommonMethods.ParseDecimal(txtLetnoZnesek.Text);
            model.Leto = CommonMethods.ParseInt(txtLeto.Text);
            model.Stranka = "";
            model.tsIDOsebe = PrincipalHelper.GetUserPrincipal().ID;
            model.ts = DateTime.Now;

            PlanModel newModel = CheckModelValidation(GetDatabaseConnectionInstance().SavePlanChanges(model));

            if (newModel != null)//If new record is added we need to refresh aspxgridview. We add new record to session model.
            {
                if (add)
                   return GetClientDataProviderInstance().AddPlanToClientModelSession(newModel);
                else
                   return GetClientDataProviderInstance().UpdatePlanToClientModelSession(newModel);
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
            bool isDeleted = CheckModelValidation(GetDatabaseConnectionInstance().DeletePlan(planID, clientID));

            GetClientDataProviderInstance().DeletePlanFromClientModelSession(planID, clientID);

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
            ClientScript.RegisterStartupScript(GetType(), "ANY_KEY", string.Format("window.parent.OnClosePopupEventHandler_Plan('{0}');", confirmCancelAction), true);

        }

        protected void ComboBoxKategorije_DataBinding(object sender, EventArgs e)
        {
            List<CategorieModel> categories = CheckModelValidation<List<CategorieModel>>(GetDatabaseConnectionInstance().GetAllCategories());
            DataTable dt = new DataTable();
            
            if (categories != null)
            {
                string listCat = JsonConvert.SerializeObject(categories);
                dt = JsonConvert.DeserializeObject<DataTable>(listCat);
            }

            (sender as ASPxComboBox).DataSource = dt;
        }

        private void Initialize()
        {
            txtLetnoZnesek.Attributes.Add("Onkeypress", "return isNumberKey_decimal(event);");
            txtLeto.Attributes.Add("Onkeypress", "return isNumberKey_int(event);");
        }
    }
}