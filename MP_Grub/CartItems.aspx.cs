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
            }
        }

        private void LoadCartItems()
        {
            if (Session["UserID"] == null || Session["TransactionID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            int transactionId = Convert.ToInt32(Session["TransactionID"]);

            using (OleDbConnection conn = new OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|/GrubDB.accdb"))
            {
                string query = @"
                    SELECT 
                        Order_Detail.OrderDetail_ID, 
                        Order_Detail.Food_ID, 
                        Food.Food_Name, 
                        Order_Detail.Quantity, 
                        Order_Detail.Order_Amount 
                        FROM Order_Detail
                        INNER JOIN Food ON Order_Detail.Food_ID = Food.Food_ID
                        WHERE Order_Detail.Transaction_ID = ? 
                        AND Order_Detail.User_ID = ?
                        AND Order_Detail.Is_Cart = 'YES'";

                try
                {
                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Transaction_ID", transactionId);
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

                            CalculateTotalPrice(dt);
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('An error occurred: " + ex.Message + "');</script>");
                }
            }
        }

        private void CalculateTotalPrice(DataTable dt)
        {
            decimal totalAmount = 0;

            foreach (DataRow row in dt.Rows)
            {
                totalAmount += Convert.ToDecimal(row["Order_Amount"]);
            }

            lblTotalAmount.Text = totalAmount.ToString("0.00");
        }

        private void UpdateQuantity(int orderDetailId, int change)
        {
            using (OleDbConnection conn = new OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|/GrubDB.accdb"))
            {
                string getQuantityQuery = "SELECT Quantity, Food_ID FROM Order_Detail WHERE OrderDetail_ID = ?";
                int currentQuantity = 0;
                int foodId = 0;
                decimal foodPrice = 0;

                try
                {
                    // Retrieve current Quantity and Food_ID
                    using (OleDbCommand getCmd = new OleDbCommand(getQuantityQuery, conn))
                    {
                        getCmd.Parameters.AddWithValue("@OrderDetail_ID", orderDetailId);
                        conn.Open();
                        using (OleDbDataReader reader = getCmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                currentQuantity = Convert.ToInt32(reader["Quantity"]);
                                foodId = Convert.ToInt32(reader["Food_ID"]);
                            }
                        }
                        conn.Close();
                    }

                    // New quantity calculation
                    int newQuantity = currentQuantity + change;
                    if (newQuantity < 1)
                    {
                        Response.Write("<script>alert('Quantity cannot be less than 1.');</script>");
                        return;
                    }
                    if (newQuantity > 100)
                    {
                        Response.Write("<script>alert('Quantity cannot exceed 100.');</script>");
                        return;
                    }

                    // Fetch food price
                    string getFoodPriceQuery = "SELECT Food_Price FROM Food WHERE Food_ID = ?";
                    using (OleDbCommand getPriceCmd = new OleDbCommand(getFoodPriceQuery, conn))
                    {
                        getPriceCmd.Parameters.AddWithValue("@Food_ID", foodId);
                        conn.Open();
                        foodPrice = Convert.ToDecimal(getPriceCmd.ExecuteScalar());
                        conn.Close();
                    }

                    // Calculate the new order amount
                    decimal newOrderAmount = foodPrice * newQuantity;

                    // Update Quantity and Order_Amount
                    string updateQuery = "UPDATE Order_Detail SET Quantity = ?, Order_Amount = ? WHERE OrderDetail_ID = ?";
                    using (OleDbCommand updateCmd = new OleDbCommand(updateQuery, conn))
                    {
                        updateCmd.Parameters.AddWithValue("@Quantity", newQuantity);
                        updateCmd.Parameters.AddWithValue("@Order_Amount", newOrderAmount);
                        updateCmd.Parameters.AddWithValue("@OrderDetail_ID", orderDetailId);

                        conn.Open();
                        updateCmd.ExecuteNonQuery();
                        conn.Close();
                       
                    }
                    LoadCartItems();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('An error occurred: " + ex.Message + "');</script>");
                }
            }
        }




        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int orderDetailId = Convert.ToInt32(btn.CommandArgument);
            UpdateQuantity(orderDetailId, 1);
        }

        protected void btnSubtract_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int orderDetailId = Convert.ToInt32(btn.CommandArgument);
            UpdateQuantity(orderDetailId, -1);
        }

        protected void btnOrder_Click(object sender, EventArgs e)
        {
            Response.Redirect("Order.aspx");
        }

        protected void btnPayment_Click(object sender, EventArgs e)
        {

            if (Session["TransactionID"] == null || Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }


            int transactionID = Convert.ToInt32(Session["TransactionID"]);
            int userID = Convert.ToInt32(Session["UserID"]);


            decimal totalPrice;
            if (!decimal.TryParse(lblTotalAmount.Text.Replace(",", "").Trim(), out totalPrice))
            {
                Response.Write("<script>alert('Error: Invalid total price format.');</script>");
                return;
            }


            UpdateTransactionTotalPrice(transactionID, totalPrice);


            Session["TransactionID"] = transactionID;
            Session["UserID"] = userID;


            Response.Redirect("Payment.aspx");
        }

        // Method to update Total_Price in the Transaction table
        private void UpdateTransactionTotalPrice(int transactionID, decimal totalPrice)
        {
            string query = "UPDATE [Transaction] SET Total_Price = ? WHERE Transaction_ID = ?";

            string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\GrubDB.accdb;";

            try
            {
                using (OleDbConnection conn = new OleDbConnection(connectionString))
                using (OleDbCommand cmd = new OleDbCommand(query, conn))
                {
                    // Ensure parameters are in the correct order
                    cmd.Parameters.AddWithValue("?", totalPrice);
                    cmd.Parameters.AddWithValue("?", transactionID);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error updating total price: " + ex.Message + "');</script>");
            }
        }



        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int orderDetailId = Convert.ToInt32(btn.CommandArgument);

            using (OleDbConnection conn = new OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|/GrubDB.accdb"))
            {
                string query = "DELETE FROM Order_Detail WHERE OrderDetail_ID = ?";

                try
                {
                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@OrderDetail_ID", orderDetailId);

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

    }
}
