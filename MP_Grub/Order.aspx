<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="MP_Grub.Order" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .restaurant-section {
             display: flex;
             flex-direction: column;
             justify-content: center;
             align-items: center;
        }

        .lblRestaurant {
            font-family: 'Akshar', sans-serif;
            color: white;
            font-weight: 700;
            font-size: 30px;
            z-index: 3;
        }

        .restaurant-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-evenly; 
            gap: 20px;
            row-gap: 60px;
            padding: 10px 0;
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
            z-index: 5;
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

        .food-button, .food-buttonB {
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

        .food-button:hover, .food-buttonB:hover{
            transform: translateY(-5px);
        }

        .background-duck {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            background-image: url('/images/Order_Duckbg1.png'); /* Default desktop background */
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
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="restaurant-section">
        <h1 class="lblRestaurant">Restaurants</h1>
        <%-- RESTAURANT NAMES --%>
        <div class="restaurant-container" id="restaurantContainer" runat="server">
            <%-- Retrieved from Database --%>
        </div>
    </div>

    <%-- FOOD ITEMS --%>
    <div id="foodPopup" class="popup">
        <h2 id="restaurantTitle" class="resto-title"></h2>
        <div class="food-item">
            <div id="foodList" class="food-name"> <%-- Retrieved from Database --%> </div>
        </div>
        <button class="food-button" style="background-color: #f44336; margin-top: 20px;" onclick="closePopup(); return false;">Close</button>
    </div>

    <%-- FOR ALERT MESSAGE --%>
    <div id="toast" style="display: none; position: fixed; top: 0px; left: 50%; transform: translateX(-50%); background-color: #333; color: #fff; padding: 10px 20px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); font-size: 16px; z-index: 9999; width: 100%; height: auto;letter-spacing: 0px; text-align: center; opacity: 1;transition: opacity 0.5s ease;"></div>

    <%-- BACKGROUND IMAGE --%>
    <div class="background-duck"></div>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" >
        let restaurantNames = {};

        //FETCH RESTAURANT NAMES
        function fetchRestaurantNames() {
            $.ajax({
                type: "POST",
                url: "Order.aspx/GetRestaurantNames",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    response.d.forEach(res => {
                        restaurantNames[res.RestaurantID] = res.RestaurantName;
                    });
                },
                error: function (error) {
                    console.error("Error fetching restaurant names:", error);
                }
            });
        }
        fetchRestaurantNames();

        //BUILDING POPUP FOOD MENU
        function showPopup(restaurantId) {
            const restaurantTitle = restaurantNames[restaurantId] || "Unknown Restaurant";
            document.getElementById('restaurantTitle').textContent = restaurantTitle + " Menu";

            //FETCH FROM THE FOOD TABLE
            $.ajax({
                type: "POST",
                url: "Order.aspx/GetRestaurantMenu",
                data: JSON.stringify({ restaurantId: restaurantId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    const foodListDiv = document.getElementById('foodList');
                    foodListDiv.innerHTML = "";

                    const foodItems = response.d || response;
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
                                <button class="food-buttonB" data-foodid='${food.FoodID}' onclick="bookmarkFood('${food.FoodID}', this);return false;">Bookmark</button>
                                <button class="food-button" onclick="addToCart('${food.FoodID}','${food.FoodName}', '${food.FoodPrice}');return false;">Add to Cart</button>
                            </div>
                        `;

                        foodListDiv.appendChild(foodItemDiv);
                    });

                    document.getElementById('foodPopup').classList.add('active');


                    //CHECKS IF THE FOODIDs IS IN THE BOOKMARK TABLE
                    $.ajax({
                        type: "POST",
                        url: "Order.aspx/GetUserBookmarkedFood",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            //LIST OF FOODIDs IN THE BOOKMARK TABLE
                            const bookmarkedFoodIDs = response.d;
                            let foodButtons = document.querySelectorAll('.food-buttonB');

                            foodButtons.forEach(button => {
                                let foodID = parseInt(button.getAttribute('data-foodid'));
                                if (bookmarkedFoodIDs.includes(foodID)) {
                                    $(button).prop("disabled", true);
                                    $(button).css("background-color", "#d3d3d3");
                                    $(button).css("cursor", "not-allowed");
                                    $(button).css("transform", "none");
                                }
                                else {
                                    //RE-ENABLE IF ITEM HAS BEEN REMOVED FROM BOOKMARK TABLE
                                    $(button).prop("disabled", false);
                                    $(button).css("background-color", "#ff7f50");
                                    $(button).css("cursor", "pointer");
                                    $(button).css("transform", "transform 0.2s ease-in-out");
                                }

                            });
                        },
                        error: function () {
                            //FOR DEBUGGING ONLY
                            console.error("Failed to get bookmarked food.");
                            showToast("Oops! Couldn’t bookmark the food due to an error", "#DC3545")
                        }
                    });
                },
                error: function (error) {
                    console.error("Error fetching menu:", error);
                    showToast("Oops! Something went wrong. Please refresh the page and try again.", "#DC3545")
                }
            });


        }


        //INSERTING TO BOOKMARK TABLE
        function bookmarkFood(foodID, buttonElement) {
            $.ajax({
                type: "POST",
                url: "Order.aspx/BookmarkFood",
                data: JSON.stringify({ foodID1: foodID }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d.success) {
                        showToast("Food has been bookmarked!", "#3CB371")
                        $(buttonElement).prop("disabled", true);
                        $(buttonElement).css("background-color", "#d3d3d3");
                        $(buttonElement).css("cursor", "not-allowed");
                        $(buttonElement).css("transform", "none");
                    } else {
                        //alert("Error: " + response.d.message);
                        showToast("Bookmarking failed. — Please refresh and try again.", "#DC3545")
                    }
                },
                error: function (xhr, status, error) {
                    //FOR DEBUGGING ONLY
                    console.error("AJAX Error:", error);
                    showToast("Oops! Couldn’t bookmark the food due to an error", "#DC3545")
                }
            });
        }


        //INSERTING TO ORDER DETAILS TABLE
        function addToCart(foodID, foodName, price) {
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
                            foodId: foodID,
                            foodName: foodName,
                            foodPrice: price,
                            transactionId: transactionId,
                            userId: userId
                        }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            if (response.d.success) {
                                showToast(response.d.message, '#3CB371')
                            }
                            else {
                                showToast(response.d.message, '#DC3545')
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("AJAX Error:", error);
                            console.error("Response:", xhr.responseText);
                            showToast("Oops! Couldn’t add the food to the cart due to an error", "#DC3545")
                        }
                    });
                },
                error: function (xhr, status, error) {
                    console.error("Session AJAX Error:", error);
                    console.error("Response:", xhr.responseText);
                    showToast("Oops! Couldn’t add the food to the cart due to an error", "#DC3545")
                }
            });
        }

        function closePopup() {
            document.getElementById('foodPopup').classList.remove('active');
        }

        //ALTERNATIVE FOR ALERT NOTIFICATION
        function showToast(message, backgroundColor) {
            const toast = document.getElementById("toast");

            toast.style.backgroundColor = backgroundColor;
            toast.textContent = message;
            toast.style.display = "block";
            toast.style.opacity = "1";

            if (toast.hideTimeout) clearTimeout(toast.hideTimeout);
            void toast.offsetWidth;

            toast.hideTimeout = setTimeout(() => {
                toast.style.opacity = "0";
                toast.addEventListener("transitionend", function handler() {
                    toast.style.display = "none";
                    toast.removeEventListener("transitionend", handler);
                });
            }, 1000);
        }
    </script>
</asp:Content>