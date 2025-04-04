using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MP_Grub
{
	public partial class Main : System.Web.UI.MasterPage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            if (!IsPostBack)
            {
                if (Session["UserID"] != null && Session["Username"] != null)
                {
                    string username = Session["Username"].ToString();

                    welcomeLabel.Text = "Hi, " + username + "!";
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void Bookmark_Click(object sender, ImageClickEventArgs e)
        {
            if (Session["UserID"] != null)
            {
                string userID = Session["UserID"].ToString();
                Response.Redirect("~/BookmarkedItems.aspx?userID=" + userID);
            }
            else
            {
                string script = "alert('You are not logged in. Please log in first.'); window.location='Login.aspx';";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "LoginAlert", script, true);
                Response.Redirect("~/Login.aspx");
            }
        }
        protected void AddToCart_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/CartItems.aspx");
        }
        protected void Button_Logout(object sender, EventArgs e)
        {

            Response.Redirect("~/Logout.aspx");
        }
    }
}