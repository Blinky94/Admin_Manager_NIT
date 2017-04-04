using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin_Manager_NIT
{
    public class GenerateTableMailingList : System.Web.UI.Page
    {
        List<string> list = new List<string>();
        /// <summary>
        /// Method to open new Window and send selected line in Owner List or Member List
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void VisitCard_OnClick(object sender, EventArgs e)
        {
            string opendWindow = "It's Open !";
            ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + opendWindow + "');", true);

            //info of the selected line in Owner or Member list exported to VisitCard.aspx.cs
            Session.Add("nameSelected", "frederic caze-sulfourt");

            // open a pop up window at the center of the page.
            ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( 'VisitCard.aspx', null, 'height=700,width=1000,status=yes,toolbar=no,scrollbars=yes,menubar=no,location=no,top=\'+Mtop+\', left=\'+Mleft+\'' );", true);
        }

        /// <summary>
        /// Generate the table dynamically with the powerShell scripts for the Owners
        /// </summary>
        public void GenerateTable(string script,string listSelected,string fileWith_,Table table,int _ID)
        {           
            try
            {          
                ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(script), listSelected);
                //list.Clear();
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
    }
}