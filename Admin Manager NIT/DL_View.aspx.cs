using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Office.Interop.Outlook;

namespace Admin_Manager_NIT
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        string getMailListMembers = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getMailListMembers.ps1";
        string getMailListOwners = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getMailListOwners.ps1";
        string getMailListDL = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getDistributionList.ps1";
        string getMailListDL_no = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getDistributionList_no_arg.ps1";
        
        string outputowner = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outputowner.txt";
        string outputmember = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outputmember.txt";
        string outputDistribution = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outputDistribution.txt";
        string emailType = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\EmailType\Email_To_Member.txt";

        List<string> listOutPutOwner = new List<string>();
        List<string> listOutPutMember = new List<string>();
        List<string> listOutPutDL = new List<string>();
  
        string memberPhoto = string.Empty;
        string ownerPhoto = string.Empty;

        /// <summary>
        /// Load_Page to load the page with or without dynamic controls
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] == null)
            {
                Response.Redirect("Authentification.aspx?erreur=1");
            }

            SetOwnerVisitCard_Visible(false);
            SetMemberVisitCard_Visible(false);

            if (Convert.ToString(ViewState["Generated"]) == "true")
            {             
                GenerateTableOwner(_DL_Selected);             
                //GenerateTableMember(_DL_Selected);

                if(Page.IsPostBack)
                {
                    if(owner_details.Text.Length > 0)
                    OpenOwnerVisitCard_OnClick(sender, e);
                    if(member_details.Text.Length > 0)
                    OpenMemberVisitCard_OnClick(sender, e);
                }
            }
        }

        string wordsToSearch;
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
                ExecutePowerShellCommand.RunScriptWithNoArgument(ExecutePowerShellCommand.LoadScript(getMailListDL_no));

            listOutPutDL = ReadFileOutPut.GetLineFromFile(outputDistribution);
            int Id = 1;
            int countList = listOutPutDL.Count;

            for (int i = Id; i <= countList; i++)           
                mailingList.Items.Add(new ListItem(listOutPutDL[i - 1]));      
        }

        int index = 0;
        /// <summary>
        /// Load current photo webControl into current photo-area controls
        /// with proportional width
        /// </summary>
        /// <param name="currentImage"></param>
        /// <param name="photo_area"></param>
        protected void PhotosLoading(string currentImage,System.Web.UI.HtmlControls.HtmlControl photo_area)
        {
            photo_area.Controls.Clear();
            System.Web.UI.WebControls.Image img = new System.Web.UI.WebControls.Image();
            img.ImageUrl = currentImage; // setting the path to the image
            img.Width = 125;
            img.ID = currentImage + Convert.ToString(index++);       
            photo_area.Controls.Add(img);
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
            {
                toDest += listOutPutOwner[i - 1] + ";";
            }
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
        /// Set Visit Card for Owners visible or invisible to the DL_View.aspx page
        /// in specific case with bool factor
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void SetOwnerVisitCard_Visible(bool _IsVisible)
        {
            title_owner.Visible = _IsVisible;
            owner_details_area.Visible = _IsVisible;
            owner_details.Visible = _IsVisible;
            owner_photo_area.Visible = _IsVisible;
        }

        /// <summary>
        /// Set Visit Card for Members visible or invisible to the DL_View.aspx page
        /// in specific case with bool factor
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void SetMemberVisitCard_Visible(bool _IsVisible)
        {
            title_member.Visible = _IsVisible;
            member_details_area.Visible = _IsVisible;
            member_details.Visible = _IsVisible;
            member_photo_area.Visible = _IsVisible;      
        }

        /// <summary>
        /// Method to open new Member Visit Card Details on Click in Loup icon
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void OpenMemberVisitCard_OnClick(object sender,EventArgs e)
        {          
            memberPhoto = "~/Images/lhermitte.jpg"; 
            PhotosLoading(memberPhoto, member_photo_area);  

            member_details.Text = string.Empty;
            member_details.Text += "Thierry" + "\n";
            member_details.Text += "L'HERMITE" + "\n";
            member_details.Text += "Ingénieur de production" + "\n";
            member_details.Text += "01 42 05 52 14";
            member_details.ReadOnly = true;

            //LinkButton definition with current member email adress
            LinkButtonMember.Text = "thierry.l_hermite@neurones.net";
            LinkButtonMember.ForeColor = System.Drawing.Color.White;
            LinkButtonMember.Font.Name = "Trocchi";
            LinkButtonMember.Font.Size = 15;

            SetMemberVisitCard_Visible(true);
        }

        /// <summary>
        /// Method to open new Owner Visit Card Details on Click in Loup icon
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void OpenOwnerVisitCard_OnClick(object sender, EventArgs e)
        {
            ownerPhoto = "~/Images/CAZE-SULFOURT FREDERIC.jpg";
            PhotosLoading(ownerPhoto, owner_photo_area);
     
            owner_details.Text = string.Empty;//Empty textbox for refreshing the information
            owner_details.Text += "Frédéric" + "\n";
            owner_details.Text += "CAZE-SULFOURT" + "\n";
            owner_details.Text += "Developer" + "\n";
            owner_details.Text += "01 42 05 87 99";
            owner_details.ReadOnly = true;

            //LinkButton definition with current owner email adress
            LinkButtonOwner.Text = "frederic.caze-sulfourt@neurones.net";
            LinkButtonOwner.ForeColor = System.Drawing.Color.White;
            LinkButtonOwner.Font.Name = "Trocchi";
            LinkButtonOwner.Font.Size = 15;
           
            SetOwnerVisitCard_Visible(true);
        }

        /// <summary>
        /// Generate the table dynamically with the powerShell scripts for the Owners
        /// </summary>
        private void GenerateTableOwner(string LD_selected)
        {
            //ExecutePowerShellCommand.RunScriptWithNoArgument(ExecutePowerShellCommand.LoadScript(getMailListOwners));
            ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(getMailListMembers), LD_selected);
            listOutPutOwner = ReadFileOutPut.GetLineFromFile(outputowner);
            int countList = listOutPutOwner.Count;

            for (int i = 1; i <= countList; i++)
            {
                TableRow tr = new TableRow();
                TableCell adressCell = new TableCell();
                TableCell imageCell = new TableCell();
                OwnerTable.Rows.Add(tr);
                adressCell.Text = listOutPutOwner[i - 1];
                LinkButton img = new LinkButton();
                img.ID = adressCell.Text;
                img.Click += new EventHandler(OpenOwnerVisitCard_OnClick);
                img.Controls.Add(new System.Web.UI.WebControls.Image { ImageUrl = "Images/loupe.png", Width = 20 });

                imageCell.Controls.Add(img);
                tr.Cells.Add(adressCell);
                tr.Cells.Add(imageCell);
            }
        }

        /// <summary>
        /// Generate the table dynamically with the powerShell scripts for the Members
        /// </summary>
        private void GenerateTableMember(string LD_selected)
        {
            ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(getMailListMembers),LD_selected);

            listOutPutMember = ReadFileOutPut.GetLineFromFile(outputmember);
            int countList = listOutPutMember.Count;

            for (int i = 1; i <= countList; i++)
            {
                TableRow tr = new TableRow();
                TableCell adressCell = new TableCell();
                TableCell imageCell = new TableCell();
                MembersTable.Rows.Add(tr);
                adressCell.Text = listOutPutMember[i - 1];
                LinkButton img = new LinkButton();
                img.ID = adressCell.Text;            
                img.Click += new EventHandler(OpenMemberVisitCard_OnClick);
                img.Controls.Add(new System.Web.UI.WebControls.Image { ImageUrl = "Images/loupe.png", Width = 20 });

                imageCell.Controls.Add(img);
                tr.Cells.Add(adressCell);
                tr.Cells.Add(imageCell);
            }
        }

        string _DL_Selected;

        /// <summary>
        /// Method Event Handler when click on "Go!" Button
        /// Generate Owners List in the result DropDownList
        /// Generate Members List in the result DropDownList
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Select_Button_DistributionList(object sender, EventArgs e)
        {
            if (Convert.ToString(ViewState["Generated"]) != "true")
            {
                _DL_Selected = mailingList.Text;
                //ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + _DL_Selected + "');", true);

                //GenerateTableMember(_DL_Selected);
                GenerateTableOwner(_DL_Selected);
                ViewState["Generated"] = "true";
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
