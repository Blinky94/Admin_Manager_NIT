using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace Admin_Manager_NIT
{
      public partial class WebForm1 : System.Web.UI.Page
      {
            string scriptPow = @"E:\AdvancedC#\Admin_Manager_NIT\powershell\getMailListMembers.ps1";
            string outPut = @"E:\AdvancedC#\Admin_Manager_NIT\powershell\tmp\output.txt";
            List<string> listOutPut = new List<string>();

            protected void Page_Load(object sender, EventArgs e)
            {
             
            }

            /// <summary>
            /// DropBox result from Go-Search_LDClick method
            /// </summary>
            /// <param name="sender"></param>
            /// <param name="e"></param>
            protected void Result_MailingList(object sender, EventArgs e)
            {
                 
            }


            /// <summary>
            /// Go Search button on event click action
            /// </summary>
            /// <param name="sender"></param>
            /// <param name="e"></param>
            protected void Go_Search_LDClick(object sender,EventArgs e)
            {
                  ExecutePowerShellCommand.RunScript(ExecutePowerShellCommand.LoadScript(scriptPow));

                  listOutPut = ReadFileOutPut.GetLineFromFile(outPut);
                  int Id = 1;
                  int countList = listOutPut.Count;

                  for(int i = Id;i <= countList; i++)
                  {
                        TableRow tr = new TableRow();
                        TableCell idCell = new TableCell();
                        TableCell adressCell = new TableCell();
                        TableCell imageCell = new TableCell();

                        OwnerTable.Rows.Add(tr);
                        //MembersTable.Rows.Add(tr);

                        idCell.Text = Convert.ToString(i);
                        adressCell.Text = listOutPut[i-1];
                        imageCell.Text = string.Format("<a href=\"#openModal\"><img class=\"loupe\" src=\"Images/loupe.png\" width=\"20\"/></a>");
                        // Add the TableCell to the TableRow
                        tr.Cells.Add(idCell);
                        tr.Cells.Add(adressCell);
                        tr.Cells.Add(imageCell);

                        mailingList.Items.Add(new ListItem(listOutPut[i-1]));
                  }
            }
      }
}
