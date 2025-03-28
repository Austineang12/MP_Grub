<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateAccount.aspx.cs" Inherits="MP_Grub.CreateAccount" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Grub - Create an Account</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f5f5f5;
        }
        .signup-box {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 300px;
        }
        .input-field {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            background-color: #FB8F52;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .error-message {
            color: red;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <form runat="server">
        <div class="signup-box">
            <h2>Create Account</h2>

            <label for="usernametxt">Username</label>
            <asp:TextBox ID="usernametxt" runat="server" CssClass="input-field"></asp:TextBox>
            <asp:Label ID="lblUsernameError" runat="server" CssClass="error-message" Visible="false"></asp:Label>

            <label for="fullnametxt">Full Name</label>
            <asp:TextBox ID="fullnametxt" runat="server" CssClass="input-field"></asp:TextBox>

            <label for="passwordtxt">Password</label>
            <asp:TextBox ID="passwordtxt" runat="server" CssClass="input-field" TextMode="Password"></asp:TextBox>

            <asp:Button ID="signupbtn" runat="server" Text="Sign Up" CssClass="btn" OnClick="SignupValidation"/>

            <p>Already have an account? <a href="Login.aspx">Login</a></p>
        </div>
    </form>
</body>
</html>

