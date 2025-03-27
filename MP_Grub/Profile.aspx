<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="MP_Grub.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f9f9f9;
            font-family: Arial, sans-serif;
            padding-top: 80px;
        }

        .profile-container {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            width: 380px;
            text-align: center;
        }

        .profile-container h2 {
            margin-bottom: 15px;
            color: #333;
            font-size: 22px;
        }

        .profile-info {
            text-align: left;
            padding: 10px 0;
        }

        .profile-info p {
            margin: 8px 0;
            font-size: 16px;
            color: #555;
        }

        .profile-info strong {
            color: #222;
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


        .error-message {
            color: red;
            font-size: 14px;
            margin-bottom: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="profile-container">
        <h2>User Profile</h2>
        
        <asp:Label ID="lblErrorMessage" runat="server" CssClass="error-message" />

        <div class="profile-info">
            <p><strong>Username:</strong> <asp:Label ID="lblUsername" runat="server" /></p>
            <p><strong>Full Name:</strong> <asp:Label ID="lblFullName" runat="server" /></p>
            <p><strong>Birthdate:</strong> <asp:Label ID="lblBirthdate" runat="server" /></p>
            <p><strong>Contact Info:</strong> <asp:Label ID="lblContactInfo" runat="server" /></p>
            <p><strong>Address:</strong> <asp:Label ID="lblAddress" runat="server" /></p>
        </div>


        <div class="btn-container">
            <asp:Button ID="editProfileBtn" runat="server" Text="Edit Profile" CssClass="btn" OnClick="EditProfileRedirect"/>
            <asp:Button ID="goHome" runat="server" Text="Done" CssClass="btn" OnClick="GoToHome" />
        </div>
    </div>
</asp:Content>
