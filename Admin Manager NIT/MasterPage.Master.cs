using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin_Manager_NIT
{

    public partial class Master_Page_Admin_Manager_NIT : System.Web.UI.MasterPage
    {
        /// <summary>
        /// Method to the page load
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            //logout.Attributes["class"] = "notVisible";
            //menuClass.Attributes["class"] = "notVisible";
            //Empty
        }

        /// <summary>
        /// Method to disconnect the current user
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Logout_OnClick(object sender,EventArgs e)
        {
            Session.Abandon();
            Session.Clear();
            Session.RemoveAll();
            System.Web.Security.FormsAuthentication.SignOut();
            Response.Redirect("Auth_Page.aspx",false);
        }

        protected void ViewLink_OnClick(object sender,EventArgs e)
        {
            //Session.Abandon();
            //Session.Clear();
            //Session.RemoveAll();
            //System.Web.Security.FormsAuthentication.SignOut();
            Response.Redirect("DL_View.aspx", false);
        }

        protected void EditLink_OnClick(object sender,EventArgs e)
        {         
            Response.Redirect("DL_View.aspx", false);
        }
    }
}