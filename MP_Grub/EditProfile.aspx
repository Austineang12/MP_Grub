<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="MP_Grub.EditProfile" %>

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

        .edit-container {
            background-color: white;
            padding: 22px 70px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            width: 480px;
            text-align: center;
            color: white;
            z-index: 5;
            transition: 0.3s ease-in-out;
        }

        .edit-container h2 {
            margin-bottom: 15px;
            color: #333;
            font-size: 20px;
        }

        .input-group {
            text-align: left;
            margin-bottom: 12px;
        }

        .input-group label {
            display: block;
            font-weight: bold;
            font-size: 18px;
            margin-bottom: 3px;
            color: #222;
        }

        .input-group input {
            font-size: 16px;
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 20px;
            border: 1px solid #ddd;
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 5px;
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
            font-size: 1rem;
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
        }

        .btn:hover {
            background-color: #E07E48;
        }

        .profile-background {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            object-fit: cover;
        }
        @media (max-width: 1000px) {
            .edit-container {
                padding: 30px 40px;
                width: 250px;
            }
            .input-group input {
                width: 100%;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="edit-container">
        <h2>Edit Profile</h2>
        
        <div class="input-group">
            <label for="username">Username</label>
            <asp:TextBox ID="username" runat="server" CssClass="input-field"></asp:TextBox><br />
            <asp:Label ID="lblUsernameError" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>
        
        <div class="input-group">
            <label for="fullName">Full Name</label>
            <asp:TextBox ID="fullName" runat="server" CssClass="input-field"></asp:TextBox><br />
            <asp:Label ID="lblFullNameError" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>
        
        <div class="input-group">
            <label for="birthdate">Birthdate</label>
            <asp:TextBox ID="birthdate" runat="server" CssClass="input-field" TextMode="Date"></asp:TextBox><br />
            <asp:Label ID="lblBirthdateError" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>
        
        <div class="input-group">
            <label for="contact">Contact Info</label>
            <asp:TextBox ID="contact" runat="server" CssClass="input-field"></asp:TextBox><br />
            <asp:Label ID="lblContactError" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>
        
        <div class="input-group">
            <label for="address">Address</label>
            <asp:TextBox ID="address" runat="server" CssClass="input-field"></asp:TextBox><br />
            <asp:Label ID="lblAddressError" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>
        
        <div class="btn-container">
            <asp:Button ID="saveBtn" runat="server" Text="Save Changes" CssClass="btn" OnClick="SaveProfile" />
        </div>
    </div>
    <div>
        <asp:Image ID="bgimage" runat="server" CssClass="profile-background" ImageUrl="~/images/Profile-bg5.png" />
    </div>
</asp:Content>