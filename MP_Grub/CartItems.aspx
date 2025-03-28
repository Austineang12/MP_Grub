<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="CartItems.aspx.cs" Inherits="MP_Grub.CartItems" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .container {
            display: flex;
            justify-content: flex-end;
            padding: 50px;
        }

        .cart-container {
            width: 30vw;
            background-color: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
        }

        .item-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .item-details {
            flex: 1;
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
            font-size: 18px;
            font-weight: bold;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .payment-button {
            font-size: 18px;
            font-weight: bold;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s;
            background-color: #FB8F52;
        }

        .order-button:hover {
            background-color: #c0c0c0;
        }

        .payment-button:hover {
            background-color: #ff7f50;
        }

        .buttons {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 30px
        }

        /*.voucher-container {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }*/

        .voucher-input {
            width: 100%;
            padding: 8px;
            border-radius: 8px;
            border: 1px solid #ccc;
            background-color: #fff;
            font-size: 16px;
            color: dimgray;
            appearance: none;
        }

        /*.voucher-input:focus {
            border-color: #ff7f50;
            outline: none;
            box-shadow: 0 0 5px rgba(255, 127, 80, 0.5);
        }*/

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="container">
        <div class="cart-container">
            <h1 class="text-title">Order Details</h1>

            <%-- Food Items --%>
            <asp:Panel ID="pnlCart" runat="server">
                <asp:Repeater ID="rptCartItems" runat="server">
                    <ItemTemplate>
                        <div class="item-container">
                            <div class="item-details">
                                <strong><%# Eval("Restaurant_Name") %></strong> - <%# Eval("Food_Name") %> - ₱<%# Eval("Food_Price") %>
                            </div>
                            <div class="controls">
                                <asp:Button ID="btnSubtract" runat="server" Text="-" CommandArgument='<%# Eval("Food_ID") %>' OnClick="btnSubtract_Click" />
                                <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("Order_Quantity") %>'></asp:Label>
                                <asp:Button ID="btnAdd" runat="server" Text="+" CommandArgument='<%# Eval("Food_ID") %>' OnClick="btnAdd_Click" />
                                <%--<asp:Button ID="btnCancel" runat="server" Text="Cancel" CommandArgument='<%# Eval("Food_ID") %>' OnClick="btnCancel_Click" />--%>
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

            <%-- Voucher Section --%>
            <div class="voucher-container">
                <asp:DropDownList ID="Voucher_Dropdown" runat="server" CssClass="voucher-input"></asp:DropDownList>
            </div>

            <%-- Order Summary --%>
            <h1 class="text-ordersummary">Order Summary</h1>

            <div class="text-summary">
                <div class="summary-row">
                    <span>Order Fee:</span>
                    <span>₱<asp:Label ID="lblOrderFee" runat="server" /></span>
                </div>
                <div class="summary-row">
                    <span>Delivery Fee:</span>
                    <span>₱<asp:Label ID="lblDeliveryFee" runat="server" /></span>
                </div>
                <div class="summary-row">
                    <span>Discounts:</span>
                    <span>-₱<asp:Label ID="lblDiscountValue" runat="server" /></span>
                </div>
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
</asp:Content>