using System;
using System.Collections.Generic;
using System.Data.OleDb;
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
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(userID))
                {
                    BindBookmarkedItems();
                }
                else
                {
                    Response.Redirect("~/Login.aspx");
                }
            }

            // Handle POST Requests
            if (Request.HttpMethod == "POST")
            {
                string bookmarkID = Request.Form["bookmarkID"];
                string newQuantity = Request.Form["newQuantity"];
                string action = Request.Form["action"]; // Identify update or delete action

                if (action == "update" && !string.IsNullOrEmpty(bookmarkID) && !string.IsNullOrEmpty(newQuantity))
                {
                    UpdateFoodQuantity(bookmarkID, newQuantity);
                }
                else if (action == "delete" && !string.IsNullOrEmpty(bookmarkID))
                {
                    DeleteBookmark(bookmarkID);
                }
            }
        }

        private void BindBookmarkedItems()
        {
            string userID = Request.QueryString["userID"];

            string query = @"
                SELECT 
                    Bookmark.Bookmark_ID, 
                    Food.Food_Name, 
                    Restaurant.Restaurant_Name, 
                    SUM(Bookmark.Food_Quantity) AS Total_Quantity
                FROM (Bookmark
                INNER JOIN Food ON Bookmark.Food_ID = Food.Food_ID)
                INNER JOIN Restaurant ON Food.Restaurant_ID = Restaurant.Restaurant_ID
                WHERE Bookmark.User_ID = @UserID
                GROUP BY Bookmark.Bookmark_ID, Food.Food_Name, Restaurant.Restaurant_Name;";

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                OleDbCommand cmd = new OleDbCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userID);

                conn.Open();
                OleDbDataReader reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    // Dictionary to keep track of unique food and restaurant combinations
                    Dictionary<string, Tuple<string, string, int>> uniqueItems = new Dictionary<string, Tuple<string, string, int>>();

                    while (reader.Read())
                    {
                        string foodName = reader["Food_Name"].ToString();
                        string restaurantName = reader["Restaurant_Name"].ToString();
                        string bookmarkID = reader["Bookmark_ID"].ToString();
                        int totalQuantity = reader["Total_Quantity"] != DBNull.Value ? Convert.ToInt32(reader["Total_Quantity"]) : 1;

                        // Use a key combination of Food and Restaurant to group similar items
                        string key = $"{foodName}_{restaurantName}";

                        if (uniqueItems.ContainsKey(key))
                        {
                            // Update the quantity for existing entry
                            uniqueItems[key] = new Tuple<string, string, int>(foodName, restaurantName, uniqueItems[key].Item3 + totalQuantity);
                        }
                        else
                        {
                            // Add new entry
                            uniqueItems.Add(key, new Tuple<string, string, int>(foodName, restaurantName, totalQuantity));
                        }
                    }

                    // Now render the grouped items
                    foreach (var item in uniqueItems.Values)
                    {
                        string foodName = item.Item1;
                        string restaurantName = item.Item2;
                        int totalQuantity = item.Item3;

                        // Generate div dynamically
                        string divItem = $@"
                    <div class='item' data-bookmarkid='{foodName}_{restaurantName}'>
                        <label class='foodName'>{foodName}</label>
                        <label class='foodStore'>{restaurantName}</label>
                        <div class='hiddenHover'>
                            <button class='removeBtn' onclick='removeBookmark({foodName}, {restaurantName})'>Remove</button>
                            <div class='quantityContainer'>
                                <input class='quantityButtonMinus' type='button' value='-' onclick='updateQuantity({foodName}, {restaurantName}, -1)' />
                                <label class='quantityLbl' id='quantity_{foodName}_{restaurantName}'>{totalQuantity}</label>
                                <input class='quantityButtonPlus' type='button' value='+' onclick='updateQuantity({foodName}, {restaurantName}, 1)' />
                            </div>
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



        private void UpdateFoodQuantity(string bookmarkID, string newQuantity)
        {
            string query = "UPDATE Bookmark SET Food_Quantity = @Quantity WHERE Bookmark_ID = @BookmarkID";

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                OleDbCommand cmd = new OleDbCommand(query, conn);
                cmd.Parameters.AddWithValue("@Quantity", newQuantity);
                cmd.Parameters.AddWithValue("@BookmarkID", bookmarkID);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }

        private void DeleteBookmark(string bookmarkID)
        {
            string query = "DELETE FROM Bookmark WHERE Bookmark_ID = @BookmarkID";

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                OleDbCommand cmd = new OleDbCommand(query, conn);
                cmd.Parameters.AddWithValue("@BookmarkID", bookmarkID);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }
    }
}
