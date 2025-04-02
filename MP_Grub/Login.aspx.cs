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

                Session["UserID"] = userId;
                Session["Username"] = username;

                // Ensure user has a valid Transaction_ID
                int transactionId = EnsureTransactionExists(userId);

                if (transactionId > 0)
                {
                    Session["TransactionID"] = transactionId;
                }

                Response.Redirect("Home.aspx");
            }
            else
            {
                Response.Write("<script>alert('Invalid username or password!');</script>");
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
                    string query = "SELECT User_ID, Username FROM [User] WHERE Username = ? AND Password = ?"; // Get User_ID & Username

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

                // Check if the user has an active transaction
                string checkActiveTransaction = "SELECT Transaction_ID FROM [Transaction] WHERE User_ID = ? AND Transaction_Status IS NULL";
                using (OleDbCommand cmd = new OleDbCommand(checkActiveTransaction, conn))
                {
                    cmd.Parameters.AddWithValue("?", userId);
                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        return Convert.ToInt32(result);
                    }
                }

                // If no active transaction, check the last transaction status
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
                            // If no transaction exists at all, create a new one
                            transactionId = CreateNewTransaction(conn, userId);
                        }
                    }
                }
            }

            return transactionId;
        }


        private int CreateNewTransaction(OleDbConnection conn, int userId)
        {
            string createTransactionQuery = "INSERT INTO [Transaction] (User_ID, Total_Price, Transaction_Status) VALUES (?, 0, 'Pending')";
            using (OleDbCommand cmd = new OleDbCommand(createTransactionQuery, conn))
            {
                cmd.Parameters.AddWithValue("?", userId);
                cmd.ExecuteNonQuery();
            }

            // Retrieve the newly created Transaction_ID
            using (OleDbCommand cmd = new OleDbCommand("SELECT @@IDENTITY", conn))
            {
                return (int)cmd.ExecuteScalar();
            }
            ;
        }
    }
}
