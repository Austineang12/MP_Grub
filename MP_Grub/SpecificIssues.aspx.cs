using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MP_Grub
{
    public partial class SpecificIssues : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
            }
        }

        protected void SkipToConfirmation(object sender, EventArgs e)
        {
            Response.Redirect("ConfirmIssue.aspx");
        }

        protected void ContinueToConfirmation(object sender, EventArgs e)
        {
            Response.Redirect("ConfirmIssue.aspx");
        }

        protected void CancelProcess(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}
