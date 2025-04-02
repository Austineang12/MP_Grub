<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Loading.aspx.cs" Inherits="MP_Grub.Loading" %>

<!DOCTYPE html>
<html>
<head>
    <title>Loading...</title>
    <style>
        body {
            margin: 0;
            overflow: hidden;
            background-color: #FB8F52;
        }
        .fade-container {
            width: 100vw;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            opacity: 1;
            transition: opacity 1s ease-in-out;
        }
        .duck {
            position: absolute;
            width: 150px;
            height: auto;
            animation: walk 3s ease-out forwards, jump 0.5s infinite ease-in-out;
        }
        @keyframes walk {
            from {
                left: 100vw;
            }
            to {
                left: calc(50vw - 75px);
            }
        }
        @keyframes jump {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-20px);
            }
        }
    </style>
</head>
<body>
    <div class="fade-container" id="fadeContainer">
        <asp:Image ID="logoDuck" runat="server" CssClass="duck" ImageUrl="~/images/Duck.png" />
    </div>

    <script>
        const duck = document.querySelector('.duck');
        const fadeContainer = document.getElementById('fadeContainer');

        setTimeout(function () {
            duck.style.animation = 'none';
        }, 3000);

        setTimeout(function () {
            fadeContainer.style.opacity = '0';
            setTimeout(function () {
                window.location.href = 'Login.aspx';
            }, 1000);
        }, 3500);
    </script>
</body>
</html>