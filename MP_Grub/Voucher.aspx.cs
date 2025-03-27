using System;
using System.Data.OleDb;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MP_Grub
{
    public partial class Voucher : Page
    {
        private string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\GrubDB.accdb;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserID"]);
                    if (HasClaimedVoucherToday(userId))
                    {
                        GenerateVoucherBtn.BackColor = System.Drawing.Color.Gray;
                    }
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void GenerateVoucher(object sender, EventArgs e)
        {
            if (Session["UserID"] != null)
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                if (HasClaimedVoucherToday(userId))
                {
                    lblMessage.Text = "Voucher claimed today. Come back tomorrow!";
                    GenerateVoucherBtn.Enabled = false;
                    return;
                }

                string[] voucherNames = { "Voucher5", "Voucher10", "Voucher20" };
                int[] discountValues = { 5, 10, 20 };
                Random rnd = new Random();
                int index = rnd.Next(voucherNames.Length);

                string selectedVoucher = voucherNames[index];
                int discountValue = discountValues[index];
                string imageUrl = "~/images/" + selectedVoucher + ".png";
                VoucherImage.ImageUrl = imageUrl;

                SaveVoucherToDatabase(userId, selectedVoucher, discountValue);
                lblMessage.Text = "Voucher claimed successfully!";
                GenerateVoucherBtn.Enabled = false;
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        private void SaveVoucherToDatabase(int userId, string voucherName, int discountValue)
        {
            string query = "INSERT INTO Voucher (Voucher_Name, Voucher_Value, Claim_Date, User_ID) VALUES (?, ?, ?, ?)";
            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                conn.Open();
                using (OleDbCommand cmd = new OleDbCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("?", voucherName);
                    cmd.Parameters.AddWithValue("?", discountValue);
                    cmd.Parameters.AddWithValue("?", DateTime.Now.ToString("yyyy-MM-dd"));
                    cmd.Parameters.AddWithValue("?", userId);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private bool HasClaimedVoucherToday(int userId)
        {
            string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|GrubDB.accdb;";
            string query = "SELECT COUNT(*) FROM Voucher WHERE User_ID = ? AND Claim_Date = ?";

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            using (OleDbCommand cmd = new OleDbCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("?", userId);
                cmd.Parameters.AddWithValue("?", DateTime.Today.ToShortDateString());

                conn.Open();
                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }

        
    }
}
