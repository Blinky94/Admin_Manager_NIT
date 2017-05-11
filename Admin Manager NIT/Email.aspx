<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Email.aspx.cs" Inherits="Admin_Manager_NIT.Email" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  
    <title>Email To Send</title>
    <link rel="stylesheet" type="text/css" href="../CSS/Mail_Style.css" />

</head>

<body>
    <form id="form1" runat="server">
        <div id="main" class="main" runat="server">
            <fieldset id="DL_E-mail">
                <legend>E-mail</legend>
                <div id="LabelZone" class="LabelZone" runat="server">
                    <div>
                        <asp:Label class="LabelStyle" runat="server" Text="From :"></asp:Label>
                    </div>
                    <div>
                        <asp:Label class="LabelStyle" runat="server" Text="To :"></asp:Label>
                    </div>
                    <div>
                        <asp:Label class="LabelStyle" runat="server" Text="Subject :"></asp:Label>
                    </div>
                    <div>
                        <asp:Label class="LabelStyle" runat="server" Text="Body :"></asp:Label>
                    </div>
                </div>
                <div id="MailZone" class="MailZone" runat="server">
                    <div id="mailFrom_zone" class="mailFrom_zone" runat="server">
                        <asp:TextBox ID="mailFrom" runat="server" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div id="mailTo_zone" class="mailTo_zone" runat="server">
                        <asp:TextBox ID="mailTo" runat="server" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div id="subject_zone" class="subject_zone" runat="server">
                        <asp:TextBox ID="subject" runat="server" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div id="body_zone" class="body_zone" runat="server">
                        <asp:TextBox ID="email_text" runat="server" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>
                <div id="sendbutton" class="sendbutton" runat="server">
                    <asp:LinkButton ID="ButtonSend" class="button" runat="server" OnClick="SendEmail_OnClick" Text="SEND !" />    
                </div>
            </fieldset>
        </div>

    </form>
</body>
</html>
