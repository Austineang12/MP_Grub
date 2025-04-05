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

            if (string.IsNullOrEmpty(userID))
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (Request.HttpMethod == "POST")
            {
                string action = Request.Form["action"];

                if (action == "update")
                {
                    string bookmarkID = Request.Form["bookmarkID"];
                    string newQuantity = Request.Form["newQuantity"];

                    if (!string.IsNullOrEmpty(bookmarkID) && !string.IsNullOrEmpty(newQuantity))
                    {
                        UpdateQuantity(bookmarkID, newQuantity);
                    }
                }
                else if (action == "delete")
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

                if (reader.HasRows)
                {
                    // Iterate over the rows to populate the bookmarks
                    while (reader.Read())
                    {
                        string foodName = reader["Food_Name"].ToString();
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
                            <div class='quantityContainer'>
                                <input class='quantityButtonMinus' type='button' value='-' onclick='updateQuantity(""{bookmarkID}"", -1)' />
                                <label class='quantityLbl' id='quantity_{bookmarkID}'>{foodQuantity}</label>
                                <input class='quantityButtonPlus' type='button' value='+' onclick='updateQuantity(""{bookmarkID}"", 1)' />
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



        private void UpdateQuantity(string bookmarkID, string newQuantity)
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
