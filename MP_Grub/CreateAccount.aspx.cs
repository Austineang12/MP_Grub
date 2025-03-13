using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace grub
{
    public partial class CreateAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void signupValidation(object sender, EventArgs e)
        {
            string nameInput = fullnametxt.Text;
            string usernameInput = usernametxt.Text;
            string passwordInput = passwordtxt.Text;
            string birthdateInput = birthdatetxt.Text;
            string contactInput = contacttxt.Text;
            string addressInput = addresstxt.Text;


            if (AccountValidation(nameInput, usernameInput, passwordInput, birthdateInput, contactInput, addressInput))
            {
                Response.Redirect("Home.aspx");
            }
            else
            {
                Response.Write("<script>alert('Invalid username or password!');</script>");
            }
        }

        private bool AccountValidation(string name, string username, string password, string birthdate, string contact, string address)
        {
            return !(string.IsNullOrWhiteSpace(name) ||
                     string.IsNullOrWhiteSpace(username) ||
                     string.IsNullOrWhiteSpace(password) ||
                     string.IsNullOrWhiteSpace(birthdate) ||
                     string.IsNullOrWhiteSpace(contact) ||
                     string.IsNullOrWhiteSpace(address));
        }
    }
}