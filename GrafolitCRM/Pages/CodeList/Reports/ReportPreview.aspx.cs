using AnalizaProdaje.Common;
using AnalizaProdaje.Pages.CodeList.Reports;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnalizaProdaje.Pages.CodeList.Reports
{
    public partial class ReportPreview : ServerMasterPage
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            this.Master.DisableNavBar = true;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Izpis grafa";

            ChartReport report = new ChartReport(GetClientDataProviderInstance().GetGraphBindingList(),
                GetClientDataProviderInstance().GetFullModelFromClientModel());
            report.CreateDocument();
            ReportViewer1.Report = report;
		}
	}
}