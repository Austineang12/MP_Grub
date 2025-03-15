<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="MP_Grub.Order" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .restaurant-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            padding: 20px;
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
            justify-content: space-between;
        }

        .restaurant-card:hover {
            transform: translateY(-10px);
        }

        .restaurant-logo {
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #fff;
            padding: 20px;
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
            font-size: 24px;
            font-weight: bold;
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

        .food-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding: 10px;
            border-bottom: 1px solid #ccc;
        }

        .food-name {
            font-size: 18px;
            font-weight: bold;
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
    <div class="restaurant-container">
        <asp:LinkButton ID="Saucy" runat="server" CssClass="restaurant-card" OnClientClick="showPopup('Saucy'); return false;">
            <div class="restaurant-logo"><img src="images/Saucy_Order.png" alt="Saucy Logo" /></div>
            <div class="restaurant-name">Saucy</div>
        </asp:LinkButton>

        <asp:LinkButton ID="SameOldCoffee" runat="server" CssClass="restaurant-card" OnClientClick="showPopup('Same Old Coffee'); return false;">
            <div class="restaurant-logo"><img src="images/SOC_Order.png" alt="Same Old Coffee Logo" /></div>
            <div class="restaurant-name">Same Old Coffee</div>
        </asp:LinkButton>

        <asp:LinkButton ID="WingspotUnlimited" runat="server" CssClass="restaurant-card" OnClientClick="showPopup('Wingspot Unlimited'); return false;">
            <div class="restaurant-logo"><img src="images/Wingspot_Order.png" alt="Wingspot Unlimited Logo" /></div>
            <div class="restaurant-name">Wingspot Unlimited</div>
        </asp:LinkButton>

        <asp:LinkButton ID="BonAppetea" runat="server" CssClass="restaurant-card" OnClientClick="showPopup('Bon Appetea'); return false;">
            <div class="restaurant-logo"><img src="images/BonAppetea_Order.png" alt="Bon Appetea Logo" /></div>
            <div class="restaurant-name">Bon Appetea</div>
        </asp:LinkButton>

        <asp:LinkButton ID="Jamaican" runat="server" CssClass="restaurant-card" OnClientClick="showPopup('Jamaican'); return false;">
            <div class="restaurant-logo"><img src="images/Jamaican_Order.png" alt="Jamaican Logo" /></div>
            <div class="restaurant-name">Jamaican</div>
        </asp:LinkButton>
    </div>

    <div id="foodPopup" class="popup">
        <h2 id="restaurantTitle"></h2>
        <div class="food-item">
            <span class="food-name">Food 1</span>
            <div class="food-actions">
                <button class="food-button">Add to Cart</button>
                <button class="food-button">Bookmark</button>
            </div>
        </div>
        <div class="food-item">
            <span class="food-name">Food 2</span>
            <div class="food-actions">
                <button class="food-button">Add to Cart</button>
                <button class="food-button">Bookmark</button>
            </div>
        </div>
        <div class="food-item">
            <span class="food-name">Food 3</span>
            <div class="food-actions">
                <button class="food-button">Add to Cart</button>
                <button class="food-button">Bookmark</button>
            </div>
        </div>
        <button class="food-button" style="background-color: #f44336; margin-top: 20px;" onclick="closePopup()">Close</button>
    </div>

    <script>
        function showPopup(restaurantName) {
            document.getElementById('restaurantTitle').textContent = restaurantName + " Menu";
            document.getElementById('foodPopup').classList.add('active');
        }

        function closePopup() {
            document.getElementById('foodPopup').classList.remove('active');
        }
    </script>
</asp:Content>
