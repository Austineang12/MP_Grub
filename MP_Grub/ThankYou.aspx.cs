using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MP_Grub
{
    public partial class ThankYou : System.Web.UI.Page
    {
        private static string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\GrubDB.accdb;";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["FeedbackID"] != null)
            {
                int feedbackID = Convert.ToInt32(Session["FeedbackID"]);
            }
            else
            {
                // Handle case where there is no feedback ID in session
                Response.Redirect("OrderConfirmation.aspx");
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            //Response.Redirect("Home.aspx");
            string reviewText = hfReviewText.Value.Trim();

            if (!string.IsNullOrEmpty(reviewText))
            {
                if (Session["FeedbackID"] != null)
                {
                    int feedbackID = Convert.ToInt32(Session["FeedbackID"]);
                    SaveReviewComment(feedbackID, reviewText);
                }
                else
                {
                    // Handle case where FeedbackID is not found in session
                    Response.Redirect("OrderConfirmation.aspx");
                }
            }
            else
            {
                // Handle case where the review text is empty
                Response.Write("<script>alert('Please enter a review before submitting.');</script>");
            }
        }

        private void SaveReviewComment(int feedbackID, string reviewText)
        {
            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                conn.Open();

                string query = @"
                    UPDATE Feedback
                    SET Comment = ?
                    WHERE Feedback_ID = ?";

                using (OleDbCommand cmd = new OleDbCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("?", reviewText);
                    cmd.Parameters.AddWithValue("?", feedbackID);
                    cmd.ExecuteNonQuery();
                }
            }
            Response.Redirect("Order.aspx");
        }
    }
}