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
            background-color: #FB8F52;
            border-radius: 20px;
            padding: 20px;
            width: 320px;
            margin: 10px auto;
            margin-top: 1%;
            box-shadow: 6px 6px 12px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .brand-container {
            font-size: 25px;
            font-family: 'Akshar', sans-serif;
            text-shadow: 3px 4px 0px rgba(0, 0, 0, 0.25);
            font-weight: 700;
            color: #404040;
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
            font-family: 'Akshar', sans-serif;
            font-weight: 700;
            background-color: white;
            align-items: center;
            color: #404040;
            border: none;
            padding: 12px 30px;
            border-radius: 20px;
            cursor: pointer;
            margin-top: 10px;
            font-size: 1rem;
            display: block;
            width: 20vw;
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
        }

        .button:hover {
            background-color: #F2F2F2;
        }

        .button:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        .modal {
            font-family: 'Akshar', sans-serif;
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
            background-color: #FB8F52;
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
            font-size: 16px;
            resize: vertical;
        }

        .modal .button {
            margin-top: 10px;
        }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
        <div class="container">
            <div class="brand-container">
                <h1>GRUB</h1>
            </div>
            <div class="image-container">
                <img src="images/Duck.png" alt="Delivery Duck">
            </div>

            <p>Thank you for rating!</p>
            <p>Would you like to leave a message?</p>

            <asp:Button ID="btnMessageReview" runat="server" Text="Send a Message Review" CssClass="button" OnClientClick="openModal(); return false;" />
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="button" OnClick="btnSubmit_Click" />
        </div>

        <!-- Review Modal -->
        <div id="reviewModal" class="modal">
            <div class="modal-content">
                <p>Type your review here...</p>
                <textarea rows="" cols="" id="reviewText" oninput="checkReview()" placeholder="Type your review here..."></textarea>
                <asp:Button ID="btnSubmitReview" runat="server" Text="Submit" CssClass="button" OnClientClick="return submitReview();"/>
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

        window.onload = function() {
            document.getElementById("<%= btnSubmitReview.ClientID %>").disabled = true; // Disable initially
        };
        function checkReview() {
            var reviewText = document.getElementById("reviewText").value.trim();
            var submitButton = document.getElementById("<%= btnSubmitReview.ClientID %>");
            
            if (reviewText === "") {
                submitButton.disabled = true;
            } else {
                submitButton.disabled = false;
            }
        }

        function submitReview() {
            var reviewText = document.getElementById("reviewText").value.trim();
            
            if (reviewText === " ") {
                alert("Please enter your review before submitting.");
                return false;
            } else {
                alert("Thanks for the feedback!");
                window.location.href = "Home.aspx";
                return false;
            }
        }

    </script>


</asp:Content>
