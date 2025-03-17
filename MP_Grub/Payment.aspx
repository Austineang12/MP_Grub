<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="MP_Grub.Payment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Payment Page</title>

    <%-- JAVASCRIPT FUNCTIONS --%>
    <script type="text/javascript">
        function showPopup() {
            const popup = document.getElementById('popup');
            popup.classList.add('active');
        }


        function closePopup() {
            const popup = document.getElementById('popup');
            popup.classList.remove('active');
            if (typeof __doPostBack === "function") {
                __doPostBack('btnClose', '');
            }
        }

    </script>

    <%-- PAYMENT STYLE --%>
    <style type="text/css">

        * {
            margin: 0;
            padding: 0;
            font-family: 'Bricolage Grotesque', sans-serif;
            letter-spacing: 0px;
            color: black;
        }

        section {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: black;
            scroll-snap-align: start;
            overflow: hidden;
            
        }

        h5 {
            margin: 25px 0 20px 0;
            font-weight: normal;
            letter-spacing: -1px;
            font-size: 16px;
        }

        h2{
            padding-left: 10%;
        }

        #receipt {
            margin-top: 10%;
        }

        /* CONTAINS THE MAIN SECTIONS */
        .paymentContainer {
            display: flex;
            flex-direction: column;
            align-items: center; 
        }


        /*SECTIONS*/
        .paymentFirst {
            background-color: white;
            height: 10vh;
            justify-content: flex-start;
            
            color: #ff5733;
            margin: 0;
        }

        .paymentSecond {
            height: auto;
            display: flex;
            flex-direction: row;
            gap: 10px;
            margin: 2% 0 5% 0;
            width: 80%;
            justify-self: center;
            justify-content: space-between;
            align-items: flex-start;
            overflow: visible;
            border-radius: 10px;
        }

            .paymentSecond .leftSide, .paymentSecond .rightSide {
                width: 50%;
                height: auto;
                display: flex;
                flex-direction: column;
                align-items: flex-start;
                padding: 0 0 4% 5%;
                justify-content: center;
                border-radius: 25px;
                overflow: visible;
            }

        /*INPUT FIELDS FOR CUSTOMER AND PAYMENT INFO*/
        .form-group {
            position: relative;
            width: 30vw;
            display: flex;
            align-items: flex-start;
            margin: 10px 0 0 0;
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

        #txtNote {
            height: 70px;
            padding-top: 42px;
            max-height: 150px;
            min-height: 70px;
            resize: vertical;
        }

        #ddlTransaction, #ddlBuilding, #ddlFloorNumber {
            height: 80px;
            padding-top: 40px;
            width: 100%;
            height: 56px;
            padding: 20px 16px 8px 16px;

        }


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

        #lblNote, #lblTransaction, #lblBuilding, #lblFloorNumber {
            font-size: 12px;
            top: 50%;
        }
        #lblNote{
            top: 20px;
            font-size: 12px;
        }

        .form-input:focus + .form-label,
        .form-input:not(:placeholder-shown) + .form-label {
            top: 30%;
            font-size: 8px;
        }






        /*ORDER SUMMARY*/
        .menu-group {
            width: 30vw;
            display: flex;
            flex-direction: row;
            align-items: center;
            margin: 10px 0;
            justify-content: space-between;
            gap: 5%;
            font-size: 18px;
            letter-spacing: -1px;
            font-weight: bold;
            border: 2px solid white;
            border-radius: 10px;
            padding: 2%;
        }

        .menu-picture {
            width: 15%;
            height: auto;
            border-radius: 10px;
        }

        .menu-name {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            justify-content: center;
            width: 100%;
        }

            .menu-name .menu-text {
                font-size: 16px;
                letter-spacing: -1px;
                white-space: normal;
                word-wrap: break-word;
                display: block;
                line-height: 1.5
            }

        .menu-label {
            letter-spacing: -1px;
        }


        /*SUBMIT AND CANCEL BUTTONS*/
        .submit-btn, .cancel-btn {
            width: 75%;
            height: 10vh;
            padding: 10px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            font-size: 14px;
            letter-spacing: 0px;
        }

            .submit-btn:hover {
                background: #174795;
            }

        .cancel-btn, #popCancel {
            background: white;
            color: black;
            border: 2px solid white;
            padding: 2px;
        }

            .cancel-btn:hover, #popCancel :hover {
                background: #c9c7c7;
                border: 0px;
            }

        #popCancel {
            border: 1px solid black;
        }

        .paymentButtons {
            width: calc(85% - 32px);
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 10px;
            margin: 15% 0 5% 0;
        }



        /*PRINTER RECEIPT*/
        .receiptSection {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            height: 50vh;
            width: 30vw;
            position: relative;
            overflow: visible;
            margin: 10% 0 2% 0;
        }

        .printer {
            width: 80%;
            height: 20vh;
            background: #333;
            border-radius: 15px;
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-top: 2vh;
        }

        .power-on {
            width: 2vw;
            height: 2vw;
            background: red;
            border-radius: 50%;
            position: absolute;
            top: 1vh;
            left: 1.5vw;
            box-shadow: 0px 0px 0.5vw rgba(255, 0, 0, 0.7);
        }

        .paper-out {
            width: 80%;
            height: 3vh; /* Adjust height responsively */
            background: black;
            border-radius: 10px;
            position: absolute;
            bottom: 10%;
        }

        .receipt {
            width: 75%;
            min-height: 30vh;
            height: auto; /* Adjust height based on viewport */
            background: white;
            position: absolute;
            top: calc(10% + 14.5vh);
            right: 3vw; /* Use vw for right positioning */
            border-top-left-radius: 5px;
            border-top-right-radius: 5px;
            box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.1);
            gap: 5px;
            justify-content: flex-start;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 0 5% 5% 5%;
            overflow: visible;
            overflow-y: auto;
        }

        .receiptLogo {
            width: 50%;
            height: 20%;
            margin-bottom: 1px; /*Pa-adjust based on size of pic*/
        }

        #grubLogo {
            width: 30%;
            height: 0%;
        }

        .receiptLine {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            align-items: flex-start;
            width: 100%;
            font-family: Helvetica, sans-serif !important;
            letter-spacing: -1px;
            font-size: clamp(1rem, 1vw, 1rem);
            /* Responsive font size */
            color: black;
        }

        .quantityPrice {
            margin-left: 10px;
            display: flex;
            justify-content: space-between;
            width: 35%;
        }

        .receiptFont {
            font-size: 16px;
            letter-spacing: -1px;
        }

        #totalLabel, #totalPrice {
            font-weight: bold;
            font-size: clamp(1rem, 2vw, 2rem);
            margin-top: 15px;
        }

        @media (max-width: 760px) {
            .paymentSecond {
                flex-direction: column;
                margin-bottom: 10%;
            }

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

            .receiptSection {
                width: 70vw;
            }

            .receipt {
                right: 7vw;
            }
        }


        /*POPUP STYLE NOTIFICATION*/
        .popup-container {
            display: flex;
            justify-content: center;
            align-items: center;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5); /* Transparent dark overlay */
            backdrop-filter: blur(8px); /* Adds a blur effect to the background */
            z-index: 999;
            visibility: hidden;
            opacity: 0;
            transition: visibility 0s, opacity 0.3s ease;
        }

        .popup-box {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            max-width: 400px;
            width: 100%;
        }

            .popup-box image {
                width: 50%;
                height: 20%;
                margin-bottom: 1px; /*Pa-adjust based on size of pic*/
            }

            .popup-container.active {
                visibility: visible;
                opacity: 1;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">

    <div class="paymentContainer">
    
        <section class="paymentFirst">
            <h2>Checkout</h2>
        </section>
        <section class="paymentSecond">
            <section class="leftSide">
                <h5>Customer Info</h5>

                <%--FULLNAME--%>
                <div class="form-group">
                    <asp:TextBox class="form-input" placeholder=" " type="text" id="txtFullName" runat="server" CausesValidation="True"></asp:TextBox>
                    <asp:Label for="form-input" class="form-label" runat="server">Full Name</asp:Label>
                </div>

                <%--CONTACT NUMBER--%>
                <div class="form-group">
                    <asp:TextBox class="form-input" placeholder=" " type="text" id="txtContactNo" runat="server"></asp:TextBox>
                    <asp:Label for="form-input" class="form-label" runat="server">Contact Number</asp:Label>
                </div>

                <%--BUILDING NAME--%>
                <div class="form-group">
                    <asp:DropDownList ID="ddlBuilding" runat="server" CssClass="form-input" placeholder=" " style="font-size: 16px;" onchange="updateLabel()">
                        <asp:ListItem Text="" Value="" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Rizal" Value="RIZAL BLDG"></asp:ListItem>
                        <asp:ListItem Text="Yuchengco" Value="YUCHENGCO BLDG"></asp:ListItem>
                        <asp:ListItem Text="Einstein" Value="EINSTEIN BLDG"></asp:ListItem>
                        <asp:ListItem Text="Basketball Court" Value="BASKETBALL COURT"></asp:ListItem>
                    </asp:DropDownList>
                    <label for="order" class="form-label" id="lblBuilding">Building Name</label>
                </div>

                <%--FLOOR NUMBER--%>
                <div class="form-group">
                    <asp:DropDownList ID="ddlFloorNumber" runat="server" CssClass="form-input" placeholder=" " style="font-size: 16px;" onchange="updateLabel()">
                        <asp:ListItem Text="" Value="" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="3" Value="3"></asp:ListItem>
                        <asp:ListItem Text="4" Value="4"></asp:ListItem>
                        <asp:ListItem Text="5" Value="5"></asp:ListItem>
                    </asp:DropDownList>
                    <label for="order" class="form-label" id="lblFloorNumber">Floor Number</label>
                </div>
                
                <%--ROOM NAME--%>
                <div class="form-group">
                    <asp:TextBox class="form-input" placeholder="" type="text" id="txtRoomNo" runat="server"></asp:TextBox>
                    <asp:Label for="form-input" class="form-label" runat="server">Room Name</asp:Label>
                </div>

                <%--NOTE FOR DELIVERY GUY--%>
                <div class="form-group">
                    <asp:TextBox ID="txtNote" runat="server" CssClass="form-input" TextMode="MultiLine"></asp:TextBox>
                    <asp:Label for="form-input" class="form-label" runat="server" ID="lblNote">Note</asp:Label>
                </div>


                <h5>Payment Info</h5>
                <%--TRANSACTION--%>
                <div class="form-group">
                    <asp:DropDownList ID="ddlTransaction" runat="server" CssClass="form-input" placeholder=" " style="font-size: 16px;" onchange="updateLabel()">
                        <asp:ListItem Text="COD" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Gcash" Value="2"></asp:ListItem>
                    </asp:DropDownList>
                    <label for="order" class="form-label" id="lblTransaction">Payment Mode</label>
                </div>

                
                <%--DISCOUNT--%>
                <div class="form-group">
                    <asp:TextBox class="form-input" placeholder=" " type="text" id="txtDiscount" runat="server"></asp:TextBox>
                    <asp:Label for="form-input" class="form-label" runat="server">Discount</asp:Label>
                </div>

                
                <%--SUBMIT AND CANCEL BUTTONS--%>
                <div class="paymentButtons">
                    <asp:Button ID="btnSubmit" runat="server" Text="Place Order" CssClass="submit-btn" onClientclick="showPopup(); return false;" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="cancel-btn" OnClick="btnCancel_Click" />
                </div>

            </section>


            <section class="rightSide">
                <h5>Order Summary</h5>

                <%--MENU ITEM--%>
                <div class="menu-group">
                    <asp:Image class="menu-picture" ID="foodImage1" runat="server" ImageUrl="~/images/Shawarma.jpg" />
                    <div class="menu-name">
                        <asp:Label ID="foodName1" runat="server" Text="Shawarma Rice" CssClass="menu-text"></asp:Label>
                        <asp:Label ID="foodStore1" runat="server" Text="Za-Wrap" CssClass="menu-text"></asp:Label>
                    </div>
                    <asp:Label ID="quantityFood1" runat="server" Text="x1" CssClass="menu-label"></asp:Label>
                </div>

                
                <div class="menu-group">
                    <asp:Image class="menu-picture" ID="foodImage2" runat="server" ImageUrl="~/images/Shawarma.jpg" />
                    <div class="menu-name">
                        <asp:Label ID="foodName2" runat="server" Text="Shawarma Rice" CssClass="menu-text"></asp:Label>
                        <asp:Label ID="foodStore2" runat="server" Text="Za-Wrap" CssClass="menu-text"></asp:Label>
                    </div>
                    <asp:Label ID="quantityFood2" runat="server" Text="x1" CssClass="menu-label"></asp:Label>
                </div>


                <%--RECEIPT--%>
                <section class="receiptSection">
                    <div class="printer">
                    <div class="power-on"></div>
                    <div class="paper-out"></div>
                    <div class="receipt">
                        <asp:Image id="receiptLogo" CssClass="receiptLogo" alt="Grub Logo" runat="server" ImageUrl="~/images/Grub Name.svg" />
                        <div class="receiptLine" id="tidewave">
                            <asp:Label ID="nameItem" runat="server" Text="Shawarma Rice" CssClass="receiptFont"></asp:Label>
                            <div class="quantityPrice">
                                <asp:Label CssClass="receiptFont" ID="quantityItem" runat="server" Text="x2"></asp:Label>
                                <asp:Label CssClass="receiptFont" ID="priceItem" runat="server" Text="₱250"></asp:Label>
                            </div>
                        </div>

                        <%--TRANSACTION TYPE--%>
                        <div class="receiptLine" >
                            <asp:Label id="transactionLabel" runat="server" Text="Transaction" CssClass="receiptFont"></asp:Label>
                            <asp:Label CssClass="receiptFont" ID="transactionType" runat="server" Text="--"></asp:Label>
                        </div>
                        
                        <%--TOTAL BILL--%>
                        <div class="receiptLine" >
                            <asp:Label id="totalLabel" runat="server" Text="Total" CssClass="receiptFont"></asp:Label>
                            <asp:Label CssClass="receiptFont" ID="totalPrice" runat="server" Text="₱250"></asp:Label>
                        </div>
                    </div>
                </div>
                </section>

            </section>
        </section>

        <%--POPUP STYLE NOTIFICATION--%>
        <div class="popup-container" id="popup">
            <div class="popup-box">
                <asp:Image class="receiptLogo" id="grubLogo" alt="Grub Logo" runat="server" ImageUrl="~/images/Grub Name.svg" />
                <p>Your order is now being processed.<br />Thank you for grubbing with us :)</p>
                <br /><br />
                <asp:Button ID="cancelPop" runat="server" Text="Close" class="cancel-btn" OnClick="btnClose_Click" />
            </div>
        </div>

    </div>

</asp:Content>
