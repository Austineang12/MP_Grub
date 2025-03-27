<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="MP_Grub.Order" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        body {
            background-color: #f4f4f4;
        }

        .restaurant-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 5%;
            border: 50px;
        }

        .restaurant-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
            cursor: pointer;
            transition: transform 0.3s ease-in-out;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            text-decoration: none !important;
            margin: 20px 0;
        }

        .restaurant-card:hover {
            transform: translateY(-10px);
        }

        .restaurant-logo {
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #fff;
            height: 150px;
        }

        .restaurant-logo img {
            width: 100%;
            height: auto;
            max-height: 150px;
            object-fit: cover;
            border-bottom: 2px solid #ff7f50;
        }

        .restaurant-name {
            background-color: #ff7f50;
            color: white;
            padding: 20px;
            font-size: 18px;
            font-weight: bold;
            letter-spacing: 0px;
            text-align: center;
        }

        .popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            z-index: 1000;
            width: 80%;
            max-width: 600px;
        }

        .popup.active {
            display: block;
        }

        .resto-title {
            color: black;
        }

        .food-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #ccc;
            color: black;
            gap: 20px;
        }

        .food-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex: 1;
        }

        .food-name {
            /*font-size: 18px;*/
            font-weight: bold;
            flex: 1;
        }

        .food-price {
            /*font-size: 18px;*/
            font-weight: bold;
            text-align: right;
            min-width: 100px;
        }

        .food-actions {
            display: flex;
            gap: 10px;
        }

        .food-button {
            background-color: #ff7f50;
            color: white;
            border: none;
            border-radius: 20px;
            padding: 8px 20px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            box-shadow: 2px 4px 6px rgba(0, 0, 0, 0.2);
            transition: transform 0.2s ease-in-out;
        }

        .food-button:hover {
            transform: translateY(-5px);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="restaurant-container" id="restaurantContainer" runat="server">
        <%-- Restaurants retrieved from the database --%>
    </div>

    
    <div id="foodPopup" class="popup">
        <h2 id="restaurantTitle" class="resto-title"></h2>
        <div id="foodList" runat="server"><%-- Food Items retrieved from the database --%></div>
        <button class="food-button" style="background-color: #f44336; margin-top: 20px;" onclick="closePopup()">Close</button>
    </div>

    <script type="text/javascript">
        function closePopup() {
            document.getElementById('foodPopup').classList.remove('active');
        }
    </script>
</asp:Content>
