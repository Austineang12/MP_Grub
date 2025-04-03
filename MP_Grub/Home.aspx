 <%@ Page Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="MP_Grub.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Home</title>
    <link href="https://fonts.googleapis.com/css2?family=Akshar:wght@300;400;700&display=swap" rel="stylesheet"/> 
    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
            font-family: 'Akshar', sans-serif;
            background-color: #f4f4f4;
            height: 100vh;
        }

        .Navigation_Section {
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
            transform: translateY(-10px);
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
            object-fit: cover;
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
            width: 15vw;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="welcome-container">
        <asp:Label ID="welcomeLabel" runat="server" CssClass="welcome-text"></asp:Label>
    </div>

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
    <div>
        <asp:Image ID="bgimage" runat="server" CssClass="background-duck" ImageUrl="~/images/Home_Duckbg.png" />
    </div>
</asp:Content>