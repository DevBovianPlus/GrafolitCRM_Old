using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnalizaProdaje.UserControls.Widgets
{
    public partial class DateTimeWidget : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DateLabel.Text = DateTime.Now.ToString("dddd, dd. MMMM yyyy", new CultureInfo("sl-SI"));
        }
    }
}