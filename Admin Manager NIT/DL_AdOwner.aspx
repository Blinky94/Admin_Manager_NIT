<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DL_AdOwner.aspx.cs" Inherits="Admin_Manager_NIT.DL_AdOwner" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Adding Owners</title>
    <link rel="stylesheet" type="text/css" href="../CSS/Add_Style2.css" /> 
</head>
<body>
    <form id="form1" runat="server">
        <div id="content">
                <fieldset id="AddOwnerField">
                <legend>Add Owner</legend>
            <div id="search_area">
                <div id="labelSearch">
                    <label>Search User in AD : </label>
                </div>
                <div id="textSearch">
                    <asp:TextBox class="DL_Search" ID="DL_SearchOwner" runat="server" OnTextChanged="SearchTextBox_TextChanged" Font-Size="Medium" />
                </div>
                <div id="buttonSearch">
                    <asp:LinkButton ID="SearchButton" class="SearchButton" runat="server" OnClick="Button_Click" Text="Search User" />
                </div>
            </div>

            <div id="result_area">
                <div id="labelResult">
                    <label>Result : </label>
                </div>

                <div id="textResult">
                    <asp:DropDownList class="DL_Select" ID="DL_SelectOwner" runat="server" Font-Size="Medium"></asp:DropDownList>
                </div>
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