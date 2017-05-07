<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DL_RemoveMember.aspx.cs" Inherits="Admin_Manager_NIT.DL_RemoveMember" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Remove Members</title>
    <link rel="stylesheet" type="text/css" href="../CSS/AddDelete_Style.css" />  
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>
                <asp:Label ID="lblErreur" runat="server"></asp:Label>
            </div>
            <div id="textSearch">
                <asp:TextBox class="DL_Search" ID="DL_ListMembersToRemove" runat="server" OnTextChanged="SearchTextBox_TextChanged" Font-Size="Medium" />
            </div>
            <div id="ConfirmOrCancel">
                <div id="confirm">
                    <asp:LinkButton ID="confirmButton" class="SearchButton" runat="server" OnClick="Button_Click" Text="Confirm" />
                </div>

                <div id="cancel_area">
                    <div id="cancel">
                        <asp:LinkButton ID="cancelButton" class="SearchButton" runat="server" OnClick="Button_Click" Text="Cancel" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
