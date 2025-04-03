<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="BookmarkedItems.aspx.cs" Inherits="MP_Grub.BookmarkedItems" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Bookmark</title>
    <link rel="stylesheet" href="styles.css" />
    <style type="text/css">
        .bookmarkPopup {
            /* Sample only */
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
            height: 80vh;
            width: 50vw;
            display: flex;
            flex-direction: column;
            position: relative; 
            border-radius: 10px;
        }

        .bookmarkContent {
            height: 95%;
            z-index: 2;
            margin-bottom: -20px; /* Negative margin to overlap with the red part */
            position: relative;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            gap: 10px;
            row-gap: 20px;
            
        }

        .optionButtons {
            background: #f0eeed;
            height: 30%;
            border-radius: 20px 20px 0 0;
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10%;
        }
        .optionBtn{
            background: #fff;
            height: 80px;
            width: 200px;
            font-weight: bold;
            font-size: 16px;
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
        

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="bookmarkPopup">
        <%-- BOOKMARK ITEMS --%>
        <div class="bookmarkContent">
            <div class="item">
                <asp:Label class="foodName" runat="server" Text="Shawarma Rice"></asp:Label>
                <asp:Label class="foodStore" runat="server" Text="Za-wrap"></asp:Label>

                <%-- HOVER HIDDEN BUTTONS --%>
                <div class="hiddenHover">
                    <asp:Button CssClass="removeBtn" ID="removeBtn" runat="server" Text="Remove" />
                    <div class="quantityContainer">
                        <input class="quantityButtonMinus" type="button" value="-" />
                        <asp:Label ID="quantityLbl" runat="server" Text="0"></asp:Label>
                        <input class="quantityButtonPlus" type="button" value="+" />
                    </div>
                </div>

            </div>

            

            <div class="item">
                <asp:Label class="foodName" runat="server" Text="Shawarma Rice"></asp:Label>
                <asp:Label class="foodStore" runat="server" Text="Za-wrap"></asp:Label>

                <%-- HOVER HIDDEN BUTTONS --%>
                <div class="hiddenHover">
                    <asp:Button CssClass="removeBtn" ID="Button1" runat="server" Text="Remove" />
                    <div class="quantityContainer">
                        <input class="quantityButtonMinus" type="button" value="-" />
                        <asp:Label ID="Label1" runat="server" Text="0"></asp:Label>
                        <input class="quantityButtonPlus" type="button" value="+" />
                    </div>
                </div>
            </div>

            
        </div>

        

        <%-- CANCEL/CHECKOUT BUTTONS --%>
        <div class="optionButtons">
            <input class="optionBtn" id="SelectBtn" type="button" value="Select"/>
            <input class="optionBtn" id="CheckoutBtn" type="button" value="Checkout All" />
        </div>
    </div>
</asp:Content>
