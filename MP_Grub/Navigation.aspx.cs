using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace MP_Grub
{
    public partial class Navigation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                carouselImage.ImageUrl = "~/Navigation_Images/1.png";
            }
        }
        protected void btnLeft_Click(object sender, EventArgs e)
        {
            string[] vouchers = {
                "~/Navigation_Images/1.png",
                "~/Navigation_Images/2.png",
                "~/Navigation_Images/3.png",
                "~/Navigation_Images/4.png",
                "~/Navigation_Images/5.png",
                "~/Navigation_Images/6.png",
                "~/Navigation_Images/7.png",
                "~/Navigation_Images/8.png",
                "~/Navigation_Images/9.png",
                "~/Navigation_Images/10.png",
                "~/Navigation_Images/11.png",
                "~/Navigation_Images/12.png",
                "~/Navigation_Images/13.png",
                "~/Navigation_Images/14.png",
                "~/Navigation_Images/15.png"
            };

            Random rnd = new Random();
            int index = rnd.Next(vouchers.Length);
            carouselImage.ImageUrl = vouchers[index];
        }

        protected void btnRight_Click(object sender, EventArgs e)
        {
            string currentImageUrl = carouselImage.ImageUrl.Replace("~/", "");
            Response.Redirect($"AddToCart.aspx?item={Uri.EscapeDataString(currentImageUrl)}");
        }
    }
}