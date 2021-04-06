<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProfilePage.aspx.cs" Inherits="Mark_In_Admin.Participants.ProfilePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../ParticipantCSS/ProfilePageCSS.css" rel="stylesheet" />
    
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <title>Profile Page</title>
    <style type="text/css">
        .outputDiv {
            height: 172px;
            width: 520px;
        }
    </style>
</head>
<body>
    
    
    <div class="container">
                
        <div class="page-header1">
            <h3 style="color:darkred;">
            <img src="../Images/NEWWWAppIcon.png" width="35" height="35" />  MARK IN 
             
            <ul class="navbar">
                        

               
                 <li class="btn btn-default"><a class="redirectProfileLink" runat="server" >Profile</a></li>
               
                <li class="btn btn-default"><a  class="redirectEventLink" runat="server">Events</a></li>
                 <li class="btn btn-primary"><a id="logout" class="redirectLogoutLink" runat="server">Logout</a></li>
                              
                
            </ul>
            
            <%--<img src="../Images/NEWWWAppIcon.png" height="35" width="35"/><p style="font-size:23px; color:darkred; font-family:Montserrat-Medium">  MARK IN</p>      
              <div class="buttonsLayout"> 
                    <a class="btn btn-default" style="color:#337ab7" href="Profile Page.aspx" id="profileButton">Profile</a>
                    <a class="btn btn-default" style="color:#337ab7" href="Contact Information.aspx" id="contactsButton">Contacts</a>
                    <a class="btn btn-default" style="color:#337ab7" href="Registered Events.aspx" id="eventsButton">Events</a>   
                    <a class="btn btn-primary" href="~" id="logoutButton">Logout</a>
                </div>--%>
            </h3> 
        </div>


        <div class="row tophalf">
            <%--<div class="tophalfwidth">--%>
                <div class="col-md-4"><h5>Profile</h5></div>
    
                <div class="col-md-4">
                    <!--<img src="https://zxing.org/w/chart?cht=qr&chs=350x350&chld=L&choe=UTF-8&chl=BEGIN%3AVCARD%0AVERSION%3A3.0%0AN%3AAng+Ming+Ming%0AORG%3ACompany%0ATITLE%3ALecturer%0ATEL%3A98765432%0AEMAIL%3Aaa%40aa.com%0AEND%3AVCARD" height:"350" width="350" class="QR"/>-->
                    <img id="displayQr" name="displayQr" runat="server" />
                    <div id="test" runat="server"></div>
                </div>
                
                <div class="col-md-4">
                    <div id="printButtonLayout">
                    <button type="button" id="printButton" class="btn btn-default">
                    <img src="../Images/printer-icon--icon-search-engine-1.png" width="28" height="21" id="printimg" />Print</button>
                    </div>
                </div>
            <%--</div>--%>
        </div>

    <form id="ProfilePageForm" runat="server">

        <div class="panel-body">

            <div class="col-md-6">
            <asp:ImageButton type="button" runat="server" id="editButton" class="btn btn-default" onclick="btnEdit_Click" ImageUrl="../Images/edit.png" Width="50" Height="40"/>
            <div class="divider"></div>
            <asp:button runat="server" id="confirmButton" class="btn btn-default" onclick="btnSave_Click" Text ="Save" />
            <div class="divider"></div>
            <asp:button type="button" runat="server" id="cancelButton" class="btn btn-default" onclick="btnCancel_Click" Text ="Cancel" />

            </div>

            <div id="messageBox" runat="server"></div>
            
              
            <div class="userinfo">

                <div class="labelDiv">
                        <label id="namelbl" class="userheader">Name: </label>      
                        <asp:textbox ID="nameoutput" runat="server" class="useroutput form-control" ReadOnly="true"/>              

                        <label id="contactslbl" class="userheader">Contact: </label>
                        <asp:textbox ID="contactsoutput" runat="server" class="useroutput form-control" ReadOnly="true"/>

                        <label id="companylbl" class="userheader">Company: </label>
                        <asp:textbox ID="companyoutput" runat="server" class="useroutput form-control" ReadOnly="true" />

                        <label id="positionlbl" class="userheader">Position: </label>
                        <asp:textbox id="positionoutput" runat="server" class="useroutput form-control" ReadOnly="true"/>

                        <label id="emaillbl" class="userheader">Email: </label>
                        <asp:textbox ID="emailoutput" runat="server" class="useroutput form-control" ReadOnly="true"/>

                        <label id="passwordlbl" class="userheader">Password: </label>
                        <asp:textbox ID="passwordoutput" runat="server" class="useroutput form-control" ReadOnly="true"/>
                           
                </div>


            </div>
            

            <div class="col-md-3"></div>
        </div>
    </form>
    </div><!--End of Container-->
    
    
    <script>



        //Get userId
        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

        //Redirect     

        $('.redirectEventLink').click(function () {

            userId = getParameterByName('ID');
            console.log(userId);
            window.location.href = "AllEvents.aspx?ID=" + userId;
        });

        /*
        $('.redirectContactLink').click(function () {

            userId = getParameterByName('ID');
            console.log(userId);
            window.location.href = "ContactInformation.aspx?ID=" + userId;
        });
        */
        $('.redirectProfileLink').click(function () {

            userId = getParameterByName('ID');
            console.log(userId);
            window.location.href = "ProfilePage.aspx?ID=" + userId;
        });



        $('.redirectLogoutLink').click(function () {

            userId = getParameterByName('ID');
            console.log(userId);
            window.location.replace("Logout.aspx?ID=" + userId);
        });

        
    </script>
     <style>
        #logout{
        color:  white;
        }

    </style>

    
</body>
</html>
