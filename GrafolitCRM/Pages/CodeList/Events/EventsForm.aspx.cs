using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AnalizaProdaje.Common;
using DatabaseWebService.Models.Client;
using DevExpress.Web;
using System.Data;
using Newtonsoft.Json;
using AnalizaProdaje.Domain.Helpers;
using System.Reflection;
using DatabaseWebService.Models;
using DatabaseWebService.Models.Event;
using System.Drawing;
using DatabaseWebService.Models.EmailMessage;
namespace AnalizaProdaje.Pages.CodeList.Events
{
    public partial class EventsForm : ServerMasterPage
    {
        EventFullModel model = null;
        int eventID = -1;
        int action = -1;
        //int planFocusedRow = 0;

        //optional id's. If user clicks on calander logo in client tab Charts.
        int clientID = -1;
        int categorieID = -1;
        int employeeID = -1;
        bool isReferallClient = false;
        int supervisorID = -1;

        protected void Page_Init(object sender, EventArgs e)
        {

            if (!Request.IsAuthenticated)
            {
                Session["PreviousPage"] = Request.RawUrl;
                RedirectHome();
            }

            action = CommonMethods.ParseInt(Request.QueryString[Enums.QueryStringName.action.ToString()].ToString());
            eventID = CommonMethods.ParseInt(Request.QueryString[Enums.QueryStringName.recordId.ToString()].ToString());

            //This id's are filled when user click calender button from client Charts tab. 
            //TODO:CHECK IF URLReferall is ClientsForm.aspx
            if (Request.QueryString.Count > 2 && Request.QueryString.Keys.Get(Request.QueryString.Count - 2).Equals(Enums.QueryStringName.eventCategorieId.ToString()))
            {
                clientID = CommonMethods.ParseInt(Request.QueryString[Enums.QueryStringName.eventClientId.ToString()].ToString());
                categorieID = CommonMethods.ParseInt(Request.QueryString[Enums.QueryStringName.eventCategorieId.ToString()].ToString());
                employeeID = CommonMethods.ParseInt(Request.QueryString[Enums.QueryStringName.eventEmployeeId.ToString()].ToString());

                isReferallClient = true;

                //We remove sessions from previous page which was Clients!
                List<Enums.ClientSession> list = Enum.GetValues(typeof(Enums.ClientSession)).Cast<Enums.ClientSession>().ToList();
                RemoveSession(Enums.ChartSession.GraphCollection);
                RemoveSession(Enums.EmployeeSession.EmployeesList);
                ClearAllSessions(list);
            }

            //if (SessionHasValue(Enums.ClientSession.PlanPopUpID))
            //   planFocusedRow = CommonMethods.ParseInt(GetValueFromSession(Enums.ClientSession.PlanPopUpID).ToString());

            //if (SessionHasValue(Enums.ClientSession.ContactPersonPopUp))
            //  contactPersonFocusedRow = CommonMethods.ParseInt(GetValueFromSession(Enums.ClientSession.ContactPersonPopUp).ToString());

            this.Master.DisableNavBar = true;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Initialize();
                if (action == (int)Enums.UserAction.Edit || action == (int)Enums.UserAction.Delete)
                {
                    if (eventID > 0)
                    {
                        if (PrincipalHelper.IsUserSuperAdmin() || PrincipalHelper.IsUserAdmin())
                            model = CheckModelValidation<EventFullModel>(GetDatabaseConnectionInstance().GetEvent(eventID));
                        else
                        {//this else checks if the signed in user actually have rights to edit this client!
                            model = CheckModelValidation<EventFullModel>(GetDatabaseConnectionInstance().GetEvent(eventID, PrincipalHelper.GetUserPrincipal().ID));
                            if (model == null) RedirectHome();
                        }

                        if (model != null)
                        {
                            GetEventDataProviderInstance().SetEventFullModel(model);
                            FillForm();

                            if (isReferallClient)
                                SetFormValuesForclientReferall();
                        }
                        //This popup shows if we set the session ShowWarning
                        ShowWarningPopUp("'Dogodka še niste shranili. Da zaključite shranjevanje dogodka pritisnite OK!'");
                    }
                }
                else if (action == (int)Enums.UserAction.Add)
                {
                    SetFormDefaultValues();

                    if (isReferallClient)
                        SetFormValuesForclientReferall();
                }
                InitializeEditDeleteButtons();
                UserActionConfirmBtnUpdate(btnConfirm, action);
            }
            else
            {
                if (model == null && SessionHasValue(Enums.EventSession.EventModel))
                    model = GetEventDataProviderInstance().GetEventFullModel();
                else if (isReferallClient)//When adding event through client we need to restore values.
                    SetFormValuesForclientReferall();
            }

            /*if (planFocusedRow > 0)
            {
                ASPxGridViewPlan.FocusedRowIndex = ASPxGridViewPlan.FindVisibleIndexByKeyValue(planFocusedRow);
                ASPxGridViewPlan.ScrollToVisibleIndexOnClient = ASPxGridViewPlan.FindVisibleIndexByKeyValue(planFocusedRow);
            }*/

        }

        private void FillForm()
        {
            txtIdDogodek.Text = model.idDogodek.ToString();

            ASPxGridLookupStranke.Value = model.idStranka > 0 ? model.idStranka : -1;
            ASPxGridLookupKategorije.Value = model.idKategorija > 0 ? model.idKategorija : -1;
            ASPxGridLookupSkrbnik.Value = model.Skrbnik > 0 ? model.Skrbnik : -1;
            ASPxGridLookupIzvajalec.Value = model.Izvajalec > 0 ? model.Izvajalec : -1;
            ASPxGridLookupStatus.Value = model.idStatus > 0 ? model.idStatus : -1;

            ASPxDateEditDatumOtvoritve.Date = model.DatumOtvoritve;
            ASPxDateEditDatumRok.Date = model.Rok;
            txtDatumZadnjegaZaprtja.Text = model.DatumZadZaprtja;
            ASPxMemoOpis.Text = model.Opis;

            ComboBoxTipDogodka.SelectedIndex = !String.IsNullOrEmpty(model.Tip)? ComboBoxTipDogodka.Items.IndexOfValue(model.Tip) : 0;
            ASPxDateEditDatumRokIzvedbe.Date = model.RokIzvedbe.GetValueOrDefault();

            ASPxGridViewMessage.DataBind();
            ASPxGridView_Sestanek.DataBind();

            ASPxRoundPanel1.HeaderText = "Dogodek - " + (model.Stranka != null ? model.Stranka.NazivPrvi : "");
        }

        private bool AddOrEditEntityObject(bool add = false)
        {
            if (add)
            {
                model = new EventFullModel();

                model.idDogodek = 0;
                model.ts = DateTime.Now;
                model.tsIDOsebe = PrincipalHelper.GetUserPrincipal().ID;
            }
            else if (model == null && !add)
            {
                model = GetEventDataProviderInstance().GetEventFullModel();
            }
            model.idStranka = CommonMethods.ParseNullableInt(GetGridLookupValue(ASPxGridLookupStranke));
            model.idKategorija = CommonMethods.ParseNullableInt(GetGridLookupValue(ASPxGridLookupKategorije));
            model.Skrbnik = CommonMethods.ParseNullableInt(GetGridLookupValue(ASPxGridLookupSkrbnik));
            model.Izvajalec = CommonMethods.ParseNullableInt(GetGridLookupValue(ASPxGridLookupIzvajalec));
            model.idStatus = CommonMethods.ParseNullableInt(GetGridLookupValue(ASPxGridLookupStatus));
            model.DatumOtvoritve = ASPxDateEditDatumOtvoritve.Date;
            model.Rok = ASPxDateEditDatumRok.Date.Equals(DateTime.MinValue) ? DateTime.Now : ASPxDateEditDatumRok.Date;
            model.DatumZadZaprtja = txtDatumZadnjegaZaprtja.Text;
            model.Opis = ASPxMemoOpis.Text;
            model.Tip = ComboBoxTipDogodka.Value != null ? ComboBoxTipDogodka.Value.ToString() : "";
            model.RokIzvedbe = !ASPxDateEditDatumRokIzvedbe.Date.Equals(DateTime.MinValue) ? ASPxDateEditDatumRokIzvedbe.Date : (DateTime?)null;

            if (SessionHasValue(Enums.EventSession.SendEmail) && GetBoolValueFromSession(Enums.EventSession.SendEmail))
            {
                EmailMessageModel messageEvent = new EmailMessageModel()
                {
                    ID = 0,
                    Code = DatabaseWebService.Common.Enums.Enums.SystemMessageEventCodes.EVENT_DOGODEK.ToString(),
                    MasterID = model.idDogodek,
                    Status = (int)DatabaseWebService.Common.Enums.Enums.SystemMessageEventStatus.UnProcessed,
                    ts = DateTime.Now,
                    tsIDOsebe = PrincipalHelper.GetUserPrincipal().ID
                };
                model.emailModel = messageEvent;

                RemoveSession(Enums.EventSession.SendEmail);
            }

            EventFullModel returnModel = CheckModelValidation(GetDatabaseConnectionInstance().SaveEventChanges(model));

            if (returnModel != null)
            {
                //this we need if we want to add new client and then go and add new Plan with no redirection to Clients page
                GetEventDataProviderInstance().SetEventFullModel(returnModel);

                //TODO: ADD new item to session and if user has added new client and create data bind.
                return true;
            }
            else
                return false;
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            bool isValid = false;
            bool isDeleteing = false;

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
                    isDeleteing = true;
                    break;
            }

            if (isValid)
            {
                ClearSessionsAndRedirect(isDeleteing);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearSessionsAndRedirect();
        }

        private bool DeleteObject()
        {
            return CheckModelValidation(GetDatabaseConnectionInstance().DeleteEvent(eventID));
        }



        #region Message
        protected void MessageCallback_Callback(object sender, CallbackEventArgsBase e)
        {
            if (e.Parameter == "RefreshGrid")
            {
                InitializeEditDeleteButtons();
                ASPxGridViewMessage.DataBind();
            }
            else
            {
                object valueID = null;
                if (ASPxGridViewMessage.VisibleRowCount > 0)
                    valueID = ASPxGridViewMessage.GetRowValues(ASPxGridViewMessage.FocusedRowIndex, "idSporocila");

                bool isValid = SetSessionsAndOpenPopUp(e.Parameter, Enums.EventSession.MessagePopupID, valueID);
                if (isValid)
                    ASPxPopupControl_Message.ShowOnPageLoad = true;
            }
        }

        protected void ASPxGridViewMessage_DataBinding(object sender, EventArgs e)
        {
            (sender as ASPxGridView).DataSource = CreateMessagesDataSource();
        }

        private DataTable CreateMessagesDataSource()
        {
            DataTable dt = new DataTable();

            model = GetEventDataProviderInstance().GetEventFullModel();
            if (model != null)
            {
                dt = SerializeToDataTable(model.Sporocila);
            }

            return dt;
        }

        #endregion

        #region HelperMethods Local
        private bool CheckClientExistInDB()
        {
            model = GetEventDataProviderInstance().GetEventFullModel();

            if (model == null && eventID == 0)
            {
                bool isValid = AddOrEditEntityObject(true);
                if (isValid)
                {
                    int idEvent = GetEventDataProviderInstance().GetEventFullModel().idDogodek;
                    var nameValues = HttpUtility.ParseQueryString(Request.QueryString.ToString());
                    nameValues.Set(Enums.QueryStringName.recordId.ToString(), idEvent.ToString());
                    AddValueToSession(Enums.EventSession.SendEmail, true);
                    AddValueToSession(Enums.CommonSession.ShowWarning, true);
                    HideSpinnerLoader();
                    ASPxWebControl.RedirectOnCallback(GenerateURI("EventsForm.aspx", (int)Enums.UserAction.Edit, idEvent.ToString()));
                }
                return false;
            }

            return true;
        }


        private bool SetSessionsAndOpenPopUp(string eventParameter, Enums.EventSession sessionToWrite, object entityID)
        {
            int callbackResult = 0;
            int.TryParse(eventParameter, out callbackResult);
            if (callbackResult > 0 && callbackResult <= 3)
            {
                switch (callbackResult)
                {
                    case (int)Enums.UserAction.Add:
                        if (CheckClientExistInDB())
                        {
                            if (model.Sporocila == null || model.Sporocila.Count == 0)//For sending emails first time only.
                                AddValueToSession(Enums.EventSession.SendEmail, true);

                            AddValueToSession(Enums.CommonSession.UserActionPopUp, callbackResult);
                            AddValueToSession(sessionToWrite, 0);
                            AddValueToSession(Enums.EventSession.EventID, eventID);
                        }
                        break;

                    default://For editing and deleting is the same code.
                        AddValueToSession(Enums.CommonSession.UserActionPopUp.ToString(), callbackResult);
                        AddValueToSession(sessionToWrite, entityID);
                        AddValueToSession(Enums.EventSession.EventID, eventID);
                        break;

                }
                return true;
            }

            return false;
        }

        private void ClearSessionsAndRedirect(bool isIDDeleted = false)
        {
            QueryStrings item = new QueryStrings() { Attribute = Enums.QueryStringName.recordId.ToString(), Value = eventID.ToString() };
            string redirectString = "";

            if (isReferallClient)
            {
                List<QueryStrings> queryStrings = new List<QueryStrings>()
                {
                    new QueryStrings() { Attribute = Enums.QueryStringName.action.ToString(), Value =  ((int)Enums.UserAction.Edit).ToString() },
                    new QueryStrings() { Attribute = Enums.QueryStringName.recordId.ToString(), Value = clientID.ToString() },
                };
                redirectString = GenerateURI("../Clients/ClientsForm.aspx", queryStrings);
            }
            else if (isIDDeleted)
                redirectString = "Events.aspx";
            else
                redirectString = GenerateURI("Events.aspx", item);

            RemoveSession(Enums.EmployeeSession.EmployeesList);
            RemoveSession(Enums.CommonSession.UserActionPopUp);

            List<Enums.EventSession> list = Enum.GetValues(typeof(Enums.EventSession)).Cast<Enums.EventSession>().ToList();
            ClearAllSessions(list, redirectString);
        }



        private object GetGridLookupValue(ASPxGridLookup lookup)
        {
            try
            {
                return lookup.Value;
            }
            catch (Exception ex)
            {
                CommonMethods.LogThis(ex.Message + "\r\n" + ex.Source + "\r\n" + ex.StackTrace);
                return null;
            }
        }
        #endregion

        #region DataBindings
        protected void ASPxGridLookupStranke_DataBinding(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            if (PrincipalHelper.IsUserSuperAdmin() || PrincipalHelper.IsUserAdmin())
                dt = CheckModelValidation(GetDatabaseConnectionInstance().GetAllClients());
            else
                dt = CheckModelValidation(GetDatabaseConnectionInstance().GetAllClients(PrincipalHelper.GetUserPrincipal().ID));

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.NewRow();
                row["idStranka"] = -1;
                row["NazivPrvi"] = "Izberi...";
                row["NazivDrugi"] = "";
                dt.Rows.InsertAt(row, 0);

                (sender as ASPxGridLookup).DataSource = dt;
            }
            else
                ClearSessionsAndRedirect();
        }

        protected void ASPxGridLookupLoad_WidthMedium(object sender, EventArgs e)
        {
            (sender as ASPxGridLookup).GridView.Width = new Unit(500, UnitType.Pixel);
        }
        protected void ASPxGridLookupLoad_WidthLarge(object sender, EventArgs e)
        {
            (sender as ASPxGridLookup).GridView.Width = new Unit(700, UnitType.Pixel);
        }
        protected void ASPxGridLookupLoad_WidthSmall(object sender, EventArgs e)
        {
            (sender as ASPxGridLookup).GridView.Width = new Unit(300, UnitType.Pixel);
        }

        protected void ASPxGridLookupKategorije_DataBinding(object sender, EventArgs e)
        {
            List<CategorieModel> listModel = CheckModelValidation(GetDatabaseConnectionInstance().GetAllCategories());

            (sender as ASPxGridLookup).DataSource = SerializeToDataTable(listModel, "idKategorija", "Koda");
        }

        protected void ASPxGridLookupSkrbnik_DataBinding(object sender, EventArgs e)
        {
            List<EmployeeSimpleModel> listModel = new List<EmployeeSimpleModel>();

            listModel = CheckModelValidation(GetDatabaseConnectionInstance().GetEmployeeSupervisorByEmployeeID(PrincipalHelper.GetUserPrincipal().ID));
            if (listModel.Count > 0)//we select the first supervisor if he exit
            {
                supervisorID = listModel[0].idOsebe;
            }
            (sender as ASPxGridLookup).DataSource = SerializeToDataTable(listModel, "idOsebe", "Ime");
        }

        protected void ASPxGridLookupIzvajalec_DataBinding(object sender, EventArgs e)
        {
            List<EmployeeSimpleModel> listModel = CheckModelValidation(GetDatabaseConnectionInstance().GetAllCompanyEmployees());//3 => Salesman

            (sender as ASPxGridLookup).DataSource = SerializeToDataTable(listModel, "idOsebe", "Ime");

        }

        protected void ASPxGridLookupStatus_DataBinding(object sender, EventArgs e)
        {
            List<EventStatusModel> listModel = CheckModelValidation(GetDatabaseConnectionInstance().GetAllEventStatuses());

            (sender as ASPxGridLookup).DataSource = SerializeToDataTable(listModel, "idStatusDogodek", "Koda");
        }
        #endregion


        #region InitializationMethods
        private void Initialize()
        {
            ASPxGridLookupStranke.DataBind();
            ASPxGridLookupKategorije.DataBind();
            ASPxGridLookupSkrbnik.DataBind();
            ASPxGridLookupIzvajalec.DataBind();
            ASPxGridLookupStatus.DataBind();
            ASPxGridViewMessage.DataBind();

            if (PrincipalHelper.IsUserSalesman())
            {
                ASPxGridLookupIzvajalec.BackColor = Color.LightGray;
                ASPxGridLookupIzvajalec.ForeColor = Color.White;
                ASPxGridLookupIzvajalec.ReadOnly = true;
                //ASPxGridLookupIzvajalec.Enabled = false;

                ASPxGridLookupSkrbnik.BackColor = Color.LightGray;
                ASPxGridLookupSkrbnik.ForeColor = Color.White;
                ASPxGridLookupSkrbnik.ReadOnly = true;
                ASPxGridLookupSkrbnik.Enabled = false;
            }
        }

        private void SetFormDefaultValues()
        {
            ASPxGridLookupStranke.Value = -1;

            ASPxGridLookupKategorije.Value = -1;

            ASPxGridLookupSkrbnik.Value = -1;

            ASPxGridLookupIzvajalec.Value = -1;

            ASPxGridLookupStatus.Value = -1;

            ASPxDateEditDatumOtvoritve.Date = DateTime.Now;

            ComboBoxTipDogodka.SelectedIndex = 0;//Moj dogodek

            if (PrincipalHelper.IsUserSalesman())
            {
                ASPxGridLookupIzvajalec.Value = PrincipalHelper.GetUserPrincipal().ID;
                ASPxGridLookupSkrbnik.Value = supervisorID;
            }
        }

        private void SetFormValuesForclientReferall()
        {
            ASPxGridLookupStranke.Value = clientID;
            ASPxGridLookupKategorije.Value = categorieID;
            ASPxGridLookupIzvajalec.Value = employeeID;

            ASPxGridLookupStranke.BackColor = Color.LightGray;
            ASPxGridLookupStranke.ForeColor = Color.White;
            ASPxGridLookupStranke.ReadOnly = true;
            //ASPxGridLookupStranke.Enabled = false;

            if (categorieID > 0)
            {
                ASPxGridLookupKategorije.BackColor = Color.LightGray;
                ASPxGridLookupKategorije.ForeColor = Color.White;
                ASPxGridLookupKategorije.ReadOnly = true;
                //ASPxGridLookupKategorije.Enabled = false;
            }

            ASPxGridLookupIzvajalec.BackColor = Color.LightGray;
            ASPxGridLookupIzvajalec.ForeColor = Color.White;
            ASPxGridLookupIzvajalec.ReadOnly = true;
            //ASPxGridLookupIzvajalec.Enabled = false;
        }

        private void InitializeEditDeleteButtons()
        {
            //Check to enable Edit and Delete button for Tab PLAN
            if (model == null || model.Sporocila == null || model.Sporocila.Count <= 0)
            {
                EnabledDeleteAndEditBtnPopUp(btnEditMessage, btnDeleteMessage);
            }
            else if (!btnEditMessage.Enabled && !btnDeleteMessage.Enabled)
            {
                EnabledDeleteAndEditBtnPopUp(btnEditMessage, btnDeleteMessage, false);
            }
        }
        #endregion

        #region EventMeetings

        protected void ASPxGridView_Sestanek_DataBinding(object sender, EventArgs e)
        {
            (sender as ASPxGridView).DataSource = CreateMeetingDataSource();
        }

        protected void CallbackPanelMeeting_Callback(object sender, CallbackEventArgsBase e)
        {
            bool isValid = false;
            if (action == (int)Enums.UserAction.Add)
            {
                isValid = AddOrEditEntityObject(true);
            }

            EventMeetingModel model = new EventMeetingModel();
            model.DogodekID = GetEventDataProviderInstance().GetEventFullModel().idDogodek;
            model.Datum = DateTime.Now;
            model.tsIDOsebe = PrincipalHelper.GetUserPrincipal().ID;

            if (e.Parameter.Equals(Enums.EventMeetingType.PRIPRAVA.ToString()))
            {
                model.Opis = htmlPriprava.Html;
                model.Tip = Enums.EventMeetingType.PRIPRAVA.ToString();

            }
            else if (e.Parameter.Equals(Enums.EventMeetingType.POROCILO.ToString()))
            {
                model.Opis = htmlPorocilo.Html;
                model.Tip = Enums.EventMeetingType.POROCILO.ToString();
            }

            EventMeetingModel newModel = CheckModelValidation(GetDatabaseConnectionInstance().SaveEventMeetingChanges(model));
            if (newModel != null)
            {
                GetEventDataProviderInstance().AddEventMeetingToEventModelSession(newModel);
            }
            else
                ShowClientPopUp("Commit save failed");
                        

            if (isValid)
            {
                int idEvent = GetEventDataProviderInstance().GetEventFullModel().idDogodek;
                AddValueToSession(Enums.CommonSession.ShowWarning, true);
                ASPxWebControl.RedirectOnCallback(GenerateURI("EventsForm.aspx", (int)Enums.UserAction.Edit, idEvent.ToString()));
            }
            else
                ASPxGridView_Sestanek.DataBind();
        }

        private DataTable CreateMeetingDataSource()
        {
            DataTable dt = new DataTable();

            model = GetEventDataProviderInstance().GetEventFullModel();
            if (model != null)
            {
                dt = SerializeToDataTable(model.SestanekDokumenti);

                if (model.SestanekDokumenti.Count > 0)
                    ASPxGridView_Sestanek.Visible = true;//default value is visible=false
            }

            return dt;
        }

        protected void ASPxGridView_Sestanek_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
        {
            if (e.RowType != GridViewRowType.Data) return;

            e.Row.BackColor = Color.AliceBlue;

            idPorociloSection.Style.Add("display", "flex");
            string tip = e.GetValue("Tip").ToString();
            if (tip.Equals(Enums.EventMeetingType.POROCILO.ToString()))
            {
                idPripravaSection.Style.Add("display", "none");
                e.Row.BackColor = Color.AntiqueWhite; 
            }
        }

        #endregion
    }
}