<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Email.aspx.cs" Inherits="Admin_Manager_NIT.Email" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  
    <title>Email To Send</title>
    <link rel="stylesheet" type="text/css" href="../CSS/EmailStyle.css" />

</head>

<body>
    <form id="form1" runat="server">
        
        <div id="title" class="title" runat="server">
            Send Email          
        </div>
        
        <div id="main" class="main" runat="server">
         
            <div id="ref_zone" class="ref_zone" runat="server">  
                <div id="from_" >                     
                    <p>From : </p>
                </div>

                <div id="to_" >                     
                    <p>To : </p>
                </div>

                <div id="subject_" >                     
                    <p>Subject : </p>
                </div>
                  
                <div id="body_" >                                         
                    <p>Body : </p>               
                </div>
            </div>

            <div id="text_zone" class="text_zone" runat="server">
                 
                 <div id="mailFrom_zone" class="mailFrom_zone" runat="server">                  
                    <asp:TextBox ID="mailFrom" runat="server"></asp:TextBox>                  
                </div>

                <div id="mailTo_zone" class="mailTo_zone" runat="server">                  
                    <asp:TextBox ID="mailTo" runat="server"></asp:TextBox>                  
                </div>
                
                <div id="subject_zone" class="subject_zone" runat="server">                      
                    <asp:TextBox ID="subject" runat="server"></asp:TextBox>    
                </div>
                
                <div id="body_zone" class="body_zone" runat="server">                    
                    <asp:TextBox ID="email_text" runat="server" TextMode="MultiLine"></asp:TextBox>       
                </div>                   
    
            </div>
              
            <div id="sendbutton" class="sendbutton" runat="server">                                                                          
                <a href="#" id="ButtonSend" runat="server" onserverclick="Send_Email_Click">SEND !</a>                                                                        
            </div>    
      
        </div>
       
    </form>
</body>
</html>
