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
            position: absolute;
            top: 10vh;
            height: 100vh;
            padding-top: 90px;
        }

        .voucher-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 120px);
            margin-top: 0;
            z-index: 5;
        }

        .voucher-label {
            color: #bf4636;
            font-weight: bold;
            font-size: 20px;
        }

        .voucher-box {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 360px;
            height: 450px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
        }

        .voucher-header {
            color: #404040;
            font-size: 25px;
        }

        .voucher-image {
            max-width: 100%;
            max-height: 200px;
            object-fit: contain;
        }

        .btn-generate {
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

        .btn-generate:hover {
            background-color: #E07E48;
        }

        #lblMessage {
            margin-top: 15px;
            font-size: 14px;
            font-weight: bold;
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
    <div class="voucher-container">
        <div class="voucher-box">
            <h2 class="voucher-header">Claim Today's Voucher</h2>
            <asp:Image ID="VoucherImage" runat="server" CssClass="voucher-image" ImageUrl="~/images/default.png" />
            <asp:Button ID="GenerateVoucherBtn" runat="server" CssClass="btn-generate" Text="Claim" OnClick="GenerateVoucher" />
            <asp:Label ID="lblMessage" runat="server" CssClass="voucher-label"></asp:Label>
        </div>
    </div>
    <div>
        <asp:Image ID="bgimage" runat="server" CssClass="profile-background" ImageUrl="~/images/Profile-bg5.png" />
    </div>
</asp:Content>

