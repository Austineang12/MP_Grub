<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="BookmarkedItems.aspx.cs" Inherits="MP_Grub.BookmarkedItems" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Bookmarked</title>
    <link rel="stylesheet" href="styles.css" />
    <style>
        /* Background color gradient */
        /*body {
            background: linear-gradient(to bottom, #fff, #fbe4d7);*/ /* Matches the design */
            /*height: 100vh;
            display: flex;
            flex-direction: column;
            Fign-items: center;
            padding-top: 20px;
        }*/

        /* Bigger container */
        .container {
            width: 500px; /* Increased size */
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
            text-align: left;
        }

        /* Title inside the box */
        .title {
            text-align: center;
            font-weight: bold;
            font-size: 28px; /* Bigger text */
            margin-bottom: 15px;
        }

        .item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid #ddd;
        }

        /* Bigger image */
        .food-image {
            width: 100px; /* Increased size */
            height: 100px;
            border-radius: 8px;
        }

        /* Increased space between text and quantity buttons */
        .details {
            flex-grow: 1;
            margin-left: 15px;
            margin-right: 50px; /* Added more space to push buttons further */
            font-size: 18px;
        }

        .subtext {
            font-size: 14px;
            color: gray;
            font-weight: bold;
        }

        .quantity {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* Bigger quantity buttons */
        .btn {
            padding: 5px 12px;
            font-size: 16px; /* Larger font */
            border: 2px solid black;
            background: white;
            color: black;
            cursor: pointer;
            border-radius: 5px;
        }

        .btn:hover {
            background: #f0f0f0;
        }

        .price {
            font-weight: bold;
            font-size: 22px; /* Bigger price */
            margin-left: 20px;
        }

        .buttons {
            margin-top: 25px;
            display: flex;
            justify-content: space-between;
        }

        /* Bigger Cancel button */
        .cancel-btn {
            padding: 12px 25px;
            border: 2px solid #ff7f4d;
            background: white;
            color: #ff7f4d;
            font-weight: bold;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
        }

        .cancel-btn:hover {
            background: #ffe6d5;
        }

        /* Bigger Add to Cart button */
        .cart-btn {
            padding: 12px 25px;
            border: none;
            background: linear-gradient(to right, #ff7f4d, #ff4500);
            color: white;
            font-weight: bold;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
        }

        .cart-btn:hover {
            opacity: 0.9;
        }
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            let quantityElement = document.getElementById("<%= lblQuantity.ClientID %>");
         let btnMinus = document.getElementById("btnMinus");
         let btnPlus = document.getElementById("btnPlus");
         let priceElement = document.querySelector(".price");

         let basePrice = 350; 

         function updatePrice() {
             let quantity = parseInt(quantityElement.innerText);
             let totalPrice = basePrice * quantity;
             priceElement.innerText = `₱${totalPrice}`; 
         }

         btnPlus.addEventListener("click", function () {
             let quantity = parseInt(quantityElement.innerText);
             quantityElement.innerText = quantity + 1;
             updatePrice(); 
         });

         btnMinus.addEventListener("click", function () {
             let quantity = parseInt(quantityElement.innerText);
             if (quantity > 1) {
                 quantityElement.innerText = quantity - 1;
                 updatePrice();
             } else {
                 document.getElementById("<%= pnlBookmark.ClientID %>").remove();
             }
         });

         updatePrice(); 
    });
    </script>
    <script>
        function addToCart() {
            window.location.href = "CartItems.aspx";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="container">
    <h2 class="title">Book Marked</h2>

    <div class="item" id="pnlBookmark" runat="server">
        <img src="Images/Shawarma.jpg" class="food-image" alt="Shawarma">
        <div class="details">
            <strong>Shawarma</strong><br>
            <span class="subtext">Al's Kitchen</span>
        </div>
        <div class="quantity">
            <button type="button" class="btn" id="btnMinus">−</button>
            <asp:Label ID="lblQuantity" runat="server" Text="1"></asp:Label>
            <button type="button" class="btn" id="btnPlus">+</button>
        </div>
        <span class="price">₱350</span>
    </div>

    <div class="buttons">
        <button type="button" class="cancel-btn">Cancel</button>
        <button type="button" class="cart-btn" onclick="addToCart()">Add to Cart</button>
    </div>
</div>
</asp:Content>
