using System;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MP_Grub
{
    public partial class Navigation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRandomImage();
            }
        }

        private void LoadRandomImage()
        {
            try
            {
                using (OleDbConnection conn = new OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|/GrubDB.accdb"))
                {
                    conn.Open();
                    string query = "SELECT Food_Photo FROM Food ORDER BY RND(Food_ID)";
                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            string imageName = result.ToString();
                            carouselImage.ImageUrl = "~/Navigation_Images/" + imageName;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error loading image: " + ex.Message;
            }
        }

        protected void btnLeft_Click(object sender, EventArgs e)
        {
            LoadRandomImage();
        }

        protected void btnRight_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            try
            {
                string currentImageUrl = carouselImage.ImageUrl;
                string imageName = Path.GetFileNameWithoutExtension(currentImageUrl);

                if (!int.TryParse(imageName, out int foodId))
                {
                    lblError.Text = "Error: Unable to extract Food ID from image.";
                    return;
                }

                /*-- Insert data to Interaction table --*/
                /*-- Error: Data type mismatch in criteria expression (when btn right is clicked) --*/
                using (OleDbConnection conn = new OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|/GrubDB.accdb"))
                {
                    conn.Open();
                    string query = "INSERT INTO Interaction (Food_ID, User_ID, Swipe_Action, Interaction_Time) VALUES (?, ?, ?, ?)";

                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Food_ID", foodId);
                        cmd.Parameters.AddWithValue("@User_ID", userId);
                        cmd.Parameters.AddWithValue("@Swipe_Action", "Right");
                        cmd.Parameters.AddWithValue("@Interaction_Time", DateTime.Now);

                        cmd.ExecuteNonQuery();
                    }

                    string getIdQuery = "SELECT @@IDENTITY";
                    using (OleDbCommand getIdCmd = new OleDbCommand(getIdQuery, conn))
                    {
                        int preferenceId = Convert.ToInt32(getIdCmd.ExecuteScalar());
                        Session["Preference_ID"] = preferenceId;
                    }
                }
                Response.Redirect("CartItems.aspx");
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
            }
        }
    }
}
