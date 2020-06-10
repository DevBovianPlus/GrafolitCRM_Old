using AnalizaProdaje.Common;
using AnalizaProdaje.Domain.Concrete;
using AnalizaProdaje.Domain.Helpers;
using DatabaseWebService.Models;
using DatabaseWebService.Models.Employee;
using DevExpress.Web;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnalizaProdaje.Pages.UserInfo
{
    public partial class UserData : ServerMasterPage
    {
        EmployeeFullModel model = null;
        int employeeID = -1;
        int action = -1;
        bool pasOrUsernameChanged = false;

        protected void Page_Init(object sender, EventArgs e)
        {
            action = 2;
            employeeID = PrincipalHelper.GetUserPrincipal().ID;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ComboBoxVloga.DataBind();

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

                if (!PrincipalHelper.IsUserSuperAdmin())
                {
                    ComboBoxVloga.Enabled = false;
                    ComboBoxVloga.BackColor = Color.LightGray;
                    ComboBoxVloga.ForeColor = Color.White;
                    txtDelovnoMesto.ReadOnly = true;
                    txtDelovnoMesto.BackColor = Color.LightGray;
                    ASPxDateEditDatumZaposlitve.ReadOnly = true;
                    ASPxDateEditDatumZaposlitve.Enabled = false;
                    ASPxDateEditDatumZaposlitve.BackColor = Color.LightGray;
                }

                UserActionConfirmBtnUpdate(btnConfirm, action);
            }
        }

        private void FillForm()
        {
            txtIme.Text = model.Ime;
            txtPriimek.Text = model.Priimek;
            txtNaslov.Text = model.Naslov;
            ASPxDateEditDatumRojstva.Date = model.DatumRojstva > DateTime.MinValue ? model.DatumRojstva : DateTime.MinValue;
            txtUporabniskoIme.Text = model.UporabniskoIme;
            txtGesloVnos.Text = model.Geslo;

            txtEmail.Text = model.Email;
            txtTelefon.Text = model.TelefonGSM;


            ComboBoxVloga.SelectedIndex = model.idVloga > 0 ? ComboBoxVloga.Items.IndexOfValue(model.idVloga.ToString()) : 0;
            ASPxDateEditDatumZaposlitve.Date = model.DatumZaposlitve > DateTime.MinValue ? model.DatumZaposlitve : DateTime.MinValue;
            txtDelovnoMesto.Text = model.DelovnoMesto;

            
            //TODO:ADD EMPLOYEE PICTURE
            if (!String.IsNullOrEmpty(model.ProfileImage))
                uploadedImage.Src = model.ProfileImage.Replace(AppDomain.CurrentDomain.BaseDirectory, "\\");
            else
            {
                uploadedImage.Src = "/Images/Profile5.png";
                clearImage.Style.Add("display", "none");
            }

        }

        private bool AddOrEditEntityObject(bool add = false)
        {
            if (model == null && !add)
            {
                model = GetEmployeeDataProviderInstance().GetFullEmployeeModel();
            }

            if (!model.UporabniskoIme.Equals(txtUporabniskoIme.Text) || !model.Geslo.Equals(txtGesloVnos.Text))//If username or password was changed wee need to sign out!
                pasOrUsernameChanged = true;

            if (PrincipalHelper.IsUserSuperAdmin())
            {
                model.idVloga = CommonMethods.ParseInt(ComboBoxVloga.Value);
                model.DatumZaposlitve = ASPxDateEditDatumZaposlitve.Date;
                model.DelovnoMesto = txtDelovnoMesto.Text;
            }

            model.Ime = txtIme.Text;
            model.Priimek = txtPriimek.Text;
            model.Naslov = txtNaslov.Text;
            model.DatumRojstva = ASPxDateEditDatumRojstva.Date;
            model.Email = txtEmail.Text;
            model.TelefonGSM = txtTelefon.Text;
            model.Email = txtEmail.Text;
            model.UporabniskoIme = txtUporabniskoIme.Text;
            model.Geslo = txtGesloVnos.Text;

            EmployeeFullModel newModel = CheckModelValidation(GetDatabaseConnectionInstance().SaveEmployeeChanges(model));

            if (newModel != null)//If new record is added we need to refresh aspxgridview. We add new record to session model.
            {
                uploadedImage.Src = newModel.ProfileImage.Replace(AppDomain.CurrentDomain.BaseDirectory, "\\");

                return true;
            }
            else
            {
                return false;
            }
        }



        protected void UploadControl_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            string profileImagesPath = AppDomain.CurrentDomain.BaseDirectory + "ProfileImages";
            if (!Directory.Exists(profileImagesPath))
                Directory.CreateDirectory(profileImagesPath);

            string path = Path.Combine(profileImagesPath, e.UploadedFile.FileName);
            e.UploadedFile.SaveAs(path);
            e.CallbackData = e.UploadedFile.FileName;

            if (model != null)
                model.ProfileImage = e.UploadedFile.FileName;
            else
                GetEmployeeDataProviderInstance().GetFullEmployeeModel().ProfileImage = path;
        }

        protected void ComboBoxVloga_DataBinding(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();

            List<RoleModel> roles = CheckModelValidation<List<RoleModel>>(GetDatabaseConnectionInstance().GetAllRoles());

            if (roles != null)
            {
                ComboBoxVloga.DataSource = SerializeToDataTable(roles, "idVloga", "Koda");
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            bool isValid = false;

            switch (action)
            {
                case (int)Enums.UserAction.Edit:
                    isValid = AddOrEditEntityObject();
                    break;
            }

            if (isValid)
            {
                RemoveSession(Enums.EmployeeSession.EmployeeFullModel);

                if (pasOrUsernameChanged)
                {
                    Session["PreviousPage"] = Request.RawUrl;
                    FormsAuthentication.SignOut();
                    Session["MainMenuSaleAnalysis"] = null;
                }
                Response.Redirect("~/Default.aspx");
            }
            else
                ShowClientPopUp("Something went wrong. Contact administrator", 1);
        }

        protected void ClearImageCallback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            GetEmployeeDataProviderInstance().GetFullEmployeeModel().ProfileImage = "";
            e.Result = "/Images/Profile5.png";
        }
    }
}