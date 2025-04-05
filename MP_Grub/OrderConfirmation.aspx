<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="OrderConfirmation.aspx.cs" Inherits="MP_Grub.OrderConfirmation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta content="" charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation</title>
    <style type="text/css">
        body {
            font-family: 'Akshar', sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
        }
        .container {
            background-color: #FB8F52;
            border-radius: 20px;
            padding: 20px;
            width: 320px;
            margin: 10px auto;
            margin-top: 1%;
            box-shadow: 6px 6px 12px rgba(0, 0, 0, 0.2);
            text-align: center;
            z-index: 5;
        }

        .brand-container {
            font-size: 25px;
            font-family: 'Akshar', sans-serif;
            text-shadow: 3px 4px 0px rgba(0, 0, 0, 0.25);
            font-weight: 700;
            color: #404040;
        }

        .image-container img {
            width: 180px;
            display: block;
            margin: 0 auto;
        }
        p {
            font-size: 18px;
            font-weight: bold;
            color: #404040;
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

        .button-container {
            display: flex;
            flex-wrap: wrap;
            flex-direction: column;
            gap: 10px;
            justify-content: center;
        }

        .button {
            font-family: 'Akshar', sans-serif;
            font-weight: 700;
            background-color: white;
            align-items: center;
            color: #404040;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            margin-top: 10px;
            font-size: 1rem;
            display: block;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
        }

        .button:hover {
            background-color: #F2F2F2;
        }

        .background-duck {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            background-image: url('/images/Feedback_Duckbg1.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            transition: background-image 0.3s ease-in-out;
        }

        @media (max-width: 1000px) {
            .background-duck {
                position: fixed;
                height: 100%;
                background-image: url('/images/Feedback_Mobilebg1.png') !important;
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
            }
        }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
        <div class="container">
            <div class="brand-container">
                <h1>GRUB</h1>
            </div>
            <div class="image-container">
               <img src="Images/Duck.png" alt="Delivery Duck">
            </div>

            <p>Your order has been delivered!</p>
            <p>How was your order?</p>

            <%-- Star Rating --%>
            <div class="stars" id="starRating">
                <span onclick="rate(1)">&#9733;</span>
                <span onclick="rate(2)">&#9733;</span>
                <span onclick="rate(3)">&#9733;</span>
                <span onclick="rate(4)">&#9733;</span>
                <span onclick="rate(5)">&#9733;</span>
            </div>

            <%-- Buttons --%>
            <div class="button-container">
                <asp:Button ID="btnOrderDetails" runat="server" Text="Skip" CssClass="button" OnClick="btnOrderDetails_Click" />
                <asp:Button ID="btnDone" runat="server" Text="Submit" CssClass="button" OnClientClick="return redirectToThankYou();" />
            </div>
        </div>

    <%-- Background Image --%>
    <div class="background-duck"></div>

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