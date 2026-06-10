<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="RejectedStudentList.aspx.cs" Inherits="Admin_RejectedStudentList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
      <h2 style="margin:20px;">❌ Rejected Students List</h2>

    <asp:GridView ID="gvRejected" runat="server" AutoGenerateColumns="false" 
        CssClass="table" Width="100%" BorderStyle="Solid" BorderWidth="1px">

        <Columns>
            <asp:BoundField DataField="s_id" HeaderText="Student ID" />
            <asp:BoundField DataField="name" HeaderText="Name" />
            <asp:BoundField DataField="email" HeaderText="Email" />
            <asp:BoundField DataField="mobile" HeaderText="Mobile" />
            <asp:BoundField DataField="Title" HeaderText="Internship" />
            <asp:BoundField DataField="ApplicationDate" HeaderText="Applied Date" />
            <asp:BoundField DataField="Status" HeaderText="Status" />

            <asp:TemplateField HeaderText="Resume">
                <ItemTemplate>
                    <a href='<%# Eval("ResumePath") %>' target="_blank">View</a>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="Comments" HeaderText="Comments" />
        </Columns>

    </asp:GridView>

</asp:Content>

