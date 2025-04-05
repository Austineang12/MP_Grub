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
                //CHECKING IF THERE IS VACANT IN ORDER_DETAIL
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
        public static object AddToCart(int foodId, string foodName, string foodPrice)
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

                    // Check if the item is already in the cart
                    string checkQuery = "SELECT Quantity FROM Order_Detail WHERE Transaction_ID = ? AND Food_ID = ? AND User_ID = ? AND Is_Cart = 'YES'";
                    using (OleDbCommand checkCmd = new OleDbCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("?", transactionId);
                        checkCmd.Parameters.AddWithValue("?", foodId);
                        checkCmd.Parameters.AddWithValue("?", userId);

                        object result = checkCmd.ExecuteScalar();

                        if (result != null)
                        {
                            // Item already exists, update quantity and amount
                            int currentQuantity = Convert.ToInt32(result);
                            int newQuantity = currentQuantity + 1;
                            decimal newAmount = newQuantity * price;

                            string updateQuery = "UPDATE Order_Detail SET Quantity = ?, Order_Amount = ? WHERE Transaction_ID = ? AND Food_ID = ? AND User_ID = ? AND Is_Cart = 'YES'";
                            using (OleDbCommand updateCmd = new OleDbCommand(updateQuery, conn))
                            {
                                updateCmd.Parameters.AddWithValue("?", newQuantity);
                                updateCmd.Parameters.AddWithValue("?", newAmount);
                                updateCmd.Parameters.AddWithValue("?", transactionId);
                                updateCmd.Parameters.AddWithValue("?", foodId);
                                updateCmd.Parameters.AddWithValue("?", userId);

                                int rowsAffected = updateCmd.ExecuteNonQuery();
                                if (rowsAffected > 0)
                                {
                                    return new { success = true, message = "Cart updated. Quantity increased." };
                                }
                                else
                                {
                                    return new { success = false, message = "Failed to update the cart item." };
                                }
                            }
                        }
                        else
                        {
                            // Item doesn't exist yet, insert new record
                            string insertQuery = "INSERT INTO Order_Detail (Transaction_ID, Food_ID, Quantity, Order_Amount, Is_Cart, User_ID) VALUES (?, ?, ?, ?, 'YES', ?)";
                            using (OleDbCommand insertCmd = new OleDbCommand(insertQuery, conn))
                            {
                                insertCmd.Parameters.AddWithValue("?", transactionId);
                                insertCmd.Parameters.AddWithValue("?", foodId);
                                insertCmd.Parameters.AddWithValue("?", 1); // initial quantity
                                insertCmd.Parameters.AddWithValue("?", price); // price * 1
                                insertCmd.Parameters.AddWithValue("?", userId);

                                int rowsAffected = insertCmd.ExecuteNonQuery();
                                if (rowsAffected > 0)
                                {
                                    return new { success = true, message = "Item added to cart!" };
                                }
                                else
                                {
                                    return new { success = false, message = "Failed to add the item to your cart." };
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return new { success = false, message = "Error: " + ex.Message };
            }
        }


        //ADDING TO BOOKMARK TABLE
        [WebMethod]
        public static object BookmarkFood(string foodID1)
        {
            try
            {
                if (System.Web.HttpContext.Current.Session["TransactionID"] == null ||
                System.Web.HttpContext.Current.Session["UserID"] == null)
                {
                    return "Session expired. Please log in again.";
                }
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

                    // Check if the user has already bookmarked this food item
                    string checkQuery = "SELECT Food_Quantity FROM Bookmark WHERE User_ID = ? AND Food_ID = ?";
                    OleDbCommand checkCmd = new OleDbCommand(checkQuery, conn);
                    checkCmd.Parameters.AddWithValue("?", userID);
                    checkCmd.Parameters.AddWithValue("?", foodID);

                    object result = checkCmd.ExecuteScalar();

                    if (result != null)
                    {
                        // If a bookmark exists, update the quantity (add 1 to the existing quantity)
                        int existingQuantity = Convert.ToInt32(result);
                        string updateQuery = "UPDATE Bookmark SET Food_Quantity = ? WHERE User_ID = ? AND Food_ID = ?";
                        OleDbCommand updateCmd = new OleDbCommand(updateQuery, conn);
                        updateCmd.Parameters.AddWithValue("?", existingQuantity + 1);
                        updateCmd.Parameters.AddWithValue("?", userID);
                        updateCmd.Parameters.AddWithValue("?", foodID);

                        int rowsAffected = updateCmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            return new { success = true, message = "Food quantity updated." };
                        }
                        else
                        {
                            return new { success = false, message = "Failed to update the food quantity." };
                        }
                    }
                    else
                    {
                        // If no bookmark exists, insert a new record with quantity = 1
                        string insertQuery = "INSERT INTO Bookmark (User_ID, Food_ID, Food_Quantity) VALUES (?, ?, ?)";
                        OleDbCommand insertCmd = new OleDbCommand(insertQuery, conn);
                        insertCmd.Parameters.AddWithValue("?", userID);
                        insertCmd.Parameters.AddWithValue("?", foodID);
                        insertCmd.Parameters.AddWithValue("?", 1); // Set quantity to 1

                        int rowsAffected = insertCmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            return new { success = true, message = "Food item bookmarked." };
                        }
                        else
                        {
                            return new { success = false, message = "Failed to bookmark the food item." };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
        }

        //CHECKING IF FOOD ITEM IS ALREADY IN THE BOOKMARK TABLE
        //TO DISABLE THE BOOKMARK BUTTON THAT IS ALREADY HAVE BEEN BOOKMARKED.
        [WebMethod(EnableSession = true)]
        public static List<int> GetUserBookmarkedFood()
        {
            List<int> bookmarkedFoodIds = new List<int>();
            int userID = Convert.ToInt32(HttpContext.Current.Session["UserID"]);

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT Food_ID FROM Bookmark WHERE User_ID = ?";
                using (OleDbCommand cmd = new OleDbCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("?", userID);
                    using (OleDbDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            bookmarkedFoodIds.Add(Convert.ToInt32(reader["Food_ID"]));
                        }
                    }
                }
            }

            return bookmarkedFoodIds;
        }




    }
}
