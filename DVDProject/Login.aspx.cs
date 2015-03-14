using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace DVDProject
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginButton_Click(object sender, EventArgs e)
        {
            if (FormsAuthentication.Authenticate(usernameTextBox.Text,
                 passwordTextBox.Text))
            {
                FormsAuthentication.RedirectFromLoginPage(usernameTextBox.Text, true);
            }
        }
    }
}