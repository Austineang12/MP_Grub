<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="MP_Grub.EditProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f5f5f5;
        }
        .edit-box {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 300px;
        }
        .input-field {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            background-color: #FB8F52;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="edit-box">
        <h2>Edit Profile</h2>

        <label for="username">Username</label>
        <asp:TextBox ID="username" runat="server" CssClass="input-field"></asp:TextBox>

        <label for="password">Password</label>
        <asp:TextBox ID="password" runat="server" CssClass="input-field" TextMode="Password"></asp:TextBox>

        <label for="confirmPassword">Confirm Password</label>
        <asp:TextBox ID="confirmPassword" runat="server" CssClass="input-field" TextMode="Password"></asp:TextBox>

        <label for="fullName">Full Name</label>
        <asp:TextBox ID="fullName" runat="server" CssClass="input-field"></asp:TextBox>

        <label for="birthdate">Birthdate</label>
        <asp:TextBox ID="birthdate" runat="server" CssClass="input-field" TextMode="Date"></asp:TextBox>

        <label for="contact">Contact Info</label>
        <asp:TextBox ID="contact" runat="server" CssClass="input-field"></asp:TextBox>

        <label for="address">Address</label>
        <asp:TextBox ID="address" runat="server" CssClass="input-field"></asp:TextBox>

        <asp:Button ID="saveBtn" runat="server" Text="Save Changes" CssClass="btn" OnClick="SaveProfileValidation"/>
    </div>
</asp:Content>