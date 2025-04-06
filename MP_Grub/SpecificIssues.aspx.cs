using System;
using System.Configuration;
using System.Data.OleDb;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MP_Grub
{
    public partial class SpecificIssues : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                if (Session["UserID"] == null)
                {
                    Response.Redirect("Login.aspx"); 
                }
            }
        }
        private void SaveIssue(string issueDetail, bool isSkip)
        {
            try
            {
                int userID = Convert.ToInt32(Session["UserID"]);


                string issue = Session["SelectedSpecifiedIssue"]?.ToString() ?? "General Inquiry";


                string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\GrubDB.accdb;";

                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    conn.Open();


                    string getMaxIDQuery = "SELECT MAX(Support_ID) FROM Support";
                    OleDbCommand cmdMaxID = new OleDbCommand(getMaxIDQuery, conn);
                    object maxID = cmdMaxID.ExecuteScalar();
                    int newSupportID = (maxID != DBNull.Value) ? Convert.ToInt32(maxID) + 1 : 1;


                    string insertQuery = "INSERT INTO Support (Support_ID, Specified_Issue, Detailed_Issue, User_ID) VALUES (@Support_ID, @Specified_Issue, @Detailed_Issue, @UserID)";
                    using (OleDbCommand cmd = new OleDbCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@Suppor_tID", newSupportID);
                        cmd.Parameters.AddWithValue("@Specified_Issue", issue);


                        if (isSkip)
                            cmd.Parameters.AddWithValue("@Detailed_Issue", DBNull.Value);
                        else
                            cmd.Parameters.AddWithValue("@Detailed_Issue", string.IsNullOrEmpty(issueDetail) ? DBNull.Value : (object)issueDetail);

                        cmd.Parameters.AddWithValue("@User_ID", userID);

                        cmd.ExecuteNonQuery();
                    }
                }

                Response.Redirect("ConfirmIssue.aspx");
            }
            catch (Exception ex)
            {
                errorLabel.Text = "Error: " + ex.Message;
                errorLabel.Visible = true;
            }
        }

        protected void SkipToConfirmation(object sender, EventArgs e)
        {
            SaveIssue(null, true);
        }

        protected void ContinueToConfirmation(object sender, EventArgs e)
        {
            string issueDetail = issueDetails.Text.Trim();

            if (string.IsNullOrEmpty(issueDetail))
            {
                errorLabel.Text = "Please enter details for the issue.";
                errorLabel.Visible = true;
                return;
            }

            SaveIssue(issueDetail, false); 
        }

        protected void CancelProcess(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}
