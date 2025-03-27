<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MP_Grub.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Grub Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Akshar:wght@400;700&display=swap" rel="stylesheet">
    <style type="text/css">
        /*Defining Customized Fonts*/
        @font-face{
            font-family: 'HeadingNow-Bold';
            src: url('/font/HeadingNow-66Bold.otf') format('opentype');
            font-weight: normal;
            font-style: normal;
        }

        @font-face{
            font-family: 'HeadingNow-Regular';
            src: url('/font/HeadingNow-64Regular.otf') format('opentype');
            font-weight: normal;
            font-style: normal;
        }
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f5f5f5;
            color: #FFFFFF;
            margin: 0;
            padding: 0;

            /*Gradiant Background*/
          background: linear-gradient(45deg, #E0F7FA, #FFFFFF, #B3E5FC, #E1F5FE);
          background-size: 400% 400%;
          animation: gradientAnimation 5s infinite alternate;
        }

        /* Keyframes for smooth gradient movement */
        @keyframes gradientAnimation {
          0% {
            background-position: 0% 50%;
          }
          100% {
            background-position: 100% 50%;
          }
        }
        #loginContainer {
            display: flex;
            border-radius: 20px;
            width: 90%; /* Adjusts with browser size */
            max-width: 1200px; 
            aspect-ratio: 1073 / 646; 
            margin: auto;
            border: 1px solid #ccc;
        }
        .loginSides{ /*login-box & pictureSide*/
            flex: 1;
            display:flex;
            justify-content: center;
            align-items:center;
            padding:0;
        }
        #pictureside {
            width: 100%;
            height: 100%;
            flex: 0 1 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            object-fit: cover;
            border-radius: 20px;
        }
        #loginbox {
            display: flex;
            flex-direction: column;
            flex: 1; /* Fill remaining space */
            background: #FB4E45;
            padding: 8%;
            border-radius: 0 20px 20px 0;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: left;
            font-family: HeadingNow-Bold, sans-serif;
        }
        label{
            font-size: 70px;
            display: block;
            margin: 0;
            margin-bottom: 40px;
            padding: 0;
            line-height: 1;
        }
        
        #grub{
            font-family: 'Akshar', sans-serif;
            font-size:24px;
            font-weight:bold;
            margin:0;
        }
        /*Input Fields*/
        .form-group {
            position: relative;
            width: 30vw;
            display: flex;
            align-items: flex-start;
            margin: 10px 0 0 0; 
            caret-color: #FFFFFF; /* Ensures the cursor is visible in white */
        }
        .form-group .toggle-password {
            color: #FFFFFF;
        }
        .form-input {
            outline: none;
            background-color: transparent;
            border: 2px solid #FFFFFF;
            border-radius: 20px;
            padding: 25px 16px 8px 16px;
            width: calc(100% - 32px);
            height: 15%;
            color: #FFFFFF;
            font-size: 16px;
        }
        .form-label {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            left: 16px;
            pointer-events: none;
            transition: all .2s ease-in-out;
            font-size: 16px;
            color: #FFFFFF;
        }
        .form-input:focus + .form-label,
        .form-input:not(:placeholder-shown) + .form-label {
            top: 30%;
            font-size: 12px;
            background-color: transparent; 
            color: #FFFFFF;
            border-color: #FFFFFF;
        }

        /*Submit Button*/
        .btn {
            font-family: 'HeadingNow-Bold', sans-serif;
            font-size: 20px;
            width: 100%;
            height:15%;
            padding: 10px;
            margin-top: 20px;
            background-color: #FB8F52;
            color: #FB4E45;
            background: #FFFFFF;
            border: 3px solid #ffffff;
            border-radius: 20px;
            cursor: pointer;
        }

        /*Small Labels*/
        .small-link{
            font-size: 12px;
            text-align: right;
        }
        p a {
            font-family: inherit;
            font-size: inherit;
            color: inherit;
            text-decoration: none; 
        }

        /*For Responsive Design*/
        @media (max-width: 768px) {
            #loginContainer {
                flex-direction: column;
                width: 95%;
                aspect-ratio: unset; 
            }
            #pictureside {
                width: 100%;
                height: 300px;
            }
            #loginbox {
                width: 100%;
            }
        }

        @media (min-width: 1200px) {
            #loginContainer {
                width: 80%;
                aspect-ratio: 1073 / 646;
            }
        }
    </style>
</head>
<body>
    <div id="loginContainer">
        <div class="loginSides" id="pictureside">
            <%-- Picture here --%>
            <img src="images/SampleOnly.gif" alt="Grub's Photo Advertisement"/>
        </div>
        <div id="loginbox" class="loginSides">
            <form id="form1" runat="server">
                <%-- Grub Logo Name --%>
                <label id="grub">GRUB</label>
                <%-- Login Name --%>
                <label>LOGIN</label>

                <%-- Username --%>
                <div class="form-group">
                    <asp:TextBox class="form-input" placeholder=" " type="text" id="usernametxt" runat="server" CausesValidation="True"></asp:TextBox>
                    <asp:Label for="usernametxt" class="form-label" runat="server">USERNAME</asp:Label>
                </div>

                <%-- Password --%>
                <div class="form-group">
                    <asp:TextBox class="form-input" placeholder=" " type="password" id="passwordtxt" runat="server" CausesValidation="True"></asp:TextBox>
                    <asp:Label for="passwordtxt" class="form-label" runat="server">PASSWORD</asp:Label>
                </div>
                <p class="small-link"><a href="CreateAccount.aspx">FORGOT PASSWORD?</a></p> 
                <%-- add aspx for the forgot password like providing the birthday from create account --%>

                <%-- Submit Button --%>
                <asp:Button ID="loginbtn" runat="server" Text="SIGN IN" CssClass="btn" OnClick="LoginValidation"/>

                <p class="small-link">NEW HERE? <a href="CreateAccount.aspx">CREATE AN ACCOUNT</a></p>
            </form>
        </div>
    </div>
</body>
</html>
