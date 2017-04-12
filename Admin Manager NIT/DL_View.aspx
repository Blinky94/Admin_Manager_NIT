<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="DL_View.aspx.cs" Inherits="Admin_Manager_NIT.WebForm1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <p>
        <asp:Label ID="lblSecret" runat="server" Style="font-weight: 700"></asp:Label>
    </p>

    <div class="contentT" id="content">
        <div id="title_area" class="title">
            <p>View Mailing List</p>
        </div>

        <div id="spacing_area">
            <!-- space between two block -->
        </div>

        <div id="search_area">
            <div id="Search_table">
                <p>
                    <label>Search :</label>
                    <asp:TextBox class="mailingList" ID="SearchDLTextBox" runat="server" OnTextChanged="SearchTextBox_TextChanged" />                 
                    <a href="#" class="Seachbutton" id="GoButton" runat="server" onserverclick="GoButton_OnClick">GO !</a>
                </p>
            </div>

            <div id="List_table">
                <div class="select_List">
                    <p>
                        <label>Result : </label>
                        <asp:DropDownList class="mailingList" ID="mailingList" runat="server"></asp:DropDownList>
                        <a href="#" class="Seachbutton" id="SelectButton" runat="server" onserverclick="SelectButton_OnClick">Select</a>
                    </p>
                </div>
            </div>
        </div>

        <div id="spacing_area2">
            <!-- space between two block -->
        </div>

        <div id="result_area">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

            <!--------------------------------------------------------OWNER LIST AREA------------------------------------------------------------------------->

            <div id="owners_list">

                <div id="title_owners" class="title" runat="server">
                    <p>Owners List</p>
                </div>

                <div id="owners_list_array">
                    <asp:Table class="headertable" ID="HeaderOwner" runat="server">
                        <asp:TableHeaderRow ID="headerowners" BackColor="LightBlue" runat="server">
                            <asp:TableHeaderCell Scope="Column" Text="Owner Email Address" Width="500" />
                            <asp:TableHeaderCell Scope="Column" Text="View" />
                        </asp:TableHeaderRow>
                    </asp:Table>

                    <asp:Table class="table" ID="tablOwnersControl" runat="server">
                        <asp:TableHeaderRow ID="TableHeaderOwners" BackColor="LightBlue" runat="server">
                        </asp:TableHeaderRow>
                    </asp:Table>

                    <div class="button_class_owners">
                        <div id="add_button_owners">
                            <asp:LinkButton ID="Add_Owner_Button" class="button" runat="server" onClick="AddOwner_OnClick" Text="Add" />
                        </div>
                        <div id="Request_button_OwnerShip">
                            <asp:LinkButton ID="request_OwnerShip" class="button" runat="server" OnClick="RequestOwnerShipButton_OnClick" Text="Request OwnerShip" />
                        </div>
                        <div id="del_button_owners">
                            <asp:LinkButton ID="Del_Owner_Button" class="button" runat="server" onClick="DeleteOwner_OnClick" Text="Delete" />
                        </div>
                    </div>

                    <!-- end button_class_owners -->
                </div>
            </div>
            <!-- end owners_list -->

            <!--------------------------------------------------------MEMBER LIST AREA------------------------------------------------------------------------->

            <div id="members_list">

                <div id="title_members" class="title" runat="server">
                    <p>Members List</p>
                </div>

                <div id="members_list_array">

                    <asp:Table class="headertable" ID="HeaderMember" runat="server">
                        <asp:TableHeaderRow ID="headermembers" BackColor="LightBlue" runat="server">
                            <asp:TableHeaderCell Scope="Column" Text="Member Email Address" Width="500" />
                            <asp:TableHeaderCell Scope="Column" Text="View" />
                        </asp:TableHeaderRow>
                    </asp:Table>

                    <asp:Table class="table" ID="tableMembersControl" runat="server">
                        <asp:TableHeaderRow ID="TableHeaderMembers" BackColor="LightBlue" runat="server">
                        </asp:TableHeaderRow>
                    </asp:Table>

                    <div class="button_class_members">
                        <div id="add_button_members">
                            <a href="#" class="button">Add</a>
                        </div>
                        <div id="del_button_members">
                            <a href="#" class="button">Delete</a>
                        </div>
                    </div>
                    <!-- end button_class_members -->

                </div>
                <!-- end list members_list_array -->
            </div>
            <!-- end result_area -->
        </div>
        <!-- End contentT -->
    </div>
    <!-- end content -->

</asp:Content>