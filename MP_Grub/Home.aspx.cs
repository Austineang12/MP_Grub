using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MP_Grub
{
	public partial class Home : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            if (!IsPostBack)
            {
                if (Session["UserID"] != null && Session["Username"] != null)
                {
                    string username = Session["Username"].ToString();

                    welcomeLabel.Text = "Welcome, " + username + "!";
                }
                else
                {
                    Response.Redirect("Login.aspx"); 
                }
            }

        }
        protected void Navigation_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Navigation.aspx");
        }
        protected void Button_OrderNow(object sender, EventArgs e)
        {
            Response.Redirect("~/Order.aspx");
        }
    }
}