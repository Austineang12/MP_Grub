﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MP_Grub
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void EditProfileRedirect(object sender, EventArgs e)
        {
            Response.Redirect("EditProfile.aspx");
        }

        protected void GoToHome(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}