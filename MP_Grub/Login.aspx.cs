using System;
using System.Web.UI;
using System.Data.OleDb;

namespace MP_Grub
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Any page load logic here
        }

        protected void LoginValidation(object sender, EventArgs e)
        {
            string usernameInput = usernametxt.Text.Trim();
            string passwordInput = passwordtxt.Text.Trim();

            // Fetch user details (User_ID and Username)
            var userDetails = GetUserDetails(usernameInput, passwordInput);

            if (userDetails != null)
            {
                int userId = userDetails.Item1;
                string username = userDetails.Item2;

                // Store UserID and Username in Session
                Session["UserID"] = userId;
                Session["Username"] = username;

                // Ensure user has a valid Transaction_ID
                int transactionId = EnsureTransactionExists(userId);
                if (transactionId > 0)
                {
                    Session["TransactionID"] = transactionId; //Store TransactionID in Session
                }
                else
                {
                    Response.Write("<script>alert('Failed to retrieve or create a transaction. Please try again.');</script>");
                    return;
                }

                Response.Redirect("Home.aspx");
            }
            else
            {
                lblError.Visible = true;
            }
        }

        private Tuple<int, string> GetUserDetails(string usernameInput, string passwordInput)
        {
            string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\GrubDB.accdb;";
            Tuple<int, string> userDetails = null;

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT User_ID, Username FROM [User] WHERE Username = ? AND Password = ?"; 

                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("?", usernameInput);
                        cmd.Parameters.AddWithValue("?", passwordInput);

                        using (OleDbDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                int userId = reader.GetInt32(0);
                                string username = reader.GetString(1);

                                userDetails = new Tuple<int, string>(userId, username);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Database Error: " + ex.Message + "');</script>");
                }
            }

            return userDetails;
        }

        private int EnsureTransactionExists(int userId)
        {
            string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\GrubDB.accdb;";
            int transactionId = 0;

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                conn.Open();

                //Check for an active transaction
                string checkActiveTransaction = "SELECT Transaction_ID FROM [Transaction] WHERE User_ID = ? AND Transaction_Status = 'Pending'";
                using (OleDbCommand cmd = new OleDbCommand(checkActiveTransaction, conn))
                {
                    cmd.Parameters.AddWithValue("?", userId);
                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        return Convert.ToInt32(result);
                    }
                }

                //Check the last completed transaction
                string checkLastTransaction = "SELECT TOP 1 Transaction_ID, Transaction_Status FROM [Transaction] WHERE User_ID = ? ORDER BY Transaction_ID DESC";
                using (OleDbCommand cmd = new OleDbCommand(checkLastTransaction, conn))
                {
                    cmd.Parameters.AddWithValue("?", userId);
                    using (OleDbDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string status = reader["Transaction_Status"] != DBNull.Value ? reader["Transaction_Status"].ToString() : null;

                            if (status == "Delivered" || status == "Canceled")
                            {
                                transactionId = CreateNewTransaction(conn, userId);
                            }
                        }
                        else
                        {
                            //If no transaction exists at all, create a new one
                            transactionId = CreateNewTransaction(conn, userId);
                        }
                    }
                }
            }

            return transactionId;
        }

        private int CreateNewTransaction(OleDbConnection conn, int userId)
        {
            int newTransactionId = 0;

            string createTransactionQuery = "INSERT INTO [Transaction] (User_ID, Total_Price, Transaction_Status) VALUES (?, 0, 'Pending')";
            using (OleDbCommand cmd = new OleDbCommand(createTransactionQuery, conn))
            {
                cmd.Parameters.AddWithValue("?", userId);
                cmd.ExecuteNonQuery();
            }

            // Fix: Retrieve the last inserted Transaction_ID
            string getLastTransactionQuery = "SELECT MAX(Transaction_ID) FROM [Transaction] WHERE User_ID = ?";
            using (OleDbCommand cmd = new OleDbCommand(getLastTransactionQuery, conn))
            {
                cmd.Parameters.AddWithValue("?", userId);
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    newTransactionId = Convert.ToInt32(result);
                }
            }

            return newTransactionId;
        }
    }
}
