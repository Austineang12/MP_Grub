using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MP_Grub
{
    public partial class Payment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            txtFullName.Text = "";
            txtContactNo.Text = "";
            ddlBuilding.SelectedIndex = 0;
            ddlFloorNumber.SelectedIndex = 0;
            txtRoomNo.Text = string.Empty;
            txtNote.Text = string.Empty;
            ddlTransaction.SelectedIndex = 0;
            txtDiscount.Text = string.Empty;
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}