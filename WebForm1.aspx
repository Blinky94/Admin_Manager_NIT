<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Admin_Manager_NIT.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
           <div id="content">                

                 <div id="title_area">
                       <p>Consulting Distribution List</p>
                 </div>
                   
                 <div id="spacing_area"> 
                        <!-- space between two block -->
                 </div>

                 <div id="search_area">                      
                       <div id="titre_search">
                              <p>Select List : </p>
                       </div>
                      
                        <div class="styled-select">
                              <select name="wgtmsr" id="wgtmsr">
                                    <option>here exemple one</option>
                                    <option>here exemple two</option>
                              </select>               
                        </div>          
                 </div>     
                 
                  <div id="spacing_area2"> 
                        <!-- space between two block -->    
                 </div>                               

                 <div id="result_area">
                       <div id="owner_LD">   

                             <div id="title_owner">
                                   <p>Owner</p>
                             </div>

                             <div id="photo_area">
                                   <img class="avatar" src="Images/CAZE-SULFOURT FREDERIC.JPG" width="150"/>
                             </div>

                              <div id="owner_description">
                                    <p>First Name : CAZE-SULFOURT</p>
                                    <p>Last Name : Frédéric</p>
                                    <p>Phone : 01 45 31 27 31</p>
                                    <p>Dot Net Developer</p>
                                    <p>frederic.caze-sulfourt@neurones.net</p>
                              </div>     

                             <div id="operations_owner">
                                   <div class="edit_class">
                                          <a href="url_edit">Edit Profil</a>
                                   </div>                                                                                              
                             </div>                        
                       </div>

                        <div id="members_list">                               
                              <div id="member_area">
                                     <div id="title_members_LD">
                                          <p>Members List</p>
                                    </div>
                             </div>
                              <div id="member_list_array">
                                    <asp:ListBox ID="ListBox1" runat="server" Height="450px" Width="480px">
                                          <asp:ListItem Text="MediumAquaMarine"></asp:ListItem>
                                          <asp:ListItem Text="MediumPurple"></asp:ListItem>
                                          <asp:ListItem Text="MediumSlateBlue"></asp:ListItem>
                                          <asp:ListItem Text="MediumSpringGreen"></asp:ListItem>
                                          <asp:ListItem Text="MediumVioletRed"></asp:ListItem>
                                    </asp:ListBox>
                              </div>
                       </div>
                 </div>

           </div>           
</asp:Content>
