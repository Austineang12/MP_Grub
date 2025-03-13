<%@ Page Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="MP_Grub.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Home</title>
    <link href="https://fonts.googleapis.com/css2?family=Akshar:wght@300;400;700&display=swap" rel="stylesheet"/> 
    <style>
        body {
            margin: 0;
            font-family: 'Akshar', sans-serif;
            background-color: #f4f4f4;
            height: 100vh;
        }

        .Navigation_Section {
            position: absolute;
            top: 100px; /* Adjust this value to move it vertically */
            right: 50px; /* Adjust this value to move it horizontally */
            background: white;
            padding: 10px;
            border-radius: 12px;
            box-shadow: 0px 6px 10px rgba(0, 0, 0, 0.1);
            max-width: 300px;
            text-align: center;
        }

        .Navigation_text {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }

        .duck-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
        }

        .btnNavigation {
            width: 90px; /* Smaller duck */
            height: auto;
            cursor: pointer;
        }

        .clickMe {
            font-size: 18px;
            font-weight: bold;
            color: black;
        }
    </style>

    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="Navigation_Section">
        <h1 class="Navigation_text">HINDI KA MAKAPILI?</h1>
        <div class="duck-container">
            <asp:ImageButton ID="Navigation" runat="server" CssClass="btnNavigation" ImageUrl="~/images/CryingDuck.png" OnClick="Navigation_Click" />
            <span class="clickMe">CLICK ME!</span>
        </div>
    </div>
</asp:Content>