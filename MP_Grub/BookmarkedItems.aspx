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
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
            width: 70vw;
            display: flex;
            flex-direction: column;
            position: relative;
            border-radius: 20px;
            height: auto; 
            margin: 50px 0 100px 0;
        }

        .bookmarkContent {
            z-index: 2;
            margin-bottom: -20px; /* Negative margin to overlap with the red part */
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
    
            overflow-y: auto; /* Enables vertical scrolling */
            overflow-x: hidden; /* Prevents horizontal scrolling */
        }


        .optionButtons {
            background: #f0eeed;
            height: 200px;
            border-radius: 20px;
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10%;
            margin-top: 20px;
        }
        .optionBtn{
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
        }


        .item{
            background: #f0eeed;
            height: 200px;
            width: 200px;
            border-radius: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            letter-spacing: 0px;

            position: relative;
            overflow: hidden;
        }
        .item:hover .hiddenHover {
            display: flex; /* Show it on hover */
        }
        .foodName{
            font-size: 18px;
            text-align: center;
            color: black;
            font-weight: bold;
        }
        .foodStore{
            font-size: 14px;
            color: black;
        }

        /*Hidden*/
        .hiddenHover{
            background: #d1d0cf;
            height: 100%; /* Make it match the item div's height */
            width: 100%;  /* Make it match the item div's width */
            border-radius: 20px; /* Match the item div's border radius */
            display: none; /* Initially hidden */
            position: absolute; /* Position it absolutely inside .item */
            top: 0; /* Align it with the top */
            left: 0; /* Align it with the left */
            flex-direction: column;
            align-items: center;
            justify-content: center;
            z-index: 10; /* Ensure it's on top when visible */
            gap: 10px;
        }
        .quantityContainer{
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: black;
            /*background: #f0eeed;*/
            border-radius: 10px;

            width: 80%;
            margin-top: 10px;
        }
        .quantityButtonMinus, .quantityButtonPlus{
            width: 50px;
            height:30px;
            border-radius: 10px;
            border: none;
            font-weight: bold;
            font-size: 16px;
            background: #fff;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .quantityButtonMinus:hover, .quantityButtonPlus:hover {
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
            transition: all 0.1s ease-in-out;
        }
        .quantityButtonPlus{
            background: #FB8F52;
        }
        .removeBtn{
            width: 80%; /* Adjust this value as needed */
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
        .removeBtn:hover {
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
            transition: all 0.1s ease-in-out;
        }

    </style>
    <script type="text/javascript">
        function updateQuantity(foodName, restaurantName, change) {
            var quantityLabel = document.getElementById(`quantity_${foodName}_${restaurantName}`);
            var currentQuantity = parseInt(quantityLabel.innerText);

            var newQuantity = currentQuantity + change;

            quantityLabel.innerText = newQuantity;

            var bookmarkID = `${foodName}_${restaurantName}`;
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "UpdateBookmarkQuantity.aspx", true); 
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.send(`bookmarkID=${bookmarkID}&newQuantity=${newQuantity}`);

            xhr.onload = function() {
                if (xhr.status === 200) {
                    console.log('Quantity updated successfully.');
                } else {
                    console.log('Error updating quantity.');
                }
            };
        }


        function removeBookmark(bookmarkID) {
            if (confirm("Are you sure you want to remove this item?")) {
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "RemoveBookmark.aspx", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.send("bookmarkID=" + bookmarkID);
        
                // Reload page after removing item
                xhr.onload = function () {
                    if (xhr.status == 200) {
                        location.reload();
                    }
                };
            }
        }


    </script>
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
            <input class="optionBtn" id="CheckoutBtn" type="button" value="Checkout" />
        </div>
    </div>

    <script type="text/javascript">

        window.history.replaceState(null, null, window.location.href);

        function goBackOrHome() {
            // Go back to the previous page if possible, else go to home page
            if (window.history.length > 1) {
                window.history.back();
            } else {
                window.location.href = '/Home.aspx';
            }
        }

        function updateQuantity(bookmarkID, change) {
            const labelID = `quantity_${bookmarkID}`;
            const label = document.getElementById(labelID);

            if (!label) return;

            let currentQuantity = parseInt(label.innerText);
            let newQuantity = currentQuantity + change;

            if (newQuantity < 1) newQuantity = 1; // Prevent quantity less than 1

            // Update label immediately
            label.innerText = newQuantity;

            // Send POST to update the database
            const formData = new FormData();
            formData.append("bookmarkID", bookmarkID);
            formData.append("newQuantity", newQuantity);
            formData.append("action", "update");

            fetch(window.location.href, {
                method: "POST",
                body: formData
            }).then(response => {
                if (!response.ok) {
                    alert("Failed to update quantity.");
                }
            }).catch(error => {
                console.error("Error:", error);
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
                    alert("Failed to remove bookmark.");
                } else {
                    // Remove item visually if request was successful
                    const itemToRemove = document.getElementById(`bookmark_${bookmarkID}`);
                    if (itemToRemove) {
                        itemToRemove.remove();
                    }
                }
            }).catch(error => {
                console.error("Error while removing bookmark:", error);
            });
        }

    </script>
</asp:Content>
