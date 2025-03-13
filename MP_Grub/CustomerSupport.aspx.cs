using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MP_Grub
{
    public partial class CustomerSupport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ticketNumber.Text = "Report-" + GenerateTicketNumber();
            }
        }

        protected void ContinueToDetails(object sender, EventArgs e)
        {
            Session["SelectedIssue"] = issueDropdown.SelectedValue;
            Response.Redirect("SpecificIssues.aspx");
        }

        protected void CancelProcess(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        private string GenerateTicketNumber()
        {
            return new Random().Next(1000, 9999).ToString();
        }
    }
}
