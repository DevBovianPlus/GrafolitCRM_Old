using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnalizaProdaje
{
    public partial class HelloMasterPage : System.Web.UI.MasterPage
    {
        public event EventHandler LoginButtonEvent;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            if (LoginButtonEvent != null)
                LoginButtonEvent(this, EventArgs.Empty);
        }
    }
}