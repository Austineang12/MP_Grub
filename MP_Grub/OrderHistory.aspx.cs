using System;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Web.UI.WebControls;

namespace MP_Grub
{
    public partial class OrderHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrderHistory();
            }
        }

        private void LoadOrderHistory()
        {
            string userID = Session["UserID"]?.ToString();
            if (string.IsNullOrEmpty(userID)) return;

            string connStr = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\GrubDB.accdb;";

            using (OleDbConnection conn = new OleDbConnection(connStr))
            {
                string query = @"
                    SELECT 
                        T.Transaction_ID,
                        T.Payment_Type,
                        T.Final_Price,
                        T.Discount_Value
                    FROM 
                        [Transaction] T
                    WHERE 
                        T.User_ID = @UserID AND T.Transaction_Status = 'Delivered'
                    ORDER BY 
                        T.Transaction_ID DESC";

                using (OleDbCommand cmd = new OleDbCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);

                    using (OleDbDataAdapter adapter = new OleDbDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        rptOrderHistory.DataSource = dt;
                        rptOrderHistory.DataBind();

                        // Show empty row panel if no data
                        pnlNoOrders.Visible = dt.Rows.Count == 0;
                    }
                }
            }
        }
    }
}
