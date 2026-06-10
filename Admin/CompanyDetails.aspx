<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="CompanyDetails.aspx.cs" Inherits="Admin_CompanyDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <h2>Company Details</h2>

<asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

<table class="table table-bordered">
    <tr><th>Company Name</th><td><asp:Label ID="lblCompanyName" runat="server" /></td></tr>
    <tr><th>Email</th><td><asp:Label ID="lblEmail" runat="server" /></td></tr>
    <tr><th>Contact Phone</th><td><asp:Label ID="lblPhone" runat="server" /></td></tr>
    <tr><th>Address</th><td><asp:Label ID="lblAddress" runat="server" /></td></tr>
    <tr>
        <th>Company Photo</th>
        <td>
            <asp:Image ID="imgCompanyPhoto" runat="server" Width="150px" Height="150px" Visible="false" />
        </td>
    </tr>
    <tr>
        <th>Document</th>
        <td>
            <asp:HyperLink ID="hlDocument" runat="server" Target="_blank" Text="View Document" Visible="true" />
        </td>
    </tr>
</table>

</asp:Content>

