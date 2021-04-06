<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AttendanceList.aspx.cs" Inherits="FYP_MarkIn.Staff.AttendanceList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../StaffCSS/attendanceList.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script src="../Scripts/bootstrap-datepicker.min.js"></script>
    


    <title>Attendance Summary</title>
</head>
<body>
   <div class="container">
                
    <div class="page-header1">
        <h3 style="color:darkred;">
        <ul class="navbar">
            <img src="../Images/NEWWWAppIcon.png"height="35" width="35" />  MARK IN         
            <li class="btn btn-primary"><a id="logout" class="redirectLogoutLink" runat="server">Logout</a></li>
            <li class="btn btn-default"><a class="redirectEventLink" runat="server">Events</a></li>
            <li class="btn btn-default"><a class="redirectAttendanceLink" runat="server">My Attendance</a></li>
                
         </ul> 
         </h3>  
    </div>
       
    <form id="AttendanceForm" runat="server" class="form-horizontal">

            
    <div class="panel-heading">

  
                         

    <div class="row">

        <!-- Left side -->
        <div class="col-md-1"></div>
        <div class="col-md-5">
            <div class="row col-md-12">
                <h5>My Attendance</h5>
                <br />
            </div>
            
            <div class="row">
                <div class="col-md-3"><p class="StaffId">Staff ID:</p></div>
                <div class="col-md-5"><span id="messageBoxStaff"></span></div>
                <div class="col-md-4"></div>
                <%--<div id="messageBoxStaff">Enter StaffID.</div>--%>
            </div>

            <div class="row">
                <div class="col-md-3"><p class="Name">Name:</p></div>
                <div class="col-md-5"><span id="messageBoxName"></span></div>
                <div class="col-md-4"></div>
                <%--<div id="messageBoxName">Enter Name.</div>--%>
            </div>
        </div>

        <!-- Right side -->
        <div class="col-md-6">
         
            <div class="row col-md-12">
                <h4>Filter By:</h4>
            </div>         
          
            <div class="row">  
             
                <div class="col-md-4">
                    <label for="SearchDate"> <h2>Date</h2></label>                           
                   <!-- <div class="input-group input-append date">
                        <input type="text"  id="SearchDate" class="form-control" name="SearchDate"/>
                        <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                    <br />-->
                <input type="text" class="form-control" placeholder="yyyy/mm/dd or yyyy-mm-dd" id="SearchDateInput" name="SearchDate" value=""/>
                </div> <%-- End of col-md-4--%>
                
                <div class="col-md-4">
                    <label for="DropDownDivId"> <h2>Present</h2></label>
                      <div class="dropdown" id="DropDownDivId">
                    <select class="form-control" id="VisiblityDropDownList">
                        <option value="Invalid">ALL</option>
                        <option value="True">Yes</option>
                        <option value="False">No</option>
                    </select>

                      </div>
                </div> <%-- End of col-md-4--%>


                <div class="col-md-4"></div> <%-- End of col-md-4--%>

            </div> <!-- End of nested row -->

            <div class="row col-md-12">
                <button Id="searchBtn" class="btn btn-default" type="button"  onclick="btnSearch_Click()">Search</button>
            </div>

        </div> <!-- End of col-md-6 -->
        
    </div> <%-- End of row --%>
   
    </div> <%-- End of panel heading--%>
      
      <div class="panel-body">
        
        <nav id="mainnav">
            <p>
             <a class="redirectEventLink">All Events</a> |
             <a class="redirectCreatedLink">Created Events</a>
                <!-- |  
             <a class="redirectRegisteredLink">Registered Events</a>        -->
            </p>
        </nav>

        <div class="table-responsive">
            <table id="attTable" class="table table-striped">
                <thead>
                    <tr>
                <td>Date</td>
                <td>Check In</td>
                <td>Check Out</td>
                <td>Present</td>
                <td>Hours Clocked</td>
                        
                        
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div> <!-- End of table div -->

    </div> <!-- End of panel body -->
    
    </form>
    
    </div> <!-- End of div container -->
    
        <script>
       

         var userId, present;
         ///////////////////////////////////////////////////////////LOAD ALL///////////////////////////////////////////////////////////
         function WebFormData2(inUserId) {
             this.UserId = inUserId;
             //this.Password = inPassword;
         }

         var loadData = function () {
             //Collect data from the respective form elements.
             userId = getParameterByName('ID');
             console.log("inUserId= " + userId);

             //Create a WebFormData class object, webformData
             var webFormData = new WebFormData2(userId);
             var webFormDataInJson = JSON.stringify(webFormData);


             var requestHandler = $.ajax({
                 type: 'POST',
                 url: 'AttendanceList.aspx/getAllAttendance',
                 data: "{'WebFormData' : '" + webFormDataInJson + "'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json"
             });

             requestHandler.done(function (response) {
                 var attId = '';
                 var attList = response.d;
                 var $attTableElement = $('#attTable tbody');
                 var $rowElement;
                 var $cellElement;
                 var index = 0;

                 for (index = 0; index < attList.length; index++) {
                     attId = attList[index].AttendanceId;
                     $rowElement = $('<tr></tr>');
                     $cellElement = $('<td></td>', { text: attList[index].Date });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: attList[index].InTime });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: attList[index].OutTime });
                     $rowElement.append($cellElement);

                     if (attList[index].Present == "False") {
                         present = "No"
                     } else {
                         present = "Yes"
                     }
                     $cellElement = $('<td></td>', { text: present });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: attList[index].TotalHours });
                     $rowElement.append($cellElement);


                     $attTableElement.append($rowElement);
                 }


             });

             requestHandler.fail(function () {
                 
             });
         };


         var loadStaffData = function () {
             //Collect data from the respective form elements.
             userId = getParameterByName('ID');
             console.log("inUserId= " + userId);

             //Create a WebFormData class object, webformData
             var webFormData = new WebFormData2(userId);
             var webFormDataInJson = JSON.stringify(webFormData);


             var requestHandler = $.ajax({
                 type: 'POST',
                 url: 'AttendanceList.aspx/getStaffDetails',
                 data: "{'WebFormData' : '" + webFormDataInJson + "'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json"
             });

             requestHandler.done(function (response) {
                 var staffName = response.d;
                 userId = getParameterByName('ID');

                 document.getElementById('messageBoxStaff').innerHTML = userId;
                 document.getElementById('messageBoxName').innerHTML = staffName;
               

                 });

             requestHandler.fail(function () {

             });
         };


         function loadSearchData(SearchwebFormData) {
             $.ajax({
                 type: 'POST',
                 url: 'AttendanceList.aspx/searchAttendance',
                 data: JSON.stringify(SearchwebFormData),
                 //"{'inWebFormData':'" + webFormDataInString + "'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json"
             }).done(function (response) {

                 $("#attTable tr").remove();

                 var attId = '';
                 var attList = response.d;
                 var $attTableElement = $('#attTable tbody');
                 var $rowElement;
                 var $cellElement;
                 var index = 0;

                 for (index = 0; index < attList.length; index++) {
                     attId = attList[index].AttendanceId;
                     $rowElement = $('<tr></tr>');
                     $cellElement = $('<td></td>', { text: attList[index].Date });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: attList[index].InTime });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: attList[index].OutTime });
                     $rowElement.append($cellElement);

                     if (attList[index].Present == "False") {
                         present = "No"
                     } else {
                         present = "Yes"
                     }
                     $cellElement = $('<td></td>', { text: present });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: attList[index].TotalHours });
                     $rowElement.append($cellElement);


                     $attTableElement.append($rowElement);
                 }


             }).fail(function () {

             });
         };

         function loadSearchDateData(SearchwebFormData) {
             $.ajax({
                 type: 'POST',
                 url: 'AttendanceList.aspx/searchAttendanceDate',
                 data: JSON.stringify(SearchwebFormData),
                 //"{'inWebFormData':'" + webFormDataInString + "'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json"
             }).done(function (response) {

                 $("#attTable tr").remove();

                 var attId = '';
                 var attList = response.d;
                 var $attTableElement = $('#attTable tbody');
                 var $rowElement;
                 var $cellElement;
                 var index = 0;

                 for (index = 0; index < attList.length; index++) {
                     attId = attList[index].AttendanceId;
                     $rowElement = $('<tr></tr>');
                     $cellElement = $('<td></td>', { text: attList[index].Date });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: attList[index].InTime });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: attList[index].OutTime });
                     $rowElement.append($cellElement);

                     if (attList[index].Present == "False") {
                         present = "No"
                     } else {
                         present = "Yes"
                     }
                     $cellElement = $('<td></td>', { text: present });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: attList[index].TotalHours });
                     $rowElement.append($cellElement);


                     $attTableElement.append($rowElement);
                 }


             }).fail(function () {

             });
         };

         function loadSearchPresentData(SearchwebFormData) {
             $.ajax({
                 type: 'POST',
                 url: 'AttendanceList.aspx/searchAttendancePresent',
                 data: JSON.stringify(SearchwebFormData),
                 //"{'inWebFormData':'" + webFormDataInString + "'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json"
             }).done(function (response) {

                 $("#attTable tr").remove();

                 var attId = '';
                 var attList = response.d;
                 var $attTableElement = $('#attTable tbody');
                 var $rowElement;
                 var $cellElement;
                 var index = 0;

                 for (index = 0; index < attList.length; index++) {
                     attId = attList[index].AttendanceId;
                     $rowElement = $('<tr></tr>');
                     $cellElement = $('<td></td>', { text: attList[index].Date });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: attList[index].InTime });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: attList[index].OutTime });
                     $rowElement.append($cellElement);

                     if (attList[index].Present == "False") {
                         present = "No"
                     } else {
                         present = "Yes"
                     }
                     $cellElement = $('<td></td>', { text: present });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: attList[index].TotalHours });
                     $rowElement.append($cellElement);


                     $attTableElement.append($rowElement);
                 }


             }).fail(function () {

             });
         };

         /////////////////////////////////////////////////////////// CALL LOAD ///////////////////////////////////////////////////////////
         /*function eventsTableElement() { loadData }*/
         window.onload = loadStaffData;
         $(document).ready(function () {
           /*  $('#SearchDate').datepicker({
                 format: "yyyy/mm/dd",
                 value : ""
             });*/
           
             loadData();
            // loadStaffData();
         });

        /////////////////////////////////////////////////////////// SEARCH ///////////////////////////////////////////////////////////

         function btnSearch_Click() {

             var e = document.getElementById("VisiblityDropDownList");
             var eventPresent = e.options[e.selectedIndex].value;
             userId = getParameterByName('ID');

             var eventDate = $('#SearchDateInput').val();

             var searchPresentData = {
                 inEventPresent: eventPresent, inUserId: userId
             };

             var searchDateData = {
                 inEventDate: eventDate, inUserId: userId
             };

             var searchData = {
                 inEventDate: eventDate, inEventPresent: eventPresent, inUserId: userId
             };

             //Both empty
             if (eventPresent == "Invalid" && eventDate == "") {
                 //do nothing
                 window.location.href = window.location.href;
                 console.log(eventDate);
                 console.log("Function 1");
             }

             //Search Date
             if (eventPresent == "Invalid" && eventDate != "") {
                 loadSearchDateData(searchDateData);
                 console.log("loadSearchDateData ran");
                 console.log("inEventPresent: " + eventPresent + " inEventDate: " + eventDate);
                 console.log("Function 2");
             }
             
             //Search Present True empty date
             if (eventPresent != "Invalid" && eventDate != "") {
                 loadSearchData(searchData);
                 console.log("loadSearchData ran");
                 console.log("inEventPresent: " + eventPresent + " inEventDate: " + eventDate);
                 console.log("Function 3");
             }

             //Search eventPresent, empty eventDate
             if (eventPresent != "Invalid" && eventDate == "") {
                 loadSearchPresentData(searchPresentData);
                 console.log("loadSearchData2 ran");
                 console.log("inEventPresent: " + eventPresent + " inEventDate: " + eventDate);
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

       /*  $('.redirectRegisteredLink').click(function () {

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


         $('.redirectLogoutLink').click(function () {

             userId = getParameterByName('ID');
             console.log(userId);
             window.location.replace("../Participants/Logout.aspx?ID=" + userId);
         });
         </script>

     <style>
        #logout{
        color:  white;
        }

    </style>
</body>
</html>