<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Voucher.aspx.cs" Inherits="MP_Grub.Voucher" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Generate Voucher</title>
    <style>
        body {
    font-family: 'Akshar', sans-serif;
    background: url('images/BGPicture.png') no-repeat center center fixed;
    background-size: cover;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
    }

    .voucher-container {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: calc(100vh - 120px);
        margin-top: 0;
        padding-top: 150px;
    }

    .voucher-box {
        background: white;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        text-align: center;
        width: 360px; /* Increased width */
        height: 450px; /* Adjusted height for better spacing */
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        align-items: center;
    }

    .voucher-header {
        color: #404040;
        margin-bottom: 15px;
    }

    .voucher-image {
        max-width: 100%;
        max-height: 200px; /* Adjusted to fit better */
        object-fit: contain;
    }

    .btn-generate {
        width: 100%;
        padding: 12px;
        background-color: #FB8F52;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        margin-top: 10px;
    }

    .btn-generate:hover {
        background-color: #E6783B;
    }

    #lblMessage {
        margin-top: 15px;
        font-size: 8px;
        font-weight: bold;
    }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="voucher-container">
        <div class="voucher-box">
            <h2 class="voucher-header">Claim Today's Voucher</h2>
            <asp:Image ID="VoucherImage" runat="server" CssClass="voucher-image" ImageUrl="~/images/default.png" />
            <asp:Button ID="GenerateVoucherBtn" runat="server" CssClass="btn-generate" Text="Claim" OnClick="GenerateVoucher" />
            <asp:Label ID="lblMessage" runat="server" ForeColor="#bf4636"></asp:Label>

        </div>
    </div>
</asp:Content>

