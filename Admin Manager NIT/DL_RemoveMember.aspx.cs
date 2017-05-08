using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin_Manager_NIT
{
    public partial class DL_RemoveMember : System.Web.UI.Page
    {
        private string scriptRemoveMember = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\RemoveUserFromDL.ps1";
        private string listMembersToRemove;
        private string currentDL;

        protected void Page_Load(object sender, EventArgs e)
        {
            DL_ListMembersToRemove.ReadOnly = true;

            listMembersToRemove = (string)(Session["ListMembersToRemove"]);
            currentDL = (string)(Session["CurrentDL"]);

            string _finalListToRemove = string.Empty;

            foreach (string member in listMembersToRemove.Split(';'))
            {
                DL_ListMembersToRemove.Text +=  member + Environment.NewLine;
            }
        }

        private void CloseCurrentWindow()
        {
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Close", "window.close();", true);
        }

        private void ConfirmSelectedMemberToRemove()
        {
            string _finalstr = string.Empty;

            if (listMembersToRemove != null)
            {
                foreach (string member in listMembersToRemove.Split(';'))
                {
                    _finalstr = member + "@" + currentDL;
                }

                ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(scriptRemoveMember), _finalstr);
                Session.Add("ReloadDLPage", "true");//allow reloding DL_view.aspx page on demand
                CloseCurrentWindow();
            }
            else
                lblErreur.Text += "No members have been selected !";
        }

        protected void Button_Click(object source, EventArgs args)
        {
            LinkButton _lnkBtn = (LinkButton)source;

            switch (_lnkBtn.ID)
            {         
                case "confirmButton":
                    ConfirmSelectedMemberToRemove();
                    break;
                case "cancelButton":
                    CloseCurrentWindow();
                    break;
            }
        }
    }
}