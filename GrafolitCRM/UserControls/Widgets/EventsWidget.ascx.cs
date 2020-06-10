using AnalizaProdaje.Domain.Helpers;
using DatabaseWebService.Models.Client;
using DevExpress.Web;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnalizaProdaje.UserControls.Widgets
{
    public partial class EventsWidget : System.Web.UI.UserControl
    {
        public DataTable eventData { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (eventData != null && eventData.Rows.Count < 1)
            {
                lblNoData.Visible = true;
                Repeater.Visible = false;
            }
            else
                Repeater.DataBind();
        }

        protected void Repeater_DataBinding(object sender, EventArgs e)
        {
            Repeater.DataSource = eventData;
        }
    }
}