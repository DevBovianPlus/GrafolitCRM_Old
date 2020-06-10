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
    public partial class Device_popup : ServerMasterPage
    {
        DevicesModel model = null;
        int deviceID = -1;
        int action = -1;
        int clientID = -1;
        protected void Page_Init(object sender, EventArgs e)
        {
            clientID = CommonMethods.ParseInt(GetStringValueFromSession(Enums.ClientSession.ClientId));
            action = CommonMethods.ParseInt(GetStringValueFromSession(Enums.CommonSession.UserActionPopUp));
            deviceID = CommonMethods.ParseInt(GetStringValueFromSession(Enums.ClientSession.DevicePopUpID));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //ComboBoxKategorije.DataBind();                
                if (action == (int)Enums.UserAction.Edit || action == (int)Enums.UserAction.Delete)
                {
                    if (deviceID > 0 && SessionHasValue(Enums.ClientSession.ClientModel))
                    {
                        model = GetClientDataProviderInstance().GetDeviceFromClientModelSession(deviceID, clientID);
                        FillForm();
                    }
                }
                else if(action == (int)Enums.UserAction.Add)//acion ADD
                {
                    txtIdStranke.Text = clientID.ToString();
                   // ComboBoxKategorije.SelectedIndex = 0;
                }
                UserActionConfirmBtnUpdate(btnConfirmPopUp, action, true);
            }
        }

        private void FillForm()
        {
            txtNapravaID.Text = model.idNaprava.ToString();
            txtIdStranke.Text = model.idStranka.ToString();
            txtKoda.Text = model.Koda;
            txtNaziv.Text = model.Naziv;
            ASPxMemoOpis.Text = model.Opis;
        }

        private bool AddOrEditEntityObject(bool add = false)
        {
            if (add)
            {
                model = new DevicesModel();

                model.idNaprava = 0;
                model.idStranka = clientID;
                model.tsIDOsebe = PrincipalHelper.GetUserPrincipal().ID;
                model.ts = DateTime.Now;
            }
            else if (model == null && !add)
            {
                model = GetClientDataProviderInstance().GetDeviceFromClientModelSession(deviceID, clientID);
            }

            model.Koda = txtKoda.Text;
            model.Naziv = txtNaziv.Text;
            model.Opis = ASPxMemoOpis.Text;

            DevicesModel newModel = CheckModelValidation(GetDatabaseConnectionInstance().SaveDeviceChanges(model));

            if (newModel != null)//If new record is added we need to refresh aspxgridview. We add new record to session model.
            {
                if (add)
                   return GetClientDataProviderInstance().AddDeviceToClientModelSession(newModel);
                else
                   return GetClientDataProviderInstance().UpdateDeviceToClientModelSession(newModel);
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
            bool isDeleted = CheckModelValidation(GetDatabaseConnectionInstance().DeleteDevice(deviceID, clientID));

            GetClientDataProviderInstance().DeleteDeviceFromClientModelSession(deviceID, clientID);

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
            ClientScript.RegisterStartupScript(GetType(), "ANY_KEY", string.Format("window.parent.OnClosePopupEventHandler_Device('{0}');", confirmCancelAction), true);

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