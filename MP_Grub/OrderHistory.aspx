<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="MP_Grub.OrderHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Order History</title>
    <style>
        body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .profile-background {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            object-fit: cover;
        }

        .table-history {
            font-family: 'Akshar', sans-serif;
            max-width: 1000px;
            background-color: white;
            border-radius: 10px;
            box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.1), 0 2px 10px rgba(0, 0, 0, 0.2);
            overflow-x: auto;
            z-index: 5;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 10px;
        }

        th, td {
            padding: 16px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #404040;
            color: white;
            font-size: 30px;
        }

        td {
            font-size: 20px;
            color: #404040;
        }

        tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="table-history">
        <table>
            <thead>
                <tr>
                    <th>Transaction ID</th>
                    <th>Payment Type</th>
                    <th>Voucher Used</th>
                    <th>Total Amount</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptOrderHistory" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("Transaction_ID") %></td>
                            <td><%# Eval("Payment_Type") %></td>
                            <td><%# Eval("Discount_Value") == DBNull.Value || Convert.ToDecimal(Eval("Discount_Value")) == 0 ? "None" : Eval("Discount_Value") + "%" %></td>
                            <td>₱<%# Eval("Final_Price", "{0:N2}") %></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>

    <%-- Background image --%>
    <div>
        <asp:Image ID="bgimage" runat="server" CssClass="profile-background" ImageUrl="~/images/Profile-bg5.png" />
    </div>
</asp:Content>

