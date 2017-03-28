using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin_Manager_NIT
{
    public partial class Email : System.Web.UI.Page
    {
        private string fromEmail;
        private string toEmail;
        private string subjectEmail;
        private List<string> body;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Get infos from DL_View.aspx page
            fromEmail = (string)(Session["fromEmail"]);
            toEmail = (string)(Session["toEmail"]);
            subjectEmail = (string)(Session["subjectEmail"]);
            body = (List<string>)(Session["body"]);

            //Display mail from, mail to, subject and body for the email
            mailFrom.Text = fromEmail;
            mailTo.Text = toEmail;
            subject.Text = subjectEmail;

            email_text.Text += "\n";//For the email body presentation
            //Restore the complete EmailType used
            foreach (var word in body)
            {
                email_text.Text += word;
                email_text.Text += "\n";
            }
        }

        protected void Send_Email_Click(object sender, EventArgs e)
        {
            ClientScriptManager cs = Page.ClientScript;
            Type csType = this.GetType();

            try
            {
                MailMessage mailMessage = new MailMessage();
                mailMessage.From = new MailAddress(fromEmail);
                mailMessage.To.Add(toEmail);
                mailMessage.Subject = subjectEmail;
                mailMessage.Body = subjectEmail;
                SmtpClient smtpClient = new SmtpClient("192.168.");
                smtpClient.EnableSsl = false;
                smtpClient.Send(mailMessage);

                //Routine to signify the email has been sent                         
                cs.RegisterStartupScript(csType, "myAlert", "<script language=JavaScript>window.alert('Email sent !');</script>");
            }
            catch (Exception ex)
            {
                //Response.Write("Could not send the e-mail - error: " + ex.Message);
                cs.RegisterStartupScript(csType, "myAlert", "<script language=JavaScript>window.alert('Could not send the e-mail - error: '.$ex.Message.');</script>");

            }
        }
    }
}