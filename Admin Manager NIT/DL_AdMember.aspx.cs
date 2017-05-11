using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Admin_Manager_NIT
{
    public partial class DL_AdMember : Page
    {
        private string scriptToClearFile = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\ClearFileContent.ps1";
        private string scriptGetUers = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\GetUser.ps1";
        private string fileWithUsersList = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\GetUser.txt";
        private string scriptAddMember = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\AddUser.ps1";
    
        protected void SearchMemberInAD(string _memberToSearch)
        {
            ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(scriptToClearFile), _memberToSearch);

            if (_memberToSearch.Length != 0)
                ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(scriptGetUers), _memberToSearch);
            else
                ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(scriptGetUers), "*");

            List<string> _listUsers = File.ReadAllLines(fileWithUsersList).ToList<string>();

            DL_SelectMember.Items.Clear();

            int countList = _listUsers.Count;
            int Id = 1;

            for (int i = Id; i <= countList; i++)
                DL_SelectMember.Items.Add(new ListItem(_listUsers[i - 1]));
        }

        private void CloseCurrentWindow()
        {
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Close", "window.close();", true);
        }

        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
            //ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + sender.ToString() + "');", true);
        }

        private void ConfirmSelectedMemberToAdd(string _memberToAddSelected)
        {
            _memberToAddSelected = _memberToAddSelected.Split(' ')[0];
            string _currentDL = (string)(Session["DistributionList"]);
            string _userToDL = _memberToAddSelected + "@" + _currentDL;

            if (_userToDL.Length != 0)
                ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(scriptAddMember), _userToDL);

            Session.Add("ReloadDLPage", "true");//allow reloding DL_view.aspx page on demand
            
            CloseCurrentWindow();
        }

        protected void Button_Click(object source, EventArgs args)
        {
            LinkButton _lnkBtn = (LinkButton)source;

            switch (_lnkBtn.ID)
            {
                case "SearchButton":
                    SearchMemberInAD(DL_SearchMember.Text.ToString());
                    break;
                case "confirmButton":
                    ConfirmSelectedMemberToAdd(DL_SelectMember.Text.ToString());
                    break;
                case "cancelButton":
                    CloseCurrentWindow();
                    break;
            }
        }
    }
}