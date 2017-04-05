using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin_Manager_NIT
{
    public partial class VisitCard : System.Web.UI.Page
    {
        private string surName;
        private string givenName;
        private string title;
        private string officePhone;
        private string mail;

        string memberPhoto = string.Empty;
        string ownerPhoto = string.Empty;
        int index = 0;
        private string nameSelected;

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
        protected void PhotosLoading(string currentImage, System.Web.UI.HtmlControls.HtmlControl photo_area)
        {
            photo_area.Controls.Clear();
            System.Web.UI.WebControls.Image img = new System.Web.UI.WebControls.Image();
            img.ImageUrl = currentImage; // setting the path to the image
            img.Width = 125;
            img.ID = currentImage + Convert.ToString(index++);
            photo_area.Controls.Add(img);
        }

        /// <summary>
        /// Method to open new Owner Visit Card Details on Click in Loup icon
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void OpenVisitCard()
        {
            ownerPhoto = "~/Images/CAZE-SULFOURT FREDERIC.jpg";
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