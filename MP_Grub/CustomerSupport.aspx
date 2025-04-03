<%@ Page Title="Customer Support" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="CustomerSupport.aspx.cs" Inherits="MP_Grub.CustomerSupport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: absolute;
            top: 10vh;
            height: 100vh;
            background-color: #f9f9f9;
            font-family: Arial, sans-serif;
            padding-top: 90px;
        }

        .container {
            background: white;
            padding: 25px 70px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 350px;
            z-index: 5;
            gap: 15px;
        }

        .container h2 {
            margin-bottom: 15px;
            color: #333;
            font-size: 20px;
        }

        .container label {
            margin-bottom: 15px;
            color: #333;
            font-size: 18px;
        }

        .dropdown {
            font-size: 16px;
            width: 20vw;
            padding: 10px;
            margin: 10px 0;
            border-radius: 10px;
            border: 1px solid #ddd;
        }

        .btn-container {
            margin-top: 15px;
        }

        .btn {
            font-family: 'Akshar', sans-serif;
            font-weight: 700;
            background-color: #FB8F52;
            align-items: center;
            color: #404040;
            border: none;
            padding: 12px 30px;
            border-radius: 20px;
            cursor: pointer;
            margin-top: 20px;
            font-size: 1rem;
            width: 20vw;
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
        }

        .btn:hover {
            background-color: #E07E48;
        }

        .profile-background {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            object-fit: cover;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="container">
        <h2>Customer Support</h2>      

        <label for="issueDropdown">Select an Issue</label>
        <asp:DropDownList ID="issueDropdown" runat="server" CssClass="dropdown">
            <asp:ListItem Text="Order Issue" Value="Order" />
            <asp:ListItem Text="Payment Issue" Value="Payment" />
            <asp:ListItem Text="Delivery Issue" Value="Delivery" />
            <asp:ListItem Text="Other" Value="Other" />
        </asp:DropDownList>

        <div class="btn-container">
            <asp:Button ID="continuebtn" runat="server" Text="Continue" CssClass="btn" OnClick="ContinueToDetails" />
            <asp:Button ID="cancelbtn" runat="server" Text="Cancel" CssClass="btn" OnClick="CancelProcess" />
        </div>
    </div>
    <div>
        <asp:Image ID="bgimage" runat="server" CssClass="profile-background" ImageUrl="~/images/Profile-bg5.png" />
    </div>
</asp:Content>

