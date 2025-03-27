<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="MP_Grub.EditProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f9f9f9;
            font-family: Arial, sans-serif;
            padding-top: 200px;
        }

        .edit-container {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            width: 400px;
            text-align: center;
        }

        .edit-container h2 {
            margin-bottom: 15px;
            color: #333;
            font-size: 22px;
        }

        .input-group {
            text-align: left;
            margin-bottom: 12px;
        }

        .input-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #222;
        }

        .input-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        .btn-container {
            margin-top: 15px;
        }

        .btn {
            width: 100%;
            padding: 12px;
            margin: 5px 0;
            font-size: 16px;
            font-weight: bold;
            background-color: #FB8F52;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn:hover {
            background-color: #e07a42;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="edit-container">
        <h2>Edit Profile</h2>
        
        <div class="input-group">
            <label for="username">Username</label>
            <asp:TextBox ID="username" runat="server" CssClass="input-field"></asp:TextBox>
        </div>
        
        <div class="input-group">
            <label for="fullName">Full Name</label>
            <asp:TextBox ID="fullName" runat="server" CssClass="input-field"></asp:TextBox>
        </div>
        
        <div class="input-group">
            <label for="birthdate">Birthdate</label>
            <asp:TextBox ID="birthdate" runat="server" CssClass="input-field" TextMode="Date"></asp:TextBox>
        </div>
        
        <div class="input-group">
            <label for="contact">Contact Info</label>
            <asp:TextBox ID="contact" runat="server" CssClass="input-field"></asp:TextBox>
        </div>
        
        <div class="input-group">
            <label for="address">Address</label>
            <asp:TextBox ID="address" runat="server" CssClass="input-field"></asp:TextBox>
        </div>
        
        <div class="btn-container">
            <asp:Button ID="saveBtn" runat="server" Text="Save Changes" CssClass="btn" OnClick="SaveProfile" />
        </div>
    </div>
</asp:Content>