<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Auth_Page.aspx.cs" Inherits="Admin_Manager_NIT.Auth_Page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Authentication Page</title>
    <link rel="stylesheet" type="text/css" href="../CSS/Authentification.css" />
</head>
<body>
    <form id="form_Authentication_Page" runat="server">

        <div id="body_Authent" class="body_Authent" runat="server">

            <div id="label_authentification" class="label_authentification">
                <asp:Label ID="authentification" class="authentification" runat="server" Text="Authentification"></asp:Label>
            </div>

            <div>
                <asp:Label ID="lblErreur" runat="server"></asp:Label>
            </div>
            <div>
                <div id="labels_col" class="labels_col">
                    <asp:Label ID="Label1" class="label_login" runat="server" Text="Login : "></asp:Label>
                    <br />
                    <asp:Label ID="Label2" class="label_pass" runat="server" Text="Password : "></asp:Label>

                </div>
                <div id="content_col" class="content_col">
                    <asp:TextBox ID="txtLogin" class="txtLogin" runat="server"></asp:TextBox>
                    <br />
                    <asp:TextBox ID="txtPass" class="txtPass" runat="server" TextMode="Password"></asp:TextBox>
                </div>
                <div id="Connexion_Button" class="Connexion_Button">
                    <asp:Button ID="connexion" Class="button" runat="server" OnClick="Connexion_Click" Text="Connexion" />
                </div>
            </div>
        </div>

    </form>
</body>
</html>
