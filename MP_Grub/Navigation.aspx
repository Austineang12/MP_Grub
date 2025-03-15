<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Navigation.aspx.cs" Inherits="MP_Grub.Navigation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>GRUB</title>
    <link href="https://fonts.googleapis.com/css2?family=Akshar:wght@300;400;700&display=swap" rel="stylesheet"/>  
    <style>
        .navigation-outline {
            display: flex;
            justify-content: center;
            align-items: center;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0px 6px 10px rgba(0, 0, 0, 0.1);
            max-width: 700px;
            max-height: 500px;
            width: 100%;
            text-align: center;
        }

        .page-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 20px;
        }

        .button-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 30px;
        }

        .options {
            width: 200px;
            height: auto;
        }

        .left-button, .right-button {
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
        }

    </style>

    <script>
        let currentIndex = 0;
        const images = [
            'images/SOC_Coffee.png',
            'images/Saucy_Pasta.png',
            'images/Izakaya Dohjima_Maki.png',
            'images/Jamaican_Beef.png',
            'images/Pinkscoop_Scrumble.png'
        ];

        function showImage(index) {
            const imgElement = document.getElementById('carouselImage');
            if (index >= 0 && index < images.length) {
                imgElement.src = images[index];
                currentIndex = index;
            }
        }

        function swipeLeft() {
            if (currentIndex < images.length - 1) {
                showImage(currentIndex + 1);
            }
        }

        function swipeRight() {
            window.location.href = 'Payment.aspx';
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="page-container">
        <div class="navigation-outline">
            <div class="button-container">
                <asp:Button ID="btnLeft" runat="server" Text="Swipe Left" CssClass="left-button" OnClientClick="swipeLeft(); return false;" />
                <div class="image-container">
                    <img id="carouselImage" src="images/SOC_Coffee.png" alt="Carousel Image" class="options active" />
                </div>
                <asp:Button ID="btnRight" runat="server" Text="Swipe Right" CssClass="right-button" OnClientClick="swipeRight(); return false;" />
            </div>
        </div>
    </div>
</asp:Content>

