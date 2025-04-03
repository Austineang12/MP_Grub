<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="MP_Grub.Order" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .restaurant-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-evenly; 
            gap: 20px;
            row-gap: 60px; /* Space between rows */
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
    <div class="restaurant-container" id="restaurantContainer" runat="server">
        <%-- Retrieved from Database --%>
    </div>

    <div id="foodPopup" class="popup">
        <h2 id="restaurantTitle" class="resto-title"></h2>
        <div class="food-item">
            <div id="foodList" class="food-name"></div>
        </div>
        <button class="food-button" style="background-color: #f44336; margin-top: 20px;" onclick="closePopup(); return false;">Close</button>
    </div>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" >
        function showPopup(restaurantId) {
    const restaurantNames = ["", "Saucy", "Same Old Coffee", "Wingspot Unlimited", "Jamaican", "Bon Appetea"];
    document.getElementById('restaurantTitle').textContent = restaurantNames[restaurantId] + " Menu";

    // Call WebMethod using AJAX
    $.ajax({
        type: "POST",
        url: "Order.aspx/GetRestaurantMenu",
        data: JSON.stringify({ restaurantId: restaurantId }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            const foodListDiv = document.getElementById('foodList');
            foodListDiv.innerHTML = "";

            const foodItems = response.d || response;  // Accessing WebMethod response
            if (foodItems.length === 0) {
                foodListDiv.innerHTML = "<p>No menu available.</p>";
                return;
            }

            foodItems.forEach(food => {
                const foodItemDiv = document.createElement('div');
                foodItemDiv.classList.add('food-item');

                foodItemDiv.innerHTML = `
                    <div class="food-details">
                        <span class="food-name">${food.FoodName}</span>
                        <span class="food-price">${food.FoodPrice}</span>
                    </div>
                    <div class="food-actions">
                        <button class="food-button" onclick="bookmarkFood('${food.FoodName}')">Bookmark</button>
                        <button class="food-button" onclick="addToCart('${food.FoodName}', '${food.FoodPrice}')">Add to Cart</button>
                    </div>
                `;

                foodListDiv.appendChild(foodItemDiv);
            });

            document.getElementById('foodPopup').classList.add('active');
        },
        error: function (error) {
            console.error("Error fetching menu:", error);
        }
    });
}


        function bookmarkFood(foodName) {
            alert(`${foodName} has been bookmarked!`);
        }

        function addToCart(foodName, price) {
            $.ajax({
                type: "POST",
                url: "Order.aspx/GetSessionData",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (sessionResponse) {
                    if (!sessionResponse.d.IsValid) {
                        console.error("Session error:", sessionResponse.d.Message);
                        alert(sessionResponse.d.Message);
                        window.location.href = "Login.aspx";
                        return;
                    }

                    var transactionId = sessionResponse.d.TransactionID;
                    var userId = sessionResponse.d.UserID;

                    $.ajax({
                        type: "POST",
                        url: "Order.aspx/AddToCart",
                        data: JSON.stringify({
                            foodName: foodName,
                            foodPrice: price,
                            transactionId: transactionId,
                            userId: userId
                        }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            alert(response.d);
                        },
                        error: function (xhr, status, error) {
                            console.error("AJAX Error:", error);
                            console.error("Response:", xhr.responseText);
                            alert("Session error. Please try again. " + error);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    console.error("Session AJAX Error:", error);
                    console.error("Response:", xhr.responseText);
                    alert("Session error. Please try again. " + error);
                }
            });
        }




        function closePopup() {
            document.getElementById('foodPopup').classList.remove('active');
        }
    </script>
</asp:Content>
