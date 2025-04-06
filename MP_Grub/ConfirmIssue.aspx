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
            margin: 0;
        }

        .container {
            background-color: white;
            padding: 30px 70px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 600px;
            color: #404040;
            z-index: 5;
            gap: 15px;
            transition: 0.3s ease-in-out, color 0.3s ease-in-out;
        }

        .message {
            font-size: 18px;
            margin-bottom: 20px;
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

        #allReportsContainer {
            margin-top: 30px;
            text-align: left;
            width: 100%;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th, table td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        table td {
            font-size: 14px;
        }

        .report-section {
            margin-bottom: 20px;
            text-align: left;
        }

        .report-item {
            margin-bottom: 10px;
            font-size: 16px;
        }

        .report-item strong {
            font-weight: bold;
        }

        @media (max-width: 1200px) {
            .container {
                width: 80%;
            }
        }

        @media (max-width: 800px) {
            .container {
                padding: 25px 40px;
                width: 90%;
            }

            table th, table td {
                font-size: 12px;
            }

            .message {
                font-size: 14px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="container">
        <h2>Report Verification</h2>

        <h3>Latest Report</h3>
        <div class="report-section">
            <div class="report-item">
                <strong>Issue:</strong> 
                <asp:Label ID="lblIssue" runat="server"></asp:Label><br />
            </div>
            <div class="report-item">
                <strong>Comments:</strong> 
                <asp:Label ID="lblDetailedIssue" runat="server"></asp:Label><br />
            </div>
        </div>

        <hr />

        <asp:Button ID="btnToggleReports" runat="server" Text="View All Reports" CssClass="btn btn-primary" OnClick="btnToggleReports_Click" />
        <asp:Button ID="GoToHomePage" runat="server" Text="Go to Home" CssClass="btn btn-secondary" OnClick="GoToHomePage_Click" />

        <div id="allReportsContainer" runat="server" visible="false">
            <h3>All Reports Under Your Account</h3>
            <asp:Repeater ID="rptAllReports" runat="server">
                <HeaderTemplate>
                    <table border="1" width="100%">
                        <tr>
                            <th>Support ID</th>
                            <th>Issue</th>
                            <th>Detailed Issue</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                        <tr>
                            <td><%# Eval("Support_ID") %></td>
                            <td><%# Eval("Specified_Issue") %></td>
                            <td><%# Eval("Detailed_Issue") %></td>
                        </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </div>
    <div>
        <asp:Image ID="bgimage" runat="server" CssClass="profile-background" ImageUrl="~/images/Profile-bg5.png" />
    </div>
</asp:Content>
