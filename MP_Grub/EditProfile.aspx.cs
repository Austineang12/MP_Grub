using System;
using System.Data.OleDb;
using System.Web.UI;
using System.Text.RegularExpressions;

namespace MP_Grub
{
    public partial class EditProfile : Page
    {
        string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\GrubDB.accdb;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserData();
            }
        }

        private void LoadUserData()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            using (OleDbConnection con = new OleDbConnection(connectionString))
            {
                string query = "SELECT Username, Full_Name, Birthdate, Contact_Info, Address FROM [User] WHERE User_ID = ?";
                using (OleDbCommand cmd = new OleDbCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("?", userId);
                    con.Open();
                    OleDbDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        username.Text = reader["Username"].ToString();
                        fullName.Text = reader["Full_Name"] != DBNull.Value ? reader["Full_Name"].ToString() : "";
                        birthdate.Text = reader["Birthdate"] != DBNull.Value ? Convert.ToDateTime(reader["Birthdate"]).ToString("yyyy-MM-dd") : "";
                        contact.Text = reader["Contact_Info"] != DBNull.Value ? reader["Contact_Info"].ToString() : "";
                        address.Text = reader["Address"] != DBNull.Value ? reader["Address"].ToString() : "";
                    }
                }
            }
        }

        protected void SaveProfile(object sender, EventArgs e)
        {
            string usernameInput = username.Text.Trim();
            string fullNameInput = fullName.Text.Trim();
            string birthdateInput = birthdate.Text.Trim();
            string contactInput = contact.Text.Trim();
            string addressInput = address.Text.Trim();

            // Username validation: No spaces
            if (usernameInput.Contains(" "))
            {
                lblUsernameError.Text = "Username cannot contain Spaces!";
                lblUsernameError.Visible = true;
                return;
            }
            else
            {
                lblUsernameError.Visible = false;
            }

            // Full Name Validation: No numbers
            if (Regex.IsMatch(fullNameInput, @"\d")) // Checks if the full name contains any numbers
            {
                lblFullNameError.Text = "Full Name cannot contain Numbers!";
                lblFullNameError.Visible = true;
                return;
            }
            else
            {
                lblFullNameError.Visible = false;
            }

            // Birthdate Validation: User must be at least 13 years old and not older than 100
            if (DateTime.TryParse(birthdateInput, out DateTime birthDate))
            {
                DateTime today = DateTime.Today;
                int age = today.Year - birthDate.Year;

                // Adjust age if birthdate hasn't occurred this year yet
                if (birthDate.Date > today.AddYears(-age)) age--;

                if (age < 13 || age > 100)
                {
                    lblBirthdateError.Text = "Age must be between 13 and 100 years old!";
                    lblBirthdateError.Visible = true;
                    return;
                }
                else
                {
                    lblBirthdateError.Visible = false;
                }
            }
            else
            {
                lblBirthdateError.Text = "Invalid birthdate format!";
                lblBirthdateError.Visible = true;
                return;
            }

            // Contact Validation: Must be exactly 11 characters
            if (contactInput.Length != 11 || !Regex.IsMatch(contactInput, @"^\d{11}$"))
            {
                lblContactError.Text = "Contact should have 11 Characters only!";
                lblContactError.Visible = true;
                return;
            }
            else
            {
                lblContactError.Visible = false;
            }

            // Address Validation: Cannot contain special characters like @, !, #
            if (Regex.IsMatch(addressInput, @"[@!#\$%\^&\*\(\)_\+\=]"))
            {
                lblAddressError.Text = "Address cannot contain special characters like @, !, #, etc.";
                lblAddressError.Visible = true;
                return;
            }
            else
            {
                lblAddressError.Visible = false;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            using (OleDbConnection con = new OleDbConnection(connectionString))
            {
                string query = "UPDATE [User] SET Username = ?, Full_Name = ?, Birthdate = ?, Contact_Info = ?, Address = ? WHERE User_ID = ?";
                using (OleDbCommand cmd = new OleDbCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("?", username.Text);
                    cmd.Parameters.AddWithValue("?", fullName.Text);
                    cmd.Parameters.AddWithValue("?", birthdate.Text);
                    cmd.Parameters.AddWithValue("?", contact.Text);
                    cmd.Parameters.AddWithValue("?", address.Text);
                    cmd.Parameters.AddWithValue("?", userId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            Response.Redirect("Profile.aspx");
        }
    }
}
