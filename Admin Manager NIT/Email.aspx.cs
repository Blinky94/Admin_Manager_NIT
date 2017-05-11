using System;
using System.Collections.Generic;
using System.Net.Mail;

namespace Admin_Manager_NIT
{
    public partial class Email : System.Web.UI.Page
    {
        private string fromEmail;
        private string listMailOwners;
        private string subjectEmail;
        private List<string> body;
        private string smtpClient = "nitcas01.neuronesit.priv";
        private string finalBody = string.Empty;

        /// <summary>
        /// Method Loading Page Email.aspx
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                body = new List<string>();
                //Display mail from, mail to, subject and body for the email
                fromEmail = (string)(Session["login"]);
                mailFrom.Text = fromEmail;

                // foreach(string name in listMailOwners)
                //     mailTo.Text += name + ";";
                listMailOwners = (string)(Session["_listMailOwners"]);
                mailTo.Text += listMailOwners;

                subjectEmail = (string)(Session["subjectEmail"]);
                subject.Text = subjectEmail;

                body = (List<string>)(Session["body"]);

                email_text.Text += "\n";
                                       
                if(body != null)
                {
                    foreach (var word in body)
                    {
                        email_text.Text += word;
                        email_text.Text += "\n";
                        finalBody += word;
                        finalBody += "\n";
                    }
                }              
            }    
            else
            {
                SendEmail_OnClick(sender, null);
            }     
        }

        /// <summary>
        /// Method to Send Email
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void SendEmail_OnClick(object sender, EventArgs e)
        {
           // ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + "login : " + (string)Session["login"] + " pass : " + (string)Session["password"] + "');", true);

            string _message = "Email Sent successfully";
            try
            {             
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(fromEmail);
                mail.To.Add(listMailOwners);
                SmtpClient smtpServer = new SmtpClient(smtpClient);
                mail.Subject = subjectEmail;
                mail.Body = finalBody;
                smtpServer.Credentials = new System.Net.NetworkCredential((string)Session["login"], (string)Session["password"]);
                smtpServer.EnableSsl = false;
                //smtpServer.EnableSsl = true;
                smtpServer.UseDefaultCredentials = false;
                //smtpServer.Port = 465;
                smtpServer.Port = 25;
                smtpServer.Send(mail);

                //Routine to signify the email has been sent                         
                ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + _message.ToString() + "');", true);
            }
            catch (Exception error)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + error.ToString() + "');", true);
            }
        }
    }
}