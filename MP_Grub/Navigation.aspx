<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Navigation.aspx.cs" Inherits="MP_Grub.Navigation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>GRUB</title>
    <link href="https://fonts.googleapis.com/css2?family=Akshar:wght@300;400;700&display=swap" rel="stylesheet"/>  
    <style type="text/css">
        .navigation-outline {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            max-width: 700px;
            max-height: 500px;
            width: 100%;
            text-align: center;
            z-index: 5;
        }

        .page-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 30vh;
            padding: 20px;
        }

        .button-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 30px;
        }

        .options, .image-container {
            display: flex;
            width: 300px;
            height: auto;
            border-radius: 12px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            transition: 0.3s ease-in-out, color 0.3s ease-in-out; 
        }

        .swipe-ducks {
            display: flex;
            width: 200px;
            height: auto;
            transition: 0.3s ease-in-out, color 0.3s ease-in-out; 
        }

        .background-duck {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            background-image: url('/images/Navigation_bg4.png'); /* Default desktop background */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            transition: background-image 0.3s ease-in-out;
        }

        /*-- Responsive Design --*/
        @media (max-width: 1000px) {
            .background-duck {
                position: fixed;
                height: 100%;
                background-image: url('/images/Order_Moblebg1.png') !important;
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
            }
            .options {
                width: 200px;
            }
            .swipe-ducks {
                width: 150px;
            }
            .button-container {
                gap: 5px;
            }
        }

    </style>
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="page-container">
        <div class="navigation-outline">
            <div class="button-container">
                <asp:ImageButton ID="NoDuck" runat="server" CssClass="swipe-ducks" ImageUrl="~/images/No_Duck.png" OnClick="btnLeft_Click"/>
                <div class="image-container" id="imageContainer" runat="server">
                    <%-- IMAGES RETRIEVED FROM THE DATABASE --%>
                </div>
                <%--<asp:ImageButton ID="YesDuck" runat="server" CssClass="swipe-ducks" ImageUrl="~/images/Yes_Duck.png" OnClick="btnRight_Click" CommandArgument="<%# Eval('Food_ID') %>" />--%>

                    <%-- REMOVED YESDUCK BUTTON, BEING CREATED IN THE BACK-END --%>
            </div>
        </div>
    </div>
    <%-- error message --%>
    <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>

    <%-- Background Image --%>
    <div class="background-duck"></div>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        let currentImage = null;
        //FOR SWIPE RIGHT
        <%--document.getElementById('<%= YesDuck.ClientID %>').addEventListener('click', function () {
            if (currentImage) {
                const foodID = currentImage.getAttribute('data-id');
                saveToOrderDetail(foodID);
            }
        });--%>

        function saveToOrderDetail(foodID) {
            $.ajax({
                type: "POST",
                url: "Navigation.aspx/GetSessionData",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (sessionResponse) {
                    if (!sessionResponse.d.IsValid) {
                        console.error("Session error:", sessionResponse.d.Message);
                        alert(sessionResponse.d.Message);
                        window.location.href = "Login.aspx";
                        return;
                    }

                    var transactionId = sessionResponse.d.TransactionID;
                    var userId = sessionResponse.d.UserID;

                    $.ajax({
                        url: 'Navigation.aspx/SaveToOrderDetail',
                        method: 'POST',
                        data: JSON.stringify({ foodID: foodID }),
                        contentType: 'application/json',
                        success: function (response) {
                            console.log('Food added to order details: ' + foodID);

                        },
                        error: function (error) {
                            console.error('Error saving to order details: ' + error);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    console.error("Session AJAX Error:", error);
                    console.error("Response:", xhr.responseText);
                    showToast("Oops! Couldn’t add the food to the cart due to an error", "#DC3545")
                }
            });
            
        }
        

        //ALTERNATIVE FOR ALERT NOTIFICATION
        function showToast(message, backgroundColor = '#333') {
            const toast = document.getElementById("toast");

            toast.style.backgroundColor = backgroundColor;
            toast.textContent = message;
            toast.style.display = "block";
            toast.style.opacity = "1";

            if (toast.hideTimeout) clearTimeout(toast.hideTimeout);
            void toast.offsetWidth;

            toast.hideTimeout = setTimeout(() => {
                toast.style.opacity = "0";
                toast.addEventListener("transitionend", function handler() {
                    toast.style.display = "none";
                    toast.removeEventListener("transitionend", handler);
                });
            }, 1000);
        }
    </script>
</asp:Content>