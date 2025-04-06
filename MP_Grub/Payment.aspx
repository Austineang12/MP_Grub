<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="MP_Grub.Payment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Payment Page</title>
    <style>
        body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .payment-container {
            font-family: 'Akshar', sans-serif;
            background-color: white;
            border-radius: 10px;
            width: 480px;
            z-index: 5;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            transition: 0.3s ease-in-out, color 0.3s ease-in-out; 
        }

        .text-payment {
            font-size: 30px;
            color: #404040;
            margin-left: 30px;
        }

        .text-info {
            font-size: 20px;
            color: #404040;
            margin-left: 30px;
            margin-bottom: 5px;
        }

        .payment-info {
            background-color: lightgrey;
            padding: 30px;
            max-width: 100%;
            box-shadow: inset 0px 4px 8px rgba(0, 0, 0, 0.2);
        }

        .form-label {
            font-weight: 500;
            font-size: 18px;
            color: #707070;
            line-height: 1;
        }

        .form-input {
            font-size: 16px;
            font-weight: 600;
            color: #404040;
            border-radius: 10px;
            border: none;
            margin-bottom: 5px;
            padding: 3px 10px;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 3px;
        }

        .order-summary {
            display: flex;
            font-weight: bold;
            justify-content: space-between;
            font-size: 18px;
            font-weight: 600;
            color: #404040;
            margin: 0 30px;
            margin-top: 15px;
        }

        .payment-buttons {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
            margin-bottom: 30px;
        }

        .cancel-btn {
            font-weight: 700;
            background-color: white;
            align-items: center;
            color: #404040;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 1rem;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
        }
        .cancel-btn:hover {
            background-color: #F2F2F2;
        }

        .submit-btn {
            font-weight: 700;
            background-color: #FB8F52;
            align-items: center;
            color: #404040;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 1rem;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
        }
        .submit-btn:hover {
            background-color: #E07E48;
        }


        /*-- Background Image --*/
        .background-duck {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            background-image: url('/images/Payment_Duckbg1.png');
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

            .payment-container {
                width: 400px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="payment-container">
        <h1 class="text-payment">Checkout</h1>

        <div class="info-container">
            <h1 class="text-info">Customer Info</h1>
            <div class="payment-info">

                <%-- Full Name (ReadOnly) --%>
                <div class="form-group">
                    <asp:Label ID="lblFullName" runat="server" CssClass="form-label">Full Name</asp:Label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-input" ReadOnly="True" placeholder=" "></asp:TextBox>
                </div>

                <%-- Contact Number (ReadOnly) --%>
                <div class="form-group">
                    <asp:Label ID="lblContactNo" runat="server" CssClass="form-label">Contact Number</asp:Label>
                    <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-input" placeholder=" "></asp:TextBox>
                </div>

                <%-- Address (Editable) --%>
                <div class="form-group">
                    <asp:Label ID="lblAddress" runat="server" CssClass="form-label">Address</asp:Label>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-input" placeholder=" "></asp:TextBox>
                </div>

                <%-- Voucher Dropdown --%>
                <div class="form-group">
                    <asp:Label ID="lblVoucher" runat="server" CssClass="form-label">Voucher</asp:Label>
                    <asp:DropDownList ID="ddlVoucher" runat="server" CssClass="form-input" AutoPostBack="True" OnSelectedIndexChanged="ddlVoucher_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>

                <%-- Payment Type Dropdown --%>
                <div class="form-group">
                    <asp:Label ID="lblTransaction" runat="server" AssociatedControlID="ddlTransaction" CssClass="form-label">Payment Type</asp:Label>
                    <asp:DropDownList ID="ddlTransaction" runat="server" CssClass="form-input">
                        <asp:ListItem Text="Cash" Value="COD" />
                        <asp:ListItem Text="Card" Value="Card" />
                    </asp:DropDownList>
                </div>
            </div>



            <%-- Total Price (ReadOnly) --%>
            <div class="order-summary">
                <span>Total Price:</span>
                <span>₱<asp:Label ID="lblTotalPrice" runat="server" CssClass="form-label" /></span>
            </div>

            <%-- Final Price After Discount (ReadOnly) --%>
            <div class="order-summary">
                <span>Final Price:</span>
                <span>₱<asp:Label ID="lblFinalPrice" runat="server" CssClass="form-label" /></span>
            </div>

            <%-- Submit and Cancel Buttons --%>
            <div class="payment-buttons">
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="cancel-btn" OnClick="btnCancel_Click" />
                <asp:Button ID="btnSubmit" runat="server" Text="Check Out" CssClass="submit-btn" OnClick="btnSubmit_Click" />
            </div>
        </div>
    </div>
    <%-- Background Image --%>
    <div class="background-duck"></div>
</asp:Content>
