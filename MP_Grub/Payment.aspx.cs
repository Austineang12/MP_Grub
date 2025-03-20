using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Windows.Forms;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;
using System.Xml.Linq;

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
            Response.Redirect("Home.aspx"); // link to feedback
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Response.Redirect("OrderConfirmation.aspx"); //link to kerk's page

            //OleDbConnection conn = new OleDbConnection(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Users\USER\Documents\Github\MP_Grub\MP_Grub\App_Data\GrubDB.mdb""");
            ////CHANGE THIS DEPENDING ON THE NEW PLACEMENT OF GRUB.MDB FILE

            //// Capture form values
            //string fullName = txtFullName.Text;
            //string contactNo = txtContactNo.Text;
            //string buildingName = ddlBuilding.SelectedItem.Value;
            //string floorNumber = ddlFloorNumber.SelectedItem.Value;
            //string roomName = txtRoomNo.Text;
            //string note = txtNote.Text;
            //string paymentType = ddlTransaction.SelectedItem.Text;
            //decimal totalAmount = 0;

            //// Validate and convert total price to decimal
            //if (!decimal.TryParse(totalPrice.Text.Replace("₱", "").Trim(), out totalAmount))
            //{
            //    return;
            //}


            //try
            //{
            //    conn.Open();
            //    OleDbCommand cmd = conn.CreateCommand();
            //    cmd.CommandType = System.Data.CommandType.Text; 
            //    cmd.CommandText = "INSERT INTO [Transaction] (User_ID, Restaurant_ID, Payment_Type, Transaction_Time, Transaction_Status, Voucher_ID, Total_Price) " +
            //       "VALUES ('" + 1 + "', '" + 24 + "', '" + paymentType + "', '" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "', '" + "Pending" + "', " +
            //       123 + ", '" + totalPrice + "')";

            //    cmd.ExecuteNonQuery();

            //    MessageBox.Show("Transaction saved successfully!", "Order Status", MessageBoxButtons.OK, MessageBoxIcon.Information);
            //    conn.Close();
            //}
            //catch (Exception ex)
            //{
            //    MessageBox.Show(ex.Message, "Something went wrong", MessageBoxButtons.OK, MessageBoxIcon.Error);
            //    conn.Close();
            //}

        }
    }
}