<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisteredParticipants.aspx.cs" Inherits="FYP_MarkIn.Staff.RegisteredParticipants" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"/>
    <script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../StaffCSS/attendanceList.css" rel="stylesheet" />
    
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/modernizr-2.6.2.js"></script>
    <script src="../Scripts/notify.min.js"></script>
    <script src="../Scripts/respond.min.js"></script>

    <title>Registered Participants</title>
</head>
<body>

     <div class="container">
        
        <%-- header --%>    
        <div class="page-header1">
            <h3 style="color:darkred;">
            <ul class="navbar">
                <img src="../Images/NEWWWAppIcon.png" height="35" width="35" />  MARK IN           
                <li class="btn btn-primary"><a id="logout" class="redirectLogoutLink" runat="server">Logout</a></li>
                <li class="btn btn-default"><a class="redirectEventLink" runat="server">Events</a></li>
                <li class="btn btn-default"><a class="redirectAttendanceLink" runat="server">My Attendance</a></li>
            </ul>  
            </h3>  
        </div>
       <form id="ParticipantsForm" runat="server" class="form-horizontal">

            
    <div class="panel-heading">
                         
    <div class="row">

        <!-- Left side -->
        <div class="col-md-1"></div>
        <div class="col-md-5">
            <div class="row col-md-12">
                <h5>Registered Participants</h5>
                <br />
            </div>
            
            <div class="row">
            
            </div>

            <div class="row">
            
            </div>
        </div>

        <!-- Right side -->
       <div class="col-md-6">
        <div class="row col-md-12">
            <h4>Filter By:</h4>
        </div>
            <div class="row">
                <div class="col-md-4">
                    <label for="SearchEName"> <h2>Name</h2></label>
                    <input type="text" class="form-control" placeholder="Search for..." id="SearchName" name="SearchEName"/>
                    <br />
            </div>
             <div class="col-md-4">
                 <label for="SearchPresent"> <h2>Present</h2></label>
                  <div class="dropdown" id="DropDownDivId">
                      
                      <select class="form-control" id="SearchPresent">
                        <option value="Invalid">ALL</option>
                        <option value="True">Yes</option>
                        <option value="False">No</option>
                      </select>

                      </div>
                </div> <%-- End of col-md-4--%>
            
                

                <div class="col-md-4"></div>
            </div> <!-- End of nested row -->
            <div class="row col-md-12">
                 <button Id="searchBtn" class="btn btn-default" type="button"  onclick="btnSearch_Click()">Search</button>
            </div>            
        </div> <!-- End of right side -->
            
        
    </div> <%-- End of row --%>
   
    </div> <%-- End of panel heading--%>
      
    </form>

    <label class ="staffinformation">
        <span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span>Event Name
    </label>

<div class="table-responsive">
                        <table id="participantTable" class="table table-striped">
                            <thead>
                                <tr>
                                    <td>Participant ID</td>
                                    <td>Name</td>
                                    <td>Contact No</td>
                                    <td>Company Name</td>
                                    <td>Company Position</td>
                                    <td>Email</td>
                                    <td>Present</td>
                                  
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>

     <script>
         window.newParticipantsId = '';

         var eventId;
         ///////////////////////////////////////////////////////////LOAD ALL///////////////////////////////////////////////////////////
         function WebFormData2(inEventId) {
             this.EventId = inEventId;
             //this.Password = inPassword;
         }

         var loadData = function () {
             //Collect data from the respective form elements.
             eventId = getParameterByName('EventId');
             console.log("eventId = " + eventId );

             //Create a WebFormData class object, webformData
             var webFormData = new WebFormData2(eventId);
             var webFormDataInJson = JSON.stringify(webFormData);


             var requestHandler = $.ajax({
                 type: 'POST',
                 url: 'RegisteredParticipants.aspx/getRegisteredParticipants',
                 data: "{'WebFormData' : '" + webFormDataInJson + "'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json"
             });

             requestHandler.done(function (response) {
                 
                 var participantId = '';
                 var participantList = response.d;
                 var $participantTableElement = $('#participantTable tbody');
                 var $rowElement;
                 var $cellElement;
                 var index = 0;


                 for (index = 0; index < participantList.length; index++) {
                     participantId = participantList[index].ParticipantId;
                     $rowElement = $('<tr></tr>');
                     $cellElement = $('<td></td>', { text: participantList[index].ParticipantId });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: participantList[index].ParticipantName });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: participantList[index].ParticipantContactNo });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: participantList[index].CompanyName });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: participantList[index].CompanyPosition });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: participantList[index].ParticipantEmail });
                     $rowElement.append($cellElement);

                     if (participantList[index].Present == "False") {
                         present = "No"
                     } else {
                         present = "Yes"
                     }
                     $cellElement = $('<td></td>', { text: present });
                     $rowElement.append($cellElement);

                     $participantTableElement.append($rowElement);
                 }


             });

             requestHandler.fail(function () {
                 
             });
         };

         //Search Name
         function loadSearchNameData(SearchwebFormData) {
             $.ajax({
                 type: 'POST',
                 url: 'RegisteredParticipants.aspx/searchRegisteredParticipantsName',
                 data: JSON.stringify(SearchwebFormData),
                 //"{'inWebFormData':'" + webFormDataInString + "'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json"
             }).done(function (response) {
                 var participantId = '';
                 var participantList = response.d;
                 var $participantTableElement = $('#participantTable tbody');
                 var $rowElement;
                 var $cellElement;
                 var index = 0;

                 $("#participantTable tr").remove();

                 for (index = 0; index < participantList.length; index++) {
                     participantId = participantList[index].ParticipantId;
                     $rowElement = $('<tr></tr>');
                     $cellElement = $('<td></td>', { text: participantList[index].ParticipantId });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: participantList[index].ParticipantName });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: participantList[index].ParticipantContactNo });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: participantList[index].CompanyName });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: participantList[index].CompanyPosition });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: participantList[index].ParticipantEmail });
                     $rowElement.append($cellElement);

                     if (participantList[index].Present == "False") {
                         present = "No"
                     } else {
                         present = "Yes"
                     }
                     $cellElement = $('<td></td>', { text: present });
                     $rowElement.append($cellElement);

                     $participantTableElement.append($rowElement);
                 }

             }).fail(function () {

             });
         };


         //Search
         function loadSearchData(SearchwebFormData) {
             $.ajax({
                 type: 'POST',
                 url: 'RegisteredParticipants.aspx/searchRegisteredParticipants',
                 data: JSON.stringify(SearchwebFormData),
                 //"{'inWebFormData':'" + webFormDataInString + "'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json"
             }).done(function (response) {
                 var participantId = '';
                 var participantList = response.d;
                 var $participantTableElement = $('#participantTable tbody');
                 var $rowElement;
                 var $cellElement;
                 var index = 0;

                 $("#participantTable tr").remove();

                 for (index = 0; index < participantList.length; index++) {
                     participantId = participantList[index].ParticipantId;
                     $rowElement = $('<tr></tr>');
                     $cellElement = $('<td></td>', { text: participantList[index].ParticipantId });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: participantList[index].ParticipantName });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: participantList[index].ParticipantContactNo });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: participantList[index].CompanyName });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: participantList[index].CompanyPosition });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: participantList[index].ParticipantEmail });
                     $rowElement.append($cellElement);
                    
                     if (participantList[index].Present == "False") {
                         present = "No"
                     } else {
                         present = "Yes"
                     }
                     $cellElement = $('<td></td>', { text: present });
                     $rowElement.append($cellElement);

                     $participantTableElement.append($rowElement);
                 }

             }).fail(function () {

             });
         };

                 



         ///////////////////////////////////////////// CALL LOAD /////////////////////////////////////////////

         window.onload = loadData;

         ///////////////////////////////////////////// SEARCH  /////////////////////////////////////////////
         function btnSearch_Click() {

             var e = document.getElementById("SearchPresent");
             var eventPresent = e.options[e.selectedIndex].value;

             eventId = getParameterByName('EventId');

             var eventName = $('#SearchName').val();

            /* var searchPresentData = {
                 inEventPresent: eventPresent, inUserId: userId
             };
             */
             var searchNameData = {
                 inEventName: eventName, inEventId: eventId
             };

             var searchData = {
                 inEventName: eventName, inEventPresent: eventPresent, inEventId: eventId
             };

             //Both empty
             if (eventPresent == "Invalid" && eventName == "") {
                 window.location.href = window.location.href;
                 console.log(eventName);
                 console.log("Function 1");
             }

             //Search Name
             if (eventPresent == "Invalid" && eventName != "") {
                 loadSearchNameData(searchNameData);
                 console.log("loadSearchNameData ran");
                 console.log("inEventPresent: " + eventPresent + " inEventName: " + eventName);
                 console.log("Function 2");
             }
             //Search Present
             if (eventPresent != "Invalid" && eventName == "") {
                 loadSearchData(searchData);
                 console.log("loadSearchData ran");
                 console.log("inEventPresent: " + eventPresent + " inEventName: " + eventName);
                 console.log("Function 3");
             }
             //Search both
             if (eventPresent != "Invalid" && eventName != "") {
                 loadSearchData(searchData);
                 console.log("loadSearchData2 ran");
                 console.log("inEventPresent: " + eventPresent + " inEventName: " + eventName);
                 console.log("Function 4");
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

  $('.redirectAttendanceLink').click(function () {

      userId = getParameterByName('ID');
      console.log(userId);
      window.location.href = "AttendanceList.aspx?ID=" + userId;
  });

  $('.redirectLogoutLink').click(function () {

      userId = getParameterByName('ID');
      console.log(userId);
      window.location.replace("../Participants/Logout.aspx?ID=" + userId);
  });

  
      //eventId = getParameterByName('EventId');

  </script>
         <style>
        #logout{
        color:  white;
        }

    </style>
  
</body>
</html>
