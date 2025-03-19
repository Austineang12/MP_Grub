using System;
using System.Web;
using System.Web.UI;
using System.Data.OleDb;

namespace MP_Grub
{
    public partial class CreateAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SignupValidation(object sender, EventArgs e)
        {
            string nameInput = fullnametxt.Text.Trim();
            string usernameInput = usernametxt.Text.Trim();
            string passwordInput = passwordtxt.Text.Trim();
            string birthdateInput = birthdatetxt.Text.Trim();
            string contactInput = contacttxt.Text.Trim();
            string addressInput = addresstxt.Text.Trim();

            if (AccountValidation(nameInput, usernameInput, passwordInput, birthdateInput, contactInput, addressInput))
            {
                if (RegisterUser(nameInput, usernameInput, passwordInput, birthdateInput, contactInput, addressInput))
                {
                    Response.Write("<script>alert('Account created successfully!'); window.location='Home.aspx';</script>");
                }
                else
                {
                    Response.Write("<script>alert('Username already exists or database error occurred!');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('All fields are required!');</script>");
            }
        }

        private bool AccountValidation(string name, string username, string password, string birthdate, string contact, string address)
        {
            return !(string.IsNullOrWhiteSpace(name) ||
                     string.IsNullOrWhiteSpace(username) ||
                     string.IsNullOrWhiteSpace(password) ||
                     string.IsNullOrWhiteSpace(birthdate) ||
                     string.IsNullOrWhiteSpace(contact) ||
                     string.IsNullOrWhiteSpace(address));
        }

        private bool RegisterUser(string name, string username, string password, string birthdate, string contact, string address)
        {
            bool success = false;
            string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\GrubDB.mdb;";

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
                            return false; // Username already exists
                        }
                    }

                    // Insert new user
                    string insertQuery = "INSERT INTO [User] ([Full_Name], [Username], [Password], [Birthdate], [Contact_Info], [Address]) " +
                                         "VALUES (?, ?, ?, ?, ?, ?)";


                    using (OleDbCommand cmd = new OleDbCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("?", name);
                        cmd.Parameters.AddWithValue("?", username);
                        cmd.Parameters.AddWithValue("?", password);
                        cmd.Parameters.AddWithValue("?", DateTime.Parse(birthdate));
                        cmd.Parameters.AddWithValue("?", contact);
                        cmd.Parameters.AddWithValue("?", address);

                        int rowsAffected = cmd.ExecuteNonQuery();
                        success = (rowsAffected > 0); // If row was inserted, registration was successful
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Database Error: " + ex.Message + "');</script>");
                }
            }
            return success;
        }
    }
}
