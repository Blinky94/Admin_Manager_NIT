<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="DL_View.aspx.cs" Inherits="Admin_Manager_NIT.WebForm1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     
       <style type="text/css">
            .auto-style1 {
                  width: 350px;
                  height: 35px;
            }
      </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
           <div class="contentT" id="content">     
                                
                <!--Popup Owner info -->
                <div class="box">                                    
                      <div id="popup1" class="overlay" runat="server">
                            <div class="popup">
                                   		<h2>Owner Details</h2>
                                    		<a class="close" href="#">&times;</a>
                                  <div class="content">
                                  
                                          <div id="photo_area">
                                                <img class="avatar" src="Images/CAZE-SULFOURT FREDERIC.JPG" width="150"/>
                                          </div>

                                          <div id="owner_description">
                                                <p>First Name : Frédéric</p>
                                                <p>Last Name : CAZE-SULFOURT</p>
                                                <p>Phone : 01 45 31 27 31</p>
                                                <p>Fonction : Dot Net Developer</p>
                                                <a href="mailto:frederic.caze-sulfourt@neurones.net" title="mail">Email : frederic.caze-sulfourt@neurones.net</a>                                                                              
                                          </div>                            
                                  </div>                                                                                                                                     
                            </div>                                         
                      </div>                       
                </div>                                                

                 <div id="title_area">
                       <p>View Mailing List</p>
                 </div>
                   
                 <div id="spacing_area"> 
                        <!-- space between two block -->
                 </div>

                  <div id="search_area">   
                        <div id="Search_table">
                              <p>
                                    <label>Search :</label>  
                                    <asp:TextBox class="mailingList" id="SearchTextBox" runat="server" />                                       
                                    <a href="#" class="Go" id="ButtonGo" runat="server" onserverclick="Go_Button_Search_DistributionList">GO !</a>                       
                              </p>
                        </div>                                              
                       
                        <div id="List_table">
                              <div class="select_List">
                                    <p>
                                          <label>Result : </label>     
                                          <asp:DropDownList class="mailingList" id="mailingList" runat="server"></asp:DropDownList>   
                                           <a href="#" class="Go" id="ButtonDLList" runat="server" onserverclick="Select_Button_DistributionList">Select</a>                                                                     
                                    </p>             
                              </div>       
                       </div>                                                                                 
                  </div>
                 
                  <div id="spacing_area2"> 
                        <!-- space between two block -->    
                 </div>                               

                 <div id="result_area">                                        
       <!--------------------------------------------------------OWNER LIST AREA------------------------------------------------------------------------->                            
                  <div id="owners_list">                               
                        <div id="title_owners_LD">
                              <p>Owners List</p>
                        </div>                                                     
                            
                        <div id="owners_list_array">                                   
                                <asp:Table class="table" ID="HeaderOwner" runat="server"> 
                                    <asp:TableHeaderRow id="TableHeaderRow1" BackColor="LightBlue" runat="server">
                                          <asp:TableHeaderCell Scope="Column" Text="Owner Email Address" width="500"/>
                                          <asp:TableHeaderCell Scope="Column" Text="View" />                                                
                                    </asp:TableHeaderRow>                                                                                                                                 
                              </asp:Table>       
                              <asp:Table class="table" ID="OwnerTable" runat="server"> 
                                    <asp:TableHeaderRow id="TableHeaderOwners" BackColor="LightBlue" runat="server">                                                                               
                                    </asp:TableHeaderRow>                                                                                                                                 
                              </asp:Table>                                 
                        </div>                              
                <div class="button_class_owners">
                      <div id="add_button_owners">
                              <a href="#" class="Go">Add</a>
                       </div>

                        <div id="del_button_owners">
                              <a href="#" class="Go">Delete</a>
                        </div>                                                                            
                       </div>  <!-- end button_class_owners -->                                                                             
                 </div> <!-- end owners_list -->   
    <!--------------------------------------------------------MEMBER LIST AREA------------------------------------------------------------------------->                   
                       <div id="members_list">                               

                              <div id="title_members_LD">
                                    <p>Members List</p>
                              </div>

                             
                             <div id="members_list_array">
                                     <asp:Table class="table" ID="HeaderMember" runat="server"> 
                                          <asp:TableHeaderRow id="headermembers" BackColor="LightBlue" runat="server">
                                                <asp:TableHeaderCell Scope="Column" Text="Member Email Address" width="500"/>
                                                <asp:TableHeaderCell Scope="Column" Text="View" />                                                
                                          </asp:TableHeaderRow>                                                                                                                                 
                                   </asp:Table>  
                                   <asp:Table class="table" ID="MembersTable" runat="server"> 
                                          <asp:TableHeaderRow id="TableHeaderMembers" BackColor="LightBlue" runat="server">                                          
                                          </asp:TableHeaderRow>                                                                                                                                 
                                   </asp:Table>  
                                   		                                                                                                                                  
                             </div> <!-- end list members_list_array -->
                                        
                        <div class="button_class_members">                                   
                               <div id="add_button_members">
                                    <a href="#" class="Go">Add</a>
                              </div>
 
                              <div id="del_button_members">
                                    <a href="#" class="Go">Delete</a>
                              </div>                               
                       </div>  <!-- end button_class_members -->                                                                             
                 </div> <!-- end members_list -->                                                                               
            </div>  <!-- end result_area -->  
       </div>  <!-- end content --> 
</asp:Content>
