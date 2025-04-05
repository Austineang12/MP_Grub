using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MP_Grub
{
    public partial class OrderConfirmation : System.Web.UI.Page
    {
        private static string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\GrubDB.accdb;";
        protected void Page_Load(object sender, EventArgs e)
        {
            //CATCH FROM FUNCTION SAVEDATA()
            if (Request.HttpMethod == "POST")
            {
                string action = Request.Form["action"];

                if (action == "submitFeedback")
                {
                    //GET RATING AND REVIEW DATA
                    string rating = Request.Form["rating"];
                    string feedbackTimeString = Request.Form["feedbackTime"];
                    string feedbackTime = DateTime.TryParse(feedbackTimeString, out DateTime parsedTime) ? parsedTime.ToString() : string.Empty;
                    string reviewText = Request.Form["reviewText"];



                    if (!string.IsNullOrEmpty(rating) && !string.IsNullOrEmpty(feedbackTime))
                    {
                        if (Session["UserID"] == null || Session["TransactionID"] == null)
                        {
                            Response.Redirect("Login.aspx");
                            return;
                        }

                        int userId = Convert.ToInt32(Session["UserID"]);
                        int transactionId = Convert.ToInt32(Session["TransactionID"]);

                        SaveFeedback(userId, transactionId, rating, feedbackTime, reviewText);
                    }
                }
            }
        }

        protected void btnOrderDetails_Click(object sender, EventArgs e)
        {
            //SKIPS THE RATING AND REVIEW AND GOES BACK TO ORDER PAGE
            Response.Redirect("Order.aspx"); 
        }

        protected void btnDone_Click(object sender, EventArgs e)
        {
            //AFTER SAVES THE RATING AND REVIEW TO DATABASE
            Response.Redirect("Order.aspx");
        }

        private void SaveFeedback(int userID, int transactionID, string rating, string feedbackTime, string comment)
        {
            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                conn.Open();
                string insertQuery = @"
                    INSERT INTO Feedback (User_ID, Transaction_ID, Rating, Feedback_Time, Comment)
                    VALUES (?, ?, ?, ?, ?)";

                using (OleDbCommand cmd = new OleDbCommand(insertQuery, conn))
                {
                    cmd.Parameters.AddWithValue("?", userID);
                    cmd.Parameters.AddWithValue("?", transactionID);
                    cmd.Parameters.AddWithValue("?", rating);
                    cmd.Parameters.AddWithValue("?", feedbackTime);
                    cmd.Parameters.AddWithValue("?", comment);


                    cmd.ExecuteNonQuery(); 
                }
            }
        }
    }
}