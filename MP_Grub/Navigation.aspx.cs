using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Util;

namespace MP_Grub
{
    public partial class Navigation : System.Web.UI.Page
    {
        private static string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\GrubDB.accdb;";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRandomImage();
                if (Session["UserID"] == null || Session["TransactionID"] == null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showToast", "showToast('Session expired or missing. Please log in again.', ' #DC3545');", true);
                    Response.End();
                    return;
                }

                string userId = Session["UserID"].ToString();
                string transactionId = Session["TransactionID"].ToString();
                System.Diagnostics.Debug.WriteLine("userID:" + userId, "transaction:" + transactionId);
                EnsureOrderDetailExists(transactionId, userId);
            }
        }

        private List<int> displayedFoodIDs = new List<int>();
        private int totalFoodCount = 0;
        private void LoadRandomImage()
        {
            try
            {
                NoDuck.Visible = false;
                string query = "SELECT Food_ID FROM Food ORDER BY RND(Food_ID)";
                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    OleDbCommand cmd = new OleDbCommand(query, conn);
                    conn.Open();
                    OleDbDataReader reader = cmd.ExecuteReader();

                    List<int> foodIDs = new List<int>();
                    while (reader.Read())
                    {
                        int foodID = Convert.ToInt32(reader["Food_ID"]);
                        foodIDs.Add(foodID); totalFoodCount++;

                    }
                    reader.Close();

                    if (foodIDs.Count > 0)
                    {
                        // Get random food item not yet displayed
                        Random rand = new Random();
                        int randomFoodID = foodIDs[rand.Next(foodIDs.Count)];

                        // Display the image for the random food item
                        DisplayFoodImage(randomFoodID);

                        // Track displayed food ID
                        displayedFoodIDs.Add(randomFoodID);
                    }

                    if (displayedFoodIDs.Count >= totalFoodCount)
                    {
                        NoDuck.Enabled = false;  // Disable the "Left" button once all images have been shown
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "showToast", "showToast('All items have been shown!', '#DC3545');", true);
                        Response.Redirect("CartItems.aspx");
                    }
                }
            }
            catch (Exception ex)
            {
                //FOR DEBUGGING ONLY
                System.Diagnostics.Debug.WriteLine("Error loading image: " + ex.Message);
            }
        }

        private void DisplayFoodImage(int foodID)
        {
            try
            {
                string query = "SELECT Food_Photo, Food_Name FROM Food WHERE Food_ID = @FoodID";
                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    OleDbCommand cmd = new OleDbCommand(query, conn);
                    cmd.Parameters.AddWithValue("@FoodID", foodID);
                    conn.Open();
                    OleDbDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        string foodName = reader["Food_Name"].ToString();
                        string imageBase64 = "images/ResImg_Default.png";

                        if (reader["Food_Photo"] is byte[] imageBytes && imageBytes.Length > 78)
                        {
                            byte[] actualImageBytes = new byte[imageBytes.Length - 78];
                            Array.Copy(imageBytes, 78, actualImageBytes, 0, actualImageBytes.Length);
                            imageBase64 = "data:image/png;base64," + Convert.ToBase64String(actualImageBytes);
                        }
                        else if (reader["Food_Photo"] is string imagePath)
                        {
                            imageBase64 = imagePath;
                        }

                        Literal card = new Literal();
                        card.Text = $@"<img id='{foodID}' src='{imageBase64}' data-id='{foodID}' alt='{foodName} Logo' />";
                        imageContainer.Controls.Add(card);

                        // Create the "Yes" button to allow the user to swipe right
                        ImageButton yesDuckButton = new ImageButton();
                        yesDuckButton.CssClass = "swipe-ducks";
                        yesDuckButton.CommandArgument = foodID.ToString();
                        //yesDuckButton.Text = "Swipe Right";
                        yesDuckButton.ImageUrl = "images/Yes_Duck.png";
                        yesDuckButton.Click += new ImageClickEventHandler(this.btnRight_Click);
                        buttonContainer.Controls.Add(yesDuckButton);

                        NoDuck.Visible = true;
                    }

                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error displaying food image: " + ex.Message);
            }
        }

        protected void btnLeft_Click(object sender, EventArgs e)
        {
            LoadRandomImage();
        }

        protected void btnRight_Click(object sender, EventArgs e)
        {
            ImageButton button = sender as ImageButton;

            if (button != null && button.CommandArgument != null)
            {
                int foodID = Convert.ToInt32(button.CommandArgument);
                SaveToOrderDetail(foodID);

            }
            LoadRandomImage();
        }

        //SAVING TO ORDER_DETAIL TABLE
        protected void SaveToOrderDetail(int foodID)
        {
            string userID = Request.QueryString["userID"];
            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                conn.Open();

                // Retrieve food information using foodID
                string query = "SELECT Food_Name, Food_Price FROM Food WHERE Food_ID = @FoodID";

                using (OleDbCommand cmd = new OleDbCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FoodID", foodID);
                    OleDbDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        string foodName = reader["Food_Name"].ToString();
                        decimal foodPrice = Convert.ToDecimal(reader["Food_Price"]);

                        // Default quantity for a new item added is 1
                        int foodQuantity = 1;
                        decimal orderAmount = foodQuantity * foodPrice;

                        // Check if the food item already exists in the Order_Detail for the user
                        string checkQuery = "SELECT COUNT(*) FROM Order_Detail WHERE Transaction_ID = ? AND Food_ID = ? AND User_ID = ? AND Is_Cart = 'YES'";

                        using (OleDbCommand checkCmd = new OleDbCommand(checkQuery, conn))
                        {
                            checkCmd.Parameters.AddWithValue("?", Convert.ToInt32(Session["TransactionID"]));
                            checkCmd.Parameters.AddWithValue("?", foodID);
                            checkCmd.Parameters.AddWithValue("?", userID);

                            int existingCount = Convert.ToInt32(checkCmd.ExecuteScalar());

                            if (existingCount == 0)
                            {
                                // Insert a new record if food item is not already in the Order_Detail
                                string insertQuery = "INSERT INTO Order_Detail (Transaction_ID, Food_ID, Quantity, Order_Amount, Is_Cart, User_ID) VALUES (?, ?, ?, ?, 'YES', ?)";

                                using (OleDbCommand insertCmd = new OleDbCommand(insertQuery, conn))
                                {
                                    insertCmd.Parameters.AddWithValue("?", Convert.ToInt32(Session["TransactionID"]));
                                    insertCmd.Parameters.AddWithValue("?", foodID);
                                    insertCmd.Parameters.AddWithValue("?", foodQuantity);
                                    insertCmd.Parameters.AddWithValue("?", orderAmount);
                                    insertCmd.Parameters.AddWithValue("?", userID);

                                    int rowsAffected = insertCmd.ExecuteNonQuery();
                                    if (rowsAffected > 0)
                                    {
                                        ScriptManager.RegisterStartupScript(this, this.GetType(), "showToast", "showToast('Item added to cart!', '#3CB371');", true);
                                    }
                                    else
                                    {
                                        ScriptManager.RegisterStartupScript(this, this.GetType(), "showToast", "showToast('Failed to update the cart item due to an error.', '#3CB371');", true);
                                    }
                                }
                            }
                            else
                            {
                                // If item exists, update the quantity and order amount
                                string updateQuery = "UPDATE Order_Detail SET Quantity = Quantity + ?, Order_Amount = Order_Amount + ? WHERE Transaction_ID = ? AND Food_ID = ? AND User_ID = ? AND Is_Cart = 'YES'";

                                using (OleDbCommand updateCmd = new OleDbCommand(updateQuery, conn))
                                {
                                    updateCmd.Parameters.AddWithValue("?", foodQuantity);
                                    updateCmd.Parameters.AddWithValue("?", orderAmount);
                                    updateCmd.Parameters.AddWithValue("?", Convert.ToInt32(Session["TransactionID"]));
                                    updateCmd.Parameters.AddWithValue("?", foodID);
                                    updateCmd.Parameters.AddWithValue("?", userID);

                                    int rowsAffected = updateCmd.ExecuteNonQuery();
                                    if (rowsAffected > 0)
                                    {
                                        ScriptManager.RegisterStartupScript(this, this.GetType(), "showToast", "showToast('Item added to cart!', '#3CB371');", true);
                                    }
                                    else
                                    {
                                        ScriptManager.RegisterStartupScript(this, this.GetType(), "showToast", "showToast('Failed to update the cart item due to an error.', '#3CB371');", true);
                                    }
                                }
                            }


                        }
                    }
                }

                conn.Close();
            }
        }

        //OTHER NECESSARY FUNCTION FOR SAVING TO ORDER_DETAIL
        private void EnsureOrderDetailExists(string transactionId, string userId)
        {
            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                conn.Open();
                string checkQuery = "SELECT COUNT(*) FROM Order_Detail WHERE Transaction_ID = ? AND User_ID = ? AND Is_Cart = 'NO'";
                using (OleDbCommand checkCmd = new OleDbCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("?", Convert.ToInt32(transactionId));
                    checkCmd.Parameters.AddWithValue("?", userId);

                    int existingCount = (int)checkCmd.ExecuteScalar();

                    //NO VACANT RECORD EXISTS, CREATE ONE
                    if (existingCount == 0)
                    {
                        string insertQuery = "INSERT INTO Order_Detail (Transaction_ID, User_ID, Is_Cart) VALUES (?, ?, 'NO')";
                        using (OleDbCommand insertCmd = new OleDbCommand(insertQuery, conn))
                        {
                            insertCmd.Parameters.AddWithValue("?", Convert.ToInt32(transactionId));
                            insertCmd.Parameters.AddWithValue("?", Convert.ToInt32(userId));

                            insertCmd.ExecuteNonQuery();
                        }
                    }
                }
            }
        }

        [WebMethod(EnableSession = true)]
        public static object GetSessionData()
        {
            if (System.Web.HttpContext.Current.Session["UserID"] == null ||
                System.Web.HttpContext.Current.Session["TransactionID"] == null)
            {
                return new { IsValid = false, Message = "Session expired. Please log in again." };
            }
            return new
            {
                IsValid = true,
                TransactionID = System.Web.HttpContext.Current.Session["TransactionID"].ToString(),
                UserID = System.Web.HttpContext.Current.Session["UserID"].ToString()
            };
        }
    }
}
