using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin_Manager_NIT
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        string scriptGetMembers = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getMembers.ps1";
        string scriptGetOwners = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getOwners.ps1";
        string scriptGetMailListDL = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getDistributionList.ps1";
        string scriptGetMailListDL_NoArg = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getDistributionList_no_arg.ps1";
        string scriptToClearFile = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\ClearFileContent.ps1";
        string scripGetUserDetails = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getUserDetails.ps1";

        string fileWithOwners = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outputowner.txt";
        string fileWithMembers = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outputmember.txt";
        string fileoutputDistribution = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outputDistribution.txt";
        string emailType = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\EmailType\Email_To_Member.txt";
        string fileWithOwnersMail = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\getOwnerMail.txt";
        string scriptgetOwnerMail = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getOwnerMail.ps1";
        string fileWithUserDetails = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outPutUserDetails.csv";
       
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

            if (!IsPostBack){}
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
                ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(scriptGetMailListDL),wordsToSearch);
            else
                ExecutePowerShellCommand.RunScriptWithNoArgument(ExecutePowerShellCommand.LoadScript(scriptGetMailListDL_NoArg));

           foreach(ListItem item in mailingList.Items)
                item.Attributes.Add("style", "font-family:Trocchi 15");
                      
            listOutPutDL = ReadFileOutPut.GetLineFromFile(fileoutputDistribution);
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
            //Variables
            string _subjectToOwner = "Request to Owner NAM/NIT";
            string _finalListMailOwners = string.Empty;       

            try
            {
                //Clear file with owners mail list
                ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(scriptToClearFile), fileWithOwnersMail);

                //Find mail in AD with owners names in file
                foreach (string elem in ReadFileOutPut.GetLineFromFile(fileWithOwners))
                    ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(scriptgetOwnerMail), elem);

                List<string> _listMailOwners = ReadFileOutPut.GetLineFromFile(fileWithOwnersMail);

                //Remove duplicated mails
                _listMailOwners = _listMailOwners.Distinct().ToList<string>();

                //Presentation of mails with ";" like in mail
                foreach (string elem in _listMailOwners)
                    _finalListMailOwners += elem + ";";

                //Send info to Email.aspx page
                Session.Add("fromEmail", "frederic.caze-sulfourt@neurones.net");
                Session.Add("_listMailOwners", _finalListMailOwners);
                Session.Add("subjectEmail", _subjectToOwner);
                Session.Add("body", ReadFileOutPut.GetLineFromFile(emailType));
                
                // open a pop up window at the center of the page.
                ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( 'Email.aspx', null, 'height=700,width=1000,status=yes,toolbar=no,scrollbars=yes,menubar=no,location=no,top=\'+Mtop+\', left=\'+Mleft+\'' );", true);
            }
            catch (Exception error)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + error.ToString() + "');", true);
            }                  
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
                tableMembersControl.Controls.Clear();
                tablOwnersControl.Controls.Clear();
                _DL_Selected = mailingList.Text;
                GenerateTable(scriptGetMembers, _DL_Selected, fileWithMembers, tableMembersControl,_ID);
                _ID = 999;
                GenerateTable(scriptGetOwners, _DL_Selected, fileWithOwners, tablOwnersControl,_ID);
            }
            catch (Exception error)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + error.ToString() + "');", true);
            }
        }

        /// <summary>
        /// Method to open new Window and send selected line in Owner List or Member List
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void VisitCard_OnClick(object sender, EventArgs e)
        {
            LinkButton _btn = (LinkButton)(sender);
            string _value = _btn.Text;
            ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(scripGetUserDetails), _value);

            List<string> _listDetailsUser = File.ReadAllLines(fileWithUserDetails).ToList<string>();
            List<string> lineAr = new List<string>();
            foreach (string line in _listDetailsUser)
            {
                string[] tmpp = line.Split(';');

                foreach(string i in tmpp)
                    lineAr.Add(i);
            }

            //Send info to VisitCard.aspx page         
            Session.Add("GivenName", lineAr[7].Trim('\"'));         
            Session.Add("Surname", lineAr[8].Trim('\"'));
            Session.Add("Title", lineAr[9].Trim('\"'));
            Session.Add("OfficePhone", lineAr[5].Trim('\"'));
            Session.Add("Mail", lineAr[6].Trim('\"'));

            ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( 'VisitCard.aspx', null, 'height=300,width=1000,status=no,toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,top=\'+Mtop+\', left=\'+Mleft+\'' );", true);
            // open a pop up window at the center of the page.
        }

        /// <summary>
        /// Generate the table dynamically with the powerShell scripts for the Owners
        /// </summary>
        public void GenerateTable(string script, string listSelected, string fileWith_, Table table, int _ID)
        {
            List<string> list = new List<string>();

            try
            {
                ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(script), listSelected);

                list = ReadFileOutPut.GetLineFromFile(fileWith_);
                int countList = list.Count;

                for (int i = 1; i <= countList; i++)
                {
                    TableRow tr = new TableRow();
                    table.Rows.Add(tr);

                    TableCell identityCell = new TableCell();

                    identityCell.Text = list[i - 1];
                    _ID++;
                    identityCell.ID = _ID.ToString();

                    LinkButton img = new LinkButton();
                    _ID++;
                    img.Text = list[i - 1];
                    img.ID = _ID.ToString();
                    img.Click += new EventHandler(VisitCard_OnClick);
                    img.Controls.Add(new System.Web.UI.WebControls.Image { ImageUrl = "Images/loupe.png", Width = 20 });

                    TableCell imageCell = new TableCell();
                    imageCell.Controls.Add(img);

                    tr.Cells.Add(identityCell);
                    tr.Cells.Add(imageCell);
                }
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