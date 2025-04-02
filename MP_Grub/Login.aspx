<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MP_Grub.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Grub Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Akshar:wght@400;700&display=swap" rel="stylesheet" />
    <style>
        body {
            margin: 0;
            height: 100vh;
            display: flex;
            background-color: #FB8F52;
            font-family: Arial, sans-serif;
        }

        .container {
            background-color: white;
        }

        #welcomeSection {
            width: 50vw;
            height: 100vh;
            background-color: #FB8F52;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            border-bottom-right-radius: 50px;
            border-top-right-radius: 50px;
        }
        #welcomeSection h1 {
            font-size: 60px;
            font-family: 'Akshar', sans-serif;
            text-shadow: 3px 4px 0px rgba(0, 0, 0, 0.25);
            font-weight: 700;
            color: #404040;
            margin-bottom: 10px;
        }
        #welcomeSection h2 {
            font-size: 2.5rem;
            margin-top: 0;
            margin-bottom: 10px;
        }
        #welcomeSection p {
            font-size: 1rem;
        }

        #loginSection {
            width: 50vw;
            max-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 20px 40px;
            background-color: #fff;
        }
        #loginSection h2 {
            font-size: 2rem;
            margin-bottom: 15px;
        }
        .welcome-button {
            font-family: 'Akshar', sans-serif;
            font-weight: 700;
            background-color: white;
            align-items: center;
            color: #404040;
            border: none;
            padding: 12px 30px;
            border-radius: 20px;
            cursor: pointer;
            margin-top: 20px;
            font-size: 1rem;
            width: 20vw;
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
        }

        .welcome-button:hover {
            background-color: #F2F2F2;
        }

        .login-button {
            font-family: 'Akshar', sans-serif;
            font-weight: 700;
            background-color: #FB8F52;
            align-items: center;
            color: #404040;
            border: none;
            padding: 12px 30px;
            border-radius: 20px;
            cursor: pointer;
            margin-top: 20px;
            font-size: 1rem;
            width: 20vw;
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
        }

        .login-button:hover {
            background-color: #E07E48;
        }

        .input {
            width: 30vw;
            padding: 12px;
            margin: 10px 0;
            border-radius: 20px;
            border: 1px solid #ddd;
        }
    </style>
    <script>
        /*-- Transistion to CreateAccount.aspx --*/
        function animateRedirect(url) {
            document.body.style.transition = "transform 0.5s ease-in-out";
            document.body.style.transform = "translateX(100%)";
            setTimeout(() => {
                sessionStorage.setItem("slideIn", "true");
                window.location.href = url;
            }, 1000);
        }

        document.addEventListener("DOMContentLoaded", function () {
            if (sessionStorage.getItem("slideIn") === "true") {
                document.body.style.transform = "translateX(100%)";
                setTimeout(() => {
                    document.body.style.transition = "transform 0.5s ease-in-out";
                    document.body.style.transform = "translateX(0)";
                }, 50);
                sessionStorage.removeItem("slideIn");
            }
        });
    </script>
</head>
<body>
    <div class="container">
        <!-- Welcome Section -->
        <div id="welcomeSection">
            <h1>GRUB</h1>
            <h2>Hello, Welcome!</h2>
            <p>Don't have an account?</p>
            <button class="welcome-button" onclick="animateRedirect('CreateAccount.aspx')">Create Account</button>
        </div>
    </div>

    <!-- Login Section -->
    <div id="loginSection">
        <h2>Login</h2>
        <form id="form1" runat="server">
            <div>
                <asp:TextBox ID="usernametxt" runat="server" CssClass="input" placeholder="Username"></asp:TextBox>
                <asp:TextBox ID="passwordtxt" runat="server" CssClass="input" TextMode="Password" placeholder="password"></asp:TextBox>
            </div>
            <div>
                <a href="ForgotPassword.aspx">Forgot Password?</a>
            </div>
            <div>
                <asp:Button ID="loginbtn" runat="server" Text="Login" class="login-button" OnClick="LoginValidation" />
            </div>
        </form>
    </div>
</body>
</html>
