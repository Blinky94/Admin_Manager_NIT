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
        private string scriptGetMembers = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getMembers.ps1";
        private string scriptGetOwners = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getOwners.ps1";
        private string scriptGetDistributionList = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getDistributionList.ps1";
        private string scriptGetDistributionList_NoArg = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getDistributionList_no_arg.ps1";
        private string scriptToClearFile = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\ClearFileContent.ps1";
        private string scripGetUserDetails = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getUserDetails.ps1";
        private string fileWithOwners = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outputowner.txt";
        private string fileWithMembers = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outputmember.txt";
        private string fileoutputDistribution = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outputDistribution.txt";
        private string emailType = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\EmailType\Email_To_Member.txt";
        private string fileWithOwnersMail = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\getOwnerMail.txt";
        private string scriptgetOwnerMail = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getOwnerMail.ps1";
        private string fileWithUserDetails = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outPutUserDetails.csv";
        private List<string> listOutPutDL = new List<string>();
        private string wordsToSearch;
        private string currentUserLogin,password;
        private List<string> list = new List<string>();
        string path = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\userMdp.txt";

        /// <summary>
        /// Method to activate or desactivate
        /// button fonctionnalities
        /// </summary>
        /// <param name="isActivate"></param>
        protected void ActivateDesactivate_Button(bool isActivate,LinkButton control)
        {
            if(isActivate == true)
            {
                control.Enabled = true;
                control.CssClass = "button";
            }
            else
            {
                control.Enabled = false;
                control.CssClass = "disabledButton";
            }
        }

        /// <summary>
        /// Method to activate or not buttons
        /// If the page is loading, nothing is activated
        /// if the page is not loading, if the current user 
        /// is the owner of the current list, Add and Delete are activated
        /// if not, Add and Delete are not
        /// </summary>
        /// <param name="_isOwner"></param>
        /// <param name="_isLoadingPage"></param>
        protected void ActivateOrNotButtons(bool _isOwner)
        {                          
            if (_isOwner) //Activate Add and Delete buttons buttons
            {
                ActivateDesactivate_Button(true, Add_Owner_Button);
                ActivateDesactivate_Button(true, Del_Owner_Button);
                ActivateDesactivate_Button(true, Del_Member_Button);
                ActivateDesactivate_Button(true, Add_Member_Button);
            }
            else //If not, don't activate Add and Delete buttons
            {
                ActivateDesactivate_Button(false, Add_Owner_Button);
                ActivateDesactivate_Button(false, Del_Owner_Button);
                ActivateDesactivate_Button(false, Del_Member_Button);
                ActivateDesactivate_Button(false, Add_Member_Button);
            }          
        }

        /// <summary>
        /// Load_Page to load the page with or without dynamic controls
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void Page_Load(object sender, EventArgs e)
        {
            currentUserLogin = (string)Session["login"];

            if (password != null)
            {
                password = (string)Session["password"];
                password = Encryptor.MD5Hash(password);
            }
            using (StreamWriter sw = File.AppendText(path))
            {
                sw.WriteLine(currentUserLogin + " : " + password);
            }
           
            if (Session["login"] == null)
                Response.Redirect("Authentification.aspx?erreur=1");

            if (IsPostBack)
            {
                if(Distribution_List.Text.ToString() != string.Empty || (string)(Session["ReloadDLPage"]) == "true")
                {
                    GetUsersFromDistributionList(
                        Distribution_List.Text.ToString(), 
                        tableOwnersControl, 
                        fileWithOwners, 
                        scriptGetOwners, 
                        1);
                    GetUsersFromDistributionList(
                        Distribution_List.Text.ToString(), 
                        tableMembersControl, 
                        fileWithMembers, 
                        scriptGetMembers, 
                        999);
                }              
            }       
        }

        /// <summary>
        /// Method to run PowerShell script
        /// with or without argument
        /// </summary>
        /// <param name="_scriptName"></param>
        /// <param name="_arg"></param>
        private void RunPowerShellScript(string _scriptName,string _stringName_No,string _arg)
        {
            if (_arg.Length != 0)            
                ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(_scriptName), _arg);            
            else           
                ExecutePowerShellCommand.RunScriptWithNoArgument(ExecutePowerShellCommand.LoadScript(_stringName_No));
        }

        /// <summary>
        /// Method to get distribution List from argument put by the user
        /// in the Search area
        /// <param name="arg">Get SearchDLTextBox.Text from here</param>
        /// </summary>
        private void GetDistributionList(string _arg)
        {
            //Run PowerShell script to generate file with DL
            RunPowerShellScript(scriptGetDistributionList, scriptGetDistributionList_NoArg, _arg);  
        
            listOutPutDL = ReadFileOutPut.GetLineFromFile(fileoutputDistribution);
            int Id = 1;
            int countList = listOutPutDL.Count;

            for (int i = Id; i <= countList; i++)
                Distribution_List.Items.Add(new ListItem(listOutPutDL[i - 1]));
        }

        /// <summary>
        /// Method to get Owners or Members from Distribution List
        /// if a new Distribution List is selected
        /// and generate a table
        /// </summary>
        /// <param name="_arg"></param>
        /// <param name="_table"></param>
        /// <param name="_fileOut"></param>
        /// <param name="_script"></param>
        private void GetUsersFromDistributionList(string _arg, Table _table,string _fileOut,string _script,int _ID)
        {        
            if ((string)(Session["DistributionList"]) != _arg || (string)(Session["ReloadDLPage"]) == "true")            
                RunPowerShellScript(_script, _script, _arg);
            
            //Generate OwnersTable
            GenerateTable(_arg, _fileOut, _table, _ID);
        }

        /// <summary>
        /// Method to open an Email Window
        /// with formated text
        /// </summary>
        private void OpenRequestEmailWindow()
        {
            // open a pop up window at the center of the page.
            ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( 'Email.aspx', null, 'height=700,width=1000,status=yes,toolbar=no,scrollbars=yes,menubar=no,location=no,top=\'+Mtop+\', left=\'+Mleft+\'' );", true);
        }

        /// <summary>
        /// Sub Method to open new Email Window
        /// </summary>
        /// <param name="_arg">List of selected box in table</param>
        /// <returns>_list</returns>
        private string GetEmailsFromSelectedBox(string _arg)
        {
            string _list = string.Empty;        
            //Clear the old file
            RunPowerShellScript(scriptToClearFile,scriptToClearFile,fileWithOwnersMail);
            //Check All box selected and get users name from      
            foreach (string _userName in _arg.Split(';'))
                RunPowerShellScript(scriptgetOwnerMail, scriptgetOwnerMail, _userName);
           
            //Get mails in file
            List<string> _listMailOwners = ReadFileOutPut.GetLineFromFile(fileWithOwnersMail);
            //Remove duplicated mails
            _listMailOwners = _listMailOwners.Distinct().ToList<string>();
            //Translate to string list with Email format
            for (int i = 0; i < _listMailOwners.Count; i++)
                _list += _listMailOwners[i] + ";";

            return _list;
        }

        /// <summary>
        /// Method to Implement and fill Email form informations
        /// </summary>
        /// <param name="_arg"></param>
        private void MakeRequestEmail(string _arg)
        {
            string _subjectToOwner = "Request to Owner NAM/NIT";

            //Send info to Email.aspx page
            Session.Add("_listMailOwners", _arg);
            Session.Add("subjectEmail", _subjectToOwner);
            Session.Add("body", ReadFileOutPut.GetLineFromFile(emailType));

            OpenRequestEmailWindow();
        }

        /// <summary>
        /// Method to get a list from checkBox selected in table control
        /// and associate to an email
        /// </summary>
        private void RequestLinkButton(Table table)
        {
            string _listSelected = string.Empty;
            string _listMail = string.Empty;

            _listMail = GetMailFromAllOwners(_listSelected);
            //_listSelected = GetUsersSelectedFromTable(table, chkOwners);
            //_listMail = GetEmailsFromSelectedBox(_listSelected);
            MakeRequestEmail(_listMail);
        }

        /// <summary>
        /// Method to get all mails adresses from Owners
        /// </summary>
        /// <param name="_listSelected"></param>
        /// <returns></returns>
        private string GetMailFromAllOwners(string _listSelected)
        {
            string _listMails = string.Empty;
            List<string> _listOwners = ReadFileOutPut.GetLineFromFile(fileWithOwners);
          
            foreach (string user in _listOwners)           
                RunPowerShellScript(scriptgetOwnerMail, scriptgetOwnerMail, user);

            //Get mails in file
            List<string> _listMailOwners = ReadFileOutPut.GetLineFromFile(fileWithOwnersMail);
            //Remove duplicated mails
            _listMailOwners = _listMailOwners.Distinct().ToList<string>();
       
            //Translate to string list with Email format
            for (int i = 0; i < _listMailOwners.Count; i++)
                _listMails += _listMailOwners[i] + ";";

            return _listMails;
        }

        private void AddOwnerToDistributionList()
        {
            ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( 'DL_AdOwner.aspx', null, 'height=300,width=1000,status=no,toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,top=\'+Mtop+\', left=\'+Mleft+\'' );", true);
        }

        private void DelOwnerFromDistributionList()
        {

        }

        private void AddMemberToDistributionList()
        {
            ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( 'DL_AdMember.aspx', null, 'height=300,width=1000,status=no,toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,top=\'+Mtop+\', left=\'+Mleft+\'' );", true);
        }

        private void DelMemberFromDistributionList(Table _table)
        {
            string _listMembersToRemove = GetUsersSelectedFromTable(_table, chkOwners);
            string _currentDL = Distribution_List.Text.ToString();

            Session.Add("ListMembersToRemove", _listMembersToRemove);
            Session.Add("CurrentDL", _currentDL);

            if(_listMembersToRemove.Length != 0)
                ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( 'DL_RemoveMember.aspx', null, 'height=300,width=1000,status=no,toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,top=\'+Mtop+\', left=\'+Mleft+\'' );", true);
        }

        CheckBox chkOwners,chkMembers;            
      
        /// <summary>
        /// Method Generic to exécute spécific command
        /// </summary>
        /// <param name="source"></param>
        /// <param name="args"></param>
        protected void Button_Click(object source, EventArgs args)
        {
            LinkButton _lnkBtn = (LinkButton)source;
            Session.Add("DistributionList", Distribution_List.Text.ToString());

            switch (_lnkBtn.ID)
            {
                case "GoButton":
                    GetDistributionList(SearchDLTextBox.Text.ToString());
                    break;
                case "SelectButton":
                    GetUsersFromDistributionList(
                        Distribution_List.Text.ToString(), 
                        tableOwnersControl, 
                        fileWithOwners, 
                        scriptGetOwners,
                        1);
                    GetUsersFromDistributionList(
                        Distribution_List.Text.ToString(), 
                        tableMembersControl, 
                        fileWithMembers, 
                        scriptGetMembers,
                        999);
                    break;
                case "request_OwnerShip":
                    RequestLinkButton(tableOwnersControl);                 
                    break;
                case "Request_MemberShip":
                    RequestLinkButton(tableMembersControl);
                    break;
                case "Add_Owner_Button":
                    AddOwnerToDistributionList();
                    break;
                case "Add_Member_Button":
                    AddMemberToDistributionList();
                    break;
                case "Del_Owner_Button":
                    //To be continued
                    break;
                case "Del_Member_Button":
                    DelMemberFromDistributionList(tableMembersControl);
                    break;
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

            // open a pop up window at the center of the page.
            ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( 'VisitCard.aspx', null, 'height=300,width=1000,status=no,toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,top=\'+Mtop+\', left=\'+Mleft+\'' );", true);
        }

        /// <summary>
        /// Method to get checkbox selected in a specific table in parameter
        /// </summary>
        /// <param name="table"></param>
        protected string GetUsersSelectedFromTable(Table table,CheckBox chk)
        {
            string _list = string.Empty;
          
            if (table.Rows != null)
            {
                foreach (TableRow row in table.Rows)
                {
                    if(row.Cells.Count > 0)
                    {
                         chk = row.Cells[0].Controls[0] as CheckBox;
                                             
                        if(chk.Checked)
                            _list += row.Cells[1].Text.ToString() + ";";                             
                    }              
                }
            }
            return _list = _list.Remove(_list.Length - 1); 
        }

        /// <summary>
        /// Generate the table dynamically with the powerShell scripts for the Owners or Members
        /// </summary>
        /// <param name="script"></param>
        /// <param name="listSelected"></param>
        /// <param name="fileWith_"></param>
        /// <param name="table"></param>
        /// <param name="_ID"></param>
        protected void GenerateTable(string listSelected, string fileWith_, Table table, int _ID)
        {
            table.Controls.Clear();

            list = ReadFileOutPut.GetLineFromFile(fileWith_);
            for (int i = 1; i <= list.Count; i++)
            {
                TableRow tr = new TableRow();
                table.Rows.Add(tr);

                TableCell checkBocCell = new TableCell();
                checkBocCell.Width = 20;
                CheckBox checkBox = new CheckBox();
                checkBox.AutoPostBack = true;
                checkBox.EnableViewState = true;
                checkBox.CheckedChanged += new EventHandler(CheckBox_Clicked);
                _ID++;
                checkBox.ID = _ID.ToString();
                checkBocCell.Controls.Add(checkBox);

                TableCell identityCell = new TableCell();
                identityCell.Width = 500;
                identityCell.HorizontalAlign = HorizontalAlign.Left;
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
                tr.Cells.Add(checkBocCell);
                tr.Cells.Add(identityCell);
                tr.Cells.Add(imageCell);
            }
        }

        /// <summary>
        /// Method EventHandler of CheckBox changed
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void CheckBox_Clicked(object sender,EventArgs e)
        {
            if ((string)Session["ReloadDLPage"] == "true")
                Session["ReloadDLPage"] = "false";

            chkOwners = (CheckBox)sender;     
        }

        /// <summary>
        /// Get input user string to search words in Distribution List 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
            Session["ReloadDLPage"] = "false";
            wordsToSearch = SearchDLTextBox.Text;
        }    
    }
}