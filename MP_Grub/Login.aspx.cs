using System;
using System.Web.UI;

namespace grub
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Any page load logic here
        }

        protected void loginValidation(object sender, EventArgs e)
        {
            string usernameInput = usernametxt.Text.Trim();
            string passwordInput = passwordtxt.Text.Trim();

            if (AccountValidation(usernameInput, passwordInput))
            {
                // Placeholder for successful login logic
                Response.Redirect("Home.aspx"); // Redirect to the home page
            }
            else
            {
                Response.Write("<script>alert('Invalid username or password!');</script>");
            }
        }

        private bool AccountValidation(string usernameInput, string passwordInput)
        {
            return !string.IsNullOrEmpty(usernameInput) && !string.IsNullOrEmpty(passwordInput);
        }
    }
}
