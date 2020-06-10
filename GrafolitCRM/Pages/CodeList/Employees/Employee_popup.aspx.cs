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
using DatabaseWebService.Models.Employee;

namespace AnalizaProdaje.Pages.CodeList.Employees
{
    public partial class Employee_popup : ServerMasterPage
    {
        EmployeeFullModel model = null;
        int employeeID = -1;
        int action = -1;
        protected void Page_Init(object sender, EventArgs e)
        {
            employeeID = CommonMethods.ParseInt(GetStringValueFromSession(Enums.EmployeeSession.EmployeePopUpId));
            action = CommonMethods.ParseInt(GetStringValueFromSession(Enums.CommonSession.UserActionPopUp));
            //messageID = CommonMethods.ParseInt(GetStringValueFromSession(Enums.EventSession.MessagePopupID));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (PrincipalHelper.IsUserSuperAdmin())
                { 
                    ComboBoxVloge.DataBind();
                    ComboBoxNadrejeni.DataBind();
                }
                else
                {
                    ASPxPageControl1.TabPages.FindByName("UserCredentialData").ClientVisible = false;
                    ASPxPageControl1.TabPages.FindByName("UserCredentialData").Enabled = false;
                }

                if (action == (int)Enums.UserAction.Edit || action == (int)Enums.UserAction.Delete)
                {
                    if (employeeID > 0)
                    {
                        model = CheckModelValidation(GetDatabaseConnectionInstance().GetEmployee(employeeID));

                        if (model != null)
                        {
                            GetEmployeeDataProviderInstance().SetEmployeeFullModel(model);
                            FillForm();
                        }
                    }
                }
                else if (action == (int)Enums.UserAction.Add)//acion ADD
                {
                    ComboBoxVloge.SelectedIndex = 0;
                }
                UserActionConfirmBtnUpdate(btnConfirmPopUp, action, true);
            }
        }

        private void FillForm()
        {
            txtOsebaID.Text = model.idOsebe.ToString();
            txtIme.Text = model.Ime;
            txtPriimek.Text = model.Priimek;
            txtNaslov.Text = model.Naslov;
            ASPxDateEditDatumRojstva.Date = model.DatumRojstva > DateTime.MinValue ? model.DatumRojstva : DateTime.MinValue;
            txtEmail.Text = model.Email;
            ASPxDateEditDatumZaposlitve.Date = model.DatumZaposlitve > DateTime.MinValue ? model.DatumZaposlitve : DateTime.MinValue;
            txtDelovnoMesto.Text = model.DelovnoMesto;
            ComboBoxZunanji.SelectedItem.Value = model.Zunanji;
            txtTelefon.Text = model.TelefonGSM;


            if (PrincipalHelper.IsUserSuperAdmin())
            {
                ComboBoxVloge.SelectedIndex = model.idVloga > 0 ? ComboBoxVloge.Items.IndexOfValue(model.idVloga.ToString()) : 0;

                //ComboBoxNadrejeni.SelectedIndex = model.idNadrejeni.HasValue ? ComboBoxNadrejeni.Items.IndexOfValue(model.idNadrejeni.Value.ToString()) : 0;
                // 22.01.20120, Boris popravek
                ComboBoxNadrejeni.SelectedIndex = model.idNadrejeni > 0 ? ComboBoxNadrejeni.Items.IndexOfValue(model.idNadrejeni.ToString()) : 0;
                txtEmail.Text = model.Email;
                txtUporabniskoIme.Text = model.UporabniskoIme;
                txtGeslo.Text = model.Geslo;
            }

        }

        private bool AddOrEditEntityObject(bool add = false)
        {
            if (add)
            {
                model = new EmployeeFullModel();

                model.idOsebe = 0;
                model.tsIDOsebe = PrincipalHelper.GetUserPrincipal().ID;
                model.ts = DateTime.Now;
            }
            else if (model == null && !add)
            {
                model = GetEmployeeDataProviderInstance().GetFullEmployeeModel();
            }

            if (PrincipalHelper.IsUserSuperAdmin())
            {
                model.Email = txtEmail.Text;
                model.UporabniskoIme = txtUporabniskoIme.Text;
                model.Geslo = txtGeslo.Text;
                model.idVloga = CommonMethods.ParseInt(ComboBoxVloge.Value);
                //model.idNadrejeni = CommonMethods.ParseInt(ComboBoxNadrejeni.Value) > 0 ? CommonMethods.ParseInt(ComboBoxNadrejeni.Value) : (int?)null;
                // 22.01.2020, Boris popravek
                model.idNadrejeni = CommonMethods.ParseInt(ComboBoxNadrejeni.Value) > 0 ? CommonMethods.ParseInt(ComboBoxNadrejeni.Value) : 1;
            }

            model.Ime = txtIme.Text;
            model.Priimek = txtPriimek.Text;
            model.Naslov = txtNaslov.Text;
            model.DatumRojstva = ASPxDateEditDatumRojstva.Date;
            model.Email = txtEmail.Text;
            model.DatumZaposlitve = ASPxDateEditDatumZaposlitve.Date;
            model.DelovnoMesto = txtDelovnoMesto.Text;
            model.Zunanji = CommonMethods.ParseInt(ComboBoxZunanji.SelectedItem.Value);
            model.TelefonGSM = txtTelefon.Text;

            EmployeeFullModel newModel = CheckModelValidation(GetDatabaseConnectionInstance().SaveEmployeeChanges(model));

            if (newModel != null)//If new record is added we need to refresh aspxgridview. We add new record to session model.
            {
                return true;
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
            bool isDeleted = CheckModelValidation(GetDatabaseConnectionInstance().DeleteEmployee(employeeID));

            return isDeleted;
        }

        private void RemoveSessionsAndClosePopUP(bool confirm = false)
        {
            string confirmCancelAction = "Preklici";

            if (confirm)
                confirmCancelAction = "Potrdi";

            RemoveSession(Enums.CommonSession.UserActionPopUp);
            //RemoveSession(Enums.EmployeeSession.EmployeePopUpId);
            RemoveSession(Enums.EmployeeSession.EmployeeFullModel);
            ClientScript.RegisterStartupScript(GetType(), "ANY_KEY", string.Format("window.parent.OnClosePopupEventHandler_Employee('{0}');", confirmCancelAction), true);

        }

        protected void ComboBoxVloge_DataBinding(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();

            List<RoleModel> roles = CheckModelValidation<List<RoleModel>>(GetDatabaseConnectionInstance().GetAllRoles());

            if (roles != null)
            {
                //GetEmployeeDataProviderInstance().AddEmployeesToSession(employees);
                string listRoles = JsonConvert.SerializeObject(roles);
                dt = JsonConvert.DeserializeObject<DataTable>(listRoles);
                //dt.Columns.Add("CelotnoIme", typeof(string), "Ime + ' ' + Priimek");
                DataRow row = dt.NewRow();
                row["idVloga"] = -1;
                row["Koda"] = "Izberi...";
                dt.Rows.InsertAt(row, 0);
            }

            (sender as ASPxComboBox).DataSource = dt;
        }

        protected void ComboBoxNadrejeni_DataBinding(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();

            List<EmployeeSimpleModel> supervisors = CheckModelValidation<List<EmployeeSimpleModel>>(GetDatabaseConnectionInstance().GetAllEmployeeSupervisors());

            if (supervisors != null)
            {
                //GetEmployeeDataProviderInstance().AddEmployeesToSession(employees);
                string listSupervisors = JsonConvert.SerializeObject(supervisors);
                dt = JsonConvert.DeserializeObject<DataTable>(listSupervisors);
                dt.Columns.Add("CelotnoIme", typeof(string), "Ime + ' ' + Priimek");
                DataRow row = dt.NewRow();
                row["idOsebe"] = -1;
                row["Ime"] = "Izberi...";
                row["Priimek"] = "";
                dt.Rows.InsertAt(row, 0);
            }

            (sender as ASPxComboBox).DataSource = dt;
        }


        private void Initialize()
        {
        }
    }
}