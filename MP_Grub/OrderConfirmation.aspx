<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="OrderConfirmation.aspx.cs" Inherits="MP_Grub.OrderConfirmation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta content="" charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GRUB Delivery</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
        }
        .container {
            background-color: #f7a76c;
            border-radius: 20px;
            padding: 20px;
            width: 320px;
            margin: 50px auto;
            margin-top: 1%;
            box-shadow: 6px 6px 12px rgba(0, 0, 0, 0.2);
            text-align: center;
        }


        .logo-container img {
            width: 120px;
            margin-bottom: 10px;
        }
        .image-container img {
            width: 180px;
            display: block;
            margin: 0 auto;
        }
        p {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin: 10px 0;
        }
        .stars span {
            font-size: 35px;
            cursor: pointer;
            color: white;
            transition: color 0.3s;
        }
        .stars span.active {
            color: gold;
        }
        .button {
            background-color: #e55b33;
            border: none;
            color: white;
            padding: 12px;
            margin: 10px;
            width: 85%;
            border-radius: 15px;
            font-size: 16px;
            cursor: pointer;
            font-weight: bold;
            box-shadow: 2px 4px 6px rgba(0, 0, 0, 0.2);
        }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
        <div class="container">
            <div class="logo-container">
                <img src="Images/GrubName.png" alt="GRUB Logo">
            </div>
            <div class="image-container">
               <img src="Images/Duck.png" alt="Delivery Duck">
            </div>
            <p>Your order has been delivered!</p>
            <p>How was your order?</p>
            <div class="stars" id="starRating">
                <span onclick="rate(1)">&#9733;</span>
                <span onclick="rate(2)">&#9733;</span>
                <span onclick="rate(3)">&#9733;</span>
                <span onclick="rate(4)">&#9733;</span>
                <span onclick="rate(5)">&#9733;</span>
            </div>
            <asp:Button ID="btnOrderDetails" runat="server" Text="Go Back to Order Details" CssClass="button" OnClick="btnOrderDetails_Click" />
            <asp:Button ID="btnDone" runat="server" Text="Done" CssClass="button" OnClientClick="return redirectToThankYou();" />
        </div>
   <script type="text/javascript">
       function rate(stars) {
           var starElements = document.querySelectorAll(".stars span");
           starElements.forEach((star, index) => {
               if (index < stars) {
                   star.classList.add("active");
               } else {
                   star.classList.remove("active");
               }
           });
       }

       function redirectToThankYou() {
           var selectedStars = document.querySelectorAll(".stars span.active").length;

           if (selectedStars === 0) {
               alert("Please select a rating before continuing.");
               return false;
           } else {
               window.location.href = "ThankYou.aspx"; 
               return false;
           }
       }
   </script>


</asp:Content>
