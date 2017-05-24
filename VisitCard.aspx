<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisitCard.aspx.cs" Inherits="Admin_Manager_NIT.VisitCard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
     <title>Visit Card Window</title>
    <link rel="stylesheet" type="text/css" href="../CSS/VisitCardStyles.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div id="VisitCardArea" class="VisitCardArea" runat="server">
            <fieldset id="OwnerField">
                <legend>User Info</legend>
                <div id="owner_details_area" runat="server">
                    <!-- photo zone area -->
                    <div id="photo_area" class="photo_area" runat="server"></div>
                    <!-- details zone area -->
                    <div class="textbox_area" runat="server">
                        <div class="Labels" runat="server">
                            <div>
                                <asp:Label class="LabelStyle" runat="server" Text="First Name :"></asp:Label>
                            </div>
                            <div>
                                <asp:Label class="LabelStyle" runat="server" Text="Last Name :"></asp:Label>
                            </div>
                            <div>
                                <asp:Label class="LabelStyle" runat="server" Text="Job :"></asp:Label>
                            </div>
                            <div>
                                <asp:Label class="LabelStyle" runat="server" Text="Phone :"></asp:Label>
                            </div>
                            <div>
                                <asp:Label class="LabelStyle" runat="server" Text="E-mail :"></asp:Label>
                            </div>
                        </div>
                        <asp:TextBox ID="details" class="txtbox_details" runat="server" TextMode="MultiLine">                          
                        </asp:TextBox>
                    </div>
                </div>
            </fieldset>           
        </div>
    </form>
</body>
</html>
