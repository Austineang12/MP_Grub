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
            text-decoration: none !important;
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
            color: blue;
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
            font-size: 18px;
            font-weight: bold;
            flex: 1;
        }

        .food-price {
            font-size: 18px;
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
    <div class="restaurant-container">
        <asp:LinkButton ID="Saucy" runat="server" CssClass="restaurant-card" OnClientClick="showPopup('1'); return false;">
            <div class="restaurant-logo"><img src="images/Saucy_Order.png" alt="Saucy Logo" /></div>
            <div class="restaurant-name">Saucy</div>
        </asp:LinkButton>

        <asp:LinkButton ID="SameOldCoffee" runat="server" CssClass="restaurant-card" OnClientClick="showPopup('2'); return false;">
            <div class="restaurant-logo"><img src="images/SOC_Order.png" alt="Same Old Coffee Logo" /></div>
            <div class="restaurant-name">Same Old Coffee</div>
        </asp:LinkButton>

        <asp:LinkButton ID="WingspotUnlimited" runat="server" CssClass="restaurant-card" OnClientClick="showPopup('3'); return false;">
            <div class="restaurant-logo"><img src="images/Wingspot_Order.png" alt="Wingspot Unlimited Logo" /></div>
            <div class="restaurant-name">Wingspot Unlimited</div>
        </asp:LinkButton>

        <asp:LinkButton ID="BonAppetea" runat="server" CssClass="restaurant-card" OnClientClick="showPopup('5'); return false;">
            <div class="restaurant-logo"><img src="images/BonAppetea_Order.png" alt="Bon Appetea Logo" /></div>
            <div class="restaurant-name">Bon Appetea</div>
        </asp:LinkButton>

        <asp:LinkButton ID="Jamaican" runat="server" CssClass="restaurant-card" OnClientClick="showPopup('4'); return false;">
            <div class="restaurant-logo"><img src="images/Jamaican_Order.png" alt="Jamaican Logo" /></div>
            <div class="restaurant-name">Jamaican</div>
        </asp:LinkButton>
    </div>

    <div id="foodPopup" class="popup">
        <h2 id="restaurantTitle" class="resto-title"></h2>
        <div class="food-item">
            <div id="foodList" class="food-name"></div>
        </div>
        <button class="food-button" style="background-color: #f44336; margin-top: 20px;" onclick="closePopup()">Close</button>
    </div>

    <script>
        const menus = {
            1: [
                { name: "Chicken Fries", price: "₱110.00" },
                { name: "Pork Bacon Ribs", price: "₱110.00" },
                { name: "Beef Pot Roast", price: "₱95.00" }
            ],
            2: [
                { name: "Vietnamese Coffee", price: "₱130.00" },
                { name: "Cafe Latte", price: "₱120.00" },
                { name: "SeaSalt Latte", price: "₱140.00" }
            ],
            3: [
                { name: "2pcs Chicken Wings", price: "₱150.00" },
                { name: "4pcs Chicken Wings", price: "₱200.00" },
                { name: "8pcs Chicken Wings", price: "₱350.00" }
            ],
            4: [
                { name: "De Original Beef", price: "₱59.00" },
                { name: "Beef Pinatubo", price: "₱59.00" },
                { name: "Cheezy Beef", price: "₱59.00" }
            ],
            5: [
                { name: "Nirvana Milktea", price: "₱90.00" },
                { name: "Dutch Dreams Milktea", price: "₱90.00" },
                { name: "Creme Brulee Milktea", price: "₱90.00" }
            ]
        };

        function showPopup(restaurantId) {
            const foodListDiv = document.getElementById('foodList');
            foodListDiv.innerHTML = "";

            menus[restaurantId].forEach(food => {
                const foodItemDiv = document.createElement('div');
                foodItemDiv.classList.add('food-item');

                foodItemDiv.innerHTML = `
            <div class="food-details">
                <span class="food-name">${food.name}</span>
                <span class="food-price">${food.price}</span>
            </div>
            <div class="food-actions">
                <button class="food-button" onclick="bookmarkFood('${food.name}')">Bookmark</button>
                <button class="food-button" onclick="addToCart('${food.name}', '${food.price}')">Add to Cart</button>
            </div>
        `;

                foodListDiv.appendChild(foodItemDiv);
            });

            const restaurantNames = ["", "Saucy", "Same Old Coffee", "Wingspot Unlimited", "Jamaican", "Bon Appetea"];
            document.getElementById('restaurantTitle').textContent = restaurantNames[restaurantId] + " Menu";
            document.getElementById('foodPopup').classList.add('active');
        }


        function bookmarkFood(foodName) {
            alert(`${foodName} has been bookmarked!`);
        }

        function addToCart(foodName, price) {
            alert(`${foodName} (${price}) has been added to the cart!`);
        }

        function closePopup() {
            document.getElementById('foodPopup').classList.remove('active');
        }
    </script>
</asp:Content>
