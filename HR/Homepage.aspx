<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Homepage.aspx.cs" Inherits="FYP_MarkIn.HR.Homepage" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../HRCSS/homepage.css" rel="stylesheet" />
    <script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script src="../Scripts/bootstrap-datepicker.min.js"></script>
    <script src="../Scripts/jquery.validate.min.js"></script>
    <script src="../Scripts/notify.min.js"></script>

   <title>All Staff Information</title>
</head>
<body>
    <div class="container">
                
        <div class="page-header1">
            <h3 style="color:darkred;">
        
                <img src="../Images/NEWWWAppIcon.png" width="35" height="35" />  MARK IN         
                <a id="logout" class="redirectLogoutLink btn btn-primary" runat="server">Logout</a>
            </h3>
            
                
        </div>
                  
     

    <form id="HomePageForm" runat="server" class="form-horizontal">

            
    <div class="panel-heading">
        <%--<Row for Categories panel heading and add category button --%>
        <%--<div class="row">
            <div class="col-md-6"></div>
            <div class="col-md-6">&nbsp;</div>
        </div> <%-- End of row--%>
                         

     <div class="row">

         <!-- Left side -->    
         <div class="col-md-1"></div>
         <div class="col-md-5">
            <div class="row col-md-12">
                <h5>Staff Information</h5>
                <br />
                <button type="button" id="AddStaff" class="btn btn-default" data-toggle="modal" data-target="#modal-1" >
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> New Staff
                </button>

               

            </div>
        </div>

        <!-- Right side -->
        <div class="col-md-6">
            <div class="row col-md-12">
                <h4>Filter By:</h4>
            </div>
           
            <div class="row"> <!-- Row for filter input -->

                <div class="col-md-4">
                    <label for="SearchDate"> <h2>Staff ID</h2></label>
                    <input type="text" class="form-control" placeholder="Search for..." id="SearchStaff" name="SearchDate"/>
                    <br />
                </div>

                <div class="col-md-4">
                    <label for="SearchPresent"> <h2>Name</h2></label>
                    <input type="text" class="form-control" placeholder="Search for..." id="SearchName" name="SearchPresent"/>
                </div>
              
                <div class="col-md-4"></div>

            </div> <!-- End of row -->

            <div class="row col-md-12">
                <button Id="searchNameandStaff" class="btn btn-default" type="button"  onclick="btnSearch_Click()">Search</button>
                <br />
            </div>
            
  
    

    </div> <!-- End of right side -->


         <!-- ADD NEW STAFF POPUP -->
         <div class="modal fade" id="modal-1">
             <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h7 class="modal-title"><center>Add Staff</center></h7>
                </div>

                <div class="modal-body">
                   
                    <div class="form-group">
                        <label for="nameInput" class="col-md-3 control-label" id="name">Name</label>
                        <div class="col-xs-7">
                            <asp:textbox ID="nameInput" runat="server" class="form-control" ReadOnly="false"/>
                        </div>
                    </div>

                     <div class="form-group">
                        <label for="nameInput" class="col-md-3 control-label" id="tableName">Staff Table Name</label>
                        <div class="col-xs-7">
                            <asp:textbox ID="tableNameInput" runat="server" class="form-control" ReadOnly="false" placeholder="Name (without spaces)"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="pwInput" class="col-md-3 control-label" id="pw">Staff Password</label>
                        <div class="col-xs-7">
                            <asp:textbox ID="passwordInput" runat="server" class="form-control" ReadOnly="false"/>
                        </div>
                    </div>
                    
                    <div class="form-group">
                         <label for="adminInput" class="col-md-3 control-label" id="adminInput">Type</label> 

                         <asp:DropDownList ID="ddlType" runat="server" style="margin-left: 15px; margin-top: 10px;" Enabled="true">
                                 <asp:ListItem Text="Admin" Value="True"></asp:ListItem>
                                  <asp:ListItem Text="Staff" Value="False"></asp:ListItem>
                        </asp:DropDownList>

                       
                         
                    </div>

                    <div class="form-group">
                        <label for="positionInput" class="col-md-3 control-label" id="position">Position</label>
                        <div class="col-xs-7">
                            <asp:textbox ID="positionInput" runat="server" class="form-control" ReadOnly="false"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="salaryInput" class="col-md-3 control-label"id="salary">Salary/Hr($)</label>
                        <div class="col-xs-5">
                            <asp:textbox ID="salaryInput" runat="server" class="form-control" ReadOnly="false" />

                        </div>
                        </div>
                    
                    <div class="form-group">
                        <label for="contactInput" id="contactInput3" class="col-md-3 control-label" style="margin-left: 0;">Contact</label>
                        <div class="col-xs-7">
                            <asp:textbox ID="contactInput" runat="server" class="form-control" ReadOnly="false" style="margin-left: 0;"/>
                        </div>
                    </div>
                    
                    <div class="form-group"  id="datePicker" >
                        <label for ="dateInput" class="col-md-3 control-label" id="dateofbirth">Date of Birth</label>
                        <div class="col-xs-5 date">
                            <div class="input-group input-append date">
                            <asp:textbox ID="dateInput" runat="server" class="form-control" ReadOnly="false" value="" placeholder="yyyy/mm/dd"/>
                                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                         </div>
                    </div>
               
                    <div class="form-group">
                        <label for="positionInput" class="col-md-3 control-label"id="address">Address</label>
                        <div class="col-xs-7">
                            <asp:textbox ID="addressInput" runat="server" class="form-control" ReadOnly="false" TextMode="multiline" Columns="50" Rows="5"/>
                        </div>
                    </div>

                     <div class="form-group">
                         <label for="statusInput" class="col-md-3 control-label"id="status">Staff Account Status</label>
                            <asp:DropDownList ID="ddlStatus" runat="server" style="margin-left: 15px; margin-top: 10px;" Enabled="True">
                                 <asp:ListItem Text="Account Status" Value=""></asp:ListItem>
                                  <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                                  <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                  <asp:ListItem Text="Inactive" Value="Inactive"></asp:ListItem>

                             </asp:DropDownList>

                   
                     </div>

                </div>

                <div class="modal-footer">
                    <a class="btn btn-danger" id="confirm">Add</a>

                </div>
            </div>
        </div>
    </div>



         <!--EDIT STAFF-->
             <div class="modal fade" id="modal-2">
                    <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h7 class="modal-title"><center>Staff Details</center></h7>
                </div>

                <div class="modal-body">
                   
                    <div class="form-group">
                        <label for="nameInput" class="col-md-3 control-label" id="name1">Name</label>
                        <div class="col-xs-7">
                            <asp:textbox ID="nameInput1" runat="server" class="form-control" ReadOnly="true"/>
                        </div>
                    </div>

                     <div class="form-group">
                        <label for="nameInput" class="col-md-3 control-label" id="tableName1">Staff Table Name</label>
                        <div class="col-xs-7">
                            <asp:textbox ID="tableNameInput1" runat="server" class="form-control" ReadOnly="true" placeholder="Name (without spaces)"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="pwInput" class="col-md-3 control-label" id="pw1">Staff Password</label>
                        <div class="col-xs-7">
                            <asp:textbox ID="passwordInput1" runat="server" class="form-control" ReadOnly="true"/>
                        </div>
                    </div>
                    
                    <div class="form-group">
                         <label for="adminInput" class="col-md-3 control-label" id="adminInput1">Type</label> 

                         <asp:DropDownList ID="ddlType1" runat="server" style="margin-left: 15px; margin-top: 10px;" Enabled="false">
                                 <asp:ListItem Text="Admin" Value="True"></asp:ListItem>
                                  <asp:ListItem Text="Staff" Value="False"></asp:ListItem>
                        </asp:DropDownList>

                       
                         
                    </div>

                    <div class="form-group">
                        <label for="positionInput" class="col-md-3 control-label" id="position1">Position</label>
                        <div class="col-xs-7">
                            <asp:textbox ID="positionInput1" runat="server" class="form-control" ReadOnly="true"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="salaryInput" class="col-md-3 control-label"id="salary1">Salary/Hr($)</label>
                        <div class="col-xs-5">
                            <asp:textbox ID="salaryInput1" runat="server" class="form-control" ReadOnly="true" />

                        </div>
                        </div>
                    
                    <div class="form-group">
                        <label for="contactInput" id="contactInput4" class="col-md-3 control-label" style="margin-left: 0;">Contact</label>
                        <div class="col-xs-7">
                            <asp:textbox ID="contactInput1" runat="server" class="form-control" ReadOnly="true" style="margin-left: 0;"/>
                        </div>
                    </div>
                    
                    <div class="form-group"  id="datePicker1" >
                        <label for ="dateInput" class="col-md-3 control-label" id="dateofbirth1">Date of Birth</label>
                        <div class="col-xs-5 date">
                            <div class="input-group input-append date">
                            <asp:textbox ID="dateInput1" runat="server" class="form-control" ReadOnly="true" value="" placeholder="yyyy/mm/dd" />
                                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                         </div>
                    </div>
               
                    <div class="form-group">
                        <label for="positionInput" class="col-md-3 control-label"id="address1">Address</label>
                        <div class="col-xs-7">
                            <asp:textbox ID="addressInput1" runat="server" class="form-control" ReadOnly="true" TextMode="multiline" Columns="50" Rows="5"/>
                        </div>
                    </div>

                     <div class="form-group">
                         <label for="statusInput" class="col-md-3 control-label"id="status1">Staff Account Status</label>
                            <asp:DropDownList ID="ddlStatus1" runat="server" style="margin-left: 15px; margin-top: 10px;" Enabled="False">
                                 <asp:ListItem Text="Account Status" Value=""></asp:ListItem>
                                  <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                                  <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                  <asp:ListItem Text="Inactive" Value="Inactive"></asp:ListItem>

                             </asp:DropDownList>

                   
                     </div>

                </div>

                <div class="modal-footer">
                   
                    <a href="" class="btn btn-default" id="cancelV" data-dismiss="modal">Cancel</a>
                    <button Id="btnEdit" class="btn btn-danger" type="button"  onclick="btnEdit_Click()" >Edit</button>
                
                    <button Id="btnSave" class="btn btn-danger" type="button"  onclick="btnSave_Click()" style="display: none;">Save</button>
                </div>
            </div>
        </div>
    </div>



    </div> <%-- End of row --%>
    </div> <%-- End of panel heading--%>
      
    </form>

    <div id ="box1"></div>
    

     <table id="staffTable" class="table table-striped">
       <thead>
     <tr>
           <td>Staff ID</td>
           <td>Name</td>
           <td>Position</td>
           <td>Salary/hr($)</td>
           <td>Status</td>
           <td>Administrator</td>
           <td>Attendance</td>
          
           
       </tr>
        </thead>
       <tbody>

       </tbody>
           </table>

           </div> <%-- End of container--%>


      <script>
          /*  $(document).ready(function () {
             $('#dateInput')
                 .datepicker({
                     format: 'dd/mm/yyyy'
                 })
                 .on('changeDate', function (e) {
                     // Revalidate the date field
                     $('#eventForm').formValidation('revalidateField', 'date');
                 });
         });
     */
         $(function () {
             $("#dateInput").datepicker({ format: 'yyyy/mm/dd' });
             $("#dateInput1").datepicker({ format: 'yyyy/mm/dd' });
       });



         

         window.newStaffId = '';
         var userId, collectedStaffId;
          /////////////////////////////////////////////////ADD/////////////////////////////////////////
         function WebFormData(inName, inPosition, inType, inSalary, inContact, inDateofbirth, inAddress, inTableName, inUserId, inPassword,inStatus) {
             this.Name = inName;
             this.TableName = inTableName;
             this.StaffPassword = inPassword;
             this.Type = inType;
             this.Position = inPosition;
             this.Salary = inSalary;
             this.Contact = inContact;
             this.Dateofbirth = inDateofbirth;
             this.Address = inAddress;
             this.Status = inStatus;
             this.UserId = inUserId
         }


         function addNewStaff() {            
             //Collect data from the respective form elements
             var Name = $('#nameInput').val();
             var Position = $('#positionInput').val();
             var Salary = $('#salaryInput').val();
             var Contact = $('#contactInput').val();
             var Dateofbirth = $('#dateInput').val();
             var Address = $('#addressInput').val();

             var e = document.getElementById("ddlType");
             var Type = e.options[e.selectedIndex].value;

             console.log("Type (add new Staff) = " + Type);

             var TableName = $('#tableNameInput').val();
             var UserId = getParameterByName('ID');
             var Password = $('#passwordInput').val();

             var e = document.getElementById("ddlStatus");
             var Status = e.options[e.selectedIndex].value;

             if (Name == "" || Position == "" || Salary == "" || Contact == "" || Dateofbirth == "" || Address == "" || Type == "" || Password == "" || Status == "") {
                 $.notify("Please fill in all the fields");
             } else {

                 //Initialize a Student class object, studentData
                 var webFormData = new WebFormData(Name, Position, Type, Salary, Contact, Dateofbirth, Address, TableName, UserId, Password, Status);
                 var webFormDataInJson = JSON.stringify(webFormData);
                 //console.log(jsonText);
                 $.ajax(
                             {
                                 type: 'POST',
                                 url: 'Homepage.aspx/AddOneStaff',
                                 data: "{'WebFormData' : '" + webFormDataInJson + "'}",
                                 //If single quote is removed from webFormDataInJason, you are passing the data 
                                 //as an object. The server side web method need to declare an object parameter.
                                 //data: "{'WebFormData' : " + studentDataInJson + "}",
                                 contentType: 'application/json; charset=utf-8',
                                 dataType: 'json',
                                 async: false,
                                 success: function (response) {

                                     window.location.href = window.location.href;
                                 },
                                 error: function (xhr, status, errorThrown) {
                                     $.notify('Error Message : ' + errorThrown);
                                 }
                             })


                 ;//end of $.ajax(...)
             }
         }

         $('#confirm').on('click', addNewStaff);//end of $('#saveButton').on(....


          /////////////////////////////////////////////////LOAD ALL/////////////////////////////////////////
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
                 url: 'Homepage.aspx/getAllStaff',
                 data: "{'WebFormData' : '" + webFormDataInJson + "'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json"
             });

             requestHandler.done(function (response) {

                 var staffId = '';
                 var hrList = response.d;
                 var $staffTableElement = $('#staffTable tbody');
                 var $rowElement;
                 var $cellElement;
                 var index = 0;
                 for (index = 0; index < hrList.length; index++) {
                     staffId = hrList[index].StaffId;
                     $rowElement = $('<tr></tr>');
                     $cellElement = $('<td></td>', { text: hrList[index].StaffId });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: hrList[index].StaffName });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: hrList[index].Position });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: hrList[index].Salary });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: hrList[index].Status });
                     $rowElement.append($cellElement);

                     $cellElement = $('<td></td>', { text: hrList[index].Type });
                     $rowElement.append($cellElement);

                     $hyperLinkElement = $('<a class="btnView2">View</a>');
                     $hyperLinkElement.addClass('btn btn-default');
                     $cellElement = $('<td></td>');
                     $cellElement.append($hyperLinkElement);
                     $rowElement.append($cellElement);

                     $hyperLinkElement = $('<a class="btnView" data-toggle="modal" href="#modal-2">View / Edit</a>');
                     $hyperLinkElement.addClass('btn btn-danger');
                     $cellElement = $('<td></td>');
                     $cellElement.append($hyperLinkElement);
                     $rowElement.append($cellElement);


                     $staffTableElement.append($rowElement);

                     $('.btnView').click(function () {
                         row = $(this).closest('tr').find('td:nth-child(1)').text();

                         $("#btnEdit").show();
                         $("#btnSave").hide();
                         document.getElementById("nameInput1").readOnly = true;
                         document.getElementById("tableNameInput1").readOnly = true;
                         document.getElementById("passwordInput1").readOnly = true;
                         document.getElementById("ddlType1").disabled = true;
                         document.getElementById("positionInput1").readOnly = true;
                         document.getElementById("salaryInput1").readOnly = true;
                         document.getElementById("contactInput1").readOnly = true;
                         document.getElementById("dateInput1").readOnly = true;
                         document.getElementById("addressInput1").readOnly = true;
                         document.getElementById("ddlStatus1").disabled = true;

                         collectedStaffId = row;
                         console.log("row id = " + row);
                         setupWebFormDetails(row);

                     });

                     $('.btnView2').click(function () {
                         var row2 = $(this).closest('tr').find('td:nth-child(1)').text();
                         userId = getParameterByName('ID');
                         window.location.href = "AttendanceList.aspx?ID=" + userId + "&StaffId=" + row2
                     });


                 }

             }).fail(function () {

             });
         };

         /////////////////////////////////////////////////////////// CALL LOAD ///////////////////////////////////////////////////////////
         function eventsTableElement() { loadData }
         window.onload = loadData;


          ////////////////////////////////// GET 1 STAFF  //////////////////////////////////
         function setupWebFormDetails(staffId) {
             $.ajax({
                 type: 'POST',
                 url: 'Homepage.aspx/getStaffInfo',
                 data: "{'staffId':" + staffId + "}",
                 contentType: 'application/json; charset=utf-8',
                 dataType: 'json',
             }).done(function (data, textStatus, jqXHR) {
                 console.log(data);
                 console.log(data.d);
                 var staff = data.d;

                 var name = staff.StaffName;
                 var position = staff.Position;
                 var salary = staff.Salary;
                 var contact = staff.Contact;
                 var dateofbirth = staff.Dateofbirth;
                 var address = staff.Address;
                 var type = staff.Type;
                 var tableName = staff.TableName;
                 var pw = staff.StaffPassword;
                 var status = staff.Status;
                 

                 $('#nameInput1').val(name);
                 $('#positionInput1').val(position);
                 $('#salaryInput1').val(salary);
                 $('#contactInput1').val(contact);
                 $('#dateInput1').val(dateofbirth);
                 $('#addressInput1').val(address);

                 $('#tableNameInput1').val(tableName);
                 $('#passwordInput1').val(pw);
                 $("#ddlStatus1").val(status);
                 $("#ddlType1").val(type);

                                  
             });
         }//end of setupWebFormDetails JavaScript function

          ////////////////////////////////// View/Edit //////////////////////////////////
         function WebFormData3(inName, inPosition, inType, inSalary, inContact, inDateofbirth, inAddress, inTableName, inUserId, inPassword, inStatus, inStaffId) {
             this.Name = inName;
             this.TableName = inTableName;
             this.StaffPassword = inPassword;
             this.Type = inType;
             this.Position = inPosition;
             this.Salary = inSalary;
             this.Contact = inContact;
             this.Dateofbirth = inDateofbirth;
             this.Address = inAddress;
             this.Status = inStatus;
             this.UserId = inUserId;
             this.StaffId = inStaffId;
         }


         function btnEdit_Click() {
             $("#btnSave").show();
             $("#btnEdit").hide();
             document.getElementById("nameInput1").readOnly = false;
             document.getElementById("passwordInput1").readOnly = false;
             document.getElementById("ddlType1").disabled = false;
             document.getElementById("positionInput1").readOnly = false;
             document.getElementById("salaryInput1").readOnly = false;
             document.getElementById("contactInput1").readOnly = false;
             document.getElementById("dateInput1").readOnly = false;
             document.getElementById("addressInput1").readOnly = false;
             document.getElementById("ddlStatus1").disabled = false;
         };

         function btnSave_Click() {
             var Name = $('#nameInput1').val();
             var Position = $('#positionInput1').val();
             var Salary = $('#salaryInput1').val();
             var Contact = $('#contactInput1').val();
             var Dateofbirth = $('#dateInput1').val();
             var Address = $('#addressInput1').val();

             var e = document.getElementById("ddlType1");
             var Type = e.options[e.selectedIndex].value;

             console.log("Type (add new Staff) = " + Type);

             var TableName = $('#tableNameInput1').val();
             var UserId = getParameterByName('ID');
             var StaffId = collectedStaffId;
             var Password = $('#passwordInput1').val();

             var e = document.getElementById("ddlStatus1");
             var Status = e.options[e.selectedIndex].value;

             //Initialize a Student class object, studentData
             var webFormData = new WebFormData3(Name, Position, Type, Salary, Contact, Dateofbirth, Address, TableName, UserId, Password, Status, StaffId);
             var webFormDataInJson = JSON.stringify(webFormData);
             //console.log(jsonText);
             $.ajax(
                         {
                             type: 'POST',
                             url: 'Homepage.aspx/UpdateOneStaff',
                             data: "{'WebFormData' : '" + webFormDataInJson + "'}",
                             //If single quote is removed from webFormDataInJason, you are passing the data 
                             //as an object. The server side web method need to declare an object parameter.
                             //data: "{'WebFormData' : " + studentDataInJson + "}",
                             contentType: 'application/json; charset=utf-8',
                             dataType: 'json',
                             async: false,
                             success: function (response) {
                                 $("#btnEdit").show();
                                 $("#btnSave").hide();
                                 document.getElementById("nameInput1").readOnly = true;
                                 document.getElementById("tableNameInput1").readOnly = true;
                                 document.getElementById("passwordInput1").readOnly = true;
                                 document.getElementById("ddlType1").disabled = true;
                                 document.getElementById("positionInput1").readOnly = true;
                                 document.getElementById("salaryInput1").readOnly = true;
                                 document.getElementById("contactInput1").readOnly = true;
                                 document.getElementById("dateInput1").readOnly = true;
                                 document.getElementById("addressInput1").readOnly = true;
                                 document.getElementById("ddlStatus1").disabled = true;

                                 $.notify("Successful updating of staff!", "success");
                             },
                             error: function (xhr, status, errorThrown) {
                                 $.notify('Error Message : ' + errorThrown);
                             }
                         })


             ;//end of $.ajax(...)
         }


          //////////////////////////////////////////////////////////LOAD SEARCH /////////////////////////////////////////////////////////
         function loadSearchData(SearchwebFormData) {
             $.ajax({
                 type: 'POST',
                 url: 'Homepage.aspx/searchStaff',
                 data: JSON.stringify(SearchwebFormData),
                 //"{'inWebFormData':'" + webFormDataInString + "'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json"
             }).done(function (response) {

                 $("#staffTable tr").remove();

                 var staffId = '';
                 var hrList = response.d;
                 var $staffTableElement = $('#staffTable tbody');
                 var $rowElement;
                 var $cellElement;
                 var index = 0;
                 for (index = 0; index < hrList.length; index++) {
                     staffId = hrList[index].StaffId;
                     $rowElement = $('<tr></tr>');
                     $cellElement = $('<td></td>', { text: hrList[index].StaffId });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: hrList[index].StaffName });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: hrList[index].Position });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: hrList[index].Salary });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: hrList[index].Status });
                     $rowElement.append($cellElement);

                     $cellElement = $('<td></td>', { text: hrList[index].Type });
                     $rowElement.append($cellElement);

                     $hyperLinkElement = $('<a class="btnView2">View</a>');
                     $hyperLinkElement.addClass('btn btn-default');
                     $cellElement = $('<td></td>');
                     $cellElement.append($hyperLinkElement);
                     $rowElement.append($cellElement);

                     $hyperLinkElement = $('<a class="btnView" data-toggle="modal" href="#modal-2">View / Edit</a>');
                     $hyperLinkElement.addClass('btn btn-danger');
                     $cellElement = $('<td></td>');
                     $cellElement.append($hyperLinkElement);
                     $rowElement.append($cellElement);


                     $staffTableElement.append($rowElement);

                     $('.btnView').click(function () {
                         row = $(this).closest('tr').find('td:nth-child(1)').text();

                         $("#btnEdit").show();
                         $("#btnSave").hide();
                         document.getElementById("nameInput1").readOnly = true;
                         document.getElementById("tableNameInput1").readOnly = true;
                         document.getElementById("passwordInput1").readOnly = true;
                         document.getElementById("ddlType1").disabled = true;
                         document.getElementById("positionInput1").readOnly = true;
                         document.getElementById("salaryInput1").readOnly = true;
                         document.getElementById("contactInput1").readOnly = true;
                         document.getElementById("dateInput1").readOnly = true;
                         document.getElementById("addressInput1").readOnly = true;
                         document.getElementById("ddlStatus1").disabled = true;

                         collectedStaffId = row;
                         console.log("row id = " + row);
                         setupWebFormDetails(row);

                     });

                     $('.btnView2').click(function () {
                         var row2 = $(this).closest('tr').find('td:nth-child(1)').text();
                         userId = getParameterByName('ID');
                         window.location.href = "AttendanceList.aspx?ID=" + userId + "&StaffId=" + row2
                     });


                 }

             }).fail(function () {

             });
         };

         function loadSearchNameData(SearchwebFormData) {
             $.ajax({
                 type: 'POST',
                 url: 'Homepage.aspx/searchStaffName',
                 data: JSON.stringify(SearchwebFormData),
                 //"{'inWebFormData':'" + webFormDataInString + "'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json"
             }).done(function (response) {

                 $("#staffTable tr").remove();

                 var staffId = '';
                 var hrList = response.d;
                 var $staffTableElement = $('#staffTable tbody');
                 var $rowElement;
                 var $cellElement;
                 var index = 0;
                 for (index = 0; index < hrList.length; index++) {
                     staffId = hrList[index].StaffId;
                     $rowElement = $('<tr></tr>');
                     $cellElement = $('<td></td>', { text: hrList[index].StaffId });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: hrList[index].StaffName });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: hrList[index].Position });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: hrList[index].Salary });
                     $rowElement.append($cellElement);
                     $cellElement = $('<td></td>', { text: hrList[index].Status });
                     $rowElement.append($cellElement);

                     $cellElement = $('<td></td>', { text: hrList[index].Type });
                     $rowElement.append($cellElement);

                     $hyperLinkElement = $('<a class="btnView2">View</a>');
                     $hyperLinkElement.addClass('btn btn-default');
                     $cellElement = $('<td></td>');
                     $cellElement.append($hyperLinkElement);
                     $rowElement.append($cellElement);

                     $hyperLinkElement = $('<a class="btnView" data-toggle="modal" href="#modal-2">View / Edit</a>');
                     $hyperLinkElement.addClass('btn btn-danger');
                     $cellElement = $('<td></td>');
                     $cellElement.append($hyperLinkElement);
                     $rowElement.append($cellElement);


                     $staffTableElement.append($rowElement);

                     $('.btnView').click(function () {
                         row = $(this).closest('tr').find('td:nth-child(1)').text();

                         $("#btnEdit").show();
                         $("#btnSave").hide();
                         document.getElementById("nameInput1").readOnly = true;
                         document.getElementById("tableNameInput1").readOnly = true;
                         document.getElementById("passwordInput1").readOnly = true;
                         document.getElementById("ddlType1").disabled = true;
                         document.getElementById("positionInput1").readOnly = true;
                         document.getElementById("salaryInput1").readOnly = true;
                         document.getElementById("contactInput1").readOnly = true;
                         document.getElementById("dateInput1").readOnly = true;
                         document.getElementById("addressInput1").readOnly = true;
                         document.getElementById("ddlStatus1").disabled = true;

                         collectedStaffId = row;
                         console.log("row id = " + row);
                         setupWebFormDetails(row);

                     });

                     $('.btnView2').click(function () {
                         var row2 = $(this).closest('tr').find('td:nth-child(1)').text();
                         userId = getParameterByName('ID');
                         window.location.href = "AttendanceList.aspx?ID=" + userId + "&StaffId=" + row2
                     });


                 }

             }).fail(function () {

             });
         };
         //////////////////////////////////SEARCH //////////////////////////////////
         function btnSearch_Click() {

             var staffId = document.getElementById("SearchStaff").value;
             var staffName = document.getElementById("SearchName").value;
             //var x = document.getElementById("SearchIdInput").value;
            // userId = getParameterByName('ID');

             var searchData = {
                 inStaffName: staffName, inStaffId: staffId
             };

             var searchNameData = {
                 inStaffName: staffName
             };

             //Both empty
             if (staffId == "" && staffName == "") {
                 window.location.href = window.location.href
                 //do nothing
             }

             //Search for staffName
             if (staffId == "" && staffName != "") {
                 loadSearchNameData(searchNameData);
                 console.log("loadSearchNameData ran");
                 console.log("instaffPresent: " + staffId + " instaffName: " + staffName);
             }

             //Both inputed value
             if (staffId != "" && staffName != "") {
                 loadSearchData(searchData);
                 console.log("loadSearchData1 ran");
                 console.log("instaffPresent: " + staffId + " instaffName: " + staffName);
             }

             //Search staffId
             if (staffId != "" && staffName == "") {
                 loadSearchData(searchData);
                 console.log("loadSearchData3 ran");
                 console.log("instaffPresent: " + staffId + " instaffName: " + staffName);
             }
         }

     


     

           //Get userId
        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

        //Redirect     

      /*  $('.redirectAttendanceLink').click(function () {

            userId = getParameterByName('ID');
            console.log(userId);
            window.location.href = "AttendanceList.aspx?ID=" + userId;
        });*/


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
        font-family:'Muli';
        width: 100px;
        color:  white;
     float: right;
       
        }
         
  

    </style>

    

          
    
</body>
</html>