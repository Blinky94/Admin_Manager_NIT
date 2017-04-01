using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin_Manager_NIT
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        string getMembers_script = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getMembers.ps1";
        string getOwners_script = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getOwners.ps1";
        string getMailListDL = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getDistributionList.ps1";
        string getMailListDL_NoArg = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getDistributionList_no_arg.ps1";

        string outputowner = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outputowner.txt";
        string outputmember = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outputmember.txt";
        string outputDistribution = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outputDistribution.txt";
        string emailType = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\EmailType\Email_To_Member.txt";

        List<string> listOutPutOwner = new List<string>();
        List<string> listOutPutMember = new List<string>();
        List<string> listOutPutDL = new List<string>();
  
        string memberPhoto = string.Empty;
        string ownerPhoto = string.Empty;

        string wordsToSearch;
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
            {
                //MembersTable.Controls.Clear();
                //OwnerTable.Controls.Clear();
                Select_Button_DistributionList(sender, e);
            }   
            else
                mailingList.Items.Clear();
        }

        /// <summary>
        /// Method Event Handler when click on "Go" Button
        /// Generate Distribution List in the DropDownList Box area
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Go_Button_Search_DistributionList(object sender, EventArgs e)
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
        protected void GenerateEmailToSend_Click(object sender,EventArgs e)
        {
            listOutPutOwner = ReadFileOutPut.GetLineFromFile(outputowner);
            int countList = listOutPutOwner.Count;

            string toDest = string.Empty;

            for (int i = 1; i <= countList; i++)
                toDest += listOutPutOwner[i - 1] + ";";
            
            //Send info to Email.aspx page
            Session.Add("fromEmail", "frederic.caze-sulfourt@neurones.net");
            string subjectToOwner = "Request to Owner NAM/NIT";         
            Session.Add("toEmail", toDest);
            Session.Add("subjectEmail", subjectToOwner);
            Session.Add("body", ReadFileOutPut.GetLineFromFile(emailType));

            // open a pop up window at the center of the page.
            ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( 'Email.aspx', null, 'height=700,width=1000,status=yes,toolbar=no,scrollbars=yes,menubar=no,location=no,top=\'+Mtop+\', left=\'+Mleft+\'' );", true);
        } 

        /// <summary>
        /// Generate the table dynamically with the powerShell scripts for the Owners
        /// </summary>
        private void GenerateTableOwner(string LD_selected)
        {
            ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(getOwners_script), LD_selected);
            listOutPutOwner = ReadFileOutPut.GetLineFromFile(outputowner);
            int countList = listOutPutOwner.Count;

            for (int i = 1; i <= countList; i++)
            {
                TableRow tr = new TableRow();
                TableCell identityCell = new TableCell();
                TableCell imageCell = new TableCell();
                OwnerTable.Rows.Add(tr);
                identityCell.Text = listOutPutOwner[i - 1];
                LinkButton img = new LinkButton();
                img.ID = identityCell.Text;
                img.Click += new EventHandler(OpenVisitCardWindow_OnClick);
                img.Controls.Add(new System.Web.UI.WebControls.Image { ImageUrl = "Images/loupe.png", Width = 20 });
                imageCell.Controls.Add(img);
                tr.Cells.Add(identityCell);
                tr.Cells.Add(imageCell);
            }
        }

        /// <summary>
        /// Generate the table dynamically with the powerShell scripts for the Members
        /// </summary>
        private void GenerateTableMember(string LD_selected)
        {
            ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(getMembers_script), _DL_Selected);

            listOutPutMember = ReadFileOutPut.GetLineFromFile(outputmember);
            int countList = listOutPutMember.Count;

            for (int i = 1; i <= countList; i++)
            {
                TableRow tr = new TableRow();
                TableCell identityCell = new TableCell();
                TableCell imageCell = new TableCell();
                MembersTable.Rows.Add(tr);
                identityCell.Text = listOutPutMember[i - 1];
                LinkButton img = new LinkButton();
                img.ID = identityCell.Text;            
                img.Click += new EventHandler(OpenVisitCardWindow_OnClick);
                img.Controls.Add(new System.Web.UI.WebControls.Image { ImageUrl = "Images/loupe.png", Width = 20 });
                imageCell.Controls.Add(img);               
                tr.Cells.Add(identityCell);
                tr.Cells.Add(imageCell);
            }
        }

        /// <summary>
        /// Method to open new Window and send selected line in Owner List or Member List
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void OpenVisitCardWindow_OnClick(object sender, EventArgs e)
        {
            string opendWindow = "It's Open !";
            ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + opendWindow + "');", true);
            
            //info of the selected line in Owner or Member list exported to VisitCard.aspx.cs
            Session.Add("nameSelected", "frederic caze-sulfourt");
            
            // open a pop up window at the center of the page.
            ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( 'VisitCard.aspx', null, 'height=700,width=1000,status=yes,toolbar=no,scrollbars=yes,menubar=no,location=no,top=\'+Mtop+\', left=\'+Mleft+\'' );", true);
        }

        /// <summary>
        /// Method Event Handler when click on "Go!" Button
        /// Generate Owners List in the result DropDownList
        /// Generate Members List in the result DropDownList
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Select_Button_DistributionList(object sender, EventArgs e)
        {
            OwnerTable.Controls.Clear();
            MembersTable.Controls.Clear();
            _DL_Selected = mailingList.Text;
            GenerateTableMember(_DL_Selected);
            GenerateTableOwner(_DL_Selected);
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
