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
                
                if (Session["UserID"] == null)
                {
                    Response.Redirect("Login.aspx"); 
                }
            }
        }

        protected void ContinueToDetails(object sender, EventArgs e)
        {
            Session["SelectedIssue"] = issueDropdown.SelectedValue;
            Session["UserID"] = Session["UserID"];
            Response.Redirect("SpecificIssues.aspx");
        }

        protected void CancelProcess(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

    }
}
