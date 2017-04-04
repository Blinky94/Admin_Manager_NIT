using System;
using System.Collections.Generic;
using System.Net.Mail;
using System.Web.UI;

namespace Admin_Manager_NIT
{
    public partial class Email : System.Web.UI.Page
    {
        private string fromEmail;
        private string _listMailOwners;
        private string subjectEmail;
        private List<string> body;

        /// <summary>
        /// Method Loading Page Email.aspx
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            //Display mail from, mail to, subject and body for the email
            fromEmail = (string)(Session["fromEmail"]);
            mailFrom.Text = fromEmail;

            // foreach(string name in listMailOwners)
            //     mailTo.Text += name + ";";
            _listMailOwners = (string)(Session["_listMailOwners"]);
            mailTo.Text += _listMailOwners;

            subjectEmail = (string)(Session["subjectEmail"]);
            subject.Text = subjectEmail;

            body = (List<string>)(Session["body"]);
              
            email_text.Text += "\n";//For the email body presentation
            //Restore the complete EmailType used
            foreach (var word in body)
            {
                email_text.Text += word;
                email_text.Text += "\n";
            }
        }

        /// <summary>
        /// Method to Send Email
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Send_Email_Click(object sender, EventArgs e)
        {
            ClientScriptManager cs = Page.ClientScript;
            Type csType = this.GetType();

            MailMessage mailMessage = new MailMessage();
            mailMessage.From = new MailAddress(fromEmail);
            mailMessage.To.Add(_listMailOwners);
            mailMessage.Subject = subjectEmail;
            mailMessage.Body = subjectEmail;
            SmtpClient smtpClient = new SmtpClient("192.168.");
            smtpClient.EnableSsl = false;
            smtpClient.Send(mailMessage);

            //Routine to signify the email has been sent                         
            cs.RegisterStartupScript(csType, "myAlert", "<script language=JavaScript>window.alert('Email sent !');</script>");                     
        }
    }
}