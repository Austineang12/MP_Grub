using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MP_Grub
{
    public partial class OrderConfirmation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnOrderDetails_Click(object sender, EventArgs e)
        {
            Response.Redirect("Order.aspx"); // go back to austine's page after submitting info to database or REMOVE THIS PARA DONE LANG NAKALAGAY
        }

        protected void btnDone_Click(object sender, EventArgs e)
        {
            Response.Redirect("ThankYou.aspx"); //to leave review
        }
    }
}