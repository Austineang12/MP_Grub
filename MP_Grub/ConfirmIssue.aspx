<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ConfirmIssue.aspx.cs" Inherits="MP_Grub.ConfirmIssue" %>

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
            background-color: white;
            padding: 25px 70px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 400px;
            color: #404040;
            z-index: 5;
            gap: 15px;
            transition: 0.3s ease-in-out, color 0.3s ease-in-out; 
        }
        .message {
            font-size: 16px;
            margin-bottom: 15px;
            color: #404040;
            font-weight: bold;
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

        @media (max-width: 800px) {
            .container {
                padding: 30px 40px;
                width: 300px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="container">
        <p class="message">Thank you for reaching out! We have received your report and will get back to you as soon as possible.</p>

        <h3>Latest Report:</h3>
        <p><strong>Issue:</strong> <asp:Label ID="lblIssue" runat="server"></asp:Label></p>
        <p><strong>Details:</strong> <asp:Label ID="lblDetails" runat="server"></asp:Label></p>

        <asp:Button ID="homebtn" runat="server" Text="Home" CssClass="btn" OnClick="GoToHomePage" />
    </div>
    <div>
        <asp:Image ID="bgimage" runat="server" CssClass="profile-background" ImageUrl="~/images/Profile-bg5.png" />
    </div>
</asp:Content>