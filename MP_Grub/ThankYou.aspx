<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ThankYou.aspx.cs" Inherits="MP_Grub.ThankYou" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta content="" charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thank You</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        .container {
            background-color: #f7a76c;
            border-radius: 20px;
            padding: 20px;
            width: 320px;
            margin: 50px auto;
            margin-top: 1%;
            box-shadow: 6px 6px 12px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .logo-container img {
            width: 120px;
            margin-bottom: 10px;
        }

        .image-container img {
            width: 180px;
            display: block;
            margin: 0 auto;
        }

        p {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin: 10px 0;
        }

        .button {
            background-color: #e55b33;
            border: none;
            color: white;
            padding: 12px;
            margin: 10px;
            width: 85%;
            border-radius: 15px;
            font-size: 16px;
            cursor: pointer;
            font-weight: bold;
            box-shadow: 2px 4px 6px rgba(0, 0, 0, 0.2);
        }

        .button:hover {
            background-color: #d14a28;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: #f7a76c;
            border-radius: 20px;
            padding: 20px;
            width: 320px;
            text-align: center;
            box-shadow: 6px 6px 12px rgba(0, 0, 0, 0.2);
        }

        .modal textarea {
            width: 90%;
            height: 100px;
            border-radius: 10px;
            padding: 10px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        .modal .button {
            margin-top: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
        <div class="container">
            <div class="logo-container">
                <img src="Images/GrubName.png" alt="GRUB Logo">
            </div>
            <div class="image-container">
                <img src="Images/Duck.png" alt="Delivery Duck">
            </div>

            <p>Thank you for rating!</p>
            <p>Would you like to leave a message?</p>

            <asp:Button ID="btnMessageReview" runat="server" Text="Send a Message Review" CssClass="button" OnClientClick="openModal(); return false;" />
            <asp:Button ID="btnSubmit" runat="server" Text="SUBMIT" CssClass="button" OnClick="btnSubmit_Click" />
        </div>

        <!-- Review Modal -->
        <div id="reviewModal" class="modal">
            <div class="modal-content">
                <p>Type your review here...</p>
                <textarea cols="" rows="" placeholder="Type your review here..."></textarea>
                <asp:Button ID="btnSubmitReview" runat="server" Text="SUBMIT" CssClass="button" />
                <button class="button" onclick="closeModal(); return false;">Cancel</button>
            </div>
        </div>
    <script type="text/javascript">
        function openModal() {
            document.getElementById("reviewModal").style.display = "flex";
        }

        function closeModal() {
            document.getElementById("reviewModal").style.display = "none";
        }
    </script>

</asp:Content>
