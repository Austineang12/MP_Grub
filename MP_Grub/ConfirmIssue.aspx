<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ConfirmIssue.aspx.cs" Inherits="MP_Grub.ConfirmIssue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: #FB8F52;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 400px;
            color: #404040;
        }
        .message {
            font-size: 16px;
            margin-bottom: 15px;
            color: #404040;
        }
        .btn {
            background-color: #404040;
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
            border-radius: 5px;
            width: 100%;
        }
        .btn:hover {
            background-color: black;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="container">
        <h2>Thank You!</h2>
        <p class="message">Thank you for reaching out! We have received your report and will get back to you as soon as possible.</p>
        <asp:Button ID="homebtn" runat="server" Text="Go Back to Home" CssClass="btn" OnClick="GoToHomePage" />
    </div>
</asp:Content>