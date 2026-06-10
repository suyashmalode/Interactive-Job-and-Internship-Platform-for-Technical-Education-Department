<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Feedback.aspx.cs" Inherits="Feedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   <style>
        .form-container {
            width: 100%;
            display: flex;
            justify-content: center;
            margin-top: 40px;
        }

        .form-box {
            width: 50%;
            padding: 30px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
        }

        .form-control {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <div class="form-container">
        <div class="form-box">
            <h2 style="text-align:center">Student Feedback Form</h2>

            <asp:Label ID="lblName" runat="server" Text="Student Name:" AssociatedControlID="txtName" />
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" required="true"></asp:TextBox>

            <asp:Label ID="lblCompany" runat="server" Text="Company Name:" AssociatedControlID="txtCompany" />
            <asp:TextBox ID="txtCompany" runat="server" CssClass="form-control" required="true"></asp:TextBox>

            <asp:Label ID="lblRating" runat="server" Text="Rating (1-5):" AssociatedControlID="ddlRating" />
            <asp:DropDownList ID="ddlRating" runat="server" CssClass="form-control">
                <asp:ListItem Text="1" Value="1" />
                <asp:ListItem Text="2" Value="2" />
                <asp:ListItem Text="3" Value="3" />
                <asp:ListItem Text="4" Value="4" />
                <asp:ListItem Text="5" Value="5" />
            </asp:DropDownList>

            <asp:Label ID="lblFeedback" runat="server" Text="Feedback:" AssociatedControlID="txtFeedback" />
            <asp:TextBox ID="txtFeedback" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control" required="true"></asp:TextBox>

            <asp:Button ID="btnSubmit" runat="server" Text="Submit Feedback" OnClick="btnSubmit_Click" CssClass="btn btn-primary" />
            <br /><br />
            <asp:Label ID="lblMessage" runat="server" ForeColor="Green" />
        </div>
    </div>

</asp:Content>

