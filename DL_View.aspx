<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="DL_View.aspx.cs" Inherits="Admin_Manager_NIT.WebForm1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" type="text/css" href="../CSS/DL_View_Style.css" />

    <asp:Label ID="lblSecret" runat="server" Style="font-weight: 700"></asp:Label>

    <div class="contentT" id="content">
        <fieldset id="MainField">
            <legend>View Mailing List</legend>
            <div id="search_area">
                <div id="Search_table">
                    <div id="label_Search">
                        <label>Search :</label>
                    </div>
                    <div id="textBox_Search">
                        <asp:TextBox class="WordToSearch" ID="SearchDLTextBox" runat="server" OnTextChanged="SearchTextBox_TextChanged" />
                    </div>
                    <div id="button_Search">
                        <asp:LinkButton ID="GoButton" class="Seachbutton" runat="server" OnClick="Button_Click" Text="GO !" />
                    </div>
                </div>

                <div id="List_table">
                    <div class="select_List">
                        <div id="label_Result">
                            <label>Result : </label>
                        </div>
                        <div id="textBox_Result">
                            <asp:DropDownList class="ListResult" ID="Distribution_List" runat="server"></asp:DropDownList>
                        </div>
                        <div id="button_Result">
                            <asp:LinkButton ID="SelectButton" class="Seachbutton" runat="server" OnClick="Button_Click" Text="Select" />
                        </div>
                    </div>
                </div>

                <div id="RefreshZone">
                    <div id="button_Refresh">
                        <asp:ImageButton ID="RefreshButton" runat="Server" ImageUrl="../Images/refresh.ico" OnClick="Button_Click" Width="40" Height="40"></asp:ImageButton>
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
                    <fieldset id="OwnerField">
                        <legend>Owners List</legend>
                        <div id="owners_list_array">

                            <div id="headerOwnersContainer">
                                <div id="headerOwners">
                                    <asp:TextBox ID="headOwners" CssClass="headertable" Text="Members List" runat="server" />
                                </div>
                                <div id="headerOwnersView">
                                    <asp:TextBox ID="headViewOwners" CssClass="headertable" Text="View" runat="server" />
                                </div>
                            </div>

                            <asp:Table class="table" ID="tableOwnersControl" runat="server">
                                <asp:TableHeaderRow ID="TableHeaderOwners" BackColor="white" runat="server">
                                </asp:TableHeaderRow>
                            </asp:Table>

                            <div class="button_class">
                                <div id="add_button_owners">
                                    <asp:LinkButton ID="Add_Owner_Button" class="button" runat="server" OnClick="Button_Click" Text="Add" />
                                </div>
                                <div id="Request_button_OwnerShip">
                                    <asp:LinkButton ID="request_OwnerShip" class="button" runat="server" OnClick="Button_Click" Text="Request OwnerShip" />
                                </div>
                                <div id="del_button_owners">
                                    <asp:LinkButton ID="Del_Owner_Button" class="button" runat="server" OnClick="Button_Click" Text="Delete" />
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </div>
                <!-- end owners_list -->

                <!--------------------------------------------------------MEMBER LIST AREA------------------------------------------------------------------------->

                <div id="members_list">
                    <fieldset id="MembersField">
                        <legend>Members List</legend>
                        <div id="members_list_array">
                            <div id="headerMembersContainer">
                                <div id="headerMembers">
                                    <asp:TextBox ID="headMembers" CssClass="headertable" Text="Members List" runat="server" />
                                </div>
                                <div id="headerMembersView">
                                    <asp:TextBox ID="headViewMembers" CssClass="headertable" Text="View" runat="server" />
                                </div>

                            </div>
                            <asp:Table class="table" ID="tableMembersControl" runat="server">
                                <asp:TableHeaderRow ID="TableHeaderMembers" BackColor="white" runat="server">
                                </asp:TableHeaderRow>
                            </asp:Table>

                            <div class="button_class">
                                <div id="add_button_members">
                                    <asp:LinkButton ID="Add_Member_Button" class="button" runat="server" OnClick="Button_Click" Text="Add" />
                                </div>
                                <div id="Request_button_MemberShip">
                                    <asp:LinkButton ID="Request_MemberShip" class="button" runat="server" OnClick="Button_Click" Text="Request MemberShip" />
                                </div>
                                <div id="del_button_members">
                                    <asp:LinkButton ID="Del_Member_Button" class="button" runat="server" OnClick="Button_Click" Text="Delete" />
                                </div>
                            </div>
                            <!-- end button_class_members -->
                        </div>
                    </fieldset>
                </div>
                <!-- end result_area -->
            </div>
            <!-- End contentT -->
        </fieldset>
        <fieldset id="LegendField">
            <legend>Keys</legend>
            <div id="Legend">
                <div id="legendOwner">
                    <div id="squareOwner">
                        <asp:TextBox ID="txtBoxOwner" runat="server" Width="50" Height="25" ReadOnly="true" BorderStyle="None" BorderColor="Transparent" />
                    </div>
                    <div id="descriptionOwner">
                        <label>Owner</label>
                    </div>
                </div>

                <div id="legendCoManager">
                    <div id="squareCoManager">
                        <asp:TextBox ID="txtBoxCoManager" runat="server" Width="50" Height="25" ReadOnly="true" BorderStyle="None" BorderColor="Transparent" />
                    </div>
                    <div id="descriptionManager">
                        <label>CoManager(s)</label>
                    </div>
                </div>

                <div id="legendLD">
                    <div id="squareLD">
                        <asp:TextBox ID="txtBoxLD" runat="server" Width="50" Height="25" ReadOnly="true" BorderStyle="None" BorderColor="Transparent" />
                    </div>
                    <div id="descriptionLD">
                        <label id="DL_" runat="server"></label>
                    </div>
                </div>

                <div id="legendMember">
                    <div id="squareMember">
                        <asp:TextBox ID="txtBoxMember" runat="server" Width="50" Height="25" ReadOnly="true" BorderStyle="None" BorderColor="Transparent" />
                    </div>
                    <div id="descriptionMember">
                        <label>Member(s)</label>
                    </div>
                </div>

            </div>
        </fieldset>
    </div>
    <!-- end content -->

</asp:Content>