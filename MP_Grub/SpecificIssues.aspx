<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SpecificIssues.aspx.cs" Inherits="MP_Grub.SpecificIssues" %>
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
            padding: 25px 0;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 400px;
            z-index: 5;
        }

        h2 {
            margin-bottom: 15px;
            color: #333;
            font-size: 20px;
        }

        label {
            display: block;
            margin-top: 10px;
            color: #333;
            font-size: 16px;
        }

        .textarea {
            width: 396px;
            height: 10vh;
            margin-top: 5px;
            border: none;
            font-size: 16px;
            background-color: lightgrey;
            color: #404040;
            box-shadow: inset 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .button-group {
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

        .cancel {
            background-color: #BC3B3B;
            color: white;
        }

        .cancel:hover {
            background-color: darkred;
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
    <div class="container">
        <h2>Describe Your Issue</h2>

        <asp:Label ID="errorLabel" runat="server" ForeColor="Red" Visible="false"></asp:Label>


        <label for="issueDetails">Details</label>
        <asp:TextBox ID="issueDetails" runat="server" CssClass="textarea" TextMode="MultiLine"></asp:TextBox>
        
        <div class="button-group">
            <asp:Button ID="skipbtn" runat="server" Text="Skip" CssClass="btn" OnClick="SkipToConfirmation" />
            <asp:Button ID="continuebtn" runat="server" Text="Continue" CssClass="btn" OnClick="ContinueToConfirmation" />
            <asp:Button ID="cancelbtn" runat="server" Text="Cancel" CssClass="btn cancel" OnClick="CancelProcess" />
        </div>
    </div>
    <div>
        <asp:Image ID="bgimage" runat="server" CssClass="profile-background" ImageUrl="~/images/Profile-bg5.png" />
    </div>
</asp:Content>
