<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Logout.aspx.cs" Inherits="FYP_MarkIn.Participants.Logout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>

        <script>
            $(document).ready(function () {
                alert("You have logged out.");
                window.location.replace("../Login/Login.aspx");
            });
                
                        
        </script>
    </form>
</body>
</html>
