<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="MP_Grub.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            position: absolute;
            top: 10vh;
            height: 100vh;
            background-color: #404040;
            font-family: Arial, sans-serif;
            padding-top: 90px;
        }

        .profile-container {
            background-color: white;
            padding: 30px 70px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            width: 480px;
            text-align: center;
            color: white;
            z-index: 5;
        }

        .profile-container h2 {
            font-family: 'Akshar', sans-serif;
            font-weight: 700;
            margin-bottom: 15px;
            color: #333;
            font-size: 20px;
        }

        .profile-info {
            text-align: left;
            padding: 10px 0;
        }

        .profile-list {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        .profile-list li {
            font-size: 16px;
            font-weight: bold;
            color: #404040;
            margin-bottom: 8px;
            display: flex;
            justify-content: space-between;
        }

        .profile-list .label {
            font-weight: bold;
            color: #222;
            min-width: 100px;
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


        .error-message {
            color: red;
            font-size: 14px;
            margin-bottom: 10px;
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
    <div class="profile-container">
        <h2>User Profile</h2>
        
        <asp:Label ID="lblErrorMessage" runat="server" CssClass="error-message" />

        <div class="profile-info">
            <ul class="profile-list">
                <li><span class="label">Username:</span> <asp:Label ID="lblUsername" runat="server" /></li>
                <li><span class="label">Full Name:</span> <asp:Label ID="lblFullName" runat="server" /></li>
                <li><span class="label">Birthdate:</span> <asp:Label ID="lblBirthdate" runat="server" /></li>
                <li><span class="label">Contact Info:</span> <asp:Label ID="lblContactInfo" runat="server" /></li>
                <li><span class="label">Address:</span> <asp:Label ID="lblAddress" runat="server" /></li>
            </ul>
        </div>


        <div class="btn-container">
            <asp:Button ID="editProfileBtn" runat="server" Text="Edit Profile" CssClass="btn" OnClick="EditProfileRedirect"/>
            <asp:Button ID="goHome" runat="server" Text="Done" CssClass="btn" OnClick="GoToHome" />
        </div>
    </div>
    
    <div>
        <%--<div class="profile-background" />--%>
        <asp:Image ID="bgimage" runat="server" CssClass="profile-background" ImageUrl="~/images/Profile-bg5.png" />
    </div>
</asp:Content>
