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
                Session["UserID"] = userDetails.Item1;
                Session["Username"] = userDetails.Item2;

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
    }
}

