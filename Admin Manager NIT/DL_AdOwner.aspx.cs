using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin_Manager_NIT
{
    public partial class DL_AdOwner : Page
    {
        private string scriptToClearFile = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\ClearFileContent.ps1";
        private string scriptGetUers = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\GetUser.ps1";
        private string fileWithUsersList = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\GetUser.txt";
        private string scriptAddOwner = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\AddCoManagersToDL.ps1";
     
        private void SearchOwnerInAD(string _ownerToSearch)
        {
            ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(scriptToClearFile), _ownerToSearch);

            if (_ownerToSearch.Length != 0)
                ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(scriptGetUers), _ownerToSearch);
            else          
                ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(scriptGetUers), "*");         

            List<string> _listUsers = File.ReadAllLines(fileWithUsersList).ToList<string>();

            DL_SelectOwner.Items.Clear();

            int countList = _listUsers.Count;
            int Id = 1;

            for (int i = Id; i <= countList; i++)
                DL_SelectOwner.Items.Add(new ListItem(_listUsers[i - 1]));
        }

        private void CloseCurrentWindow()
        {
            // close the currentpop up window.
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Close", "window.close();", true);
        }

        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {       
            //ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + sender.ToString() + "');", true);
        }

        private void ConfirmSelectedOwnerToAdd(string _ownerToAddSelected)
        {     
            _ownerToAddSelected = _ownerToAddSelected.Split(' ')[0];
            string _currentDL = (string)(Session["DistributionList"]);
            string _userToDL = _ownerToAddSelected + "@" + _currentDL;

            if (_userToDL.Length != 0)          
                ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(scriptAddOwner), _userToDL);

            Session.Add("ReloadDLPage", "true");

            CloseCurrentWindow();
        }

        protected void Button_Click(object source, EventArgs args)
        {
            LinkButton _lnkBtn = (LinkButton)source;

            switch (_lnkBtn.ID)
            {
                case "SearchButton":
                    SearchOwnerInAD(DL_SearchOwner.Text.ToString());
                    break;
                case "confirmButton":
                    ConfirmSelectedOwnerToAdd(DL_SelectOwner.Text.ToString());
                    break;
                case "cancelButton":
                    CloseCurrentWindow();
                    break;
            }
        }     
    }
}