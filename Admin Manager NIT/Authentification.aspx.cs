﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;
using System.DirectoryServices.Protocols;
using System.Net;

namespace Admin_Manager_NIT
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        string sDomain = "NITINFRA15.neuronesit.priv";

        /// <summary>
        /// Load_Page method
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["erreur"] != null)
                {
                   // lblErreur.Text = "You must be loged to access to the site's fonctionnalities !";
                }             
            }
        }

        /// <summary>
        /// Method to connect to the LDAP
        /// and return true if the user is authenticate
        /// false if not found
        /// </summary>
        /// <param name="login"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        protected void ConnectTo_LDAP(string login, string password)
        {
            string getLogin=string.Empty, getPassword = string.Empty;
            try
            {
                LdapConnection connection = new LdapConnection(sDomain);
                NetworkCredential credential = new NetworkCredential(login,password);
                connection.Credential = credential;
                connection.Bind();

                lblErreur.Text = string.Empty;
                Session["login"] = getLogin;
                Session["password"] = getPassword;

                Response.Redirect("DL_View.aspx");
            }
            catch (LdapException lexc)
            {
                String error = lexc.ServerErrorMessage;
                lblErreur.Text = string.Empty;
                lblErreur.Text += lexc.ServerErrorMessage;
            }
            catch (Exception exc)
            {
                lblErreur.Text = string.Empty;
                lblErreur.Text += "error logon or password";
            }  
        }

        /// <summary>
        /// Methods to connect to LDAP
        /// return to DL_view.aspx if authenticate
        /// else return error login/password
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Connexion_Click(object sender,EventArgs e)
        {
            string getLogin = string.Empty;
            string getPassword = string.Empty;

            getLogin = txtLogin.Text;
            getPassword = txtPass.Text;

            ConnectTo_LDAP(getLogin,getPassword);

           
               // Session["login"] = getLogin;
              //  Session["password"] = getPassword;

              //  Response.Redirect("DL_View.aspx");
            
           // else
           // {
           //     lblErreur.Text = "login or password incorrect !";
           // }
        }
    }
}