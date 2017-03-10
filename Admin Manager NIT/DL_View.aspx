<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="DL_View.aspx.cs" Inherits="Admin_Manager_NIT.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     
       <style type="text/css">
            .auto-style1 {
                  width: 350px;
                  height: 35px;
            }
      </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
           <div id="content">                

                 <div id="title_area">
                       <p>View Distribution List</p>
                 </div>
                   
                 <div id="spacing_area"> 
                        <!-- space between two block -->
                 </div>

                  <div id="search_area">   
                        <div id="Search_table">
                              <p>
                                    <label>Search :</label>&nbsp;&nbsp;&nbsp;
                                    <input type ="text"
                                    id ="SearchLD"
                                    value ="" class="auto-style1" />                           
                              </p>
                        </div>
                        
                        <div id="Go_table">
                              <div id="Go_Button">
                                    <a href="#" class="Go">GO !</a>
                              </div>
                        </div>
                       
                        <div id="List_table">
                              <div class="select_List">
                                    <p>
                                          <label>Result : </label>
                                          <select name="listbox" id="listbox">
                                          <option>here exemple one</option>
                                          <option>here exemple two</option>
                                          </select>  
                                    </p>             
                              </div>       
                       </div>                                                                                    
                  </div>    <!-- end search_area --> 
                 
                  <div id="spacing_area2"> 
                        <!-- space between two block -->    
                 </div>                               

                 <div id="result_area">                    

                        <div id="members_list">                               

                              <div id="title_members_LD">
                                    <p>Members List</p>
                              </div>

                             <div id="members_list_array">
                                    <table class="table"> <!-- cellspacing='0' is important, must stay -->
	                                    <!-- Table Header -->
	                                    <thead>
		                                    <tr>
			                                    <th>ID</th>
			                                    <th>Member Email Adress</th>
                                                      <th></th>
		                                    </tr>
	                                    </thead>
	                                    <!-- Table Header -->

	                                    <!-- Table Body -->
	                                    <tbody>
		                                    <tr>
			                                    <td>1</td>
			                                    <td>laurent.souesmes@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr><!-- Table Row -->

		                                    <tr>
			                                    <td>2</td>
			                                    <td>raphael.deluard@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr><!-- Darker Table Row -->

		                                    <tr>
			                                    <td>3</td>
			                                    <td>frederic.caze-sulfourt@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>	
                                                
                                                <tr>
			                                    <td>4</td>
			                                    <td>jean-françois.martin@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>	
                                                
                                                <tr>
			                                    <td>5</td>
			                                    <td>jean-christophe.totte@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>	
                                                
                                                <tr>
			                                    <td>6</td>
			                                    <td>mike.tyson@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>		
                                                
                                                <tr>
			                                    <td>7</td>
			                                    <td>philippe.tutute@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>	
                                                
                                                <tr>
			                                    <td>8</td>
			                                    <td>fernand.nathan@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>		
                                                 
                                                <tr>
			                                    <td>9</td>
			                                    <td>philippe.tutute@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>	
                                                
                                                <tr>
			                                    <td>10</td>
			                                    <td>fernand.nathan@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>		
                                                
                                                 <tr>
			                                    <td>11</td>
			                                    <td>mike.tyson@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>		
                                                
                                                <tr>
			                                    <td>12</td>
			                                    <td>philippe.tutute@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>	
                                                
                                                <tr>
			                                    <td>13</td>
			                                    <td>fernand.nathan@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>		
                                                 
                                                <tr>
			                                    <td>14</td>
			                                    <td>philippe.tutute@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>	
                                                
                                                <tr>
			                                    <td>15</td>
			                                    <td>fernand.nathan@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>		
                                                  <tr>
			                                    <td>16</td>
			                                    <td>mike.tyson@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>		
                                                
                                                <tr>
			                                    <td>17</td>
			                                    <td>philippe.tutute@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>	
                                                
                                                <tr>
			                                    <td>18</td>
			                                    <td>fernand.nathan@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>		
                                                 
                                                <tr>
			                                    <td>19</td>
			                                    <td>philippe.tutute@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>	
                                                
                                                <tr>
			                                    <td>20</td>
			                                    <td>fernand.nathan@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>	
                                                
                                                 <tr>
			                                    <td>21</td>
			                                    <td>philippe.tutute@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>	
                                                
                                                <tr>
			                                    <td>22</td>
			                                    <td>fernand.nathan@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>		
                                                 
                                                <tr>
			                                    <td>23</td>
			                                    <td>philippe.tutute@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>	
                                                
                                                <tr>
			                                    <td>24</td>
			                                    <td>fernand.nathan@neurones.net</td>
			                                    <td>
                                                            <img class="loupe" src="Images/loupe.png" width="20"/>
			                                    </td>
		                                    </tr>									
                                                							                                  
	                                    </tbody>
	                                    <!-- Table Body -->

                                    </table>                                   
                              </div> <!-- end list members_list_array -->
                                        
                        <div class="button_class_members">                                   
                               <div id="add_button_members">
                                    <a href="#" class="Go">Add</a>
                              </div>
 
                              <div id="del_button_members">
                                    <a href="#" class="Go">Delete</a>
                              </div>

                              <div id="new_button_members">
                                    <a href="#" class="Go">New</a>
                              </div>                                    
                       </div>  <!-- end button_class_members -->                                                                             
                 </div> <!-- end members_list -->  
                        
                 <div id="owners_list">                               
                        <div id="title_owners_LD">
                              <p>Owners List</p>
                        </div>                                                     
                            
                       <div id="owners_list_array">                                   
                             <table class="table"> <!-- cellspacing='0' is important, must stay -->
	                                    <!-- Table Header -->	                                    
                                   <thead>
		                              <tr>
			                              <th>ID</th>
			                              <th>Owner Email Adress</th>
                                                <th></th>
		                              </tr>
	                              </thead>
	                              <!-- Table Header -->

	                              <!-- Table Body -->
	                              <tbody>
		                              <tr>
			                              <td>1</td>
			                              <td>laurent.souesmes@neurones.net</td>
			                              <td>        
                                                      <a href="#openModal"><img class="loupe" src="Images/loupe.png" width="20"/></a>
                                                      
                                                      <div id="openModal" class="modalDialog">
                                                            <div>
                                                                  <a href="#close" title="Close" class="close">X</a>                                                                         
                                    
                                                            <div id="owner_box">  
                                                                  <div id="title_owner">
                                                                        <p>Owner</p>
                                                                  </div>

                                                                  <div id="photo_area">
                                                                        <img class="avatar" src="Images/CAZE-SULFOURT FREDERIC.JPG" width="150"/>
                                                                  </div>

                                                                  <div id="owner_description">
                                                                        <p>First Name : Frédéric</p>
                                                                        <p>Last Name : CAZE-SULFOURT</p>
                                                                        <p>Phone : 01 45 31 27 31</p>
                                                                        <p>Fonction : Dot Net Developer</p>
                                                                        <p>Email : frederic.caze-sulfourt@neurones.net</p>
                                                                  </div>     
                                                            </div> 
                                                            </div>
                                                            
                                                      </div>	                                                     
			                              </td>
		                              </tr><!-- Table Row -->

		                              <tr>
			                              <td>2</td>
			                              <td>raphael.deluard@neurones.net</td>
			                              <td>
                                                      <img class="loupe" src="Images/loupe.png" width="20"/>
			                              </td>
		                              </tr><!-- Darker Table Row -->

		                              <tr>
			                              <td>3</td>
			                              <td>frederic.caze-sulfourt@neurones.net</td>
			                              <td>
                                                      <img class="loupe" src="Images/loupe.png" width="20"/>
			                              </td>
		                              </tr>	
                                                
                                                <tr>
			                              <td>4</td>
			                              <td>frederic.caze-sulfourt@neurones.net</td>
			                              <td>
                                                      <img class="loupe" src="Images/loupe.png" width="20"/>
			                              </td>
		                              </tr>	
                                                
                                                <tr>
			                              <td>4</td>
			                              <td>frederic.caze-sulfourt@neurones.net</td>
			                              <td>
                                                      <img class="loupe" src="Images/loupe.png" width="20"/>
			                              </td>
		                              </tr>		

                                             <tr>
                  
			                              <td>4</td>
			                              <td>frederic.caze-sulfourthjjjjjjjjjjjjjjjjjjj@neurones.net</td>
			                              <td>
                                                      <img class="loupe" src="Images/loupe.png" width="20"/>
			                              </td>
                                             </tr>   
                                               
					                                  
	                              </tbody>
	                              <!-- Table Body -->                                   
                             </table>                            
                       </div>
                                    
                       <div class="button_class_owners">
                              <div id="add_button_owners">
                                    <a href="#" class="Go">Add</a>
                              </div>

                              <div id="del_button_owners">
                                    <a href="#" class="Go">Delete</a>
                              </div>

                              <div id="new_button_owners">
                                    <a href="#" class="Go">New</a>
                              </div>

                              <div id="modify_button_owners">
                                    <a href="#" class="Go">Modify</a>                              
                              </div>                                                                               
                       </div>  <!-- end button_class_owners -->                                                                             
                 </div> <!-- end owners_list -->                                                                                
            </div>  <!-- end result_area -->  
       </div>  <!-- end content --> 
</asp:Content>
