using System;
using System.Data.OleDb;
using System.Web.UI;

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
                        fullName.Text = reader["Full_Name"].ToString();
                        birthdate.Text = Convert.ToDateTime(reader["Birthdate"]).ToString("yyyy-MM-dd");
                        contact.Text = reader["Contact_Info"].ToString();
                        address.Text = reader["Address"].ToString();
                    }
                }
            }
        }

        protected void SaveProfile(object sender, EventArgs e)
        {
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
