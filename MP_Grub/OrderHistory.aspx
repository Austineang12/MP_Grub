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
                    <th>Date</th>
                    <th>Restaurant</th>
                    <th>Total Price</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%-- Example row (You can replace these with a repeater or data binding later) --%>
                <tr>
                    <td>#10023</td>
                    <td>2025-04-03</td>
                    <td>Grub Grill</td>
                    <td>₱450.00</td>
                    <td>Delivered</td>
                </tr>
                <tr>
                    <td>#10022</td>
                    <td>2025-03-28</td>
                    <td>Pizza Spot</td>
                    <td>₱320.00</td>
                    <td>Cancelled</td>
                </tr>
            </tbody>
        </table>
    </div>

    <%-- Background image --%>
    <div>
        <asp:Image ID="bgimage" runat="server" CssClass="profile-background" ImageUrl="~/images/Profile-bg5.png" />
    </div>
</asp:Content>

