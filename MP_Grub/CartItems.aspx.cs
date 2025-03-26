using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MP_Grub
{
    public partial class CartItems : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e )
        {
            //if (!IsPostBack)
            //{
            //    lblQuantity.Text = "1";
            //}
        }
        protected void btnCancel_Button(object sender, EventArgs e)
        {
            Response.Redirect("~/Home.aspx");
        }
        protected void btnPayment_Button(object sender, EventArgs e)
        {
            Response.Redirect("~/Payment.aspx");
        }
    }
}