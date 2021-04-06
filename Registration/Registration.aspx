<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="Mark_In_Admin.Registration.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../ParticipantCSS/Registration.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script src="../Scripts/notify.min.js"></script>

    <title>Registration</title>
</head>
<body>
    <div class="container">

    <div class="page-header1">
        <h3 style="color:darkred;">
             <img src="../Images/NEWWWAppIcon.png" height="35" width="35"/>  MARK IN         
        </h3>  
    </div>

    <form id="registrationForm" runat="server">
    <div class ="panel-body">
        <div class="centralize">

            <h2>Registration</h2>

            <div class="inputform">
                <div class="inputdivs">
                    <label class="registrationheaders">Name:     </label>
                    <input type="text" runat="server" id="name" class="form-control inputpadding"/>
                </div>

                <div class="inputdivs">
                    <label class="registrationheaders">Password:     </label>
                    <input type="password" runat="server" id="Pw" class="form-control inputpadding"/>
                </div>
                <div class="inputdivs">
                    <label class="registrationheaders">Re-enter Password:     </label>
                    <input type="password" runat="server" id="confirmPw" class="form-control inputpadding"/>
                </div>
            
                <div class="inputdivs">
                    <label class="registrationheaders">Contact No:     </label>
                    <input type="text" runat="server" id="contact" class="form-control inputpadding"/>
                </div>
                <div class="inputdivs">
                    <label class="registrationheaders">Company:     </label>
                    <input type="text" runat="server" id="company" class="form-control inputpadding"/>
                </div>
                <div class="inputdivs">
                    <label class="registrationheaders">Position:    </label>
                    <input type="text" runat="server" id="position" class="form-control inputpadding"/>
                </div>
                <div class="inputdivs">
                    <label class="registrationheaders">Email:     </label>
                    <input type="text" runat="server" id="email" class="form-control inputpadding"/>
                </div>
                <div class="inputdivs">
                    <label class="registrationheaders">Re-enter Email:     </label>
                    <input type="text" runat="server" id="confirmEmail" class="form-control inputpadding"/>
                </div>
                </div>

            <label class="infolbl">Your password will be emailed to you upon registration.</label>
            
            <div class="button"><input type="button" id="btnRegister" value="Register" style="width:200px" class="btn btn-primary"/></div> 
 

            <label class="haveaccountlbl">Have an account? Sign in <a href="../Login/Login.aspx" class="herespan">here</a>.</label>
            
            <div id="display"><img id="displayQr" runat="server" name="displayQr" /></div>

        </div> <!--End of centralize-->
        </div> <!--End of panel-body-->
    
    </form>
    </div>
    <div>
    
    </div>
    <script>

        function WebFormData(inName, inPassword, inContact, inCompanyName, inPosition, inEmail) {
            this.Name = inName;
            this.Password = inPassword;
            this.Contact = inContact;
            this.CompanyName= inCompanyName;
            this.Position = inPosition;
            this.Email = inEmail;
        }


        ////////////////////////////////////////////////////////// ADD //////////////////////////////////////////////////////////
        function addNewParticipant() {
            //Collect data from the respective form elements
            var Name = $('#name').val();
            var Password = $('#Pw').val();
            var cPassword = $('#confirmPw').val();
            var Contact = $('#contact').val();
            var CompanyName = $('#company').val();
            var Position = $('#position').val();
            var Email = $('#email').val();
            var cEmail = $('#confirmEmail').val();

            if (Name == "" || Password == "" || cPassword == "" || Contact == "" || CompanyName == "" || Position == "" || Email == "" || cEmail == "") {
                $.notify("Please fill in all the fields");
            } else {
                if (Password != cPassword) {
                    $.notify("Passwords do not match");
                }
                else if (Email != cEmail) {
                    $.notify("Emails do not match");
                }
               
                else {
                    //Initialize a Event class object, eventData
                    var webFormData = new WebFormData(Name, Password, Contact, CompanyName, Position, Email);
                    var webFormDataInJson = JSON.stringify(webFormData);
                    //console.log(jsonText);
                    $.ajax(
                                {
                                    type: 'POST',
                                    url: 'Registration.aspx/AddOnePart',
                                    data: "{'WebFormData' : '" + webFormDataInJson + "'}",
                                    contentType: 'application/json; charset=utf-8',
                                    dataType: 'json',
                                    async: false,
                                    success: function (response) {
                                        $.notify("Successful registration!", "success");

                                    },
                                    error: function (xhr, status, errorThrown) {
                                        $.notify('Error Message : ' + errorThrown);
                                    }
                                })
                    ;//end of $.ajax(...)
                }
            }

        }

        $('#btnRegister').on('click', addNewParticipant);//end of $('#saveButton').on(....
    </script>
</body>
</html>
