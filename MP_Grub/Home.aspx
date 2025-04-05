<%@ Page Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="MP_Grub.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Home</title>
    <link href="https://fonts.googleapis.com/css2?family=Akshar:wght@300;400;700&display=swap" rel="stylesheet"/> 
    <style type="text/css">
        /*html, body {
            height: 100%;
            margin: 0;
        }*/

        body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .Navigation_Section {
            font-family: 'Akshar', sans-serif;
            position: absolute;
            top: 100px;
            right: 50px;
            background: white;
            padding: 10px;
            border-radius: 12px;
            box-shadow: 0px 6px 10px rgba(0, 0, 0, 0.1);
            max-width: 300px;
            text-align: center;
            z-index: 5;
            transition: transform 0.3s ease-in-out;
        }

        .Navigation_Section:hover {
            background-color: #F2F2F2; 
        }

        .Navigation_text {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
            color: black;
        }

        .duck-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
        }

        .btnNavigation {
            width: 90px;
            height: auto;
            cursor: pointer;
        }

        .clickMe {
            font-size: 18px;
            font-weight: bold;
            color: black;
        }

        .background-duck {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            background-image: url('/images/Home_Duckbg.png'); /* Default desktop background */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            transition: background-image 0.3s ease-in-out;
        }

        .order-button {
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
            /*width: 20vw;*/
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
        }

        .order-button:hover {
            background-color: #E07E48;
        }

        .button-container {
            position: absolute;
            left: 110px;
            top: 60%;
            z-index: 5;
        }

        /*-- Responsive Design --*/
        @media (max-width: 1000px) {
            .background-duck {
                position: absolute;
                width: 100%;
                height: 100vh;
                background-image: url('/images/Home_Mobilebg2.png') !important;
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
            }   

            .Navigation_Section {
                right: auto;
                left: 50%;
                transform: translateX(-50%);
                width: 70%;
            }

            .button-container {
                bottom: 5vh;
            }

            .order-button {
                margin-top: 100px;
                width: 50vw;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="container">
        <div class="Navigation_Section">
            <h1 class="Navigation_text">HINDI KA MAKAPILI?</h1>
            <div class="duck-container">
                <asp:ImageButton ID="Navigation" runat="server" CssClass="btnNavigation" ImageUrl="~/images/CryingDuck.png" OnClick="Navigation_Click" />
                <span class="clickMe">CLICK ME!</span>
            </div>
        </div>
        <div class="button-container">
            <asp:Button ID="btnOrder" runat="server" Text="Order Now" CssClass="order-button" OnClick="Button_OrderNow" />
        </div>

        <div class="background-duck"></div>
    </div>
</asp:Content>