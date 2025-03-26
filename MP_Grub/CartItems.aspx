<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="CartItems.aspx.cs" Inherits="MP_Grub.CartItems" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Cart</title>
    <style>
       
        body {
            background: linear-gradient(to bottom, #fff, #fbe4d7);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start; 
            padding-top: 40px; 
        }

        .cart-container {
            width: 500px; 
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
        }

        .cart-title {
            text-align: center;
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .item {
            display: flex;
            align-items: flex-start;
            gap: 10px;
        }

        .item img {
            width: 50px;
            height: 50px;
            border-radius: 5px;
        }

        .details {
            flex-grow: 1;
        }

        .details strong {
            font-size: 16px;
        }

        .subtext {
            font-size: 12px;
            color: #444;
            font-weight: bold;
        }

        .row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 8px;
        }

        .quantity {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .btn {
            padding: 3px 8px;
            font-size: 12px;
            border: 1px solid black;
            background: white;
            color: black;
            cursor: pointer;
            border-radius: 3px;
        }

        .price {
            font-weight: bold;
            font-size: 18px;
        }

        .voucher-container {
            margin-top: 10px;
        }

        .voucher-input {
            width: 100%;
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        .order-summary {
            margin-top: 15px;
            font-size: 14px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
        }

        .total-payment {
            font-weight: bold;
            font-size: 16px;
        }

        .bottom-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
        }

        .btn-cancel, .btn-payment {
            width: 48%;
            padding: 8px;
            font-size: 14px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
        }

        .btn-cancel {
            background: white;
            color: #FF8040;
            border: 1px solid #FF8040;
        }

        .btn-payment {
            background: #FF8040;
            color: white;
            border: none;
        }
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            let quantityElement = document.getElementById("<%= lblQuantity.ClientID %>");
        let btnMinus = document.getElementById("btnMinus");
        let btnPlus = document.getElementById("btnPlus");
        let priceElement = document.querySelector(".price"); 
        let orderFeeElement = document.querySelector(".summary-row:nth-child(1) span:last-child"); 
        let deliveryFeeElement = document.querySelector(".summary-row:nth-child(2) span:last-child"); 
        let discountElement = document.querySelector(".summary-row:nth-child(3) span:last-child"); 
        let totalPaymentElement = document.querySelector(".total-payment span:last-child");
        let voucherInput = document.querySelector(".voucher-input"); 

        let basePrice = 350; 
        let defaultDeliveryFee = 30; 
        let deliveryFee = defaultDeliveryFee; 
        let discountAmount = 0; 

        function updatePrice() {
            let quantity = parseInt(quantityElement.innerText);
            let totalPrice = basePrice * quantity;
            let totalPayment = totalPrice + deliveryFee - discountAmount;

            priceElement.innerText = `₱${totalPrice}`; 
            orderFeeElement.innerText = `₱${totalPrice}`; 
            deliveryFeeElement.innerText = `₱${deliveryFee}`; 
            discountElement.innerText = `₱${discountAmount}`; 
            totalPaymentElement.innerText = `₱${totalPayment}`; 
        }

        btnPlus.addEventListener("click", function () {
            let quantity = parseInt(quantityElement.innerText);
            quantityElement.innerText = quantity + 1;
            applyVoucher(); 
            updatePrice();
        });

        btnMinus.addEventListener("click", function () {
            let quantity = parseInt(quantityElement.innerText);
            if (quantity > 1) {
                quantityElement.innerText = quantity - 1;
                applyVoucher(); 
                updatePrice();
            }
        });

        function applyVoucher() {
            let quantity = parseInt(quantityElement.innerText);
            let totalPrice = basePrice * quantity;
            let voucherCode = voucherInput.value.trim().toUpperCase(); 

            if (voucherCode === "50%OFF") {
                discountAmount = totalPrice * 0.5; 
                deliveryFee = defaultDeliveryFee; 
            } else if (voucherCode === "WFD") {
                discountAmount = 0; 
                deliveryFee = 0; 
            } else {
                discountAmount = 0; 
                deliveryFee = defaultDeliveryFee; 
            }

            updatePrice();
        }

        voucherInput.addEventListener("input", applyVoucher);

        updatePrice(); 
    });
    </script>
    <script>
        <%--document.addEventListener("DOMContentLoaded", function () {
            document.getElementById("<%= btnCancel.ClientID %>").addEventListener("click", function () {
                window.location.href = "Home.aspx";
            });

            document.getElementById("<%= btnPayment.ClientID %>").addEventListener("click", function () {
                window.location.href = "Payment.aspx";
            });
        });--%>
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="cart-container">
        <div class="cart-title">Cart</div>

        <div class="item">
            <img src="Images/Shawarma.jpg" alt="Shawarma">
            <div class="details">
                <strong>Shawarma</strong><br>
                <span class="subtext">Al's Kitchen</span>
                <div class="row">
                    <div class="quantity">
                        <button type="button" class="btn" id="btnMinus">−</button>
                        <asp:Label ID="lblQuantity" runat="server" Text="1"></asp:Label>
                        <button type="button" class="btn" id="btnPlus">+</button>
                    </div>
                    <span class="price">₱350</span>
                </div>
            </div>
        </div>

        <div class="voucher-container">
            <input type="text" class="voucher-input" placeholder="Voucher:">
        </div>

        <div class="order-summary">
            <div class="summary-row">
                <span>Order Fee</span>
                <span>₱350</span>
            </div>
            <div class="summary-row">
                <span>Delivery Fee</span>
                <span>₱30</span>
            </div>
            <div class="summary-row">
                <span>Discounts</span>
                <span>₱0</span>
            </div>
            <div class="summary-row total-payment">
                <span>Total Payment</span>
                <span>₱380</span>
            </div>
        </div>

        <div class="bottom-buttons">
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-cancel" OnClick="btnCancel_Button" />
            <asp:Button ID="btnPayment" runat="server" Text="Payment" CssClass="btn-payment" OnClick="btnPayment_Button" />
        </div>
    </div>
</asp:Content>
