using AnalizaProdaje.Common;
using DatabaseWebService.Models.FinancialControl;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace AnalizaProdaje.Pages.Display
{
    public partial class FinancialControl : ServerMasterPage
    {
        FinancialControlModel model = null;
        protected void Page_Init(object sender, EventArgs e)
        {
            string intervalInSeconds = WebConfigurationManager.AppSettings["IntervalFinancialControl"].ToString();
            Response.AppendHeader("Refresh", intervalInSeconds);
        }
        protected void Page_Load(object sender, EventArgs e)
        {            
            LastPageUpdate.Text = DateTime.Now.ToString("dd. MMMM yyyy - HH:mm:ss");

            model = CheckModelValidation(GetDatabaseConnectionInstance().GetFinancialControlData());
            if (model != null)
                FillForm();
        }

        private void FillForm()
        {
            
            txtDobavitelji.Text = model.Dobavitelji.ToString("N2");
            SetInputField(Decimal.Compare(model.Dobavitelji, 0) < 0, Decimal.Compare(model.Dobavitelji, 0) == 0, txtDobavitelji, imgDobavitelji);

            txtDobicek.Text = model.Dobicek.ToString("N2");
            SetInputField(Decimal.Compare(model.Dobicek, 0) < 0, Decimal.Compare(model.Dobicek, 0) == 0, txtDobicek, imgDobicek);

            txtInvesticije.Text = model.Investicije.ToString("N2");//vedno rdeče - brez puščice
            txtInvesticije.BackColor = ColorTranslator.FromHtml("#FF7A7A");
            //SetInputField(Decimal.Compare(model.Investicije, 0) < 0, Decimal.Compare(model.Investicije, 0) == 0, txtInvesticije, imgInvesticije);

            txtInvesticijskoVzdrzevanje.Text = model.Investicijsko_vzdrzevanje.ToString("N2");//oranžno - brez puščice
            txtInvesticijskoVzdrzevanje.BackColor = ColorTranslator.FromHtml(WebConfigurationManager.AppSettings["ColorOrange"].ToString());
            //SetInputField(Decimal.Compare(model.Investicijsko_vzdrzevanje, 0) < 0, Decimal.Compare(model.Investicijsko_vzdrzevanje, 0) == 0, txtInvesticijskoVzdrzevanje, imgInvestVzdrze);

            txtKrediti.Text = model.Krediti.ToString("N2");
            SetInputField(Decimal.Compare(model.Krediti, 0) < 0, Decimal.Compare(model.Krediti, 0) == 0, txtKrediti, imgKrediti);

            txtKupci.Text = model.Kupci.ToString("N2");
            SetInputField(Decimal.Compare(model.Kupci, 0) < 0, Decimal.Compare(model.Kupci, 0) == 0, txtKupci, imgKupci);

            txtSkupaj.Text = model.Skupaj.ToString("N2");
            SetInputField(Decimal.Compare(model.Skupaj, 0) < 0, Decimal.Compare(model.Skupaj, 0) == 0, txtSkupaj, imgSkupaj);

            txtZaloga.Text = model.Zaloga.ToString("N2");
            SetInputField(Decimal.Compare(model.Zaloga, 0) < 0, Decimal.Compare(model.Zaloga, 0) == 0, txtZaloga, imgZaloga);

            txtStDniDobavitelji.Text = model.StDniDobavitelji.ToString();
            SetInputField(model.StDniDobavitelji < 0, model.StDniDobavitelji == 0, txtStDniDobavitelji, imgStDniDobavitelji);

            //Posebnost
            txtStDniKupci.Text = model.StDniKupci.ToString();
            SetInputField(model.StDniKupci > 0, model.StDniKupci == 0, txtStDniKupci, imgStDniKupci);
        }

        private void SetInputField(bool isInRedArea, bool isNeutral, ASPxTextBox inputField, HtmlImage img)
        {
            string red = WebConfigurationManager.AppSettings["ColorRed"].ToString();
            string green = WebConfigurationManager.AppSettings["ColorGreen"].ToString();

            if (!isNeutral && isInRedArea)
            {
                inputField.BackColor = ColorTranslator.FromHtml(red);
                img.Src = "../../Images/arrowDown.png";
            }
            else if (!isNeutral && !isInRedArea)//value is in green area
            {
                inputField.BackColor = ColorTranslator.FromHtml(green);
                img.Src = "../../Images/arrowUp.png";
            }
            else if (isNeutral)
            {
                img.Src = "../../Images/arrowNeutral.png";
            }
        }
    }
}