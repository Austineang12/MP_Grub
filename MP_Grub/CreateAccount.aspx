<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateAccount.aspx.cs" Inherits="MP_Grub.CreateAccount" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Create Account</title>
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

        .signup-box {
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
        .signup-box h2 {
            margin-bottom: 20px;
            font-size: 1.8rem;
        }
        .input-field {
            width: 30vw;
            padding: 12px;
            margin: 10px 0;
            border-radius: 20px;
            border: 1px solid #ddd;
        }
        .create-button {
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

        .create-button:hover {
            background-color: #E07E48;
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }
        .alternate-section {
            width: 50vw;
            height: 100vh;
            background-color: #FB8F52;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            border-bottom-left-radius: 50px;
            border-top-left-radius: 50px;
        }
        .alternate-section h2 {
            font-size: 2.5rem;
            margin-top: 0;
            margin-bottom: 10px;
        }
        .alternate-button {
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

        .alternate-button:hover {
            background-color: #F2F2F2;
        }
    </style>
    <script>
        /*-- Transistion to Login.aspx --*/
        function animateRedirect(url) {
            document.body.style.transition = "transform 0.5s ease-in-out";
            document.body.style.transform = "translateX(-100%)";
            setTimeout(() => {
                sessionStorage.setItem("slideIn", "true");
                window.location.href = url;
            }, 1000);
        }

        document.addEventListener("DOMContentLoaded", function () {
            if (sessionStorage.getItem("slideIn") === "true") {
                document.body.style.transform = "translateX(-100%)";
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
    <%-- Create Account section --%>
    <div class="signup-box">
        <form id="form1" runat="server">
            <h2>Create Account</h2>
            <div>
                <asp:TextBox ID="usernametxt" runat="server" CssClass="input-field" placeholder="Username"></asp:TextBox>
                <asp:Label ID="lblUsernameError" runat="server" CssClass="error-message" Visible="false"></asp:Label>
            </div>
            <div>
                <asp:TextBox ID="fullnametxt" runat="server" CssClass="input-field" placeholder="Full Name"></asp:TextBox>
            </div>
            <div>
                <asp:TextBox ID="passwordtxt" runat="server" CssClass="input-field" TextMode="Password" placeholder="Password"></asp:TextBox>
            </div>
            <div>
                <asp:Button ID="signupbtn" runat="server" Text="Sign Up" CssClass="create-button" OnClick="SignupValidation"/>
            </div>
        </form>
    </div>

    <div class="container">
        <%-- Alternate section --%>
        <div class="alternate-section">
            <h2>Welcome Back!</h2>
            <p>Already have an account?</p>
            <button class="alternate-button" onclick="animateRedirect('Login.aspx')">Login</button>
        </div>
    </div>
</body>
</html>