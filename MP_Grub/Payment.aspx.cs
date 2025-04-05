using System;
using System.Data.OleDb;
using System.Web.UI.WebControls;

namespace MP_Grub
{
    public partial class Payment : System.Web.UI.Page
    {
        string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\GrubDB.accdb;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null || Session["TransactionID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserData();
                LoadVoucherDropdown();
                LoadTotalPrice();
                UpdateFinalPrice();
            }
        }

        private void LoadUserData()
        {
            string userId = Session["UserID"].ToString();

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                conn.Open();
                OleDbCommand userCmd = new OleDbCommand("SELECT Full_Name, Contact_Info, Address FROM [User] WHERE User_ID = ?", conn);
                userCmd.Parameters.AddWithValue("?", userId);
                OleDbDataReader reader = userCmd.ExecuteReader();

                if (reader.Read())
                {
                    txtFullName.Text = reader["Full_Name"].ToString();
                    txtContactNo.Text = reader["Contact_Info"].ToString();
                    txtAddress.Text = reader["Address"].ToString();
                }
            }
        }

        private void LoadVoucherDropdown()
        {
            string userId = Session["UserID"].ToString();

            ddlVoucher.Items.Clear();
            ddlVoucher.Items.Add(new ListItem("No Discount", "0"));

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                conn.Open();
                OleDbCommand voucherCmd = new OleDbCommand("SELECT Voucher_ID, Voucher_Name, Voucher_Value FROM Voucher WHERE User_ID = ?", conn);
                voucherCmd.Parameters.AddWithValue("?", userId);
                OleDbDataReader vReader = voucherCmd.ExecuteReader();

                while (vReader.Read())
                {
                    string text = $"{vReader["Voucher_Name"]} - {vReader["Voucher_Value"]}%";
                    ddlVoucher.Items.Add(new ListItem(text, vReader["Voucher_ID"].ToString()));
                }
            }
        }

        private void LoadTotalPrice()
        {
            string transactionId = Session["TransactionID"].ToString();

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                conn.Open();
                OleDbCommand priceCmd = new OleDbCommand("SELECT Total_Price FROM [Transaction] WHERE Transaction_ID = ? AND Transaction_Status = 'Pending'", conn);
                priceCmd.Parameters.AddWithValue("?", transactionId);
                object result = priceCmd.ExecuteScalar();
                lblTotalPrice.Text = result != null ? result.ToString() : "0.00";
            }
        }

        private void UpdateFinalPrice()
        {
            double totalPrice = Convert.ToDouble(lblTotalPrice.Text);
            double discountValue = 0;

            if (ddlVoucher.SelectedValue != "0")
            {
                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    conn.Open();
                    OleDbCommand cmd = new OleDbCommand("SELECT Voucher_Value FROM Voucher WHERE Voucher_ID = ?", conn);
                    cmd.Parameters.AddWithValue("?", ddlVoucher.SelectedValue);
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                        discountValue = Convert.ToDouble(result);
                }
            }

            double finalPrice = totalPrice - (totalPrice * (discountValue / 100));
            lblFinalPrice.Text = finalPrice.ToString("F2");
        }
         
        protected void ddlVoucher_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdateFinalPrice();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string userId = Session["UserID"].ToString();
            string transactionId = Session["TransactionID"].ToString();
            string paymentType = ddlTransaction.SelectedValue;
            string voucherId = ddlVoucher.SelectedValue;

            double discountValue = 0;
            double totalPrice = Convert.ToDouble(lblTotalPrice.Text);

            // If a voucher is selected, get the discount value, delete voucher after using
            if (voucherId != "0")
            {
                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    conn.Open();
                    OleDbCommand discountCmd = new OleDbCommand("SELECT Voucher_Value FROM Voucher WHERE Voucher_ID = ?", conn);
                    discountCmd.Parameters.AddWithValue("?", voucherId);
                    object discountObj = discountCmd.ExecuteScalar();
                    if (discountObj != null)
                        discountValue = Convert.ToDouble(discountObj);
                }

                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    conn.Open();
                    OleDbCommand deleteVoucherCmd = new OleDbCommand("DELETE FROM Voucher WHERE Voucher_ID = ? AND User_ID = ?", conn);
                    deleteVoucherCmd.Parameters.AddWithValue("?", voucherId);
                    deleteVoucherCmd.Parameters.AddWithValue("?", userId);
                    deleteVoucherCmd.ExecuteNonQuery();
                }
            }

            // Calculate the final price after discount
            double finalPrice = totalPrice - (totalPrice * (discountValue / 100));
            lblFinalPrice.Text = finalPrice.ToString("F2");

            try
            {
                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    conn.Open();

                    // Update the transaction in the database
                    OleDbCommand updateCmd = new OleDbCommand(@"
                UPDATE [Transaction] 
                SET Payment_Type = ?, 
                    Voucher_ID = ?, 
                    Discount_Value = ?, 
                    Final_Price = ?, 
                    Transaction_Status = 'Delivered' 
                WHERE Transaction_ID = ? AND User_ID = ? AND Transaction_Status = 'Pending'", conn);

                    // Assign parameters for the update
                    updateCmd.Parameters.AddWithValue("?", paymentType);
                    updateCmd.Parameters.AddWithValue("?", voucherId);
                    updateCmd.Parameters.AddWithValue("?", discountValue);
                    updateCmd.Parameters.AddWithValue("?", finalPrice);
                    updateCmd.Parameters.AddWithValue("?", transactionId);
                    updateCmd.Parameters.AddWithValue("?", userId);


                    int rowsAffected = updateCmd.ExecuteNonQuery();


                    if (rowsAffected > 0)
                    {
                        if (Session["TransactionID"] == null || Session["UserID"] == null)
                        {
                            Response.Redirect("Login.aspx");
                            return;
                        }

                        int transactionID = Convert.ToInt32(Session["TransactionID"]);
                        int userID = Convert.ToInt32(Session["UserID"]);


                        CreateNewTransaction(userId);

                        Session["TransactionID"] = transactionID;
                        Session["UserID"] = userID;
                        Response.Redirect("OrderConfirmation.aspx");
                    }
                    else
                    {
                        Response.Write("<script>alert('Failed to update the transaction. Please try again.');</script>");
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('An error occurred: " + ex.Message + "');</script>");
            }
        }



        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        private void CreateNewTransaction(string userId)
        {
            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                conn.Open();

                // Create new transaction with 'Pending' status and other fields set to NULL
                OleDbCommand cmd = new OleDbCommand(@"
                INSERT INTO [Transaction] (User_ID, Transaction_Status)
                VALUES (?, 'Pending')", conn);

                cmd.Parameters.AddWithValue("?", userId);

                cmd.ExecuteNonQuery();

                // Retrieve the new Transaction_ID for this transaction
                OleDbCommand getTransactionCmd = new OleDbCommand("SELECT MAX(Transaction_ID) FROM [Transaction] WHERE User_ID = ?", conn);
                getTransactionCmd.Parameters.AddWithValue("?", userId);
                object result = getTransactionCmd.ExecuteScalar();
                if (result != null)
                {
                    // Set the new TransactionID in session
                    Session["TransactionID"] = Convert.ToInt32(result);
                }
            }

            // Redirect to OrderConfirmation.aspx after creating the new transaction
            Response.Redirect("OrderConfirmation.aspx");
        }
    }
}