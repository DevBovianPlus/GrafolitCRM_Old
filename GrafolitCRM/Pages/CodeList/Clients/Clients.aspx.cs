using AnalizaProdaje.Common;
using AnalizaProdaje.Domain.Concrete;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Data.Filtering;
using AnalizaProdaje.Domain.Helpers;
using DatabaseWebService.Models.Client;
using System.Net.Mime;
using DevExpress.XtraPrintingLinks;
using System.IO;

namespace AnalizaProdaje.Pages.CodeList.Clients
{
    public partial class Clients : ServerMasterPage
    {
        int clientFocusedRowID = 0;
        protected void Page_Init(object sender, EventArgs e)
        {
            if (Request.QueryString[Enums.QueryStringName.recordId.ToString()] != null)
                clientFocusedRowID = CommonMethods.ParseInt(Request.QueryString[Enums.QueryStringName.recordId.ToString()].ToString());
            Initialize();
            //ShowSpinnerLoader();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                ASPxGridViewStranke.DataBind();
                InitializeEditDeleteButtons();
                if (clientFocusedRowID > 0)
                {
                    ASPxGridViewStranke.FocusedRowIndex = ASPxGridViewStranke.FindVisibleIndexByKeyValue(clientFocusedRowID);
                    ASPxGridViewStranke.ScrollToVisibleIndexOnClient = ASPxGridViewStranke.FindVisibleIndexByKeyValue(clientFocusedRowID);
                }
            }
            ASPxGridViewStranke.Settings.GridLines = GridLines.Both;
        }

        protected void ASPxGridViewStranke_DataBinding(object sender, EventArgs e)
        {
            ASPxGridView grid = (ASPxGridView)sender;
            grid.DataSource = CreateDataSource();

            if(PrincipalHelper.IsUserSalesman())
                grid.Columns["ImeInPriimekZaposlen"].Visible = false;
        }

        protected void btnExportStranke_Click(object sender, EventArgs e)
        {
           CommonMethods.ExportToPDFFitToPage(ASPxGridViewExporterStranke, this);
        }

       


        protected override DataTable CreateDataSource()
        {
            DataTable dt = new DataTable();
            if (PrincipalHelper.IsUserSuperAdmin() || PrincipalHelper.IsUserAdmin())
                dt = CheckModelValidation<DataTable>(GetDatabaseConnectionInstance().GetAllClients());
            else
                dt = CheckModelValidation<DataTable>(GetDatabaseConnectionInstance().GetAllClients(PrincipalHelper.GetUserPrincipal().ID));
            
            /*if (SessionHasValue(Enums.ClientSession.ColumnFilters))
            {
                CriteriaFilterHelper criteria = (CriteriaFilterHelper)GetValueFromSession(Enums.ClientSession.ColumnFilters);
                List<ClientSimpleModel> list = CheckModelValidation(GetDatabaseConnectionInstance().GetClientsByFilter(criteria.Column.FieldName, criteria.Value));
                dt = SerializeToDataTable(list);
            }*/

            return dt;
        }

        protected void ASPxCallback1_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            string[] split = e.Parameter.Split(';');
            if (split[0].Equals("DblClick") && !String.IsNullOrEmpty(split[1]))
            {
                DevExpress.Web.ASPxWebControl.RedirectOnCallback(GenerateURI("ClientsForm.aspx", (int)Enums.UserAction.Edit, split[1]));
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            RedirectWithCustomURI("ClientsForm.aspx", (int)Enums.UserAction.Add, 0);
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            object valueID = ASPxGridViewStranke.GetRowValues(ASPxGridViewStranke.FocusedRowIndex, "idStranka");

            RedirectWithCustomURI("ClientsForm.aspx", (int)Enums.UserAction.Edit, valueID);
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            object valueID = ASPxGridViewStranke.GetRowValues(ASPxGridViewStranke.FocusedRowIndex, "idStranka");

            RedirectWithCustomURI("ClientsForm.aspx", (int)Enums.UserAction.Delete, valueID);
        }

        private void Initialize()
        {
            //TODO: Add input constraint (ex: number only) and other masks.
            ASPxGridViewStranke.FocusedRowIndex = 0;
        }

        private void InitializeEditDeleteButtons()
        {
            //Check to enable Edit and Delete button for Tab PLAN
            if (ASPxGridViewStranke.VisibleRowCount <= 0)
            {
                EnabledDeleteAndEditBtnPopUp(btnEdit, btnDelete);
            }
            else if (!btnEdit.Enabled && !btnDelete.Enabled)
            {
                EnabledDeleteAndEditBtnPopUp(btnEdit, btnDelete, false);
            }
        }

        /*protected void ASPxGridViewStranke_ProcessColumnAutoFilter(object sender, ASPxGridViewAutoFilterEventArgs e)
        {
            if (e.Kind == GridViewAutoFilterEventKind.CreateCriteria)
            {
                if (SessionHasValue(Enums.ClientSession.ColumnFilters))
                {
                    //TODO:Check if current value exist in session
                    CriteriaFilterHelper list = (CriteriaFilterHelper)GetValueFromSession(Enums.ClientSession.ColumnFilters);
                   
                    if (list.Column == e.Column && (!list.Value.Equals(e.Value) && !String.IsNullOrEmpty(e.Value)))
                    {
                        list.Column = e.Column;
                        list.Criteria = e.Criteria;
                        list.Value = e.Value;
                        AddValueToSession(Enums.ClientSession.ColumnFilters, list);
                    }

                    if (String.IsNullOrEmpty(e.Value))//search sttring was deleted
                        RemoveSession(Enums.ClientSession.ColumnFilters);
                }
                else
                {//TODO: We add value to session and call web service with existing filter
                    AddValueToSession(Enums.ClientSession.ColumnFilters, new CriteriaFilterHelper { Column = e.Column, Criteria = e.Criteria, Value = e.Value });
                }
                ASPxGridViewStranke.DataBind();
            }
        }*/
    }
}