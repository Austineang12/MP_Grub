<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Navigation.aspx.cs" Inherits="MP_Grub.images.Navigation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Navigation</title>
    <style>
        .Navigation_platform {
            position: center;
            width: 250px;
            height: 250px;
            background-color: #FB8F52;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="Navigation_platform">

    </div>
</asp:Content>
