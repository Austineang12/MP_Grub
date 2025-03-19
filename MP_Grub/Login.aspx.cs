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

            if (AccountValidation(usernameInput, passwordInput))
            {
                Response.Redirect("Home.aspx");
            }
            else
            {
                Response.Write("<script>alert('Invalid username or password!');</script>");
            }
        }

        private bool AccountValidation(string usernameInput, string passwordInput)
        {
            bool isValid = false;

            // Define the database connection string
            string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\GrubDB.mdb;";

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT COUNT(*) FROM [User] WHERE Username = ? AND Password = ?";

                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("?", usernameInput);
                        cmd.Parameters.AddWithValue("?", passwordInput);

                        int count = (int)cmd.ExecuteScalar();
                        isValid = (count > 0); 
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Database Error: " + ex.Message + "');</script>");
                }
            }

            return isValid;
        }
    }
}
