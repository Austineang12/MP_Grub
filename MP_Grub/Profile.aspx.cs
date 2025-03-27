using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MP_Grub
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }
            }

            string userId = Session["UserID"].ToString();
            string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\GrubDB.accdb;";

            using (OleDbConnection con = new OleDbConnection(connectionString))
            {
                string query = "SELECT Username, Full_Name, Birthdate, Contact_Info, Address FROM [User] WHERE User_ID = ?";
                using (OleDbCommand cmd = new OleDbCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("?", userId);

                    try
                    {
                        con.Open();
                        OleDbDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            lblUsername.Text = reader["Username"]?.ToString() ?? "";
                            lblFullName.Text = reader["Full_Name"]?.ToString() ?? "";
                            lblBirthdate.Text = reader["Birthdate"] != DBNull.Value ? Convert.ToDateTime(reader["Birthdate"]).ToString("MM/dd/yyyy") : "";
                            lblContactInfo.Text = reader["Contact_Info"]?.ToString() ?? "";
                            lblAddress.Text = reader["Address"]?.ToString() ?? "";
                        }

                        reader.Close();
                    }
                    catch (Exception ex)
                    {
                        lblErrorMessage.Text = "Error loading profile: " + ex.Message;
                    }
                }
            }
        }

        protected void EditProfileRedirect(object sender, EventArgs e)
        {
            Response.Redirect("EditProfile.aspx");
        }

        protected void GoToHome(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}