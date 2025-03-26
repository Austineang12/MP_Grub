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

		}

        protected void Bookmark_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/BookmarkedItems.aspx");
        }
        protected void AddToCart_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/CartItems.aspx");
        }
    }
}