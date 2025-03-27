<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SpecificIssues.aspx.cs" Inherits="MP_Grub.SpecificIssues" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            padding-top: 150px;
        }

        .container {
            background-color: #FB8F52;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 400px;
        }

        h2 {
            color: white;
        }

        label {
            display: block;
            margin-top: 10px;
            color: white;
            font-size: 16px;
        }

        .textarea {
            width: 100%;
            height: 100px;
            padding: 10px;
            margin-top: 5px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
        }

        .button-group {
            margin-top: 15px;
        }

        .btn {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .skip {
            background-color: #404040;
            color: white;
        }

        .continue {
            background-color: #404040;
            color: white;
        }

        .cancel {
            background-color: #BC3B3B;
            color: white;
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
            <asp:Button ID="skipbtn" runat="server" Text="Skip" CssClass="btn skip" OnClick="SkipToConfirmation" />
            <asp:Button ID="continuebtn" runat="server" Text="Continue" CssClass="btn continue" OnClick="ContinueToConfirmation" />
            <asp:Button ID="cancelbtn" runat="server" Text="Cancel" CssClass="btn cancel" OnClick="CancelProcess" />
        </div>
    </div>
</asp:Content>
