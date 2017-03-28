<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="DL_View.aspx.cs" Inherits="Admin_Manager_NIT.WebForm1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <p><asp:Label ID="lblSecret" runat="server" style="font-weight: 700"></asp:Label></p>
        
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
                                    <asp:TextBox class="mailingList" id="SearchDLTextBox" runat="server" OnTextChanged="SearchTextBox_TextChanged" />                                       
                                    <a href="#" class="search_area_buttons" id="ButtonGo" runat="server" onserverclick="Go_Button_Search_DistributionList">GO !</a>                       
                              </p>
                        </div>                                              
                       
                        <div id="List_table">
                              <div class="select_List">
                                    <p>
                                          <label>Result : </label>     
                                          <asp:DropDownList class="mailingList" id="mailingList" runat="server"></asp:DropDownList>   
                                           <a href="#" class="search_area_buttons" id="ButtonDLList" runat="server" onserverclick="Select_Button_DistributionList">Select</a>                                                                     
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
                                <asp:TableHeaderRow id="TableHeaderRow1" BackColor="LightBlue" runat="server">                                                                           
                                    <asp:TableHeaderCell Scope="Column" Text="Owner Email Address" width="500"/>                                        
                                    <asp:TableHeaderCell Scope="Column" Text="View"/>                                                
                                </asp:TableHeaderRow>                                                                                                                                 
                            </asp:Table>       
                              
                            <asp:Table class="table" ID="OwnerTable" runat="server">                                     
                                <asp:TableHeaderRow id="TableHeaderOwners" BackColor="LightBlue" runat="server">                          
                                </asp:TableHeaderRow>                                                                                                                                                               
                            </asp:Table>                                                                                                                                 
                        </div>                                                
                         
                         <div class="button_class">                                           
                             <div id="add_button_owners">                                                               
                                 <a href="#" class="Go">Add</a>                                                                           
                             </div>
                        
                             <div id="del_button_owners">                                                          
                                 <a href="#" class="Go">Delete</a>                        
                             </div>     
                             
                             <div id="Request_button_OwnerShip">
                                 <a href="#" class="Go"  runat="server" onserverclick="GenerateEmailToSend_Click">Request OwnerShip</a>
                             </div>
                         </div>  <!-- end button_class_owners -->     
                         
                          <div id="title_owner" class="title" runat="server">
                              <p>Owner Details</p>
                        </div>   

                        <div id="owner_details_area" class="details" runat="server">
                            <!-- photo zone area -->
                            <div id="owner_photo_area" class="photo_area" runat="server"></div>
                            <!-- details zone area -->
                            <div class="textbox_area" runat="server">
                                <div class="titles_descriptions" runat="server">
                                    <p>First Name : </p>
                                    <p>Last Name : </p>
                                    <p>Job : </p>
                                    <p>Phone : </p>                                                                       
                                    <p>Email : </p>
                                </div>  
                                 
                                <asp:TextBox ID="owner_details" class="txtbox_details" runat="server" TextMode="MultiLine">                          
                                </asp:TextBox>                              
                            </div>                            
                             
                            <div id="email_link_owner" class="email">
                                <asp:LinkButton ID="LinkButtonOwner" class="email_css"  runat="server"></asp:LinkButton>                                        
                            </div>                            
                        </div>                   
                                    
                     </div> <!-- end owners_list --> 
                     
<!--------------------------------------------------------MEMBER LIST AREA------------------------------------------------------------------------->                                         
                     
                     <div id="members_list"> 
                         
                          <div id="title_members" class="title" runat="server">                             
                             <p>Members List</p>                              
                         </div>
                                                          
                         <div id="members_list_array">                                    
                             <asp:Table class="headertable" ID="HeaderMember" runat="server">                                           
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
                                                                
                         <div class="button_class">                                                                  
                             <div id="add_button_members">                                   
                                 <a href="#" class="Go">Add</a>                              
                             </div> 
                              
                             <div id="del_button_members">                                    
                                 <a href="#" class="Go">Delete</a>                             
                             </div>                                                     
                         </div>  <!-- end button_class_members -->                                                        
               
                        <div id="title_member" class="title" runat="server">                             
                             <p>Member Details</p>            
                         </div>                                                                                                         
                 
                            <div id="member_details_area" class="details" runat="server">
                             
                                <!-- photo zone area -->
                             
                                <div id="member_photo_area" class="photo_area" runat="server"></div>
                             
                                <!-- details zone area -->                        
                                <div class="textbox_area" runat="server">
                                 
                                    <div class="titles_descriptions" runat="server">                                                               
                                        <p>First Name : </p> 
                                        <p>Last Name : </p>
                                        <p>Job : </p>
                                        <p>Phone : </p>
                                        <p>Email : </p>
                                    </div>
                                  
                                    <asp:TextBox ID="member_details" class="txtbox_details" runat="server" TextMode="MultiLine">                                                              
                                    </asp:TextBox>                                                                         
                                </div> 
                                   
                                <div id="email_link_member" class="email">                                      
                                     <asp:LinkButton ID="LinkButtonMember" class="email_css" runat="server"></asp:LinkButton>                                        
                                </div>                                                    
                         </div>                  
                     </div>  <!-- end result_area -->                        
                 </div> <!-- End contentT -->
           </div>  <!-- end content --> 
</asp:Content>