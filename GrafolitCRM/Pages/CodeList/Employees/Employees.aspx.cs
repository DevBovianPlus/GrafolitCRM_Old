using AnalizaProdaje.Common;
using AnalizaProdaje.Domain.Concrete;
using AnalizaProdaje.Domain.Helpers;
using DatabaseWebService.Models;
using DevExpress.Web;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnalizaProdaje.Pages.CodeList.Employees
{
    public partial class Employees : ServerMasterPage
    {

        protected void Page_Init(object sender, EventArgs e)
        {
            if (PrincipalHelper.IsUserSuperAdmin() || PrincipalHelper.IsUserAdmin())
            {
                ASPxGridViewZaposleni.DataBind();
                InitializeEditDeleteButtons();
            }
            else
                RedirectHome();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            ASPxGridViewZaposleni.Settings.GridLines = GridLines.Both;
        }

        protected override DataTable CreateDataSource()
        {
            DataTable dt = new DataTable();
            List<EmployeeSimpleModel> employees = CheckModelValidation(GetDatabaseConnectionInstance().GetAllCompanyEmployees());
            dt = SerializeToDataTable(employees);

            return dt;
        }

        protected void ASPxGridViewZaposleni_DataBinding(object sender, EventArgs e)
        {
            (sender as ASPxGridView).DataSource = CreateDataSource();
        }

        protected void EmployeeCallback_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            if (e.Parameter == "RefreshGrid")
            {
                InitializeEditDeleteButtons();
                ASPxGridViewZaposleni.DataBind();
            }
            else
            {
                object valueID = null;
                if (ASPxGridViewZaposleni.VisibleRowCount > 0)
                    valueID = ASPxGridViewZaposleni.GetRowValues(ASPxGridViewZaposleni.FocusedRowIndex, "idOsebe");

                bool isValid = SetSessionsAndOpenPopUp(e.Parameter, Enums.EmployeeSession.EmployeePopUpId, valueID);
                if (isValid)
                    ASPxPopupControl_Employee.ShowOnPageLoad = true;
            }
        }

        protected void btnExportZaposleni_Click(object sender, EventArgs e)
        {
            CommonMethods.ExportToPDFFitToPage(ASPxGridViewExporterZaposleni, this);
        }

        #region HelperMethods Local
        private bool SetSessionsAndOpenPopUp(string eventParameter, Enums.EmployeeSession sessionToWrite, object entityID)
        {
            int callbackResult = 0;
            int.TryParse(eventParameter, out callbackResult);
            if (callbackResult > 0 && callbackResult <= 3)
            {
                switch (callbackResult)
                {
                    case (int)Enums.UserAction.Add:
                        AddValueToSession(Enums.CommonSession.UserActionPopUp, callbackResult);
                        AddValueToSession(sessionToWrite, 0);
                        break;

                    default://For editing and deleting is the same code.
                        AddValueToSession(Enums.CommonSession.UserActionPopUp.ToString(), callbackResult);
                        AddValueToSession(sessionToWrite, entityID);
                        break;

                }
                return true;
            }

            return false;
        }

        private void InitializeEditDeleteButtons()
        {
            //Check to enable Edit and Delete button for Tab PLAN
            if (ASPxGridViewZaposleni.VisibleRowCount <= 0)
            {
                EnabledDeleteAndEditBtnPopUp(btnEditEmployee, btnDeleteEmployee);
            }
            else if (!btnEditEmployee.Enabled && !btnDeleteEmployee.Enabled)
            {
                EnabledDeleteAndEditBtnPopUp(btnEditEmployee, btnDeleteEmployee, false);
            }
        }
        #endregion
    }
}