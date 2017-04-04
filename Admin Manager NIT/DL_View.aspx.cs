using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin_Manager_NIT
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        string scriptGetMembers = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getMembers.ps1";
        string scriptGetOwners = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getOwners.ps1";
        string getMailListDL = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getDistributionList.ps1";
        string getMailListDL_NoArg = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getDistributionList_no_arg.ps1";
        string fileWithOwners = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outputowner.txt";
        string fileWithMembers = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outputmember.txt";
        string outputDistribution = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outputDistribution.txt";
        string emailType = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\EmailType\Email_To_Member.txt";

        List<string> listOutPutDL = new List<string>(); 
        string memberPhoto = string.Empty;
        string ownerPhoto = string.Empty;
        string wordsToSearch;
        GenerateTableMailingList genOwners, genMembers;
        string _DL_Selected;

        /// <summary>
        /// Load_Page to load the page with or without dynamic controls
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] == null)
                Response.Redirect("Authentification.aspx?erreur=1");

            if (!IsPostBack)
            {  }
            else
                SelectButton_OnClick(sender, e);     
        }

        /// <summary>
        /// Method Event Handler when click on "Go" Button
        /// Generate Distribution List in the DropDownList Box area
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GoButton_OnClick(object sender, EventArgs e)
        {           
            //ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + wordsToSearch + "');", true);
            mailingList.Items.Clear();

            if (SearchDLTextBox.Text.Length != 0)     
                ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(getMailListDL),wordsToSearch);
            else
                ExecutePowerShellCommand.RunScriptWithNoArgument(ExecutePowerShellCommand.LoadScript(getMailListDL_NoArg));

           foreach(ListItem item in mailingList.Items)
                item.Attributes.Add("style", "font-family:Trocchi 15");
                      
            listOutPutDL = ReadFileOutPut.GetLineFromFile(outputDistribution);
            int Id = 1;
            int countList = listOutPutDL.Count;

            for (int i = Id; i <= countList; i++)           
                mailingList.Items.Add(new ListItem(listOutPutDL[i - 1]));      
        }

        /// <summary>
        /// Make an Email to the list Owners of a specific Distribution List
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void RequestOwnerShipButton_OnClick(object sender,EventArgs e)
        {
            List<String> list = new List<string>();
            list = ReadFileOutPut.GetLineFromFile(fileWithOwners);
            int countList = list.Count;

            string toDest = string.Empty;

            for (int i = 1; i <= countList; i++)
                toDest += list[i - 1] + ";";
            
            //Send info to Email.aspx page
            Session.Add("fromEmail", "frederic.caze-sulfourt@neurones.net");
            string subjectToOwner = "Request to Owner NAM/NIT";         
            Session.Add("toDest", toDest);
            Session.Add("subjectEmail", subjectToOwner);
            Session.Add("body", ReadFileOutPut.GetLineFromFile(emailType));

            // open a pop up window at the center of the page.
            ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( 'Email.aspx', null, 'height=700,width=1000,status=yes,toolbar=no,scrollbars=yes,menubar=no,location=no,top=\'+Mtop+\', left=\'+Mleft+\'' );", true);
        }

        /// <summary>
        /// Method Event Handler when click on "Go!" Button
        /// Generate Owners List in the result DropDownList
        /// Generate Members List in the result DropDownList
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void SelectButton_OnClick(object sender, EventArgs e)
        {
            try
            {
                int _ID = 1;
                genOwners = new GenerateTableMailingList();
                genMembers = new GenerateTableMailingList();
                tableMembersControl.Controls.Clear();
                tablOwnersControl.Controls.Clear();
                _DL_Selected = mailingList.Text;
                genMembers.GenerateTable(scriptGetMembers, _DL_Selected, fileWithMembers, tableMembersControl,_ID);
                _ID = 999;
                genOwners.GenerateTable(scriptGetOwners, _DL_Selected, fileWithOwners, tablOwnersControl,_ID);
            }
            catch (Exception error)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + error.ToString() + "');", true);
            }
        }  

        /// <summary>
        /// Get input user string to search words in Distribution List 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {           
            wordsToSearch = SearchDLTextBox.Text;
        }    
    }
}
