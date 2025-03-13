<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="MP_Grub.Payment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Payment Page</title>
    <link rel="stylesheet" type="text/css" href="payment-style.css" />
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">

    
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

</asp:Content>
