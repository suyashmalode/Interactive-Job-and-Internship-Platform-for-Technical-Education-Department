<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="Admin_ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
<style>
        /* Center form container */
        .form-container {
            max-width: 450px;
            margin: 50px auto;
            padding: 40px 30px;
            background: #f9f9f9;
            border-radius: 15px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #222;
            font-weight: 700;
        }

        /* Style labels */
        .form-container label {
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            color: #555;
            font-weight: 500;
        }

        /* Style ASP.NET TextBoxes */
        .form-container input[type="text"],
        .form-container input[type="password"],
        .form-container .aspTextBox {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ccc;
            border-radius: 10px;
            font-size: 14px;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }

        .form-container input[type="text"]:focus,
        .form-container input[type="password"]:focus,
        .form-container .aspTextBox:focus {
            border-color: #007bff;
            box-shadow: 0 0 10px rgba(0,123,255,0.3);
            outline: none;
        }

        /* Style button */
        .form-container .btn {
            width: 100%;
            padding: 14px;
            margin-top: 25px;
            background: linear-gradient(90deg, #0066ff, #004aad);
            color: #fff;
            font-size: 16px;
            font-weight: 600;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .form-container .btn:hover {
            background: linear-gradient(90deg, #004aad, #0066ff);
            transform: translateY(-2px);
        }

        /* Message label */
        .form-container .message {
            display: block;
            text-align: center;
            margin-bottom: 10px;
            font-weight: 500;
        }

        .form-container .message.error {
            color: #dc3545;
        }

        .form-container .message.success {
            color: #28a745;
        }
    </style>

    <div class="form-container">
        <h2>Change Admin Credentials</h2>

        <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>

        <asp:Label ID="lblCurrentUsername" Text="Current Username" runat="server"></asp:Label>
        <asp:TextBox ID="txtCurrentUsername" runat="server" ReadOnly="true" CssClass="aspTextBox"></asp:TextBox>

        <asp:Label ID="lblNewUsername" Text="New Username" runat="server"></asp:Label>
        <asp:TextBox ID="txtNewUsername" runat="server" CssClass="aspTextBox"></asp:TextBox>

        <asp:Label ID="lblCurrentPassword" Text="Current Password" runat="server"></asp:Label>
        <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" CssClass="aspTextBox"></asp:TextBox>

        <asp:Label ID="lblNewPassword" Text="New Password" runat="server"></asp:Label>
        <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="aspTextBox"></asp:TextBox>

        <asp:Button ID="btnChange" runat="server" Text="Update Credentials" OnClick="btnChange_Click" CssClass="btn" />
    </div></asp:Content>

