<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DL_RemoveMember.aspx.cs" Inherits="Admin_Manager_NIT.DL_RemoveMember" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Remove Members</title>
    <link rel="stylesheet" type="text/css" href="<%=VirtualPathUtility.ToAbsolute("~/CSS/Rm_Style.css")%>" />  
</head>
<body>
    <form id="form1" runat="server">
        <div id="content_RemoveMember">
            <fieldset id="RmdMemberField">
                <legend>Remove Members</legend>
                <div>
                    <asp:Label ID="lblErreur" runat="server"></asp:Label>
                </div>
                <div id="DL_LabelText">
                    <asp:Label ID="ConfirmText" class="ConfirmTextClass" Text="Do you confirm to remove these users from DL ?" runat="server"></asp:Label>
                </div>
                <div id="DL_LabelList">
                    <asp:TextBox class="DL_ListMembersToRemove" ID="DL_ListMembersToRemove" runat="server" TextMode="MultiLine" Font-Size="Medium" />
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
            </fieldset>
        </div>
    </form>
</body>
</html>
