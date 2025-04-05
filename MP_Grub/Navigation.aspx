<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Navigation.aspx.cs" Inherits="MP_Grub.Navigation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>GRUB</title>
    <link href="https://fonts.googleapis.com/css2?family=Akshar:wght@300;400;700&display=swap" rel="stylesheet"/>  
    <style>
        .navigation-outline {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
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
            transition: 0.3s ease-in-out, color 0.3s ease-in-out; 
        }

        .swipe-ducks {
            display: flex;
            width: 200px;
            height: auto;
            transition: 0.3s ease-in-out, color 0.3s ease-in-out; 
        }

        .background-duck {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            background-image: url('/images/Navigation_bg4.png'); /* Default desktop background */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            transition: background-image 0.3s ease-in-out;
        }

        /*-- Responsive Design --*/
        @media (max-width: 1000px) {
            .background-duck {
                position: fixed;
                height: 100%;
                background-image: url('/images/Order_Moblebg1.png') !important;
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
            }
            .options {
                width: 200px;
            }
            .swipe-ducks {
                width: 150px;
            }
            .button-container {
                gap: 5px;
            }
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

    <%-- Background Image --%>
    <div class="background-duck"></div>
</asp:Content>