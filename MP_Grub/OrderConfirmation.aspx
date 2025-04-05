<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true"
    CodeBehind="OrderConfirmation.aspx.cs" Inherits="MP_Grub.OrderConfirmation" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <meta content="" charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Feedback</title>
        <style type="text/css">
            body {
                font-family: 'Akshar', sans-serif;
                text-align: center;
                margin: 0;
                padding: 0;
            }

            .container {
                /*padding: 20px;*/
                width: 45vw;
                min-width: 300px;
                max-width: 100%;
                background-color: white;
                height: 75vh;
                display: flex;
                flex-direction: column;
                margin: 10px auto;
                /*margin-top: 1%;*/
                box-shadow: 0px 0px 20px 2px rgba(0, 0, 0, 0.2);
                border-radius: 20px;
                /*text-align: center;*/
                z-index: 1;
            }

            .notification {
                height: auto;
                width: 100%;
                background-color: #a3d9ff;
                color: #107bc7;
                border-radius: 20px 20px 0 0;
                background: linear-gradient(45deg, #a3d9ff, #d0eaff);
                animation: gradientShift 4s ease infinite;
            }

            @keyframes gradientShift {
                0% {
                    background: linear-gradient(45deg, #a3d9ff, #d0eaff);
                }

                50% {
                    background: linear-gradient(45deg, #d0eaff, #a3d9ff);
                }

                100% {
                    background: linear-gradient(45deg, #a3d9ff, #d0eaff);
                }
            }

            #notificationText {
                color: #107bc7;
            }

            .feedbackContainer {
                display: flex;
                flex-direction: column;
                width: 100%;
                height: 100%;
                background-color: white;
                /*box-shadow: 0px 0px 20px 2px rgba(0, 0, 0, 0.2);*/
                border-radius: 0 0 20px 20px;
                justify-content: flex-start;
                margin-top: 1%;

            }

            .top {
                display: flex;
                flex-direction: row;
                align-self: flex-start;
                width: 80%;
                padding: 1% 2%;
                margin-left: 8%;
                border-bottom: 1px solid #F0F0F0;
                gap: 1%;
            }

            .top img {
                width: 5%;
                height: auto;
            }

            .middle {
                width: 85%;
                height: 70%;
                display: flex;
                flex-direction: column;
                align-content: center;
            }

            .middle img {
                width: 8vw;
                height: auto;
                position: absolute;
                top: 35.5%;
                left: 51.5%;
                transform: translate(-50%, -50%);

            }

            #heading {
                font-size: 32px;
            }

            #description {
                font-size: 14px;
                color: #808080;
                letter-spacing: 0px;
                font-weight: normal;
            }

            p {
                font-size: 18px;
                font-weight: bold;
                color: #404040;
                margin: 10px 0;
            }

            .stars {
                gap: 5px;
            }

            .stars span {
                font-size: 68px;
                cursor: pointer;
                color: #E0E0E0;
                transition: color 0.3s;
            }

            .stars span.active {
                color: #FB8F52;
            }

            #reviewText {
                border-radius: 20px;
                margin-top: 2%;
                margin-left: 0.8%;
                padding: 5%;
                width: 88%;
                height: 90px;
                font-family: 'Akshar', sans-serif;
                font-size: 18px;
                resize: none;
                scroll-behavior: auto;
                background-color: #F7F7F7;
                border: 1px solid #F0F0F0;
            }

            .bottom {
                display: flex;
                flex-direction: row;
                width: 85%;
                height: auto;
                justify-content: space-between;
                margin-top: 2%;
            }

            .button,
            .button1 {
                width: 18%;
                height: 55px;
                font-family: 'Akshar', sans-serif;
                font-size: 16px;
                font-weight: 700;
                background-color: transparent;
                align-items: center;
                color: #A0A0A0;
                /*padding: 10px 20px;*/
                border: 1px solid #E0E0E0;
                border-radius: 20px;
                cursor: pointer;
                /*margin-top: 10px;*/
                /*font-size: 1rem;*/
                /*display: block;*/
                box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
                transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
            }

            .button1 {
                background-color: #FB8F52;
                color: white;
            }

            .button:hover {
                background-color: #F2F2F2;
            }

            .button1:hover {
                background-color: #D86F38;
            }

            .background-duck {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100vh;
                background-image: url('/images/Feedback_Duckbg1.png');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                transition: background-image 0.3s ease-in-out;
            }

            @media (max-width: 800px) {
                .container {
                    width: 90vw;
                    max-width: 100%;
                }

                .stars span {
                    font-size: 42px;
                }

                .button,
                .button1 {
                    width: 22%;
                }
            }
        </style>


    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
        <div class="container">
            <section class="notification">
                <p id="notificationText">Status:&nbsp;&nbsp;Your order is being prepared!</p>
            </section>
            <section class="feedbackContainer">
                <div class="top">
                    <img src="images/Feedback_Icon_fill.svg" alt="Feedback Icon">
                    <p>Feedback</p>
                </div>
                <div class="middle">
                    <p id="heading">How was your order?</p>
                    <p id="description">Your input is valuable in helping us better understand your<br />needs and
                        tailor our service accordingly.</p>
                    <div class="stars" id="starRating">
                        <span onclick="rate(1)">&#9733;</span>
                        <span onclick="rate(2)">&#9733;</span>
                        <span onclick="rate(3)">&#9733;</span>
                        <span onclick="rate(4)">&#9733;</span>
                        <span onclick="rate(5)">&#9733;</span>
                    </div>
                    <textarea rows="" cols="" id="reviewText" oninput="checkReview()"
                        placeholder="Type your review here..."></textarea>
                </div>
                <div class="bottom">
                    <asp:Button ID="btnOrderDetails" runat="server" Text="Skip" CssClass="button"
                        OnClick="btnOrderDetails_Click" />
                    <asp:Button ID="btnDone" runat="server" Text="Submit" CssClass="button1"
                        OnClientClick="return saveData();" />
                </div>
            </section>
        </div>
        <%-- FOR ALERT MESSAGE --%>
            <div id="toast"
                style="display: none; position: fixed; top: 0px; left: 50%; transform: translateX(-50%); background-color: #333; color: #fff; padding: 10px 20px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); font-size: 16px; z-index: 9999; width: 100%; height: auto;letter-spacing: 0px; text-align: center;">
            </div>

            <%-- BACKGROUND IMAGE --%>
                <div class="background-duck"></div>

                <script type="text/javascript">
                    //ONLY RATING STARS HAVE VALIDATION
                    function rate(stars) {
                        var starElements = document.querySelectorAll(".stars span");
                        starElements.forEach((star, index) => {
                            if (index < stars) {
                                star.classList.add("active");
                            } else {
                                star.classList.remove("active");
                            }
                        });
                    }

                    //SAVING TO FEEDBACK TABLE
                    function saveData() {
                        var selectedStars = document.querySelectorAll(".stars span.active").length;
                        var reviewText = document.getElementById("reviewText").value.trim();

                        if (selectedStars === 0) {
                            showToast("Please select a rating before submitting.");
                            return false;
                        } else {
                            var feedbackTime = new Date().toISOString();

                            if (reviewText === "") { reviewText = "None" }

                            var formData = new FormData();
                            formData.append("action", "submitFeedback");
                            formData.append("rating", selectedStars);
                            formData.append("feedbackTime", feedbackTime);
                            formData.append("reviewText", reviewText);

                            fetch(window.location.href, {
                                method: "POST",
                                body: formData
                            })
                                .then(res => {
                                    if (res.ok) {
                                        showToast("Thanks for your feedback!", "#3CB371");
                                        //DELAY REDIRECTING AFTER 1 SECOND
                                        setTimeout(function () {
                                            window.location.href = "order.aspx";
                                        }, 1000);
                                    } else {
                                        showToast("We encountered an issue saving your feedback. We apologize for the inconvenience.", "#DC3545");
                                        setTimeout(function () {
                                            window.location.href = "order.aspx";
                                        }, 1000);
                                    }
                                })
                                .catch(err => {
                                    //FOR DEBUGGING ONLY
                                    console.error("Error submitting feedback", err);
                                    showToast("Oops! There was an error submitting your feedback. We’re sorry for the inconvenience!", "#DC3545");
                                    setTimeout(function () {
                                        window.location.href = "order.aspx";
                                    }, 1000);
                                });

                            return false;
                        }
                    }

                    //ALTERNATIVE FOR ALERT NOTIFICATION
                    function showToast(message, backgroundColor) {
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
                        }, 2500);
                    }

                </script>
    </asp:Content>