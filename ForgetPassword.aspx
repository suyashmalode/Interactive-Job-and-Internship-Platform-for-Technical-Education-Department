<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ForgetPassword.aspx.cs" Inherits="ForgetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<%-- <style>
       
      /*  .container {
            width:50%;
       
            margin: 80px auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px gray;
        }*/
       
        .message {
            margin-top: 10px;
            font-weight: bold;
        }
    </style>--%>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="container">
          
    <div style="text-align: center;">
        <h2>Forgot Password</h2>
        <label for="txtStudentID">Enter your Student ID</label><br />
        <asp:TextBox ID="txtStudentID" runat="server" CssClass="form-control" AutoComplete="off" 
                     Width="50%" style="display: block; margin: 0 auto;" /><br />
        <asp:Button ID="btnSubmit" runat="server" Text="Retrieve Password" CssClass="btn btn-primary" OnClick="btnSubmit_Click"/><br />
        <asp:Label ID="lblMessage" runat="server" CssClass="message" ForeColor="Red"></asp:Label>
    </div>
</div>

</asp:Content>

