<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AllEvents.aspx.cs" Inherits="FYP_MarkIn.Staff.AllEvents" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"/>
    <script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../Scripts/moment.min.js"></script>
    <script src="../Scripts/bootstrap-datetimepicker.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <link href="../StaffCSS/homepage.css" rel="stylesheet" />
    <script src="../Scripts/modernizr-2.6.2.js"></script>
    <script src="../Scripts/notify.min.js"></script>
    <script src="../Scripts/respond.min.js"></script>



    <title>All Events</title>
</head>
<body>
    <div class="container">
                
        <div class="page-header1">
            <h3 style="color:darkred;">
            <ul class="navbar">
                <img src="../Images/NEWWWAppIcon.png" width="35" height="35" />  MARK IN         
                <li class="btn btn-primary"><a id="logout" class="redirectLogoutLink" runat="server">Logout</a></li>
               <li class="btn btn-default"><a class="redirectEventLink" runat="server">Events</a></li>
                <li class="btn btn-default"><a class="redirectAttendanceLink" runat="server">My Attendance</a></li>
            </ul> 
                
            </h3>  
        </div>
                  
    <form id="AllEventsForm" runat="server" class="form-horizontal">

            
    <div class="panel-heading">
        <%--<Row for Categories panel heading and add category button --%>

        <%--<div class="row">
            <div class="col-md-6"></div>
            <div class="col-md-6">&nbsp;</div>
        </div>--%> <%-- End of row--%>
                         

     <div class="row">

         <!-- Left side -->
         <div class="col-md-1"></div>
         <div class="col-md-5">
            <h5>All Events</h5>
         </div>     
         
         <!-- Right side -->    
        <div class="col-md-6">
            
            <div class="row col-md-12">
                <h4>Filter By:</h4>
            </div>

            <div class="row">
                
                <div class="col-md-4">
                    <label for="SearchId"> <h2>Event ID</h2></label>
                    <input type="text" class="form-control" placeholder="Search for..." id="SearchIdInput" name="SearchId" value=""/>
                    <br />
                </div>
                
                <div class="col-md-4">
                    <label for="SearchName"> <h2>Name</h2></label>
                    <input type="text" class="form-control" placeholder="Search for..." id="SearchNameInput" name="SearchName" value=""/>
                </div>

                <div class="col-md-4"></div>

            </div> <!-- End of nested row -->
            
            <div class="row col-md-12">               
                <button Id="searchNameandStaff" class="btn btn-default" type="button"  onclick="btnSearch_Click()">Search</button>
            </div>            
        
        </div> <!-- End of right side -->
            
        
            
	    <!-- Pop up -->
		<div class="modal fade" id="modal-1">
	        <div class="modal-dialog">
	            <div class="modal-content">

	                <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal">&times;</button>
	                    <h3 class="modal-title"><center>Event Details</center></h3>
		            </div>

		        <div class="modal-body">

                    <div class="form-group">
                        <label for="nameInput" class="col-md-3 control-label" id="name">Event Name</label>
                        <div class="col-xs-7">
                            <input type="text" class="form-control " name="nameInput" id="nameInput" readonly="readonly"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="Location" class="col-md-3 control-label" id="venue">Location</label>
                        <div class="col-xs-7">
                            <input type="text" class="form-control" name="location" id="location" readonly="readonly"/>
                        </div>
                    </div>
                     <div class="form-group">
                        <label for="SdateInput" class="col-md-3 control-label" id="sDate">Start Date/Time</label>
                        <div class="col-xs-7">
                            <input type="text" class="form-control" name="location" id="SdateInput" readonly="readonly"/>
                        </div>
                    </div>
                     <div class="form-group">
                        <label for="EdateInput" class="col-md-3 control-label" id="eDate">End Date/Time</label>
                        <div class="col-xs-7">
                            <input type="text" class="form-control" name="location" id="EdateInput" readonly="readonly"/>
                        </div>
                    </div>

                    <!--
                    <div class="form-group"  id="SdatePicker" >
                        <label for ="dateInput" class="col-md-3 control-label" id="start">Start Date/Time</label>
                        <div class="col-xs-6 date">
                            <div class="input-group input-append date" id="SdateInput" >
                                <input type="text" class="form-control"/>
                                <span class="input-group-addon add-on">
                                    <span class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                        </div>
                    </div>

                    <div class="form-group"  id="EdatePicker" >
                        <label for ="dateInput" class="col-md-3 control-label" id="end">End Date/Time</label>
                        <div class="col-xs-6 date">
                            <div class="input-group input-append date">
                                <input type="text"  id="EdateInput" class="form-control" name="EdateInput"/>
                                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                        </div>
                        </div>
                       
                    -->


                    <div class="form-group">
                        <label for="desInput" class="col-md-3 control-label"id="descr">Description</label>
                        <div class="col-xs-7">
                            <textarea class="form-control" rows="5" id="comment" readonly="readonly"></textarea>
                        </div>
                    </div>
        

	            </div>

                <div class="modal-footer">
					
				</div>
			</div>
		</div>
	</div>


        
    </div> <%-- End of row --%>
        
     

    </div> <%-- End of panel heading--%>

  <div class="panel-body">
      <nav id="mainnav">
        <p>
          <a class="redirectEventLink">All Events</a> |
          <a class="redirectCreatedLink">Created Events</a>
            <!-- |  
          <a class="redirectRegisteredLink">Registered Events</a>         
            -->
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
      <td>Created By</td>
      
    </tr>
  </thead> 
  <tbody>

  </tbody>
</table>
    
    </div><%-- End of table responsive --%>
    </div> <%-- End of panel-body--%>
    </form> <%-- End of form--%>
</div> <%-- End of container--%>

  
        <script>  
          /*  $(function () {
                $('#SdateInput').datetimepicker();
                $('#EdateInput').datetimepicker({
                    useCurrent: false //Important! See issue #1075
                });
                $("#SdateInput").on("dp.change", function (e) {
                    $('##SdateInput').data("DateTimePicker").minDate(e.date);
                });
                $("#EdateInput").on("dp.change", function (e) {
                    $('#EdateInput').data("DateTimePicker").maxDate(e.date);
                });
            });

            */

            var row, userId;

        ///////////////////////////////////////////////////////////LOAD ALL///////////////////////////////////////////////////////////
        function WebFormData(inEventName, inEventStart, inEventEnd, inEventLocation, inEventDescription) {
            this.Name = inEventName;
            this.Start = inEventStart;
            this.End = inEventEnd;
            this.Location = inEventLocation;
            this.Description = inEventDescription;
        }

        var loadData = function () {
            var webFormData = new WebFormData();
            var webFormDataInString = JSON.stringify(webFormData);


            var requestHandler = $.ajax({
                type: 'POST',
                url: 'AllEvents.aspx/getAllEventsData',
                data: "{'inWebFormData':'" + webFormDataInString + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json"
                //async: false
            });

            requestHandler.done(function (response) {
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
                    $cellElement = $('<td></td>', { text: eventsList[index].CreatedBy });
                    $rowElement.append($cellElement);

                    $hyperLinkElement = $('<a class="btnView" data-toggle="modal" href="#modal-1">View Event</a>');
                    $hyperLinkElement.addClass('btn btn-default');

                    $cellElement = $('<td></td>');
                    $cellElement.append($hyperLinkElement);
                    $rowElement.append($cellElement);
                    $eventsTableElement.append($rowElement);

                    $('.btnView').click(function () {
                        row = $(this).closest('tr').find('td:nth-child(1)').text();
                        
                        console.log("row id = " + row);
                        setupWebFormDetails(row);

                    });

                }
            });

            requestHandler.fail(function (error) {
                console.log(error);
            })
        };


        ///////////////////////////////////////////////////////////LOAD///////////////////////////////////////////////////////////
        function eventsTableElement() { loadData }
        window.onload = loadData;
       

       ///////////////////////////////////////////////////////////Get 1 Event///////////////////////////////////////////////////////////
        function setupWebFormDetails(eventId) {
            $.ajax({
                type: 'POST',
                url: 'AllEvents.aspx/getOneEventsData',
                data: "{'eventId':" + eventId + "}",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
            }).done(function (data, textStatus, jqXHR) {
                console.log(data);
                console.log(data.d);
                var event = data.d;

                var name = event.EventName;
                var location = event.EventLocation;
                var startTime = event.EventStart;
                var endTime = event.EventEnd
                var desc = event.EventDescription;


                $('#nameInput').val(name);
                $('#location').val(location);
                $('#SdateInput').val(startTime);
                $('#EdateInput').val(endTime);
                $('#comment').val(desc);

            });
        }

        ///////////////////////////////////////////////////////////SEARCH///////////////////////////////////////////////////////////
      
        function loadSearchNameData(SearchwebFormData) {
            $.ajax({
                type: 'POST',
                url: 'AllEvents.aspx/searchEventName',
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

                    $cellElement = $('<td></td>', { text: eventsList[index].CreatedBy });
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


       // var obj = { username: $("#txtuser").val(), name: $("#txtname").val() }; document.getElementById('SearchId')
        

           function loadSearchData(SearchwebFormData) {
            $.ajax({
                type: 'POST',
                url: 'AllEvents.aspx/searchEvent',
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
                    $cellElement = $('<td></td>', { text: eventsList[index].CreatedBy });
                    $rowElement.append($cellElement);

                    $hyperLinkElement = $('<a class="btnView" data-toggle="modal" href="#modal-1">View Event</a>');
                    $hyperLinkElement.addClass('btn btn-default');

                    $cellElement = $('<td></td>');
                    $cellElement.append($hyperLinkElement);
                    $rowElement.append($cellElement);
                    $eventsTableElement.append($rowElement);

                    $('.btnView').click(function () {
                        row = $(this).closest('tr').find('td:nth-child(1)').text();

                        console.log("row id = " + row);
                        setupWebFormDetails(row);

                    });
                    
                }
            });
            
        };


           function btnSearch_Click() {

               var eventId = document.getElementById("SearchIdInput").value;
               var eventName = document.getElementById("SearchNameInput").value;
               //var x = document.getElementById("SearchIdInput").value;


               var searchNameData = {
                   inEventName: eventName
               };

               var searchData = {
                   inEventName: eventName, inEventId: eventId

               };

               //Both empty
               if (eventId == "" && eventName == "") {
                   window.location.href = window.location.href
                   //do nothing
               }

               //Search for eventName
               if (eventId == "" && eventName != "") {
                   loadSearchNameData(searchNameData);
                   console.log("loadSearchNameData ran");
                   console.log("inEventName: " + eventName);
               }

               //Both inputed value
               if (eventId != "" && eventName != "") {
                   loadSearchData(searchData);
                   console.log("loadSearchData1 ran");
                   console.log("inEventPresent: " + eventId + " inEventName: " + eventName);
               }

               //Search eventPresent, empty eventName
               if (eventId != "" && eventName == "") {
                   loadSearchData(searchData);
                   console.log("loadSearchData2 ran");
                   console.log("inEventPresent: " + eventId + " inEventName: " + eventName);
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

       /*    $('.redirectRegisteredLink').click(function () {
              
               userId = getParameterByName('ID');
               console.log(userId);
               window.location.href = "RegisteredEvents.aspx?ID="+userId;
           });
           */
           $('.redirectCreatedLink').click(function () {

               userId = getParameterByName('ID');
               console.log(userId);
               window.location.href = "CreateEvent.aspx?ID=" + userId;
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

        </script>

        <style>
        .modal-dialog{
           display: inline-block;
            text-align: left;
             vertical-align: middle;
        }

           #logout{
        color:  white;
        }

    </style>

    </body>
</html>
