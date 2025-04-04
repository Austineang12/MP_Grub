<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="MP_Grub.Payment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Payment Page</title>

    
    <%-- PAYMENT STYLE --%>
    <style type="text/css">


        /*section {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: black;
            scroll-snap-align: start;
            overflow: hidden;
            
        }*/

        h5 {
            font-weight: normal;
            font-size: 16px;
            color: #404040;
            font-size: 25px;
            align-items: center;
        }

        h3{
            align-items: center;
        }


        /* CONTAINS THE MAIN SECTIONS */
        .paymentContainer {
            display: flex;
            margin-top: 10vh;
            flex-direction: column;
            align-items: center;
            z-index: 5;
            /*max-width: 500px;*/
            width: 500px;
            /*height: 400px;*/
            background-color: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease-in-out;
        }


        /*SECTIONS*/
        .paymentFirst {
            color: #404040;
            font-size: 25px;
            align-items: center;
        }

        .paymentSecond {
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center; 
        }

        .paymentSecond .leftSide {
            width: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            border-radius: 25px;
            /*overflow: visible;*/
        }

        /*INPUT FIELDS FOR CUSTOMER AND PAYMENT INFO*/
        /* Common Form Group */
        .form-group {
            position: relative;
            width: 100%;
            display: flex;
            align-items: flex-start;
        }

        .leftSide .form-input {
            border: 2px solid #b5b3b3;
            border-radius: 5px;
            padding: 25px 16px 8px 16px;
            width: calc(100% - 32px);
            height: 5px;
            font-weight: 600;
            letter-spacing: 0px;
            text-transform: uppercase;
        }

        /*#txtNote {
            height: 70px;
            padding-top: 42px;
            max-height: 150px;
            min-height: 70px;
            resize: vertical;
        }*/

        /* Adjusted for Dropdowns - Floating Label Effect */
        #ddlTransaction, #ddlBuilding, #ddlFloorNumber {
            height: 70px;
            padding: 20px 16px 8px 16px;
            width: 100%;
            border: 2px solid #b5b3b3;
            border-radius: 5px;
            font-weight: 600;
            letter-spacing: 0px;
            background-color: white;
            appearance: none; /* Removes default arrow in some browsers */
            cursor: pointer;
        }

        /* Optional: Custom dropdown arrow */
        #ddlTransaction, #ddlBuilding, #ddlFloorNumber {
            background-image: url('data:image/svg+xml;utf8,<svg fill="%23b5b3b3" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/></svg>');
            background-repeat: no-repeat;
            background-position: right 16px center;
            background-size: 16px;
        }

        /* Floating Label Styling */
        .leftSide .form-label {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            left: 16px;
            pointer-events: none;
            transition: all .1s ease-in-out;
            font-size: 12px;
            color: #b5b3b3;
            letter-spacing: 0.1px;
            font-weight: 400;
        }

        /* Ensure proper label positioning for specific labels */
        #lblNote, #lblTransaction, #lblBuilding, #lblFloorNumber {
            font-size: 12px;
            top: 50%;
        }
        #lblNote {
            top: 20px;
            font-size: 12px;
        }

        /* Floating Label for Input Fields */
        .form-input:focus + .form-label,
        .form-input:not(:placeholder-shown) + .form-label {
            top: 30%;
            font-size: 8px;
        }

        /* Floating Label for Dropdowns */
        #ddlTransaction:focus + .form-label,
        #ddlTransaction:not([value=""]) + .form-label,
        #ddlBuilding:focus + .form-label,
        #ddlBuilding:not([value=""]) + .form-label,
        #ddlFloorNumber:focus + .form-label,
        #ddlFloorNumber:not([value=""]) + .form-label {
            top: 30%;
            font-size: 8px;
        }

        .submit-btn {
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
            display: block;
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
        }

        .submit-btn:hover {
            background-color: #E07E48;
        }

        .cancel-btn {
            font-family: 'Akshar', sans-serif;
            font-weight: 700;
            background-color: white;
            align-items: center;
            color: #404040;
            border: none;
            padding: 12px 30px;
            border-radius: 20px;
            cursor: pointer;
            margin-top: 10px;
            font-size: 1rem;
            display: block;
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }

        .cancel-btn:hover {
            background-color: #F2F2F2;
        }


        .paymentButtons {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        /*@media (max-width: 760px) {
            .paymentSecond {*/
                /*flex-direction: column;*/
                /*margin-bottom: 10%;*/
            /*}

            .form-group {
                width: 75vw;
            }

            .paymentButtons {
                width: 68vw;
                margin: 35% 0 2% 0;
            }

            .menu-group {
                width: 68vw;
            }
        }*/


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
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">

    <div class="paymentContainer">

        <div class="paymentFirst">
            <h3>Checkout</h3>
        </div>

        <section class="paymentSecond">
            <section class="leftSide">

                <h5>Customer Info</h5>

                <%-- Full Name (ReadOnly) --%>
                <div class="form-group">
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-input" ReadOnly="True" placeholder=" "></asp:TextBox>
                    <asp:Label ID="lblFullName" runat="server" AssociatedControlID="txtFullName" CssClass="form-label">Full Name</asp:Label>
                </div>

                <%-- Contact Number (ReadOnly) --%>
                <div class="form-group">
                    <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-input" ReadOnly="True" placeholder=" "></asp:TextBox>
                    <asp:Label ID="lblContactNo" runat="server" AssociatedControlID="txtContactNo" CssClass="form-label">Contact Number</asp:Label>
                </div>

                <%-- Address (Editable) --%>
                <div class="form-group">
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-input" placeholder=" "></asp:TextBox>
                    <asp:Label ID="lblAddress" runat="server" AssociatedControlID="txtAddress" CssClass="form-label">Address</asp:Label>
                </div>

                <%-- Voucher Dropdown --%>
                <div class="form-group">
                    <asp:DropDownList ID="ddlVoucher" runat="server" CssClass="form-input" AutoPostBack="True" OnSelectedIndexChanged="ddlVoucher_SelectedIndexChanged">
                    </asp:DropDownList>

                    <asp:Label ID="lblVoucher" runat="server" AssociatedControlID="ddlVoucher" CssClass="form-label">Voucher</asp:Label>
                </div>

                <%-- Payment Type Dropdown --%>
                <div class="form-group">
                    <asp:DropDownList ID="ddlTransaction" runat="server" CssClass="form-input">
                        <asp:ListItem Text="Cash" Value="Cash" />
                        <asp:ListItem Text="Card" Value="Card" />
                    </asp:DropDownList>
                    <asp:Label ID="lblTransaction" runat="server" AssociatedControlID="ddlTransaction" CssClass="form-label">Payment Type</asp:Label>
                </div>

                <%-- Total Price (ReadOnly) --%>
                <div class="form-group">
                    <asp:TextBox ID="txtTotalPrice" runat="server" CssClass="form-input" ReadOnly="True" placeholder=" "></asp:TextBox>
                    <asp:Label ID="lblTotalPrice" runat="server" AssociatedControlID="txtTotalPrice" CssClass="form-label">Total Price</asp:Label>
                </div>

                <%-- Final Price After Discount (ReadOnly) --%>
                <div class="form-group">
                    <asp:TextBox ID="txtFinalPrice" runat="server" CssClass="form-input" ReadOnly="True" placeholder=" "></asp:TextBox>
                    <asp:Label ID="lblFinalPrice" runat="server" AssociatedControlID="txtFinalPrice" CssClass="form-label">Final Price</asp:Label>
                </div>

                <%-- Submit and Cancel Buttons --%>
                <div class="paymentButtons">
                    <asp:Button ID="btnSubmit" runat="server" Text="Place Order" CssClass="submit-btn" OnClick="btnSubmit_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="cancel-btn" OnClick="btnCancel_Click" />
                </div>

            </section>
        </section>
    </div>
    <%-- Background Image --%>
    <div class="background-duck"></div>
</asp:Content>
