using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Globalization;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

namespace MP_Grub
{
    public partial class Order : System.Web.UI.Page
    {
        private static string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\GrubDB.accdb;";

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    if (Session["UserID"] == null || Session["TransactionID"] == null)
                    {
                        Response.Write("<script>alert('Session expired or missing. Please log in again.'); window.location='Login.aspx';</script>");
                        Response.End();
                        return;
                    }

                    string userId = Session["UserID"].ToString();
                    string transactionId = Session["TransactionID"].ToString();

                    EnsureOrderDetailExists(transactionId, userId);
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }

            LoadRestaurants();
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
                    string restaurantName = reader["Restaurant_Name"].ToString() ?? "Unknown Restaurant";
                    string imageBase64 = "images/ResImg_Default.png";

                    if (reader["Restaurant_Photo"] is byte[] imageBytes && imageBytes.Length > 78)
                    {
                        byte[] actualImageBytes = new byte[imageBytes.Length - 78];
                        Array.Copy(imageBytes, 78, actualImageBytes, 0, actualImageBytes.Length);
                        imageBase64 = "data:image/png;base64," + Convert.ToBase64String(actualImageBytes);
                    }
                    else if (reader["Restaurant_Photo"] is string imagePath)
                    {
                        imageBase64 = imagePath;
                    }

                    Literal card = new Literal();
                    card.Text = $@"<div class='restaurant-card' onclick='showPopup({restaurantId}); return false;'>
                        <div class='restaurant-logo'><img src='{imageBase64}' alt='{restaurantName} Logo' /></div>
                        <div class='restaurant-name'>{restaurantName}</div>
                    </div>";
                    restaurantContainer.Controls.Add(card);
                }
                reader.Close();
            }
        }

        [WebMethod]
        public static List<object> GetRestaurantNames()
        {
            string query = "SELECT Restaurant_ID, Restaurant_Name FROM Restaurant";
            List<object> restaurantList = new List<object>();

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                OleDbCommand cmd = new OleDbCommand(query, conn);
                conn.Open();
                OleDbDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    restaurantList.Add(new
                    {
                        RestaurantID = reader["Restaurant_ID"],
                        RestaurantName = reader["Restaurant_Name"].ToString()
                    });
                }
                reader.Close();
            }

            return restaurantList;
        }




        private void EnsureOrderDetailExists(string transactionId, string userId)
        {
            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                conn.Open();

                //Check if a vacant Order_Detail record exists
                string checkQuery = "SELECT COUNT(*) FROM Order_Detail WHERE Transaction_ID = ? AND User_ID = ? AND Is_Cart = 'NO'";
                using (OleDbCommand checkCmd = new OleDbCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("?", Convert.ToInt32(transactionId)); // Ensure Transaction_ID is INT
                    checkCmd.Parameters.AddWithValue("?", userId); // Ensure User_ID is treated as a string if necessary

                    int existingCount = (int)checkCmd.ExecuteScalar();

                    if (existingCount == 0) // No vacant record exists, create one
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




        [WebMethod]
        public static object GetRestaurantMenu(int restaurantId)
        {
            string query = "SELECT Food_ID, Food_Name, Food_Price FROM Food WHERE Restaurant_ID = ?";
            List<object> foodList = new List<object>();

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                OleDbCommand cmd = new OleDbCommand(query, conn);
                cmd.Parameters.AddWithValue("?", restaurantId);
                conn.Open();
                OleDbDataReader reader = cmd.ExecuteReader();

                CultureInfo culture = new CultureInfo("en-PH");
                while (reader.Read())
                {
                    foodList.Add(new
                    {
                        FoodID = reader["Food_ID"].ToString(),
                        FoodName = reader["Food_Name"].ToString(),
                        FoodPrice = Convert.ToDecimal(reader["Food_Price"]).ToString("C", culture)
                    });
                }
                reader.Close();
            }
            return foodList;
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

        [WebMethod(EnableSession = true)]
        public static string AddToCart(int foodId, string foodName, string foodPrice)
        {
            if (System.Web.HttpContext.Current.Session["TransactionID"] == null ||
                System.Web.HttpContext.Current.Session["UserID"] == null)
            {
                return "Session expired. Please log in again.";
            }

            string transactionId = System.Web.HttpContext.Current.Session["TransactionID"].ToString();
            string userId = System.Web.HttpContext.Current.Session["UserID"].ToString();

            try
            {
                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    conn.Open();
                    decimal price = decimal.Parse(Regex.Replace(foodPrice, "[^0-9.]", ""));

                    // Insert new order into Order_Detail
                    string query = "INSERT INTO Order_Detail (Transaction_ID, Food_ID, Quantity, Order_Amount, Is_Cart, User_ID) VALUES (?, ?, 1, ?, 'YES', ?)";
                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("?", transactionId);
                        cmd.Parameters.AddWithValue("?", foodId);
                        cmd.Parameters.AddWithValue("?", price);
                        cmd.Parameters.AddWithValue("?", userId);

                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            return "Item added to cart!";
                        }
                        else
                        {
                            return "Failed to add item to cart.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }


        //ADDING TO BOOKMARK TABLE
        [WebMethod]
        public static object BookmarkFood(string foodID1)
        {
            try
            {
                // Retrieve userID from session
                int userID = Convert.ToInt32(HttpContext.Current.Session["UserID"].ToString());
                int foodID = Convert.ToInt32(foodID1);

                // Ensure userID is valid
                if (userID == 0)
                {
                    return new { success = false, message = "User is not logged in." };
                }

                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    conn.Open();

                    

                    string query = "INSERT INTO Bookmark (User_ID, Food_ID) VALUES (?, ?)";
                    OleDbCommand cmd = new OleDbCommand(query, conn);

                    cmd.Parameters.AddWithValue("?", userID);
                    cmd.Parameters.AddWithValue("?", foodID);

                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        return new { success = true };
                    }
                    else
                    {
                        return new { success = false, message = "Failed to bookmark the food item." };
                    }
                }
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
        }





    }
}
