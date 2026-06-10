<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="~/CompanyForgetPassword.aspx.cs" Inherits="Company_ForgetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div class="container">
          
    <div style="text-align: center;">
        <h2>Forgot Password</h2>
        <label for="txtcompanyname">Enter your Company Name</label><br />
        <asp:TextBox ID="txtcompanyname" runat="server" CssClass="form-control" 
                     Width="50%" style="display: block; margin: 0 auto; " autocomplete="off"   /><br />
        <asp:Button ID="btnSubmit" runat="server" Text="Retrieve Password" OnClick="btnSubmit_Click" CssClass="btn btn-primary" /><br />
        <asp:Label ID="lblMessage" runat="server" CssClass="message" ForeColor="Red"></asp:Label>
    </div>
</div>
</asp:Content>

