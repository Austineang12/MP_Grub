using System;
using System.Data.OleDb;
using System.Web.UI;

namespace MP_Grub
{
    public partial class ConfirmIssue : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLatestReport();
                LoadAllReports();
            }
        }

        private void LoadLatestReport()
        {
            string userID = Session["UserID"]?.ToString();

            if (!string.IsNullOrEmpty(userID))
            {
                string connStr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|GrubDB.accdb;";
                using (OleDbConnection conn = new OleDbConnection(connStr))
                {
                    string query = "SELECT TOP 1 Specified_Issue, Detailed_Issue FROM Support WHERE User_ID = ? ORDER BY Support_ID DESC";
                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("?", userID);
                        conn.Open();
                        using (OleDbDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblIssue.Text = reader["Specified_Issue"].ToString();
                                lblDetailedIssue.Text = string.IsNullOrEmpty(reader["Detailed_Issue"].ToString()) ? "No details provided." : reader["Detailed_Issue"].ToString();
                            }
                            else
                            {
                                lblIssue.Text = "No reports found.";
                                lblDetailedIssue.Text = "-";
                            }
                        }
                    }
                }
            }
        }

        private void LoadAllReports()
        {
            string userID = Session["UserID"]?.ToString();

            if (!string.IsNullOrEmpty(userID))
            {
                string connStr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|GrubDB.accdb;";
                using (OleDbConnection conn = new OleDbConnection(connStr))
                {
                    string query = "SELECT Support_ID, Specified_Issue, Detailed_Issue FROM Support WHERE User_ID = ?";
                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("?", userID);
                        conn.Open();
                        using (OleDbDataReader reader = cmd.ExecuteReader())
                        {
                            rptAllReports.DataSource = reader;
                            rptAllReports.DataBind();
                        }
                    }
                }
            }
        }

        protected void btnToggleReports_Click(object sender, EventArgs e)
        {
            allReportsContainer.Visible = !allReportsContainer.Visible;
            btnToggleReports.Text = allReportsContainer.Visible ? "Hide All Reports" : "View All Reports";
        }

        protected void GoToHomePage_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}
