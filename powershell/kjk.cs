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
        string currentUserLogin;
        List<string> listOwnersFromChecked = new List<string>();
        List<string> listMembersFromChecked = new List<string>();
        List<string> listMailOwners = new List<string>();
        string listOwnersSelected, listMembersSelected;

        /// <summary>
        /// Method to test if currentUser is in the current Owner List
        /// </summary>
        /// <param name="listMailOwners"></param>
        /// <returns></returns>
        protected bool IsCurrentUserInOwnersList(List<string> listMailOwners)
        {
            bool _isuserIsOwnerList = false;

            foreach (string mail in listMailOwners)
                if (mail == currentUserLogin)
                    return _isuserIsOwnerList = true;
                else
                    return _isuserIsOwnerList = false;

            return _isuserIsOwnerList;
        }

        /// <summary>
        /// Method to get Email from specific checked list
        /// </summary>
        /// <param name="list"></param>
        /// <returns></returns>
        protected string GetMailFromSelected(List<string> list)
        {
            string _final = string.Empty;
            listMailOwners.Clear();//RAZ of the old OwnerList
            
            //Clear ownerMailFile
            ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(scriptToClearFile), fileWithOwnersMail);         

            foreach (string elem in list)
                 ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(scriptgetOwnerMail), elem);

            //Get mails in file
            listMailOwners = ReadFileOutPut.GetLineFromFile(fileWithOwnersMail);

            //Remove duplicated mails
            listMailOwners = listMailOwners.Distinct().ToList<string>();

            for(int i = 0; i < listMailOwners.Count; i++)
                _final += listMailOwners[i] + ";";

            return _final;
        }

        /// <summary>
        /// Method to return Mails from Owners list
        /// </summary>
        /// <returns></returns>
        protected List<string> GetMailFromOwners()
        {
            listMailOwners.Clear();//RAZ of the old OwnerList

            //Clean the fileWithOwnersMail
            ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(scriptToClearFile), fileWithOwnersMail);

            //Find mail in AD with owners names in file
            foreach (string elem in ReadFileOutPut.GetLineFromFile(fileWithOwners))
                ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(scriptgetOwnerMail), elem);

            listMailOwners = ReadFileOutPut.GetLineFromFile(fileWithOwnersMail);

            //Remove duplicated mails
            listMailOwners = listMailOwners.Distinct().ToList<string>();

            return listMailOwners;
        }

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
        protected void Page_Load(object sender, EventArgs e)
        {
            currentUserLogin = (string)Session["login"];

            if (Session["login"] == null)
                Response.Redirect("Authentification.aspx?erreur=1");

            if (!IsPostBack){}
            else
            {
                SelectButton_OnClick(sender, e);
                List<string> listOwners = GetMailFromOwners();

                bool _isOwnerInOwnerList = false;

                if (listOwners.Count > 0)
                {
                    SelectButton_OnClick(sender, e);
                    foreach (string mail in listOwners)
                        if (mail.ToLower() == currentUserLogin.ToLower())
                            _isOwnerInOwnerList = true;

                    ActivateOrNotButtons(_isOwnerInOwnerList);
                }
            }       
        }

        /// <summary>
        /// Method Event Handler when click on "Go" Button
        /// Generate Distribution List in the DropDownList Box area
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GoButton_OnClick(object sender, EventArgs e)
        {           
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
        /// Method to Add new Owner
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void AddOwner_OnClick(object sender, EventArgs e)
        {
            try
            {

            }
            catch (Exception error)
            {
                ClientScript.RegisterStartupScript(GetType(), "yourMessage", "alert('" + error.ToString() + "');", true);
            }
        }
        CheckBox chk;
        /// <summary>
        /// Make an Email to the list Owners of a specific Distribution List
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void RequestOwnerShipButton_OnClick(object sender, EventArgs e)
        {
            string _subjectToOwner = "Request to Owner NAM/NIT";
            string _finalListMailOwners = string.Empty;      

            listOwnersFromChecked.Clear();

            try
            {
                listOwnersSelected = GetUsersSelectedFromTable(tablOwnersControl, chk, listOwnersSelected);
                //listMembersSelected = GetUsersSelectedFromTable(tableMembersControl, chk, listMembersSelected);

                listOwnersFromChecked = listOwnersSelected.Split(';').ToList<string>();
                // listMembersFromChecked = listMembersSelected.Split(';').ToList<string>();

                _finalListMailOwners = GetMailFromSelected(listOwnersFromChecked);
              
                //Send info to Email.aspx page
                Session.Add("_listMailOwners", _finalListMailOwners);
                Session.Add("subjectEmail", _subjectToOwner);
                Session.Add("body", ReadFileOutPut.GetLineFromFile(emailType));

                // open a pop up window at the center of the page.
                ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( 'Email.aspx', null, 'height=700,width=1000,status=yes,toolbar=no,scrollbars=yes,menubar=no,location=no,top=\'+Mtop+\', left=\'+Mleft+\'' );", true);

                listOwnersSelected = string.Empty;
                listMembersSelected = string.Empty;
            }
            catch (Exception error)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + error.ToString() + "');", true);
            }
        }

        /// <summary>
        /// Method to Delete Owner
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void DeleteOwner_OnClick(object sender, EventArgs e)
        {
            try
            {

            }
            catch (Exception error)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + error.ToString() + "');", true);
            }
        }

        /// <summary>
        /// Method to Add new Owner
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void AddMember_OnClick(object sender, EventArgs e)
        {
            try
            {

            }
            catch (Exception error)
            {
                ClientScript.RegisterStartupScript(GetType(), "yourMessage", "alert('" + error.ToString() + "');", true);
            }
        }

        /// <summary>
        /// Make an Email to the list Owners of a specific Distribution List
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void RequestMemberShipButton_OnClick(object sender, EventArgs e)
        {

            string _subjectToOwners = "Request to Owners NAM/NIT";
            string _finalListMailOwners = string.Empty;

            listMembersFromChecked.Clear();
            try
            {
                //List<string> _listMailOwners = GetMailFromOwners();

                //Make list email owners with emailTo format ";"
               // foreach (string elem in listCheckedUsers)
                //    _finalListMailOwners += elem + ";";

                //Send info to Email.aspx page
                Session.Add("fromEmail", currentUserLogin);
                Session.Add("_listMails", _finalListMailOwners);
                Session.Add("subjectEmail", _subjectToOwners);
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
        /// Method to Delete Owner
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void DeleteMember_OnClick(object sender, EventArgs e)
        {
            try
            {

            }
            catch (Exception error)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + error.ToString() + "');", true);
            }
        }

        Table ownersTable = new Table(), membersTable = new Table();
        string _oldListSelected = string.Empty;

        /// <summary>
        /// Method Event Handler when click on "Go!" Button
        /// Generate Owners List in the result DropDownList
        /// Generate Members List in the result DropDownList
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void SelectButton_OnClick(object sender, EventArgs e)
        {
            bool _isNewListSelected = false;

            try
            {
                int _ID = 1;
                tableMembersControl.Controls.Clear();
                tablOwnersControl.Controls.Clear();
                _DL_Selected = mailingList.Text;

                if (_DL_Selected != _oldListSelected)                
                    _isNewListSelected = true;         
                else
                    _isNewListSelected = false;

                GenerateTable(_isNewListSelected, scriptGetMembers, _DL_Selected, fileWithMembers, tableMembersControl, _ID);
                _ID = 999;
                GenerateTable(_isNewListSelected,scriptGetOwners, _DL_Selected, fileWithOwners, tablOwnersControl, _ID);
                _oldListSelected = _DL_Selected;
                 
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

            // open a pop up window at the center of the page.
            ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( 'VisitCard.aspx', null, 'height=300,width=1000,status=no,toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,top=\'+Mtop+\', left=\'+Mleft+\'' );", true);
        }

        /// <summary>
        /// Method to get checkbox selected in a specific table in parameter
        /// </summary>
        /// <param name="table"></param>
        protected string GetUsersSelectedFromTable(Table table,CheckBox chk,string listSelected)
        {
            string tot = string.Empty;
          
            if (table.Rows != null)
            {
                foreach (TableRow row in table.Rows)
                {
                    if(row.Cells.Count > 0)
                    {
                         chk = row.Cells[0].Controls[0] as CheckBox;
                                             
                        if(chk.Checked)
                            listSelected += row.Cells[1].Text.ToString() + ";";                             
                    }              
                }
            }
            return listSelected;
        }

        /// <summary>
        /// Generate the table dynamically with the powerShell scripts for the Owners or Members
        /// </summary>
        /// <param name="script"></param>
        /// <param name="listSelected"></param>
        /// <param name="fileWith_"></param>
        /// <param name="table"></param>
        /// <param name="_ID"></param>
        protected void GenerateTable(bool isNewListSelected, string script, string listSelected, string fileWith_, Table table, int _ID)
        {
           
            List<string> listOfUsersInTable = new List<string>();

            try
            {
                if(isNewListSelected)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" +"new list" + "');", true);

                    ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(script), listSelected);

                    listOfUsersInTable = ReadFileOutPut.GetLineFromFile(fileWith_);
                    int countList = listOfUsersInTable.Count;

                    for (int i = 1; i <= countList; i++)
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
                        identityCell.Text = listOfUsersInTable[i - 1];
                        _ID++;
                        identityCell.ID = _ID.ToString();

                        LinkButton img = new LinkButton();
                        _ID++;
                        img.Text = listOfUsersInTable[i - 1];
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
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + "old list" + "');", true);

                    int countList = listOfUsersInTable.Count;

                    for (int i = 1; i <= countList; i++)
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
                        identityCell.Text = listOfUsersInTable[i - 1];
                        _ID++;
                        identityCell.ID = _ID.ToString();

                        LinkButton img = new LinkButton();
                        _ID++;
                        img.Text = listOfUsersInTable[i - 1];
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
            }
            catch (Exception error)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + error.ToString() + "');", true);
            }
        }

        /// <summary>
        /// Method EventHandler of CheckBox changed
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void CheckBox_Clicked(object sender,EventArgs e)
        {                 
            chk = (CheckBox)sender;     
            //ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + listOwnersSelected.ToString() + "');", true);
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