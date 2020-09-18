using AnalizaProdaje.Common;
using AnalizaProdaje.Domain.Concrete;
using AnalizaProdaje.Domain.Helpers;
using DatabaseWebService.Models;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnalizaProdaje.Pages.CodeList.Events
{
    public partial class Events : ServerMasterPage
    {
        int eventFocusedRowID = 0;
        protected void Page_Init(object sender, EventArgs e)
        {
            if (Request.QueryString[Enums.QueryStringName.recordId.ToString()] != null)
                eventFocusedRowID = CommonMethods.ParseInt(Request.QueryString[Enums.QueryStringName.recordId.ToString()].ToString());
            Initialize();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            ASPxGridViewEvents.DataBind();
            ASPxGridViewEvents.Settings.GridLines = GridLines.Both;
            
            InitializeEditDeleteButtons();
            if (eventFocusedRowID > 0)
            {
                ASPxGridViewEvents.FocusedRowIndex = ASPxGridViewEvents.FindVisibleIndexByKeyValue(eventFocusedRowID);
                ASPxGridViewEvents.ScrollToVisibleIndexOnClient = ASPxGridViewEvents.FindVisibleIndexByKeyValue(eventFocusedRowID);
            }
        }

        protected void ASPxGridViewEvents_DataBinding(object sender, EventArgs e)
        {
            (sender as ASPxGridView).DataSource = CreateDataSource();
        }

        protected void btnExportEvents_Click(object sender, EventArgs e)
        {
            CommonMethods.ExportToPDFFitToPage(ASPxGridViewExporterEvents, this);
        }

        protected override DataTable CreateDataSource()
        {
            DataTable dt = new DataTable();
            if (PrincipalHelper.IsUserSuperAdmin() || PrincipalHelper.IsUserAdmin())
                dt = CheckModelValidation<DataTable>(GetDatabaseConnectionInstance().GetAllEvents());
            else
                dt = CheckModelValidation<DataTable>(GetDatabaseConnectionInstance().GetAllEvents(PrincipalHelper.GetUserPrincipal().ID));
                        
            return dt;
        }

        protected void ASPxCallback1_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            string[] split = e.Parameter.Split(';');
            if (split[0].Equals("DblClick") && !String.IsNullOrEmpty(split[1]))
            {
                DevExpress.Web.ASPxWebControl.RedirectOnCallback(GenerateURI("EventsForm.aspx", (int)Enums.UserAction.Edit, split[1]));
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            //List<EmployeeSimpleModel> listModel = CheckModelValidation(GetDatabaseConnectionInstance().GetEmployeeSupervisorByEmployeeID(PrincipalHelper.GetUserPrincipal().ID));
            if (PrincipalHelper.GetUserPrincipal().HasSupervisor)
                RedirectWithCustomURI("EventsForm.aspx", (int)Enums.UserAction.Add, 0);
            else
                ErrorLabel.Text = "Skrbnik za osebo ni izbran!";
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            object valueID = ASPxGridViewEvents.GetRowValues(ASPxGridViewEvents.FocusedRowIndex, "idDogodek");

            RedirectWithCustomURI("EventsForm.aspx", (int)Enums.UserAction.Edit, valueID);
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            object valueID = ASPxGridViewEvents.GetRowValues(ASPxGridViewEvents.FocusedRowIndex, "idDogodek");

            RedirectWithCustomURI("EventsForm.aspx", (int)Enums.UserAction.Delete, valueID);
        }

        private void Initialize()
        {
            //TODO: Add input constraint (ex: number only) and other masks.
            ASPxGridViewEvents.FocusedRowIndex = 0;
        }

        private void InitializeEditDeleteButtons()
        {
            //Check to enable Edit and Delete button for Tab PLAN
            if (ASPxGridViewEvents.VisibleRowCount <= 0)
            {
                EnabledDeleteAndEditBtnPopUp(btnEdit, btnDelete);
            }
            else if (!btnEdit.Enabled && !btnDelete.Enabled)
            {
                EnabledDeleteAndEditBtnPopUp(btnEdit, btnDelete, false);
            }
        }
    }
}