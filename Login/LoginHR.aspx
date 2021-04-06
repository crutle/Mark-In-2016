<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginHR.aspx.cs" Inherits="Mark_In_Admin.Login.LoginHR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Verify HR</title>

    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../ParticipantCSS/VerifyHR.css" rel="stylesheet" />

    <script src="../Scripts/bootstrap.min.js"></script>

</head>
<body>
    <form id="LoginHRForm" runat="server">
    <div class="container">
    
        <div class="logoimg">
            <img src="../Images/NEWWWAppIcon.png" class ="logo"  width="300" height="300"/>
        </div>

        <div class="MarkInTitle">            
            <label class ="markinlbl">Mark In</label>
        </div>

        <div class="userinfo">

            <div>
                  <label id="typelbl" class="userinfoheader">Type: </label>
                  <asp:label id="typeoutputlbl" class="userinfooutput" runat="server" />
                  
                  <label id="useridlbl" class="userinfoheader">User ID: </label>
                  <asp:label id="useridoutputlbl" class="userinfooutput" runat="server" />
                 
                  <label id="namelbl" class="userinfoheader">Name: </label>
                  <asp:label id="nameoutputlbl" class="userinfooutput" runat="server" />
  
            </div>

        </div>
                
        <label class="passwordlbl">Enter Password</label> 
        <div class="centralize">
           <asp:textbox runat="server" type="password" class="form-control" id="IdInput" name="IdInput" placeholder="Password"/>
        </div>

        <div class="btnCentralize">
            <a href="Login.aspx" id="btnBack" style="width: 90px" class="btn btn-default">Back</a>
                 <asp:Button ID="btnLogin" CssClass="btn btn-primary" style="width: 90px" Text="Login" OnClick="btnLogin_Click" runat="server" />
        </div>

        <div class="noaccountdiv">

            <label class="forgotpasswordlbl"><span style ="color:blue">Forgot Password?</span></label>
          

        </div>

    </div> <!-- End of div container-->

    </form>
</body>
</html>
