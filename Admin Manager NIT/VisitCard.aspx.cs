using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace Admin_Manager_NIT
{
    public partial class VisitCard : System.Web.UI.Page
    {
        string scriptGetUserPhoto = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\GetBinariesToPhoto.ps1";
        string _path = @"C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\Admin Manager NIT\Images\";
        private string surName;
        private string givenName;
        private string title;
        private string officePhone;
        private string mail;

        string memberPhoto = string.Empty;
        string ownerPhoto = string.Empty;
        int index = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            surName = (string)(Session["Surname"]);
            givenName = (string)(Session["GivenName"]); 
            title= (string)(Session["Title"]);
            officePhone = (string)(Session["OfficePhone"]);
            mail = (string)(Session["Mail"]);

            OpenVisitCard();                          
        }

        /// <summary>
        /// Load current photo webControl into current photo-area controls
        /// with proportional width
        /// </summary>
        /// <param name="currentImage"></param>
        /// <param name="photo_area"></param>
        protected void PhotosLoading(string currentImage, HtmlControl photo_area)
        {
            photo_area.Controls.Clear();
            Image img = new Image()
            {
                ImageUrl = currentImage, // setting the path to the image
                Width = 170,
                ID = currentImage + Convert.ToString(index++)
            };
            photo_area.Controls.Add(img);
        }

        /// <summary>
        /// Test if file exist in specific folder
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        protected bool IsFileExistInFolder(string path)
        {
            if (System.IO.File.Exists(path))
                return true;
            else
                return false;
        }

        /// <summary>
        /// Method to open new Owner Visit Card Details on Click in Loup icon
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void OpenVisitCard()
        {
            ExecutePowerShellCommand.RunScriptWithArgument(ExecutePowerShellCommand.LoadScript(scriptGetUserPhoto), surName);

            if (IsFileExistInFolder(_path + surName + ".jpg"))
                ownerPhoto = "~/Images/" + surName + ".jpg";
            else
                ownerPhoto = "~/Images/Empty.jpg";

            // ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + ownerPhoto.ToString() + "');", true);

            PhotosLoading(ownerPhoto, photo_area);

            details.Text = string.Empty;//Empty textbox for refreshing the information
            details.Text += givenName + "\n";
            details.Text += surName +  "\n";
            details.Text += title + "\n";
            details.Text += officePhone + "\n";
            details.Text += mail;
            details.ReadOnly = true;    
        }
    }
}