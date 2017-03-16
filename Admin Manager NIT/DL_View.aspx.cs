using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace Admin_Manager_NIT
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        string getMailListMembers = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getMailListMembers.ps1";
        string getMailListOwners = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getMailListOwners.ps1";
        string getMailListDL = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\getMailListDL.ps1";

        string outputowner = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outputowner.txt";
        string outputmember = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outputmember.txt";
        string outputDistribution = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\outputDistribution.txt";

        List<string> listOutPutOwner = new List<string>();
        List<string> listOutPutMember = new List<string>();
        List<string> listOutPutDL = new List<string>();

        /// <summary>
        /// Method Event Handler when click on "Go" Button
        /// Generate Distribution List in the DropDownList Box area
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Go_Button_Search_DistributionList(object sender, EventArgs e)
        {
            mailingList.Items.Clear();
            ExecutePowerShellCommand.RunScript(ExecutePowerShellCommand.LoadScript(getMailListDL));

            listOutPutDL = ReadFileOutPut.GetLineFromFile(outputDistribution);
            int Id = 1;
            int countList = listOutPutDL.Count;

            for (int i = Id; i <= countList; i++)
            {
                mailingList.Items.Add(new ListItem(listOutPutDL[i - 1]));
            }
        }

        /// <summary>
        /// Method to open new Visit Card Details on Click in Loup icon
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void OpenOwnerVisitCard_OnClick(object sender, EventArgs e)
        {



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
            ExecutePowerShellCommand.RunScript(ExecutePowerShellCommand.LoadScript(getMailListOwners));

            listOutPutOwner = ReadFileOutPut.GetLineFromFile(outputowner);
            int Id = 1;
            int countList = listOutPutOwner.Count;

            for (int i = Id; i <= countList; i++)
            {
                TableRow tr = new TableRow();
                TableCell adressCell = new TableCell();
                TableCell imageCell = new TableCell();
                OwnerTable.Rows.Add(tr);
                LinkButton lnkPost = new LinkButton();
                lnkPost.Click += new EventHandler(this.LoupeOnClick);
                adressCell.Text = listOutPutOwner[i - 1];
                lnkPost.Attributes.Add("runat", "server");
                lnkPost.Controls.Add(new Image { ImageUrl = "Images/loupe.png", Width = 20 });
                imageCell.Controls.Add(lnkPost);
                //   imageCell.Text = string.Format("<a href=\"#\"><img class=\"loupe\" src=\"Images/loupe.png\" width=\"20\" onClick=\"OpenOwnerVisitCard_OnClick\" runat=\"server\"/></a>");      
                tr.Cells.Add(adressCell);
                tr.Cells.Add(imageCell);
            }
            Response.Write(" is Clicked");
        }


        protected void LoupeOnClick(object sender, EventArgs e)
        {
            ExecutePowerShellCommand.RunScript(ExecutePowerShellCommand.LoadScript(getMailListMembers));

            listOutPutMember = ReadFileOutPut.GetLineFromFile(outputmember);
            int Id2 = 1;
            int countList2 = listOutPutMember.Count;

            for (int i = Id2; i <= countList2; i++)
            {
                TableRow tr = new TableRow();
                // TableCell idCell = new TableCell();
                TableCell adressCell = new TableCell();
                TableCell imageCell = new TableCell();
                MembersTable.Rows.Add(tr);

                LinkButton lnkPost = new LinkButton();

                adressCell.Text = listOutPutMember[i - 1];
                lnkPost.Attributes.Add("runat", "server");
                lnkPost.Controls.Add(new Image { ImageUrl = "Images/loupe.png", Width = 20 });
                imageCell.Controls.Add(lnkPost);
                /*  adressCell.Text = listOutPutMember[i - 1];
                  imageCell.Text = string.Format("<a href=\"#openModal\"><img class=\"loupe\" src=\"Images/loupe.png\" width=\"20\"/></a>");*/
                tr.Cells.Add(adressCell);
                tr.Cells.Add(imageCell);
            }
        }

        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
        }
    }
}
