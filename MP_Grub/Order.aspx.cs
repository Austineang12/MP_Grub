using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MP_Grub
{
    public partial class Order : System.Web.UI.Page
    {
        private string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\GrubDB.accdb;";

        protected void Page_Load(object sender, EventArgs e)
        {
            //LoadRestaurants();
            if (!IsPostBack)
            {
                LoadRestaurants();
            }
            else
            {
                string eventTarget = Request.Params["__EVENTTARGET"];
                string eventArgument = Request.Params["__EVENTARGUMENT"];

                if (eventTarget == "LoadMenu" && int.TryParse(eventArgument, out int restaurantId))
                {
                    LoadMenu(restaurantId);
                    ShowPopup();
                }
            }
        }

        private void LoadRestaurants()
        {
            string query = "SELECT Restaurant_ID, Restaurant_Name, Restaurant_Location, Restaurant_Photo FROM Restaurant";

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                OleDbCommand cmd = new OleDbCommand(query, conn);
                conn.Open();
                OleDbDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    int restaurantId = Convert.ToInt32(reader["Restaurant_ID"]);
                    string restaurantName = reader["Restaurant_Name"]?.ToString() ?? "Unknown Restaurant";
                    string imagePath = ""; //= "images/ResImg_Default.png"; // Default image path

                    // FOR DEBUGGING ONLY
                    if (reader["Restaurant_Photo"] != DBNull.Value)
                    {
                        try
                        {
                            // Check if the image exists using a debug message
                            Response.Write($"<script>console.log('Image found for Restaurant ID: {restaurantId}');</script>");

                            OleDbCommand attachmentCmd = new OleDbCommand($"SELECT Restaurant_Photo FROM Restaurant WHERE Restaurant_ID = ?", conn);
                            attachmentCmd.Parameters.AddWithValue("?", restaurantId);

                            using (OleDbDataReader attachmentReader = attachmentCmd.ExecuteReader())
                            {
                                while (attachmentReader.Read())
                                {
                                    dynamic recordset = attachmentReader["Restaurant_Photo"];

                                    if (recordset != null && recordset.Read())
                                    {
                                        byte[] imageBytes = (byte[])recordset.Fields["FileData"].Value;
                                        byte[] actualImageData = imageBytes.Skip(20).ToArray();
                                        string base64Image = Convert.ToBase64String(actualImageData);
                                        imagePath = $"data:image/png;base64,{base64Image}";
                                        Response.Write($"<script>console.log('Image loaded successfully for ID: {restaurantId}');</script>");
                                    }
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            Response.Write($"<script>alert('Error loading image for Restaurant ID {restaurantId}: {ex.Message}');</script>");
                        }
                    }
                    else
                    {
                        Response.Write($"<script>console.log('No image for Restaurant ID: {restaurantId}, using default');</script>");
                    }

                    Literal card = new Literal();
                    card.Text = $@"
                        <div class=""restaurant-card"" onclick='__doPostBack(""LoadMenu"", ""{restaurantId}"")'>
                            <div class='restaurant-logo'><img src='{imagePath}' alt='{restaurantName} Logo' /></div>
                            <div class='restaurant-name'>{restaurantName}</div>
                        </div>";
                    restaurantContainer.Controls.Add(card);
                }
                reader.Close();
            }
        }

        private void LoadMenu(int restaurantId)
        {
            string query = "SELECT Food_ID, Food_Name, Food_Price FROM [Food] WHERE Restaurant_ID = @Restaurant_ID";

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                conn.Open();
                using (OleDbCommand cmd = new OleDbCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Restaurant_ID", restaurantId);
                    using (OleDbDataReader reader = cmd.ExecuteReader())
                    {
                        foodList.Controls.Clear();
                        while (reader.Read())
                        {
                            string foodName = reader["Food_Name"]?.ToString() ?? "Unknown Food";
                            string foodPrice = reader["Food_Price"]?.ToString() ?? "₱0.00";

                            Literal foodItem = new Literal();
                            foodItem.Text = $@"
                                <div class='food-item'>
                                    <div class='food-details'>
                                        <span class='food-name'>{foodName}</span>
                                        <span class='food-price'>{foodPrice}</span>
                                    </div>
                                    <div class='food-actions'>
                                        <button class='food-button' onclick=""bookmarkFood('{foodName}')"" >Bookmark</button>
                                        <button class='food-button' onclick=""addToCart('{foodName}', '{foodPrice}')"" >Add to Cart</button>
                                    </div>
                                </div>";
                            foodList.Controls.Add(foodItem);
                        }
                    }
                }
            }
        }

        private void ShowPopup()
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowPopup", "document.getElementById('foodPopup').classList.add('active');", true);
        }
    }
}
