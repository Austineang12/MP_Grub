using System;
using System.Globalization;
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

            fullNameInput = CapitalizeEachWord(fullNameInput);

            // Reset error messages
            lblUsernameError.Text = "";
            lblFullNameError.Text = "";
            lblPasswordError.Text = "";
            lblError.Text = "";

            lblUsernameError.Visible = false;
            lblFullNameError.Visible = false;
            lblPasswordError.Visible = false;
            lblError.Visible = false;



            // Required field validation
            if (string.IsNullOrWhiteSpace(usernameInput) ||
                string.IsNullOrWhiteSpace(fullNameInput) ||
                string.IsNullOrWhiteSpace(passwordInput))
            {
                lblError.Text = "All fields are required.";
                lblError.Visible = true;
                return;
            }



            // Username validations
            if (usernameInput.Length <= 5)
            {
                lblUsernameError.Text = "Username must be more than 5 characters.";
                lblUsernameError.Visible = true;
                return;
            }

            if (usernameInput.Contains(" "))
            {
                lblUsernameError.Text = "Username cannot contain spaces.";
                lblUsernameError.Visible = true;
                return;
            }

            if (usernameInput != usernameInput.ToLower())
            {
                lblUsernameError.Text = "Username must be in lowercase only.";
                lblUsernameError.Visible = true;
                return;
            }

            // Full Name validations
            if (fullNameInput.Length <= 3)
            {
                lblFullNameError.Text = "Full Name must be more than 3 characters.";
                lblFullNameError.Visible = true;
                return;
            }

            if (Regex.IsMatch(fullNameInput, @"[\d,]"))
            {
                lblFullNameError.Text = "Full Name cannot contain numbers or commas.";
                lblFullNameError.Visible = true;
                return;
            }

            // Password validations
            if (passwordInput.Length <= 6)
            {
                lblPasswordError.Text = "Your password length is too weak.";
                lblPasswordError.Visible = true;
                return;
            }

            if (passwordInput.Contains(" "))
            {
                lblPasswordError.Text = "Password cannot contain spaces.";
                lblPasswordError.Visible = true;
                return;
            }

            // If all validations pass, try to register the user
            int userID = RegisterUser(usernameInput, fullNameInput, passwordInput);

            if (userID > 0)
            {
                // Redirect with animation
                string script = "animateRedirect('Login.aspx');";
                ClientScript.RegisterStartupScript(this.GetType(), "Redirect", script, true);
            }
            else
            {
                lblError.Text = "This username already exists or a database error occurred.";
                lblError.Visible = true;

                usernametxt.Text = "";
                fullnametxt.Text = "";
                passwordtxt.Text = "";
            }
        }
        private string CapitalizeEachWord(string input)
        {
            if (string.IsNullOrWhiteSpace(input))
                return input;

            TextInfo textInfo = new CultureInfo("en-US", false).TextInfo;
            return textInfo.ToTitleCase(input.ToLower());
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
