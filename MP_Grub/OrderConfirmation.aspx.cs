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
            if (Request.HttpMethod == "POST")
            {
                string action = Request.Form["action"];

                if (action == "submitFeedback")
                {
                    // Get rating and feedback time from the form
                    string rating = Request.Form["rating"];
                    string feedbackTimeString = Request.Form["feedbackTime"];
                    string feedbackTime = DateTime.TryParse(feedbackTimeString, out DateTime parsedTime) ? parsedTime.ToString() : string.Empty;

                    if (!string.IsNullOrEmpty(rating) && !string.IsNullOrEmpty(feedbackTime))
                    {
                        if (Session["UserID"] == null || Session["TransactionID"] == null)
                        {
                            Response.Redirect("Login.aspx");
                            return;
                        }

                        int userId = Convert.ToInt32(Session["UserID"]);
                        int transactionId = Convert.ToInt32(Session["TransactionID"]);

                        SaveFeedback(userId, transactionId, rating, feedbackTime);
                    }
                }
            }
        }

        protected void btnOrderDetails_Click(object sender, EventArgs e)
        {
            Response.Redirect("Order.aspx"); // go back to Order page after submitting info to database
        }

        protected void btnDone_Click(object sender, EventArgs e)
        {
            Response.Redirect("ThankYou.aspx"); //to leave review
        }

        private void SaveFeedback(int userID, int transactionID, string rating, string feedbackTime)
        {
            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                conn.Open();

                // Step 1: Insert feedback data
                string insertQuery = @"
            INSERT INTO Feedback (User_ID, Transaction_ID, Rating, Feedback_Time)
            VALUES (?, ?, ?, ?)";

                using (OleDbCommand cmd = new OleDbCommand(insertQuery, conn))
                {
                    cmd.Parameters.AddWithValue("?", userID);
                    cmd.Parameters.AddWithValue("?", transactionID);
                    cmd.Parameters.AddWithValue("?", rating);
                    cmd.Parameters.AddWithValue("?", feedbackTime);

                    cmd.ExecuteNonQuery(); 
                }

                string selectQuery = "SELECT @@IDENTITY"; //last inserted identity value

                using (OleDbCommand cmd = new OleDbCommand(selectQuery, conn))
                {
                    var feedbackId = cmd.ExecuteScalar(); 
                    // Storing the feedback ID in the session
                    Session["FeedbackID"] = feedbackId;
                }
            }
        }
    }
}