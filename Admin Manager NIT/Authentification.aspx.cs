using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin_Manager_NIT
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["erreur"] != null)
                {
                    lblErreur.Text = "You must be loged to access to the site's fonctionnalities !";
                }
            }
        }

        protected void Connexion_Click(object sender,EventArgs e)
        {
            if (txtLogin.Text == "toto" && txtPass.Text == "123456")
            {
                Session["login"] = txtLogin.Text;
                Response.Redirect("DL_View.aspx");
            }
            else
            {
                lblErreur.Text = "login or password incorrect !";
            }
        }
    }
}