using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MP_Grub
{
    public partial class EditProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void SaveProfileValidation(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(username.Text) &&
                !string.IsNullOrWhiteSpace(password.Text) &&
                !string.IsNullOrWhiteSpace(confirmPassword.Text) &&
                password.Text == confirmPassword.Text &&
                !string.IsNullOrWhiteSpace(fullName.Text) &&
                !string.IsNullOrWhiteSpace(birthdate.Text) &&
                !string.IsNullOrWhiteSpace(contact.Text) &&
                !string.IsNullOrWhiteSpace(address.Text))
            {
                Response.Redirect("Profile.aspx");
            }
        }
    }

}