using AnalizaProdaje.Common;
using AnalizaProdaje.Domain.Helpers;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnalizaProdaje
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        private bool disableNavBar;
        private bool reSignin;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsAuthenticated)
            {
                Session["MainMenuSaleAnalysis"] = AppDomain.CurrentDomain.BaseDirectory + "App_Data\\Nav_bar\\MainMenu.xml";
                UsernameLabel.Text = PrincipalHelper.GetUserPrincipal().firstName + " " + PrincipalHelper.GetUserPrincipal().lastName;
                SignedInHelloLabel.Visible = true;
                UserRoleLabel.Visible = true;
                SignedInAsLabel.Visible = true;
                UserRoleLabel.Text = PrincipalHelper.GetUserPrincipal().RoleName;
                ASPxNavBarMainMenu.Visible = true;
                SetMainMenuBySignInRole();

                if (!String.IsNullOrEmpty(PrincipalHelper.GetUserPrincipal().ProfileImage))
                    headerProfileImage.Src = PrincipalHelper.GetUserPrincipal().ProfileImage.Replace(AppDomain.CurrentDomain.BaseDirectory, "\\");
                else
                    headerProfileImage.Src = "/Images/Profile5.png";
            }
            else
            {
                ASPxNavBarMainMenu.Visible = false;
                UsernameLabel.Text = "";
                UserRoleLabel.Visible = false;
                SignedInAsLabel.Visible = false;
                SignedInHelloLabel.Visible = false;


                //Session["PreviousPage"] = Request.RawUrl;
                ASPxPopupControl_PonovnaPrijava.ShowOnPageLoad = true;

            }


            ASPxNavBarMainMenu.DataBind();
        }

        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session["MainMenuSaleAnalysis"] = null;
            Session.RemoveAll();
            Response.Redirect("~/Default.aspx");
        }

        private void SetMainMenuBySignInRole()
        {
            if (PrincipalHelper.IsUserSuperAdmin())
            {
                SetXmlDataSourceSetttings(Enums.UserRole.SuperAdmin.ToString());
            }
            else if (PrincipalHelper.IsUserAdmin())
            {
                SetXmlDataSourceSetttings(Enums.UserRole.Admin.ToString());
            }
            else if (PrincipalHelper.IsUserSalesman())
            {
                SetXmlDataSourceSetttings(Enums.UserRole.Salesman.ToString());
            }
            else
            {
                SetXmlDataSourceSetttings(Enums.UserRole.User.ToString());
            }
        }

        private void SetXmlDataSourceSetttings(string userRole)
        {
            XmlDataSource1.DataFile = Session["MainMenuSaleAnalysis"].ToString();
            XmlDataSource1.XPath = "GlavniMenu/" + userRole + "/Oddelek";

            if (!DisableNavBar)
                ASPxNavBarMainMenu.Enabled = true;
            else
                ASPxNavBarMainMenu.Enabled = false;
        }

        public bool DisableNavBar
        {
            get { return disableNavBar; }
            set { disableNavBar = value; }
        }

        public bool ReSignIn
        {
            get { return reSignin; }
            set { reSignin = value; }
        }

        protected void ReportErrorBtnClick_Click(object sender, EventArgs e)
        {
            ASPxPopupControl_ReportErrorToDeveloper.ShowOnPageLoad = true;
        }
    }
}