<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="BookmarkedItems.aspx.cs" Inherits="MP_Grub.BookmarkedItems" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Bookmark</title>
    <style type="text/css">
        #bookmarkTitle {
            font-size: 24px;
            font-weight: bold;
            color: black;
            margin: 20px 0 10px 50px;
        }

        .bookmarkPopup {
            background-color: white;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
            width: 40vw;
            display: flex;
            flex-direction: column;
            position: relative;
            border-radius: 20px;
            height: 80vh;
            /*margin: 50px 0 100px 0;*/
            z-index: 5;
        }

        .bookmarkContent {
            background-color: lightgrey;
            box-shadow: inset 0px 4px 15px rgba(0, 0, 0, 0.2);
            /*z-index: 2;*/
            margin-bottom: -20px;
            /* Negative margin to overlap with the red part */
            position: relative;
            padding: 20px;
            padding-bottom: 40px;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-evenly;
            align-items: center;
            gap: 10px;
            row-gap: 20px;
            height: auto;
            overflow-y: auto;
            height: 480px;

            /* make the scroll bar hidden */
            scrollbar-width: none;
            -ms-overflow-style: none;
        }

        /* make the scroll bar hidden */
        .bookmarkContent::-webkit-scrollbar {
            display: none;
        }


        .optionButtons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 50px;
            margin-bottom: 30px;

            /*background: blue;
                    height: 200px;
                    border-radius: 20px;
                    position: relative;
                    z-index: 1;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    gap: 10%;
                    margin-top: 20px;*/
        }

        .optionBtn {
            font-weight: 700;
            background-color: #FB8F52;
            align-items: center;
            color: #404040;
            border: none;
            padding: 10px 20px;
            border-radius: 15px;
            cursor: pointer;
            font-size: 1rem;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
        }

        .optionBtn:hover {
            background-color: #E07E48;
        }

        /*.optionBtn{
                    background: #fff;
                    height: 80px;
                    width: 250px;
                    font-weight: bold;
                    font-size: 18px;
                    border-radius: 20px;
                    border: none;
                    box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
                }
                #CheckoutBtn{
                    background: #FB8F52;
                    width: 300px;
                }
                .optionBtn:hover {
                    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
                    transition: all 0.3s ease-in-out;
                }*/


        .item {
            background: white;
            height: 100px;
            width: 300px;
            border-radius: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            letter-spacing: 0px;

            position: relative;
            overflow: hidden;
            row-gap: 1%;
        }

        .item:hover .hiddenHover {
            display: flex;
            /* Show it on hover */
        }

        .foodName {
            font-size: 18px;
            text-align: center;
            color: black;
            font-weight: bold;
        }

        .foodStore {
            font-size: 14px;
            color: black;
        }

        /*Hidden*/
        .hiddenHover {
            background: #d1d0cf;
            height: 100%;
            width: 100%;
            border-radius: 20px;
            display: none;
            position: absolute;
            top: 0;
            left: 0;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            z-index: 10;
            gap: 10px;
        }

        .removeBtn, .addCartBtn {
            width: 80%;
            height: 45px;
            background-color: #cf3a23;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            text-align: center;
            font-size: 16px;
            font-weight: bold;
        }
        .addCartBtn{
            background-color: #FB8F52;
        }

        .removeBtn:hover, .addCartBtn:hover {
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
            transition: all 0.1s ease-in-out;
        }

        /*-- Background Image --*/
        .background-duck {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            background-image: url('/images/Cart_Duckbg2.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            transition: background-image 0.3s ease-in-out;
        }

        @media (max-width: 1000px) {
            .background-duck {
                position: fixed;
                height: 100%;
                background-image: url('/images/Order_Moblebg1.png') !important;
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
            }

            .bookmarkPopup {
                width: 400px;
            }
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="bookmarkPopup">
        <label ID="bookmarkTitle">Your Bookmark</label>
        <%-- BOOKMARK ITEMS --%>
        <div class="bookmarkContent" id="bookmarkContent" runat="server">
        <%-- RETRIEVED FROM DATABASE --%>
        </div>

        <%-- CANCEL/CHECKOUT BUTTONS --%>
        <div class="optionButtons">
            <input class="optionBtn" id="BackBtn" type="button" value="Back" onclick="goBackOrHome();"/>
            <input class="optionBtn" id="CheckoutBtn" type="button" value="Checkout"/>
        </div>
    </div>
    <%-- Background Image --%>
    <div class="background-duck"></div>

    <%-- FOR ALERT MESSAGE --%>
    <div id="toast" style="display: none; position: fixed; top: 0px; left: 50%; transform: translateX(-50%); background-color: #333; color: #fff; padding: 10px 20px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); font-size: 16px; z-index: 9999; width: 100%; height: auto;letter-spacing: 0px; text-align: center; opacity: 1;transition: opacity 0.5s ease;"></div>

    <script type="text/javascript">

        window.history.replaceState(null, null, window.location.href);

        function goBackOrHome() {
            if (window.history.length > 1) {
                window.history.back();
            } else {
                window.location.href = '/Order.aspx';
            }
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
                        showToast(sessionResponse.d.Message);
                        window.location.href = "Login.aspx";
                        return;
                    }

                    Console.log("foodID: ", foodID,"\nfoodName: ", foodName,"\nprice:", price);
                    var transactionId = sessionResponse.d.TransactionID;
                    var userId = sessionResponse.d.UserID;

                    $.ajax({
                        type: "POST",
                        url: "BookmarkedItems.aspx/AddToCart",
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

        function removeBookmark(bookmarkID) {
            console.log("Removing bookmark with ID:", bookmarkID);

            const formData = new FormData();
            formData.append("bookmarkID", bookmarkID);
            formData.append("action", "delete");

            fetch(window.location.href, {
                method: "POST",
                body: formData

            }).then(response => {
                if (!response.ok) {
                    /*alert("Failed to remove bookmark.");*/
                    showToast('Unable to delete bookmark due to an error.', '#DC3545')
                }

                else {
                    const itemToRemove = document.getElementById(`bookmark_${
                    bookmarkID}`);

                    if (itemToRemove) {
                        itemToRemove.remove();
                    }

                }

            }).catch(error => {
                console.error("Error while removing bookmark:", error);
            });
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
            }, 2500);
        }


    </script>
</asp:Content>
