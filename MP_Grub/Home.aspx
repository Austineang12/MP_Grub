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
            z-index: 5;
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
            width: 90px; /* Smaller duck */
            height: auto;
            cursor: pointer;
        }

        .clickMe {
            font-size: 18px;
            font-weight: bold;
            color: black;
        }

        .background-duck {
            position: absolute; /* Ensure the background stays in place */
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            object-fit: cover; /* Ensures the image covers the entire area */
            z-index: 1; /* Puts it behind other content */
        }


    </style>

    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="Navigation_Section">
        <h1 class="Navigation_text">HINDI KA MAKAPILI?</h1>
        <div class="duck-container">
            <asp:ImageButton ID="Navigation" runat="server" CssClass="btnNavigation" ImageUrl="~/images/CryingDuck.png" OnClick="Navigation_Click" />
            <spa
                n class="clickMe">CLICK ME!</spa>
        </div>
    </div>
    <div>
        <asp:Image ID="bgimage" runat="server" CssClass="background-duck" ImageUrl="~/images/bg_Duck.png" />
    </div>
</asp:Content>