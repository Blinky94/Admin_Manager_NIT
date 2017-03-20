<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="DL_View.aspx.cs" Inherits="Admin_Manager_NIT.WebForm1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
           <div class="contentT" id="content">     
                    
<!-- Bootstrap Modal Dialog -->
               <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <div class="popup" id="myModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <asp:UpdatePanel ID="upModal" runat="server" ChildrenAsTriggers="false" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="content">
                                <div class="Title">
                                    <h2 class="owner-title">
                                        <asp:Label ID="title" runat="server" Text=""></asp:Label></h2>
                                </div>   
                                  <div id="photo_area">                                   
                                      <asp:Image class="avatar" ID="imageowner" runat="server" width="150" ImageUrl="" />                                          
                                  </div>
                                <div class="owner_description">
                                    <h4 class="description">
                                            <asp:Label ID="firstname" runat="server" Text=""></asp:Label>                                       
                                        <br />
                                        <br />
                                            <asp:Label ID="lastname" runat="server" Text=""></asp:Label>
                                        <br />
                                        <br />
                                            <asp:Label ID="fonction" runat="server" Text=""></asp:Label>                                                                              
                                        <br />
                                        <br />
                                            <asp:Label ID="phone" runat="server" Text=""></asp:Label>                                                                               
                                        <br />
                                        <br />
                                            <asp:Label ID="email" runat="server" Text=""></asp:Label>                                                                               
                                        <br />
                                        </h4>
                                </div>                                    
                             
                                <div class="close">
                                    <button id="buttoncloseowner" runat="server" onclick="OnCloseButton_Owner_Event" class="buttonCloseOwner" data-dismiss="modal" aria-hidden="true">Close</button>
                                </div>                             
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:asyncpostbacktrigger ControlID="buttoncloseowner" />
                        </Triggers>
                    </asp:UpdatePanel>
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
                                    <asp:TextBox class="mailingList" id="SearchDLTextBox" runat="server" OnTextChanged="SearchTextBox_TextChanged" />                                       
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
