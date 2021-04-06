<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Mark_In_Admin.Login.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link rel="icon" href="../favicon.ico"/>

    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <link href="../ParticipantCSS/LoginCSS.css" rel="stylesheet" />
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />

    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/notify.min.js"></script>

</head>
<body>
    <form id="LoginForm" runat="server">


    <div class="container">
    <div class="row">    
        
        <div class="col-lg-3"></div>
        <div class="col-lg-6">

            <div class="logoimg">
                <img src="../Images/NEWWWAppIcon.png" class ="logo"  width="350" height="350"/>
            </div>

            <div class="MarkInTitle">            
                <label class ="markinlbl">Mark In</label>
            </div>

            <div class="userinput">
                <div class="centralize">

                    <label class="IDinput">User Id:</label>     
                    <input type="text" class="form-control" id="IdInput" name="IdInput" placeholder="Enter User ID"/>
                </div>
            </div>

            <div class="btnCentralize">
                <input type="button" id="btnVerify" value="Verify" class="btn btn-primary" /> <!--Verify Button-->
            </div>

            <div class="noaccountdiv">
                <label class="noaccountlbl">Don't have an account? Sign up <a href="../Registration/Registration.aspx" style="color:blue" class="clickherelbl">here</a></label>
            </div>

        </div> <!-- End of div lg 6-->
        <div class="col-lg-3"></div>
        
    </div> <!-- End of div row -->

    </div> <!-- End of div container-->



 <script>

    

    function WebFormData(inUserId) {
        this.UserId = inUserId;
        //this.Password = inPassword;
    }

    function collectUserData() {
        //Collect data from the respective form elements.
        var userId = $('#IdInput').val();
    
        //Create a WebFormData class object, webformData
        var webFormData = new WebFormData(userId);
        var webFormDataInJson = JSON.stringify(webFormData);
  
        var jqXHR = $.ajax(
					{
						type: 'POST',
						url: 'Login.aspx/CheckUserData',
						data: "{'WebFormData' : '" + webFormDataInJson + "'}",
						contentType: 'application/json; charset=utf-8',
						dataType: 'json'
					});

      jqXHR.done(function (data, textStatus, jqXHR) {
          var responseObject = data.d;
       
                if (responseObject.status == 'HR') {
                    window.location.replace("LoginHR.aspx?ID=" + userId);
                }
               
                if (responseObject.status == 'STAFF') {
                    window.location.replace("LoginStaff.aspx?ID=" + userId);
                }

                if (responseObject.status == 'PARTICIPANT') {
                    window.location.replace("LoginParticipant.aspx?ID=" + userId);
                }

                if (responseObject.status == 'ERROR') {
                    $.notify(responseObject.message);
                   
                    console.log('ajax().done() section was executed with error');
                }

                console.log('ajax().done() section was executed');
      })

      jqXHR.error(function (jqXHR, textStatus, errorThrown) {
          $.notify('Error Message : ' + errorThrown);
        })//end of $.ajax(...)
    }//end of collectProductDataAndSave function
    

    $(document).ready(function () {
        $('#btnVerify').on('click', function (event) {
            collectUserData();//The collectUserData() function has the logic to make an Ajax call to send the web form data to the server.  
        });//end of btnVerify
    });

</script>
        </form>
</body>
</html>

