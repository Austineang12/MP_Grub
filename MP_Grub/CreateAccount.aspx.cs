using System;
using System.Web;
using System.Web.UI;
using System.Data.OleDb;
using System.Text.RegularExpressions;

namespace MP_Grub
{
    public partial class CreateAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void SignupValidation(object sender, EventArgs e)
        {
            string usernameInput = usernametxt.Text.Trim();
            string fullNameInput = fullnametxt.Text.Trim();
            string passwordInput = passwordtxt.Text.Trim();

            if (usernameInput.Contains(" "))
            {
                lblUsernameError.Text = "Username cannot contain spaces!";
                lblUsernameError.Visible = true;
                return;
            }
            else
            {
                lblUsernameError.Visible = false;
            }

            // Full Name validation: No numbers or commas
            if (Regex.IsMatch(fullNameInput, @"[\d,]")) // Checks if full name contains any digit (0-9) or comma (,)
            {
                lblFullNameError.Text = "Full Name cannot contain numbers or commas!";
                lblFullNameError.Visible = true;
                return;
            }
            else
            {
                lblFullNameError.Visible = false;
            }

            // Password validation: No spaces
            if (passwordInput.Contains(" "))
            {
                lblPasswordError.Text = "Password cannot contain Spaces!";
                lblPasswordError.Visible = true;
                return;
            }
            else
            {
                lblPasswordError.Visible = false;
            }

            if (string.IsNullOrWhiteSpace(usernameInput) ||
                string.IsNullOrWhiteSpace(fullNameInput) ||
                string.IsNullOrWhiteSpace(passwordInput))
            {
                Response.Write("<script>alert('All fields are required!');</script>");
                return;
            }

            int userID = RegisterUser(usernameInput, fullNameInput, passwordInput);

            if (userID > 0)
            {
                /*-- Transition to Login.aspx --*/
                string script = "animateRedirect('Login.aspx');";
                ClientScript.RegisterStartupScript(this.GetType(), "Redirect", script, true);
            }
            else
            {
                Response.Write("<script>alert('Username already exists or database error occurred!');</script>");
            }
        }

        private int RegisterUser(string username, string fullName, string password)
        {
            int userID = -1;
            string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\GrubDB.accdb;";

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Check if username already exists
                    string checkQuery = "SELECT COUNT(*) FROM [User] WHERE Username = ?";
                    using (OleDbCommand checkCmd = new OleDbCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("?", username);
                        int count = (int)checkCmd.ExecuteScalar();

                        if (count > 0)
                        {
                            return -1;
                        }
                    }

                    // Insert new user
                    string insertQuery = "INSERT INTO [User] ([Username], [Full_Name], [Password]) VALUES (?, ?, ?)";

                    using (OleDbCommand cmd = new OleDbCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("?", username);
                        cmd.Parameters.AddWithValue("?", fullName);
                        cmd.Parameters.AddWithValue("?", password);

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            string getUserIdQuery = "SELECT User_ID FROM [User] WHERE Username = ?";
                            using (OleDbCommand getIdCmd = new OleDbCommand(getUserIdQuery, conn))
                            {
                                getIdCmd.Parameters.AddWithValue("?", username);
                                object result = getIdCmd.ExecuteScalar();
                                if (result != null)
                                {
                                    userID = Convert.ToInt32(result);
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Database Error: " + ex.Message + "');</script>");
                }
            }
            return userID;
        }
    }
}
