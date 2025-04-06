using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Globalization;
using System.Text.RegularExpressions;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MP_Grub
{
    public partial class BookmarkedItems : System.Web.UI.Page
    {
        private static string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\GrubDB.accdb;";

        protected void Page_Load(object sender, EventArgs e)
        {
            string userID = Request.QueryString["userID"];

            if (string.IsNullOrEmpty(userID))
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (Request.HttpMethod == "POST")
            {
                string action = Request.Form["action"];
                if (action == "delete")
                {
                    string bookmarkID = Request.Form["bookmarkID"].ToString();
                    if (!string.IsNullOrEmpty(bookmarkID))
                    {
                        RemoveBookmark(bookmarkID);
                    }
                }

                BindBookmarkedItems();
            }
            else if (!IsPostBack)
            {
                BindBookmarkedItems();
                if (Session["UserID"] == null || Session["TransactionID"] == null)
                {
                    Response.Write("<script>showToast('Session expired or missing. Please log in again.', ' #DC3545')</script>");
                    Response.End();
                    return;
                }

                string userId = Session["UserID"].ToString();
                string transactionId = Session["TransactionID"].ToString();

                EnsureOrderDetailExists(transactionId, userId);
            }
        }

        private void BindBookmarkedItems()
        {
            string userID = Request.QueryString["userID"];

            string query = @"
                    SELECT 
                        Bookmark.Bookmark_ID,
                        Food.Food_ID,
                        Food.Food_Name,
                        Food.Food_Price,
                        Restaurant.Restaurant_Name,
                        Bookmark.Food_Quantity
                    FROM (Bookmark
                    INNER JOIN Food ON Bookmark.Food_ID = Food.Food_ID)
                    INNER JOIN Restaurant ON Food.Restaurant_ID = Restaurant.Restaurant_ID
                    WHERE Bookmark.User_ID = @UserID";

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                OleDbCommand cmd = new OleDbCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userID);

                conn.Open();
                OleDbDataReader reader = cmd.ExecuteReader();
                CultureInfo culture = new CultureInfo("en-PH");
                if (reader.HasRows)
                {
                    // Iterate over the rows to populate the bookmarks
                    while (reader.Read())
                    {
                        string foodID = reader["Food_ID"].ToString();
                        string foodName = reader["Food_Name"].ToString();
                        string foodPrice = Convert.ToDecimal(reader["Food_Price"]).ToString("C", culture);
                        string restaurantName = reader["Restaurant_Name"].ToString();
                        string bookmarkID = reader["Bookmark_ID"].ToString();
                        //int foodID = Convert.ToInt32(reader["Food_ID"]);
                        int foodQuantity = reader["Food_Quantity"] != DBNull.Value ? Convert.ToInt32(reader["Food_Quantity"]) : 1;

                        // Build the HTML for each food item
                        string divItem = $@"
                    <div class='item' id='bookmark_{bookmarkID}'>
                        <label class='foodName'>{foodName}</label>
                        <label class='foodStore'>{restaurantName}</label>
                        <div class='hiddenHover'>
                            <input class='removeBtn' type='button' value='Remove' onclick='removeBookmark(""{bookmarkID}"")' />
                            <input class='addCartBtn' type='button' value='Add to Cart' onclick='addToCart('${foodID}','${foodName}', '${foodPrice}');return false;'/>
                        </div>
                    </div>";

                        
                        Literal lit = new Literal();
                        lit.Text = divItem;
                        bookmarkContent.Controls.Add(lit);
                    }
                }

                reader.Close();
                conn.Close();
            }
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
                                    return new { success = true, message = "Item added to cart!" };
                                }
                                else
                                {
                                    return new { success = false, message = "Failed to update the cart item due to an error." };
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
                                    return new { success = false, message = "Failed to add the item to your cart due to an error." };
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


        private void RemoveBookmark(string bookmarkID)
        {
            string userID = Request.QueryString["userID"];
            string deleteQuery = @"
                DELETE FROM Bookmark
                WHERE Bookmark_ID = @BookmarkID
                AND User_ID = @UserID";

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                OleDbCommand cmd = new OleDbCommand(deleteQuery, conn);
                cmd.Parameters.AddWithValue("@BookmarkID", Convert.ToInt32(bookmarkID));
                cmd.Parameters.AddWithValue("@UserID", userID);
                Response.Write("<script >showToast('Bookmark removed.', '#3CB371');</script>");
                try
                {
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery(); 
                    System.Diagnostics.Debug.WriteLine("Rows affected: " + rowsAffected);


                    if (rowsAffected == 0)
                    {
                        System.Diagnostics.Debug.WriteLine("No rows were deleted. Check the query or the data.");
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Error deleting bookmark: " + ex.Message);
                }
                finally
                {
                    conn.Close();
                }
            }
        }
    }
}
