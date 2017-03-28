<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Authentification.aspx.cs" Inherits="Admin_Manager_NIT.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     
    <div id="body_Authent" class="body_Authent" runat="server">
        <br />
        <br />
        <br />
        <br />
          <h3>Authentification</h3>
        <div>                
            <asp:Label ID="lblErreur" runat="server"></asp:Label>                       
            <br />
            <br />
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
            <br />
            <br />               
            <br />
            <asp:Button ID="connexion_button" runat="server" OnClick="Connexion_Click" Text="Connexion" font-size="18"/>
        </div>    
    </div>
   
</asp:Content>
