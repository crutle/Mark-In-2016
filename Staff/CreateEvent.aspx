<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateEvent.aspx.cs" Inherits="FYP_MarkIn.Staff.CreateEvent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"/>
    <script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    
    <link href="../StaffCSS/homepage.css" rel="stylesheet" />


    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../Scripts/moment.min.js"></script>
    <script src="../Scripts/bootstrap-datetimepicker.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <link href="../StaffCSS/homepage.css" rel="stylesheet" />
    <script src="../Scripts/modernizr-2.6.2.js"></script>
    <script src="../Scripts/notify.min.js"></script>
    <script src="../Scripts/respond.min.js"></script>
    


<title>Created Events</title>
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
                  
     

    <form id="EventForm" runat="server" class="form-horizontal">

            
    <div class="panel-heading">
                         

    <div class="row">
<!-- Left side -->
         <div class="col-md-1"></div>
         <div class="col-md-5">
            <h5>Events</h5>
            <br />
            <button type="button" id="AddEvent" class="btn btn-default" data-toggle="modal" data-target="#modal-1" data-title="Create" >
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> New Event
            </button>
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

            
           <!--ADD Pop up -->
		<div class="modal fade" id="modal-1">
	        <div class="modal-dialog">
	            <div class="modal-content">

	                <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal">&times;</button>
	                    <h3 class="modal-title"><center>Add New Event</center></h3>
		            </div>

		        <div class="modal-body">

                    <div class="form-group">
                        <label for="nameInput" class="col-md-3 control-label" id="name1">Event Name</label>
                        <div class="col-xs-7">
                            <input type="text" class="form-control " name="nameInput" id="nameInput"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="Location" class="col-md-3 control-label" id="venue">Location</label>
                        <div class="col-xs-7">
                            <input type="text" class="form-control" name="location" id="location" />
                        </div>
                    </div>

                     <div class="form-group"  id="SdatePicker" >
                        <label for ="dateInput" class="col-md-3 control-label" id="start">Start Date/Time</label>
                        <div class="col-xs-6 date">
                            <div class="input-group input-append date">
                                <input type="text"id="SdateInput" class="form-control" name="SdateInput"/>
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



                    <div class="form-group">
                        <label for="desInput" class="col-md-3 control-label"id="descr">Description</label>
                        <div class="col-xs-7">
                            <textarea class="form-control" rows="5" id="comment" ></textarea>
                        </div>
                    </div>
        

	            </div>

                <div class="modal-footer">
					<a href="" class="btn btn-default" id="cancel" data-dismiss="modal">Cancel</a>
				 	<a href="" class="btn btn-danger" id="register">Add</a>
				</div>
			</div>
		</div>
	</div>


        <!--View/Edit Pop up -->
		<div class="modal fade" id="modal-2">
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
                            <input type="text" class="form-control " name="nameInput" id="nameInputV" disabled ="disabled"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="Location" class="col-md-3 control-label" id="venueV">Location</label>
                        <div class="col-xs-7">
                            <input type="text" class="form-control" name="location" id="locationV" disabled ="disabled"/>
                        </div>
                    </div>
                     <div class="form-group">
                        <label for="SdateInput" class="col-md-3 control-label" id="sDate">Start Date/Time</label>
                        <div class="col-xs-7">
                            <input type="text" class="form-control" name="location" id="SdateInputV" disabled ="disabled"/>
                        </div>
                    </div>
                     <div class="form-group">
                        <label for="EdateInput" class="col-md-3 control-label" id="eDate">End Date/Time</label>
                        <div class="col-xs-7">
                            <input type="text" class="form-control" name="location" id="EdateInputV" disabled ="disabled"/>
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
                        <label for="desInput" class="col-md-3 control-label"id="descrV">Description</label>
                        <div class="col-xs-7">
                            <textarea class="form-control" rows="5" id="commentV" disabled="disabled"></textarea>
                        </div>
                    </div>
        

	            </div>

                <div class="modal-footer">
                    <div class="form-group">
                    <a id="redirectEventAttendeesLink" class="btn btn-info" style="float: left; margin-left: 15px;">View Attendees</a>
                    </div>

                    <button Id="btnDelete" class="btn btn-danger" type="button" onclick="btnDelete_Click()" style="float: left;">Delete</button>

					<a href="" class="btn btn-default" id="cancelV" data-dismiss="modal">Cancel</a>
                    <button Id="btnEdit" class="btn btn-danger" type="button"  onclick="btnEdit_Click()" >Edit</button>
                    <input type="text" " name="eventId" id="eventIdValue" style="display: none;" disabled="disabled" value=""/>
                    <button Id="btnSave" class="btn btn-danger" type="button"  onclick="btnSave_Click()" style="display: none;">Save</button>
                    
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
          <a class="redirectRegisteredLink">Registered Events</a>      -->
            

        </p>
      </nav>
                    <div class="table-responsive">
                        <table id="eventTable" class="table table-striped">
                            <thead>
                                <tr>
                                    <td>Event ID</td>
                                    <td>Name</td>
                                    <td>Start</td>
                                    <td>End</td>
                                   
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
        </form>
    </div>
    
<script>

        $(function () {
            $('#SdateInput').datetimepicker({
                useCurrent: false,
                format: 'DD/MM/YYYY HH:mm:ss A'
        });
            $('#SdateInputV').datetimepicker({
                useCurrent: false,
                format: 'DD/MM/YYYY HH:mm:ss A'
            });

            $('#EdateInput').datetimepicker({
                useCurrent: false, //Important! See issue #1075
                format: 'DD/MM/YYYY HH:mm:ss A'
            });
            $('#EdateInputV').datetimepicker({
                useCurrent: false, //Important! See issue #1075
                format: 'DD/MM/YYYY HH:mm:ss A'
            });

            $("#SdateInput").on("dp.change", function (e) {
                $('#SdateInput').data("DateTimePicker").minDate(e.date);
            });
            $("#SdateInputV").on("dp.change", function (e) {
                $('#SdateInputV').data("DateTimePicker").minDate(e.date);
            });

            $("#EdateInput").on("dp.change", function (e) {
                $('#EdateInput').data("DateTimePicker").maxDate(e.date);
            });
            $("#EdateInpuV").on("dp.change", function (e) {
                $('#EdateInputV').data("DateTimePicker").maxDate(e.date);
            });
        });

//changing modal-tittle according to the trigger-button
/*
$(document).ready(function(){
 $("#modal-1").on('show.bs.modal', function(event){
        var button = $(event.relatedTarget);  // Button that triggered the modal
        var titleData = button.data('title'); // Extract value from data-* attributes
        $(this).find('.modal-title').text(titleData + ' Event');
    });
});//end of change modal-tittle
*/

        var eventIdForEdit, selectedEventId;

  window.newEventId = '';
  function WebFormData(inEventName, inEventLocation, inEventStart, inEventEnd, inEventDescription, inUserId) {
   
      this.EventName = inEventName;
      this.EventLocation = inEventLocation;
      this.EventStart = inEventStart;
      this.EventEnd = inEventEnd;
      this.EventDescription = inEventDescription;
      this.UserId = inUserId;
  }


    ////////////////////////////////////////////////////////// ADD //////////////////////////////////////////////////////////
  function addNewEvent() {
      //Collect data from the respective form elements
      var EventName = $('#nameInput').val();
      var EventLocation = $('#location').val();
      var EventStart = $('#SdateInput').val();
      var EventEnd = $('#EdateInput').val();
      var EventDescription = $('#comment').val();
      var userID = getParameterByName('ID');

      if (EventName == "" || EventLocation == "" || EventStart == "" || EventEnd == "" || EventDescription == "") {
          $.notify("Please fill in all the fields");
      } else {

          //Initialize a Event class object, eventData
          var webFormData = new WebFormData(EventName, EventLocation, EventStart, EventEnd, EventDescription, userID);
          var webFormDataInJson = JSON.stringify(webFormData);
          //console.log(jsonText);
          $.ajax(
                      {
                          type: 'POST',
                          url: 'CreateEvent.aspx/AddOneEvent',
                          data: "{'WebFormData' : '" + webFormDataInJson + "'}",
                          contentType: 'application/json; charset=utf-8',
                          dataType: 'json',
                          async: false,
                          success: function (response) {

                              $.notify("Successful adding of new event!", "success");

                          },
                          error: function (xhr, status, errorThrown) {
                              $.notify('Error Message : ' + errorThrown);
                          }
                      })
          ;//end of $.ajax(...)
      }
  }

  $('#register').on('click', addNewEvent);//end of $('#saveButton').on(....


    ////////////////////////////////////////////////////////// UPDATE //////////////////////////////////////////////////////////
  function WebFormData3(inEventName, inEventLocation, inEventStart, inEventEnd, inEventDescription, inUserId, inEventId) {
   
      this.EventName = inEventName;
      this.EventLocation = inEventLocation;
      this.EventStart = inEventStart;
      this.EventEnd = inEventEnd;
      this.EventDescription = inEventDescription;
      this.UserId = inUserId;
      this.EventId = inEventId;
  }

  function btnSave_Click() { 

      var EventName = $('#nameInputV').val();
      var EventLocation = $('#locationV').val();
      var EventStart = $('#SdateInputV').val();
      var EventEnd = $('#EdateInputV').val();
      var EventDescription = $('#commentV').val();
      var userID = getParameterByName('ID');

      var EventID = eventIdForEdit;

      //Initialize a Event class object, eventData
      var webFormData = new WebFormData3(EventName, EventLocation, EventStart, EventEnd, EventDescription, userID, EventID);
      var webFormDataInJson = JSON.stringify(webFormData);
      //console.log(jsonText);
      $.ajax(
                  {
                      type: 'POST',
                      url: 'CreateEvent.aspx/UpdateOneEvent',
                      data: "{'WebFormData' : '" + webFormDataInJson + "'}",
                      contentType: 'application/json; charset=utf-8',
                      dataType: 'json',
                      async: false,
                      success: function (response) {

                          $("#btnEdit").show();
                          $("#btnSave").hide();
                          document.getElementById('nameInputV').disabled = true;
                          document.getElementById('locationV').disabled = true;
                          document.getElementById('SdateInputV').disabled = true;
                          document.getElementById('EdateInputV').disabled = true;
                          document.getElementById('commentV').disabled = true;

                          $.notify("Successful updating of event!", "success");

                      },
                      error: function (xhr, status, errorThrown) {
                          $.notify('Error Message : ' + errorThrown);
                      }
                  })
      ;//end of $.ajax(...)
  }


    ////////////////////////////////////////////////////////// LOAD //////////////////////////////////////////////////////////
  function WebFormData2(inUserId) {
      this.UserId = inUserId;
      //this.Password = inPassword;
  }

  var loadData = function () {
      //Collect data from the respective form elements.
      var userId = getParameterByName('ID');
      console.log("inUserId= " + userId);

      //Create a WebFormData class object, webformData
      var webFormData = new WebFormData2(userId);
      var webFormDataInJson = JSON.stringify(webFormData);


      var requestHandler = $.ajax({
          type: 'POST',
          url: 'CreateEvent.aspx/getAllEvent',
          data: "{'WebFormData' : '" + webFormDataInJson + "'}",
          contentType: "application/json; charset=utf-8",
          dataType: "json"
      });

      requestHandler.done(function (response) {
          var eventId = '';
          var eventList = response.d;
          var $eventTableElement = $('#eventTable tbody');
          var $rowElement;
          var $cellElement;
          var index = 0;

          for (index = 0; index < eventList.length; index++) {
              eventId = eventList[index].EventId;
              $rowElement = $('<tr></tr>');
              $cellElement = $('<td></td>', { text: eventList[index].EventId });
              $rowElement.append($cellElement);
              $cellElement = $('<td></td>', { text: eventList[index].EventName });
              $rowElement.append($cellElement);
              $cellElement = $('<td></td>', { text: eventList[index].EventStart });
              $rowElement.append($cellElement);
              $cellElement = $('<td></td>', { text: eventList[index].EventEnd });
              $rowElement.append($cellElement);

              $hyperLinkElement = $('<a class="btnView" data-toggle="modal" href="#modal-2">View Event</a>');
              $hyperLinkElement.addClass('btn btn-default');
              $cellElement = $('<td></td>');
              $cellElement.append($hyperLinkElement);
              $rowElement.append($cellElement);
              $eventTableElement.append($rowElement);


              $('.btnView').click(function () {
                  row = $(this).closest('tr').find('td:nth-child(1)').text();
                 
                  $("#btnEdit").show();
                  $("#btnSave").hide();
                  document.getElementById('nameInputV').disabled = true;
                  document.getElementById('locationV').disabled = true;
                  document.getElementById('SdateInputV').disabled = true;
                  document.getElementById('EdateInputV').disabled = true;
                  document.getElementById('commentV').disabled = true;

                  console.log("row id = " + row);
                  eventIdForEdit = row;
                  setupWebFormDetails(row);

              });

          }
       

      });

      requestHandler.fail(function () {
          console.log(error);
      });
  };



  /////////////////////////////////////////////////////////// CALL LOAD ///////////////////////////////////////////////////////////
  function eventsTableElement() { loadData }
  window.onload = loadData;

  /////////////////////////////////////////////////////////// EDIT ///////////////////////////////////////////////////////////
  function btnEdit_Click() {
      $("#btnSave").show();
      $("#btnEdit").hide();
      document.getElementById('nameInputV').disabled = false;
      document.getElementById('locationV').disabled = false;
      document.getElementById('SdateInputV').disabled = false;
      document.getElementById('EdateInputV').disabled = false;
      document.getElementById('commentV').disabled = false;

  };

  /////////////////////////////////////////////////////////// Get 1 Event ///////////////////////////////////////////////////////////
  function setupWebFormDetails(eventId) {
      $.ajax({
          type: 'POST',
          url: 'CreateEvent.aspx/getOneEventsData',
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
          var reventId = event.EventId;

          $('#nameInputV').val(name);
          $('#locationV').val(location);
          $('#SdateInputV').val(startTime);
          $('#EdateInputV').val(endTime);
          $('#commentV').val(desc);
          $('#eventIdValue').val(reventId);
          console.log("EventId: " + reventId);


      });
  }
    ////////////////////////////////////// SEARCH //////////////////////////////////////
  function loadSearchNameData(SearchwebFormData) {
      $.ajax({
          type: 'POST',
          url: 'CreateEvent.aspx/searchEventName',
          data: JSON.stringify(SearchwebFormData),
          //"{'inWebFormData':'" + webFormDataInString + "'}",
          contentType: "application/json; charset=utf-8",
          dataType: "json"
      }).done(function (response) {

          $("#eventTable tr").remove();

          var eventId = '';
          var eventsList = response.d;
          var $eventsTableElement = $('#eventTable tbody');
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
              $hyperLinkElement = $('<a class="btnView" data-toggle="modal" href="#modal-2">View Event</a>');
              $hyperLinkElement.addClass('btn btn-default');

              $cellElement = $('<td></td>');
              $cellElement.append($hyperLinkElement);
              $rowElement.append($cellElement);
              $eventsTableElement.append($rowElement);


              $('.btnView').click(function () {
                  row = $(this).closest('tr').find('td:nth-child(1)').text();

                  $("#btnEdit").show();
                  $("#btnSave").hide();
                  document.getElementById('nameInputV').disabled = true;
                  document.getElementById('locationV').disabled = true;
                  document.getElementById('SdateInputV').disabled = true;
                  document.getElementById('EdateInputV').disabled = true;
                  document.getElementById('commentV').disabled = true;

                  console.log("row id = " + row);
                  eventIdForEdit = row;
                  setupWebFormDetails(row);

              });

          }
      });

  };

  // var obj = { username: $("#txtuser").val(), name: $("#txtname").val() }; document.getElementById('SearchId')


    function loadSearchData(SearchwebFormData) {
        $.ajax({
            type: 'POST',
            url: 'CreateEvent.aspx/searchEvent',
            data: JSON.stringify(SearchwebFormData),
            //"{'inWebFormData':'" + webFormDataInString + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        }).done(function (response) {

            $("#eventTable tr").remove();

            var eventId = '';
            var eventsList = response.d;
            var $eventsTableElement = $('#eventTable tbody');
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

                $hyperLinkElement = $('<a class="btnView" data-toggle="modal" href="#modal-2">View Event</a>');
                $hyperLinkElement.addClass('btn btn-default');

                $cellElement = $('<td></td>');
                $cellElement.append($hyperLinkElement);
                $rowElement.append($cellElement);
                $eventsTableElement.append($rowElement);
                console.log("append rows to table");

                $('.btnView').click(function () {
                    row = $(this).closest('tr').find('td:nth-child(1)').text();

                    $("#btnEdit").show();
                    $("#btnSave").hide();
                    document.getElementById('nameInputV').disabled = true;
                    document.getElementById('locationV').disabled = true;
                    document.getElementById('SdateInputV').disabled = true;
                    document.getElementById('EdateInputV').disabled = true;
                    document.getElementById('commentV').disabled = true;

                    console.log("row id = " + row);
                    eventIdForEdit = row;
                    setupWebFormDetails(row);

                });

            }
        }).fail(function () {
            console.log(error);
        });

    };
    /////////////////////////////////////////DELETE//////////////////////////////////////////

    function deleteEvent(SearchwebFormData) {
        $.ajax({
            type: 'POST',
            url: 'CreateEvent.aspx/deleteEvent',
            data: JSON.stringify(SearchwebFormData),
            //"{'inWebFormData':'" + webFormDataInString + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        }).done(function (response) {
            console.log("Marked Deleted");
            window.location.href = window.location.href;


        });

    }
        /////////////////////////////////////////Btn Functions//////////////////////////////////////////

        function btnSearch_Click() {

            var eventId = document.getElementById("SearchIdInput").value;
            var eventName = document.getElementById("SearchNameInput").value;
            //var x = document.getElementById("SearchIdInput").value;
            userId = getParameterByName('ID');

            var searchNameData = {
                inEventName: eventName, inUserId: userId
            };

            var searchData = {
                inEventName: eventName, inEventId: eventId, inUserId: userId

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

        function btnDelete_Click() {
            //To be changed to dialog yes no
            var result = confirm("Are you sure you want to delete this event?");

            if (result) {
                console.log("Delete clicked");

                selectedEventId = $('#eventIdValue').val();
                userId = getParameterByName('ID');

                var deleteEventData = {
                    inEventId: selectedEventId, inUserId: userId
                };

                deleteEvent(deleteEventData);


                //redirect "refresh" when done


            } else {
                // Do nothing; they cancelled
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

       /* $('.redirectRegisteredLink').click(function () {

            userId = getParameterByName('ID');
            console.log(userId);
            window.location.href = "RegisteredEvents.aspx?ID=" + userId;
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

        $('#redirectEventAttendeesLink').click(function () {

            userId = getParameterByName('ID');
            selectedEventId = $('#eventIdValue').val();
            console.log(userId);
            window.location.href = "RegisteredParticipants.aspx?ID=" + userId + "&EventId=" + selectedEventId;
        });

        $('.redirectLogoutLink').click(function () {

            userId = getParameterByName('ID');
            console.log(userId);
            window.location.replace("../Participants/Logout.aspx?ID=" + userId);
        });

</script>

    <style>
    .table-striped>tbody>tr:nth-child(odd)>td, .table-striped>tbody>tr:nth-child(odd)>th {
    font-family: 'Muli';
    background-color: #c0f7a1;
}

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
