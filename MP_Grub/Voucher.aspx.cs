using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MP_Grub
{
	public partial class Voucher : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}
        protected void GenerateVoucher(object sender, EventArgs e)
        {
            
            string[] vouchers = { "~/images/Voucher5.png", "~/images/Voucher10.png", "~/images/Voucher20.png" };

            Random rnd = new Random();
            int index = rnd.Next(vouchers.Length); //to randomize voucher options

            VoucherImage.ImageUrl = vouchers[index];
        }
    }
}