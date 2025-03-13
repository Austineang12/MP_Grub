<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="MP_Grub.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f5f5f5;
        }
        .profile-box {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 300px;
        }
        .info {
            text-align: left;
            margin-bottom: 10px;
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
    <div class="profile-box">
        <h2>Profile</h2>
        <div class="info">
            <p><strong>User ID:</strong> 12345</p>
            <p><strong>Username:</strong> user123</p>
            <p><strong>Password:</strong> ******</p>
            <p><strong>Full Name:</strong> John Doe</p>
            <p><strong>Birthdate:</strong> 01/01/2000</p>
            <p><strong>Contact Info:</strong> 09123456789</p>
            <p><strong>Address:</strong> 123 Street, City</p>
            <p><strong>Preference ID:</strong> 67890</p>
        </div>
        <asp:Button ID="editProfileBtn" runat="server" Text="Edit Profile" CssClass="btn" OnClick="EditProfileRedirect"/>
        <asp:Button ID="goHome" runat="server" Text="Done" CssClass="btn" OnClick="GoToHome" />
    </div>
</asp:Content>