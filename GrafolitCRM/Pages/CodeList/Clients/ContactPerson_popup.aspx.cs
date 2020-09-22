using AnalizaProdaje.Common;
using AnalizaProdaje.Domain.Concrete;
using AnalizaProdaje.Domain.Helpers;
using DatabaseWebService.Models;
using DatabaseWebService.Models.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnalizaProdaje.Pages.CodeList.Clients
{
    public partial class ContactPerson_popup : ServerMasterPage
    {
        ContactPersonModel model = null;
        int contactPersonID = -1;
        int action = -1;
        int clientID = -1;
        protected void Page_Init(object sender, EventArgs e)
        {
            clientID = CommonMethods.ParseInt(GetStringValueFromSession(Enums.ClientSession.ClientId));
            action = CommonMethods.ParseInt(GetStringValueFromSession(Enums.CommonSession.UserActionPopUp));
            contactPersonID = CommonMethods.ParseInt(GetStringValueFromSession(Enums.ClientSession.ContactPersonPopUp));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (action == (int)Enums.UserAction.Edit || action == (int)Enums.UserAction.Delete)
                {
                    if (contactPersonID > 0 && SessionHasValue(Enums.ClientSession.ClientModel))
                    {
                        model = GetClientDataProviderInstance().GetContactPersonFromClientModelSession(contactPersonID, clientID);
                        FillForm();
                    }
                }
                else if(action == (int)Enums.UserAction.Add) //action ADD
                {
                    txtIdStranke.Text = clientID.ToString();
                }
                UserActionConfirmBtnUpdate(btnConfirmPopUp, action, true);
            }
            //ShowClientPopUp("'TESTINg'", 1);
            Initialize();
        }

        private void FillForm()
        {
            txtContactPersonID.Text = model.idKontaktneOsebe.ToString();
            txtIdStranke.Text = model.idStranka.ToString();
            txtNaziv.Text = model.NazivKontaktneOsebe;
            txtTelefon.Text = model.Telefon;
            txtGSM.Text = model.GSM;
            txtEmail.Text = model.Email;
            txtDelovnoMesto.Text = model.DelovnoMesto;
            txtZaporednaStevilka.Text = model.ZaporednaStevika.ToString();
            txtFax.Text = model.Fax;
            ASPxMemoZaznamki.Text = model.Opombe;
            dtDateRojDan.Date = model.RojstniDatum > DateTime.MinValue ? model.RojstniDatum : DateTime.MinValue;
        }

        private bool AddOrEditEntityObject(bool add = false)
        {
            if (add)
            {
                model = new ContactPersonModel();

                model.idKontaktneOsebe = 0;
                model.idStranka = clientID;
                model.tsIDOsebe = PrincipalHelper.GetUserPrincipal().ID;
                model.ts = DateTime.Now;
            }
            else if (model == null && !add)
            {
                model = GetClientDataProviderInstance().GetContactPersonFromClientModelSession(contactPersonID, clientID);
            }
            model.NazivKontaktneOsebe = txtNaziv.Text;
            model.Telefon = txtTelefon.Text;
            model.GSM = txtGSM.Text;
            model.Email = txtEmail.Text;
            model.DelovnoMesto = txtDelovnoMesto.Text;
            model.ZaporednaStevika = CommonMethods.ParseInt(txtZaporednaStevilka.Text);
            model.Fax = txtFax.Text;
            model.Opombe = ASPxMemoZaznamki.Text;
             
            if (!dtDateRojDan.Date.Equals(DateTime.MinValue)) model.RojstniDatum = dtDateRojDan.Date;

            ContactPersonModel newModel =  CheckModelValidation(GetDatabaseConnectionInstance().SaveContactPersonChanges(model));

            if (newModel != null)//If new record is added we need to refresh aspxgridview. We add new record to session model.
            {
                if (add)
                    return GetClientDataProviderInstance().AddContactPersonToClientModelSession(newModel);
                else
                    return GetClientDataProviderInstance().UpdateContactPersonToClientModelSession(newModel);
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
            bool isDeleted = CheckModelValidation(GetDatabaseConnectionInstance().DeleteContactPerson(contactPersonID, clientID));

            GetClientDataProviderInstance().DeleteContactPersonFromClientModelSession(contactPersonID, clientID);

            return isDeleted;
        }

        private void RemoveSessionsAndClosePopUP(bool confirm = false)
        {
            string confirmCancelAction = "Preklici";

            if (confirm)
                confirmCancelAction = "Potrdi";

            //RemoveSession(Enums.ClientSession.ContactPersonPopUp);
            RemoveSession(Enums.CommonSession.UserActionPopUp);
            RemoveSession(Enums.ClientSession.ClientId);
            ClientScript.RegisterStartupScript(GetType(), "ANY_KEY", string.Format("window.parent.OnClosePopupEventHandler_ContactPerson('{0}');", confirmCancelAction), true);

        }

        private void Initialize()
        {
            txtZaporednaStevilka.Attributes.Add("Onkeypress", "return isNumberKey_int(event);");
        }
    }
}