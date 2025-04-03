<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Navigation.aspx.cs" Inherits="MP_Grub.Navigation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>GRUB</title>
    <link href="https://fonts.googleapis.com/css2?family=Akshar:wght@300;400;700&display=swap" rel="stylesheet"/>  
    <style>
        .navigation-outline {
            display: flex;
            justify-content: center;
            align-items: center;
            /*background: #314558;*/
            padding: 20px;
            /*border-radius: 12px;*/
            /*box-shadow: 0px 6px 10px rgba(0, 0, 0, 0.1);*/
            max-width: 700px;
            max-height: 500px;
            width: 100%;
            text-align: center;
            z-index: 5;
        }

        .page-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 30vh;
            padding: 20px;
        }

        .button-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 30px;
        }

        .options {
            display: flex;
            width: 300px;
            height: auto;
            border-radius: 12px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }

        /*.left-button, .right-button {
            font-size: 18px;
            font-family: 'Akshar', sans-serif;
            font-weight: bold;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .left-button {
            background-color: #E74C3C;
            color: white;
        }

        .left-button:hover {
            background-color: #C0392B;
        }

        .right-button {
            background-color: #27AE60;
            color: white;
        }

        .right-button:hover {
            background-color: #1E8449;
        }*/
        .profile-background {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            object-fit: cover;
        }
        .swipe-ducks {
            display: flex;
            width: 15vw;
            height: auto;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="page-container">
        <div class="navigation-outline">
            <div class="button-container">
                <%--<asp:Button ID="btnLeft" runat="server" Text="Swipe Left" CssClass="left-button" OnClick="btnLeft_Click" />--%>
                <asp:ImageButton ID="NoDuck" runat="server" CssClass="swipe-ducks" ImageUrl="~/images/No_Duck.png" OnClick="btnLeft_Click" />
                <div class="image-container">
                    <asp:Image ID="carouselImage" runat="server" ImageUrl="~/Navigation_Images/1.png" CssClass="options" />
                </div>
                <%--<asp:Button ID="btnRight" runat="server" Text="Swipe Right" CssClass="right-button" OnClick="btnRight_Click" />--%>
                <asp:ImageButton ID="YesDuck" runat="server" CssClass="swipe-ducks" ImageUrl="~/images/Yes_Duck.png" OnClick="btnRight_Click" />
            </div>
        </div>
    </div>
    <%-- error message --%>
    <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>

    <div>
        <asp:Image ID="bgimage" runat="server" CssClass="profile-background" ImageUrl="~/images/Navigation_bg4.png" />
    </div>
</asp:Content>