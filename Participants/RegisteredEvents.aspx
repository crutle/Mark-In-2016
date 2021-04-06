<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisteredEvents.aspx.cs" Inherits="Mark_In_Admin.Participants.RegisteredEvents" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src="../Scripts/bootstrap-datepicker.min.js"></script>
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    
    <link href="../ParticipantCSS/RegisteredEventsCSS.css" rel="stylesheet" />
       
    <script src="../Scripts/notify.min.js"></script>
    <script src="../Scripts/moment.min.js"></script>
 
    <title>Registered Events</title>
</head>
<body>
    <div class="container">
                
        <div class="page-header1">
            <h3 style="color:darkred;">
            <ul class="navbar">
                <img src="../Images/NEWWWAppIcon.png" width="35" height="35" />  MARK IN         
                    
                 <li class="btn btn-primary"><a id="logout" class="redirectLogoutLink" runat="server">Logout</a></li>
                <li class="btn btn-default"><a class="redirectEventLink" runat="server">Events</a></li>
                <li class="btn btn-default"><a class="redirectProfileLink" runat="server">Profile</a></li>
                
            </ul> 
                
            </h3>  
        </div>
                  
    <form id="RegisteredEventsForm" runat="server" class="form-horizontal">

            
    <div class="panel-heading">
        <%--<div class="row">
            <div class="col-md-6"></div>
            <div class="col-md-6">&nbsp;</div>
        </div>--%> <%-- End of row--%>
                         

    <div class="row">

         <!-- Left side -->
         <div class="col-md-1"></div>
         <div class="col-md-5">
            <h5>Registered Events</h5>
         </div>     
         

            <!-- Right side -->    
        <div class="col-md-6">
            
            <div class="row col-md-12">
                <h4>Filter By:</h4>
            </div>

            <div class="row">
                
                <div class="col-md-4">
                    <label for="SearchName"> <h2>Name</h2></label>
                    <input type="text" class="form-control" placeholder="Search for..." id="SearchNameInput" name="SearchName" value=""/>
                </div>

                <div class="col-md-4">
                     <label for="SearchAttendance"> <h2>Attendance Status</h2></label>
                    <select id="ddlPresent">
                         <option value="Invalid" selected="selected">Attendance Status</option>
                         <option value="True">Present</option>
                         <option value="False">Absent</option>
                    </select>
                  
                </div>

                <div class="col-md-4"></div>
                 
            </div> <!-- End of nested row -->
            

            <div class="row col-md-12">               
                <button Id="searchNameandStaff" class="btn btn-default" type="button"  onclick="btnSearch_Click()">Search</button>
            </div>            
        
        </div> <!-- End of right side -->

        
   
      </div> <%-- End of row --%>
   

        </div><%-- End of panel heading--%>

      
      <div class="panel-body">

      <nav id="mainnav">
        <p>
          <a class="redirectEventLink">All Events</a> |
          <a class="redirectRegisteredLink" >Registered Events</a>         
        </p>
      </nav>


       <div class="table-responsive">
        <table id="eventsTable" class="table table-striped">
  <thead>
    <tr>
      <td>Event ID</td>
      <td>Name</td>
      <td>Start</td>
      <td>End</td>
      <td>Status</td>
      <td>Attendance</td>
      
    </tr>
  </thead> 
            <tbody>
                </tbody>
  
</table>
         
           </div><%-- End of table responsive --%>   
        </div><%-- End of panel body --%>
        </form><%--End of form --%>
           </div> <%-- End of container--%>



 <script>
     var userId;
     ///////////////////////////////////////////////////////////LOAD ALL///////////////////////////////////////////////////////////

     function WebFormData(inUserId) {
         this.UserId = inUserId;
         //this.Password = inPassword;
     }

     function loadData() {
         //Collect data from the respective form elements.
         var inUserId = getParameterByName('ID');
         console.log("inUserId= " + inUserId);

         //Create a WebFormData class object, webformData
         var webFormData = new WebFormData(inUserId);
         var webFormDataInJson = JSON.stringify(webFormData);

             $.ajax({
                 type: 'POST',
                 url: 'RegisteredEvents.aspx/getAllJoinedEventsData',
                 //data: JSON.stringify(SearchwebFormData),
                 data: "{'WebFormData' : '" + webFormDataInJson + "'}",
                 //"{'inUserId':" + inUserId + "}",
                 //
                 contentType: "application/json; charset=utf-8",
                 dataType: "json"
             }).done(function (response) {

                 var eventId = '';
                 var eventsList = response.d;
                 var $eventsTableElement = $('#eventsTable tbody');
                 var $rowElement;
                 var $cellElement;
                 var index = 0;


                 // $('#nameInput').on
                 //var $register =

                 //$('<input type="button" value="Register" />').click((function () {
                 //$('.modal-content').modal('show');
                 //modal.style.display = "block";
                 //});

                 for (index = 0; index < eventsList.length; index++) {
                     eventId = eventsList[index].EventId;
                     $rowElement = $('<tr></tr>');
                     $cellElement = $('<td></td>', { text: eventsList[index].EventId });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: eventsList[index].EventName });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: eventsList[index].EventStart });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: eventsList[index].EventEnd });
                     $rowElement.append($cellElement);

                     //////////////////////////////////////////

                     //Check event status Past or Ongoing or Upcoming
                     var eventStatus = "";
                     
                     var start = new Date(eventsList[index].EventStart);
                     start = moment(start).format("DD/MM/YYYY");

                     var end = new Date(eventsList[index].EventEnd);
                     end = moment(end).format("DD/MM/YYYY");
                                    
                     var dateTime = new Date();
                     dateTime = moment(dateTime).format("DD/MM/YYYY");

                     console.log("Current DateTime= " + dateTime)
                     console.log("Event Start format= "+ start);
                     console.log("Event End format= " + end);

                     
                     //Ahead of start = now > start
                     //Ahead of end = now > end
                     //Before start = now < start
                     //Before end = now < end

                     //Past Event
                     if(dateTime > start && dateTime > end){
                         console.log("Past Event");
                         eventStatus = "Past";
                     }
                       
                     //Ongoing event
                     if(dateTime > start && dateTime == end){
                         console.log("Ongoing Event");
                         eventStatus = "Ongoing";
                     }

                     if(dateTime > start && dateTime < end){
                         console.log("Ongoing Event");
                         eventStatus = "Ongoing";
                     }
                     //Upcoming event
                     if (dateTime < start && dateTime < end) {
                         console.log("Upcoming Event");
                         eventStatus = "Upcoming";
                     }

                     $cellElement = $('<td></td>', { text: eventStatus});
                     $rowElement.append($cellElement);

                     //////////////////////////////////////////

                     //Check if Attendance is present or absent
                     var attendanceStatus;
                     if(eventsList[index].Present == "False")
                     {
                         attendanceStatus = "Absent"
                         console.log("attendanceStatus= " + attendanceStatus);
                     } else {
                         attendanceStatus = "Present"
                         console.log("attendanceStatus= " + attendanceStatus);
                     }
                     $cellElement = $('<td></td>', { text: attendanceStatus });
                     $rowElement.append($cellElement);


                     $eventsTableElement.append($rowElement);
                     console.log("append rows to table")
                 }
             });

     };

     ///////////////////////////////////////////////////////////SEARCH///////////////////////////////////////////////////////////


     function loadSearchNameData(SearchwebFormData) {
         $.ajax({
             type: 'POST',
             url: 'RegisteredEvents.aspx/searchEventName',
             data: JSON.stringify(SearchwebFormData),
             //"{'inWebFormData':'" + webFormDataInString + "'}",
             contentType: "application/json; charset=utf-8",
             dataType: "json"
         }).done(function (response) {

             $("#eventsTable tr").remove();

             var eventId = '';
             var eventsList = response.d;
             var $eventsTableElement = $('#eventsTable tbody');
             var $rowElement;
             var $cellElement;
             var index = 0;

             // $('#nameInput').on
             //var $register =

             //$('<input type="button" value="Register" />').click((function () {
             //$('.modal-content').modal('show');
             //modal.style.display = "block";
             //});


             for (index = 0; index < eventsList.length; index++) {
                 eventId = eventsList[index].EventId;
                 $rowElement = $('<tr></tr>');
                 $cellElement = $('<td></td>', { text: eventsList[index].EventId });
                 $rowElement.append($cellElement);
                 $cellElement = $('<td></td>', { text: eventsList[index].EventName });
                 $rowElement.append($cellElement);
                 $cellElement = $('<td></td>', { text: eventsList[index].EventStart });
                 $rowElement.append($cellElement);
                 $cellElement = $('<td></td>', { text: eventsList[index].EventEnd });
                 $rowElement.append($cellElement);
                 //////////////////////////////////////////

                 //Check event status Past or Ongoing or Upcoming
                 var eventStatus = "";

                 var start = new Date(eventsList[index].EventStart);
                 start = moment(start).format("DD/MM/YYYY");
                 console.log("Start1 = " + start);

                 var end = new Date(eventsList[index].EventEnd);
                 end = moment(end).format("DD/MM/YYYY");
                 console.log("End1 = " + end);

                 var dateTime = new Date();
                 dateTime = moment(dateTime).format("DD/MM/YYYY");

                 console.log("Current DateTime= " + dateTime)
                 console.log("Event Start format= " + start);
                 console.log("Event End format= " + end);


                 //Ahead of start = now > start
                 //Ahead of end = now > end
                 //Before start = now < start
                 //Before end = now < end

                 //Past Event
                 if (dateTime > start && dateTime > end) {
                     console.log("Past Event");
                     eventStatus = "Past";
                 }

                 //Ongoing event
                 if (dateTime > start && dateTime == end) {
                     console.log("Ongoing Event");
                     eventStatus = "Ongoing";
                 }

                 if (dateTime > start && dateTime < end) {
                     console.log("Ongoing Event");
                     eventStatus = "Ongoing";
                 }
                 //Upcoming event
                 if (dateTime < start && dateTime < end) {
                     console.log("Upcoming Event");
                     eventStatus = "Upcoming";
                 }

                 $cellElement = $('<td></td>', { text: eventStatus });
                 $rowElement.append($cellElement);

                 //////////////////////////////////////////

                 //Check if Attendance is present or absent
                 var attendanceStatus;
                 if (eventsList[index].Present == "False") {
                     attendanceStatus = "Absent"
                     console.log("attendanceStatus= " + attendanceStatus);
                 } else {
                     attendanceStatus = "Present"
                     console.log("attendanceStatus= " + attendanceStatus);
                 }
                 $cellElement = $('<td></td>', { text: attendanceStatus });
                 $rowElement.append($cellElement);


                 $eventsTableElement.append($rowElement);
                 console.log("append rows to table")
             }
         });

     };


     function loadSearchData(SearchwebFormData) {
         $.ajax({
             type: 'POST',
             url: 'RegisteredEvents.aspx/searchEvent',
             data: JSON.stringify(SearchwebFormData),
             //"{'inWebFormData':'" + webFormDataInString + "'}",
             contentType: "application/json; charset=utf-8",
             dataType: "json"
         }).done(function (response) {

             $("#eventsTable tr").remove();

             var eventId = '';
             var eventsList = response.d;
             var $eventsTableElement = $('#eventsTable tbody');
             var $rowElement;
             var $cellElement;
             var index = 0;

             // $('#nameInput').on
             //var $register =

             //$('<input type="button" value="Register" />').click((function () {
             //$('.modal-content').modal('show');
             //modal.style.display = "block";
             //});


             for (index = 0; index < eventsList.length; index++) {
                 eventId = eventsList[index].EventId;
                 $rowElement = $('<tr></tr>');
                 $cellElement = $('<td></td>', { text: eventsList[index].EventId });
                 $rowElement.append($cellElement);
                 $cellElement = $('<td></td>', { text: eventsList[index].EventName });
                 $rowElement.append($cellElement);
                 $cellElement = $('<td></td>', { text: eventsList[index].EventStart });
                 $rowElement.append($cellElement);
                 $cellElement = $('<td></td>', { text: eventsList[index].EventEnd });
                 $rowElement.append($cellElement);
                 //////////////////////////////////////////

                 //Check event status Past or Ongoing or Upcoming
                 var eventStatus = "";

                 var start = new Date(eventsList[index].EventStart);
                 start = moment(start).format("DD/MM/YYYY");
                 console.log("Start1 = " + start);

                 var end = new Date(eventsList[index].EventEnd);
                 end = moment(end).format("DD/MM/YYYY");
                 console.log("End1 = " + end);

                 var dateTime = new Date();
                 dateTime = moment(dateTime).format("DD/MM/YYYY");

                 console.log("Current DateTime= " + dateTime)
                 console.log("Event Start format= " + start);
                 console.log("Event End format= " + end);


                 //Ahead of start = now > start
                 //Ahead of end = now > end
                 //Before start = now < start
                 //Before end = now < end

                 //Past Event
                 if (dateTime > start && dateTime > end) {
                     console.log("Past Event");
                     eventStatus = "Past";
                 }

                 //Ongoing event
                 if (dateTime > start && dateTime == end) {
                     console.log("Ongoing Event");
                     eventStatus = "Ongoing";
                 }

                 if (dateTime > start && dateTime < end) {
                     console.log("Ongoing Event");
                     eventStatus = "Ongoing";
                 }
                 //Upcoming event
                 if (dateTime < start && dateTime < end) {
                     console.log("Upcoming Event");
                     eventStatus = "Upcoming";
                 }

                 $cellElement = $('<td></td>', { text: eventStatus });
                 $rowElement.append($cellElement);

                 //////////////////////////////////////////

                 //Check if Attendance is present or absent
                 var attendanceStatus;
                 if (eventsList[index].Present == "False") {
                     attendanceStatus = "Absent"
                     console.log("attendanceStatus= " + attendanceStatus);
                 } else {
                     attendanceStatus = "Present"
                     console.log("attendanceStatus= " + attendanceStatus);
                 }
                 $cellElement = $('<td></td>', { text: attendanceStatus });
                 $rowElement.append($cellElement);


                 $eventsTableElement.append($rowElement);
                 console.log("append rows to table")
             }
         });

     };



     function btnSearch_Click() {

         var e = document.getElementById("ddlPresent");
         var eventPresent = e.options[e.selectedIndex].value;
         userId = getParameterByName('ID');

         var eventName = document.getElementById("SearchNameInput").value;
      
         var searchNameData = {
                         inEventName: eventName , inUserId: userId
         };

         var searchData = {
             inEventName: eventName, inEventPresent: eventPresent, inUserId: userId
         };

         //Both empty
         if (eventPresent == "Invalid" && eventName == "") {
             //do nothing
             window.location.href = window.location.href
         }

         //Search for eventName
         if (eventPresent == "Invalid" && eventName != "") {
             loadSearchNameData(searchNameData);
             console.log("loadSearchNameData ran");
             console.log("inEventName: " + eventName);
         }

         //Both inputed value
         if (eventPresent != "Invalid" && eventName != ""){
             loadSearchData(searchData);
             console.log("loadSearchData1 ran");
             console.log("inEventPresent: " + eventPresent + " inEventName: " + eventName);
         }

         //Search eventPresent, empty eventName
         if(eventPresent != "Invalid" && eventName == "")
             loadSearchData(searchData);
             console.log("loadSearchData2 ran");
             console.log("inEventPresent: " + eventPresent + " inEventName: " + eventName);
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

     $('.redirectRegisteredLink').click(function () {

         userId = getParameterByName('ID');
         console.log(userId);
         window.location.href = "RegisteredEvents.aspx?ID=" + userId;
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
        
         function eventsTableElement() { loadData }
         window.onload = loadData;

         
    
 </script>
 <style>
        #logout{
        color:  white;
        }

    </style>


    </body>
</html>
