<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContactInformation.aspx.cs" Inherits="Mark_In_Admin.Participants.ContactInformation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../ParticipantCSS/ContactInformationCSS.css" rel="stylesheet" />
    <script src="../Scripts/bootstrap-datepicker.min.js"></script>
    <script src="../Scripts/jquery-1.10.2.min.js"></script>

    <title>Contacts Information</title>
</head>
<body>
    <div class="container">
                
        <div class="page-header1">
            <h3 style="color:darkred;">
            <ul class="navbar">
                <img src="../Images/NEWWWAppIcon.png" width="35" height="35" />  MARK IN         
                    
                
              <li class="btn btn-primary"><a id="logout" class="redirectLogoutLink" runat="server">Logout</a></li>
                <li class="btn btn-default"><a class="redirectEventLink" runat="server">Events</a></li>
                <li class="btn btn-default"><a class="redirectContactLink" runat="server">Contacts</a></li>
                <li class="btn btn-default"><a class="redirectProfileLink" runat="server">Profile</a></li>
                
            </ul> 
                
            </h3>  
        </div>
                  
    <form id="ContactsInformationForm" runat="server" class="form-horizontal">

            
    <div class="panel-heading">
        <%--<div class="row">
            <div class="col-md-6"></div>
            <div class="col-md-6">&nbsp;</div>
        </div>--%> <%-- End of row--%>
        
     <div class="row">

         <!-- Left side -->
         <div class="col-md-1"></div>
         <div class="col-md-5">
            <h5>Contact Information</h5>
         </div>     
         
         <!-- Right side -->    
        <div class="col-md-6">
            
            <div class="row col-md-12">
                <h4>Filter By:</h4>
            </div>

            <div class="row">
                
                <div class="col-md-4">
                    <label for="SearchCompany"><h2>Company</h2></label>
                    <input type="text"  id="searchCompany" class="form-control" name="searchCompany" placeholder="Search for..."/>
                    <br />
                </div>
                
                <div class="col-md-4">
                    <label for="SearchName"><h2>Name</h2></label>
                    <input type="text"  id="searchName" class="form-control" name="searchName" placeholder="Search for..."/>
                </div>

                <div class="col-md-4"></div>

            </div> <!-- End of nested row -->
            
            <div class="row col-md-12">
                <button type="button" id="searchIDandName" class="btn btn-default" onclick="btnSearch_Click()">Search</button>
            </div>            
        
        </div> <!-- End of right side -->
   
      </div> <%-- End of row --%>
   

        </div><%-- End of panel heading--%>

      

  <div class="panel-body">
  <div class="table-responsive">
  <table id="contactsTable" class="table table-striped">
  <thead>
    <tr>
      <td>Name</td>
      <td>Contacts</td>
      <td>Company</td>
      <td>Position</td>
      <td>Email</td>
      
    </tr>
  </thead> 
  <tbody>

  </tbody>
</table>

     </div><%-- End of table responsive--%>
     </div><%-- End of panel body--%>
     </form><%-- End of form--%>
     </div> <%-- End of container--%>


      <script>


        function WebFormData(inUserId) {
            this.UserId = inUserId;
        }

        var loadData = function () {
            var inUserId = getParameterByName('ID');

            var webFormData = new WebFormData(inUserId);
            var webFormDataInJson = JSON.stringify(webFormData);


            var requestHandler = $.ajax({
                type: 'POST',
                url: 'ContactInformation.aspx/getAllContactInformation',
                data: "{'WebFormData' : '" + webFormDataInJson + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json"
                //async: false
            });
            
            requestHandler.done(function (response) {

                var contactId = '';
                var contactList = response.d;
                var $contactsTableElement = $('#contactsTable tbody');
                var $rowElement;
                var $cellElement;
                var index = 0;

                //var $register =

                //$('<input type="button" value="Register" />').click((function () {
                //$('.modal-content').modal('show');
                //modal.style.display = "block";
                //});
               
                    for (index = 0; index < contactList.length; index++) {
                        contactId = contactList[index].ParticipantId;
                        $rowElement = $('<tr></tr>');
                        $cellElement = $('<td></td>', { text: contactList[index].ParticipantName});
                        $rowElement.append($cellElement);
                        $cellElement = $('<td></td>', { text: contactList[index].ParticipantContactNo});
                        $rowElement.append($cellElement);
                        $cellElement = $('<td></td>', { text: contactList[index].CompanyName });
                        $rowElement.append($cellElement);
                        $cellElement = $('<td></td>', { text: contactList[index].CompanyPosition });
                        $rowElement.append($cellElement);
                        $cellElement = $('<td></td>', { text: contactList[index].ParticipantEmail });
                        $rowElement.append($cellElement);

                        $contactsTableElement.append($rowElement);
                }
            });

            requestHandler.fail(function (error) {
                console.log(error);
            })
        };

        function eventsTableElement() { loadData }
        window.onload = loadData;



        ///////////////////////////////////////////////////////////SEARCH///////////////////////////////////////////////////////////

        function loadSearchData(SearchwebFormData) {
            $.ajax({
                type: 'POST',
                url: 'ContactInformation.aspx/searchEvent',
                data: JSON.stringify(SearchwebFormData),
                //"{'inWebFormData':'" + webFormDataInString + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).done(function (response) {

                $("#contactsTable tr").remove();


                var contactId = '';
                var contactList = response.d;
                var $contactsTableElement = $('#contactsTable tbody');
                var $rowElement;
                var $cellElement;
                var index = 0;


                // $('#nameInput').on
                //var $register =

                //$('<input type="button" value="Register" />').click((function () {
                //$('.modal-content').modal('show');
                //modal.style.display = "block";
                //});


                for (index = 0; index < contactList.length; index++) {
                    contactId = contactList[index].ParticipantId;
                    $rowElement = $('<tr></tr>');
                    $cellElement = $('<td></td>', { text: contactList[index].ParticipantName });
                    $rowElement.append($cellElement);
                    $cellElement = $('<td></td>', { text: contactList[index].ParticipantContactNo });
                    $rowElement.append($cellElement);
                    $cellElement = $('<td></td>', { text: contactList[index].CompanyName });
                    $rowElement.append($cellElement);
                    $cellElement = $('<td></td>', { text: contactList[index].CompanyPosition });
                    $rowElement.append($cellElement);
                    $cellElement = $('<td></td>', { text: contactList[index].ParticipantEmail });
                    $rowElement.append($cellElement);


                    $contactsTableElement.append($rowElement);
                    

                }
            });

        };


        function btnSearch_Click() {

            var contactCompany = document.getElementById("searchCompany").value;
            var contactName = document.getElementById("searchName").value;
            //var x = document.getElementById("SearchIdInput").value;
            userId = getParameterByName('ID');

            var searchData = {
                inContactName: contactName, inContactCompany: contactCompany, inUserId: userId
                //$("#SearchNameInput").text(), inEventId: $("#SearchIdInput").text()
            };

            if (contactName == "" && contactCompany == "") {
                window.location.href = window.location.href
                //do nothing
            } else {
                loadSearchData(searchData);
                console.log("loadSearchData ran");
                console.log("inContactName: " + contactName + " inContactCompany: " + contactCompany + " inUserId: " +userId);

            }

        }





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


        $('.redirectContactLink').click(function () {

            userId = getParameterByName('ID');
            console.log(userId);
            window.location.href = "ContactInformation.aspx?ID=" + userId;
        });

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
