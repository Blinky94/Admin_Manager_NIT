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
        <div>
             <div id="owner_details_area" class="details" runat="server">
                <!-- photo zone area -->
                <div id="photo_area" class="photo_area" runat="server"></div>
                <!-- details zone area -->
                <div class="textbox_area" runat="server">
                    <div class="titles_descriptions" runat="server">
                        <p>First Name : </p>
                        <p>Last Name : </p>
                        <p>Job : </p>
                        <p>Phone : </p>                                                                       
                        <p>Email : </p>
                    </div>  
                                 
                    <asp:TextBox ID="details" class="txtbox_details" runat="server" TextMode="MultiLine">                          
                    </asp:TextBox>                              
                </div>                                                           
            </div>             
        </div>
    </form>
</body>
</html>
