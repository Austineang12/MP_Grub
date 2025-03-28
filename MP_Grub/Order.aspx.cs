using System;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace MP_Grub
{
    public partial class Order : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadRestaurants();
        }

        private void LoadRestaurants()
        {
            // Example connection string (Adjust as per your database)
            string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\GrubDB.mdb;";
            string query = "SELECT Restaurant_ID, Restaurant_Name, Restaurant_Location, Restaurant_Photo FROM Restaurant";

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                OleDbCommand cmd = new OleDbCommand(query, conn);
                conn.Open();
                OleDbDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    int restaurantId = Convert.ToInt32(reader["Restaurant_ID"]);
                    string restaurantName = reader["Restaurant_Name"] != DBNull.Value ? reader["Restaurant_Name"].ToString() : "Unknown Restaurant";
                    string restaurantLocation = reader["Restaurant_Location"] != DBNull.Value ? reader["Restaurant_Location"].ToString() : "Unknown Location"; //To be passed to payment
                    
                    string imageBase64 = "images/ResImg_Default.png"; // Default image

                    if (reader["Restaurant_Photo"] != DBNull.Value)
                    {
                        // Check if it's stored as binary data (OLE Object)
                        if (reader["Restaurant_Photo"] is byte[] imageBytes)
                        {
                            // Handle Binary OLE Object Image
                            if (imageBytes.Length > 78) // OLE header detected
                            {
                                const int oleHeaderSize = 78;
                                byte[] actualImageBytes = new byte[imageBytes.Length - oleHeaderSize];
                                Array.Copy(imageBytes, oleHeaderSize, actualImageBytes, 0, actualImageBytes.Length);
                                imageBase64 = "data:image/png;base64," + Convert.ToBase64String(actualImageBytes);
                            }
                            else
                            {
                                imageBase64 = "data:image/png;base64," + Convert.ToBase64String(imageBytes);
                            }
                        }
                        // If stored as a path (string)
                        else if (reader["Restaurant_Photo"] is string imagePath)
                        {
                            imageBase64 = imagePath;
                        }
                    }
                    Literal card = new Literal();
                    card.Text = $@"
                        <div class='restaurant-card' onclick='showPopup({restaurantId}); return false;'>
                            <div class='restaurant-logo'><img src='{imageBase64}' alt='{restaurantName} Logo' /></div>
                            <div class='restaurant-name'>{restaurantName}</div>
                        </div>";
                    restaurantContainer.Controls.Add(card);
                }
                reader.Close();
            }
        }
    }
}
