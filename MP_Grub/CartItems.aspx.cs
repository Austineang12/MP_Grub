using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;

namespace MP_Grub
{
    public partial class CartItems : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCartItems();
                LoadVouchers();
            }
        }

        private void LoadCartItems()
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);

            using (OleDbConnection conn = new OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|/GrubDB.accdb"))
            {
                string query = @"
                    SELECT Food.Food_ID, Food.Food_Name, Food.Food_Price, Restaurant.Restaurant_Name, Order_Detail.Order_Quantity 
                    FROM ((Order_Detail
                    INNER JOIN Food ON Order_Detail.Food_ID = Food.Food_ID)
                    INNER JOIN Restaurant ON Food.Restaurant_ID = Restaurant.Restaurant_ID)
                    INNER JOIN [Transaction] ON Order_Detail.Transaction_ID = [Transaction].Transaction_ID
                    WHERE [Transaction].User_ID = ? AND [Transaction].Transaction_Status = 'Pending'";

                try
                {
                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@User_ID", userId);
                        conn.Open();

                        using (OleDbDataAdapter adapter = new OleDbDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);

                            rptCartItems.DataSource = dt;
                            rptCartItems.DataBind();
                            pnlCart.Visible = dt.Rows.Count > 0;
                            pnlEmptyCart.Visible = dt.Rows.Count == 0;

                            CalculateSummary(dt);
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("An error occurred: " + ex.Message);
                }
            }
        }

        private void LoadVouchers()
        {
            if (Session["UserID"] == null)
                return;

            int userId = Convert.ToInt32(Session["UserID"]);

            using (OleDbConnection conn = new OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|/GrubDB.accdb"))
            {
                string query = "SELECT TOP 1 Voucher_ID, Voucher_Name, Voucher_Value FROM Voucher WHERE User_ID = ? ORDER BY Voucher_ID DESC";

                try
                {
                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@User_ID", userId);
                        conn.Open();

                        using (OleDbDataReader reader = cmd.ExecuteReader())
                        {
                            Voucher_Dropdown.Items.Clear();
                            Voucher_Dropdown.Items.Add(new ListItem("Select a Voucher", ""));

                            if (reader.Read())
                            {
                                Session["Voucher_ID"] = reader["Voucher_ID"];
                                Session["Voucher_Value"] = Convert.ToDecimal(reader["Voucher_Value"]);
                                Voucher_Dropdown.Items.Add(new ListItem(reader["Voucher_Name"].ToString(), reader["Voucher_ID"].ToString()));
                            }
                            else
                            {
                                Voucher_Dropdown.Items.Add(new ListItem("No Vouchers Available", ""));
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("An error occurred while loading vouchers: " + ex.Message);
                }
            }
        }

        private void CalculateSummary(DataTable dt)
        {
            decimal orderFee = 0;
            foreach (DataRow row in dt.Rows)
            {
                orderFee += Convert.ToDecimal(row["Food_Price"]) * Convert.ToInt32(row["Order_Quantity"]);
            }

            decimal deliveryFee = 30.00m;
            decimal discountValue = 0;

            if (Session["Voucher_Value"] != null)
            {
                decimal voucherValue = Convert.ToDecimal(Session["Voucher_Value"]);
                discountValue = orderFee * voucherValue;
            }

            decimal totalAmount = orderFee + deliveryFee - discountValue;

            lblOrderFee.Text = orderFee.ToString("0.00");
            lblDeliveryFee.Text = deliveryFee.ToString("0.00");
            lblDiscountValue.Text = discountValue.ToString("0.00");
            lblTotalAmount.Text = totalAmount.ToString("0.00");
        }

        protected void ddlVoucher_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadVouchers();
            LoadCartItems();
        }

        private void UpdateQuantity(int foodId, int change)
        {
            using (OleDbConnection conn = new OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|/GrubDB.accdb"))
            {
                string query = @"UPDATE Order_Detail SET Order_Quantity = Order_Quantity + ? 
                                  WHERE Food_ID = ? AND Order_Quantity + ? BETWEEN 1 AND 50";
                try
                {
                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Change", change);
                        cmd.Parameters.AddWithValue("@Food_ID", foodId);
                        cmd.Parameters.AddWithValue("@Change2", change);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("Error: " + ex.Message);
                }
            }
            LoadCartItems();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            int foodId = Convert.ToInt32(((Button)sender).CommandArgument);
            UpdateQuantity(foodId, 1);
        }

        protected void btnSubtract_Click(object sender, EventArgs e)
        {
            int foodId = Convert.ToInt32(((Button)sender).CommandArgument);
            UpdateQuantity(foodId, -1);
        }

        protected void btnOrder_Click(object sender, EventArgs e)
        {
            Response.Redirect("Order.aspx");
        }

        protected void btnPayment_Click(object sender, EventArgs e)
        {
            Response.Redirect("Payment.aspx");
        }
    }
}
