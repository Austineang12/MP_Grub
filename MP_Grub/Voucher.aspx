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

        .voucher-box {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 320px;
            height: 380px; 
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .voucher-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 120px); /* Adjusted spacing to prevent overlap */
            margin-top: 0; /* Reset margin-top */
            padding-top: 150px; /* Adjust this value as needed */
        }

        .voucher-image {
            width: 100%;
            height: 150px; /* Keep image height constant */
            object-fit: contain; /* Prevents stretching */
            display: block;
        }
        .voucher-header{
            color: #404040;
            margin-bottom: 15px;
        }

        .btn-generate {
            width: 100%;
            padding: 10px;
            background-color: #FB8F52;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .btn-generate:hover {
            background-color: #E6783B;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="voucher-container">
        <div class="voucher-box">
            <h2 class="voucher-header">Claim Today's Voucher</h2>
            <asp:Image ID="VoucherImage" runat="server" CssClass="voucher-image" ImageUrl="~/images/default.png" />
            <asp:Button ID="GenerateVoucherBtn" runat="server" CssClass="btn-generate" Text="Claim" OnClick="GenerateVoucher" />
        </div>
    </div>
</asp:Content>

