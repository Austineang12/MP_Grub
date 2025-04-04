<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="CartItems.aspx.cs" Inherits="MP_Grub.CartItems" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            font-family: 'Akshar', sans-serif;
            font-weight: 700;
            z-index: 5;
        }

        .cart-container {
            width: 50vw;
            max-width: 500px;
            min-width: 300px;
            background-color: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease-in-out;
        }

        .cart-item-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border: 1px solid #ddd;
            padding: 15px;
            margin: 10px 0;
            border-radius: 8px;
            background: #f9f9f9;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            flex-wrap: wrap;
        }

        .cart-item-container h3 {
            font-size: 18px;
            margin-bottom: 5px;
            color: #404040;
        }

        .cart-item-container p {
            font-size: 16px;
            margin: 2px 0;
            color: #404040;
        }

        .item-details {
            flex: 1;
            min-width: 50%;
        }

        .controls-container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .controls {
            display: flex;
            align-items: center;
        }

        .text-summary {
            justify-content: space-between;
            font-size: 15px;
            color: #404040;
            margin-top: 10px;
            padding-top: 10px;
            border-top: 2px solid #ddd;
        }

        .text-ordersummary {
            font-size: 18px; 
            color: #404040;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
        }

        .empty-cart {
            text-align: center;
            margin-top: 50px;
            font-size: 18px;
            color: #404040;
        }
        .empty-cart img {
            width: 100px;
            height: auto;
        }

        .text-title {
            font-size: 30px;
            color: #404040;
        }

        .order-button {
            font-family: 'Akshar', sans-serif;
            font-weight: 700;
            background-color: white;
            align-items: center;
            color: #404040;
            border: none;
            padding: 12px 30px;
            border-radius: 20px;
            cursor: pointer;
            margin-top: 20px;
            font-size: 1rem;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
        }

        .payment-button {
            font-family: 'Akshar', sans-serif;
            font-weight: 700;
            background-color: #FB8F52;
            align-items: center;
            color: #404040;
            border: none;
            padding: 12px 30px;
            border-radius: 20px;
            cursor: pointer;
            margin-top: 10px;
            font-size: 1rem;
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
        }

        .order-button:hover {
            background-color: #F2F2F2;
        }

        .payment-button:hover {
            background-color: #E07E48;
        }

        .buttons {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .delete-button {
            font-family: 'Akshar', sans-serif;
            background-color: #ff4d4d;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .delete-button:hover {
            background-color: #cc0000;
        }

        .add-quantity-button {
            background-color: #FB8F52;
            color: white;
            border: none;
            padding: 5px 5px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }

        .sub-quantity-button {
            background-color: #FB8F52;
            color: white;
            border: none;
            padding: 5px 7px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }

        .quantity-button:hover {
            background-color: #ff7f50;
        }

        .quantity-text {
            padding: 0 10px;
            font-size: 16px;
            font-weight: bold;
            color: #404040;
        }

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
            .container {
                padding: 10px;
            }

            .cart-container {
                width: 90vw;
                max-width: 350px;
            }

            .buttons {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>

    <script>
        function updateQuantity(orderDetailId, newQuantity, newOrderAmount) {
            document.getElementById("qty_" + orderDetailId).innerText = newQuantity;
            document.getElementById("orderAmount_" + orderDetailId).innerText = newOrderAmount.toFixed(2);
        }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="container">
        <div class="cart-container">
            <h1 class="text-title">Order Details</h1>

            <%-- Food Items --%>
            <asp:Panel ID="pnlCart" runat="server" Visible="false">
                <asp:Repeater ID="rptCartItems" runat="server">
                    <ItemTemplate>
                        <div class="cart-item-container">
                            <%-- Food Details --%>
                            <div class="item-details">
                                <h3><%# Eval("Food_Name") %></h3>
                                <p>Quantity: <%# Eval("Quantity") %></p>
                                <p>Order Amount: ₱<%# Eval("Order_Amount", "{0:N2}") %></p>    
                            </div>

                            <%-- Quantity --%>
                            <div class=" ">
                                <div class="controls">
                                    <asp:Button ID="btnSubtract" runat="server" Text="-" CssClass="sub-quantity-button"
                                        CommandArgument='<%# Eval("OrderDetail_ID") %>' OnClick="btnSubtract_Click" />

                                    <span class="quantity-text" id="qty_<%# Eval("OrderDetail_ID") %>">
                                        <%# Eval("Quantity") %>
                                    </span>

                                    <asp:Button ID="btnAdd" runat="server" Text="+" CssClass="add-quantity-button"
                                        CommandArgument='<%# Eval("OrderDetail_ID") %>' OnClick="btnAdd_Click" />
                                </div>

                                <%-- Remove Cart Items --%>
                                <asp:Button ID="btnDelete" runat="server" Text="Remove" CssClass="delete-button"
                                    CommandArgument='<%# Eval("OrderDetail_ID") %>' OnClick="btnDelete_Click" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </asp:Panel>

            <%-- If the cart is empty --%>
            <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false" CssClass="empty-cart">
                <p><strong>Kawawa ka naman,</strong></p>
                <asp:Image ID="CryingDuck" runat="server" CssClass="logoDuck" ImageUrl="~/images/CryingDuck.png" />
                <p><strong>Order ka muna!</strong></p>
            </asp:Panel>

            <%-- Order Summary --%>
            <h1 class="text-ordersummary">Order Summary</h1>

            <div class="text-summary">                
                <div class="summary-row">
                    <span>Total Amount:</span>
                    <span>₱<asp:Label ID="lblTotalAmount" runat="server"/></span>
                </div>
            </div>

            <%-- Buttons --%>
            <div class="buttons">
                <asp:Button ID="btnOrder" runat="server" Text="Order More" class="order-button" OnClick="btnOrder_Click" />
                <asp:Button ID="btnPayment" runat="server" Text="Proceed to Payment" class="payment-button" OnClick="btnPayment_Click" />
            </div>
        </div>
    </div>
    <%-- Background Image --%>
    <div class="background-duck"></div>
</asp:Content>