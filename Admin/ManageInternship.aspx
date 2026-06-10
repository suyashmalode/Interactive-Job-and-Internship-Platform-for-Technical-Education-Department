<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="ManageInternship.aspx.cs" Inherits="Admin_ManageInternship" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 8px;
            border: 1px solid #ccc;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .btn-approve {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }
        .btn-reject {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }
    </style>
     
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <h2>Manage Job / Internship Listings</h2>

    <asp:Label ID="lblAdminMessage" runat="server" CssClass="text-success"></asp:Label>

    <asp:GridView ID="gvJobListings" runat="server" AutoGenerateColumns="False" OnRowCommand="gvJobListings_RowCommand" DataKeyNames="JobInternshipID">
        <Columns>
            <asp:BoundField DataField="JobInternshipID" HeaderText="ID" ReadOnly="true" />
            <asp:BoundField DataField="CompanyID" HeaderText="Company ID" ReadOnly="true" />
            <asp:BoundField DataField="Title" HeaderText="Title" />
            <asp:BoundField DataField="JobType" HeaderText="Type" />
            <asp:BoundField DataField="Location" HeaderText="Location" />
            <asp:BoundField DataField="PostedDate" HeaderText="Posted Date" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="LastDateToApply" HeaderText="Last Date" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="Status" HeaderText="Status" />

            <asp:TemplateField HeaderText="PDF Document">
                <ItemTemplate>
                    <asp:HyperLink ID="lnkPDF" runat="server" Text="View PDF" Target="_blank" Visible='<%# !string.IsNullOrEmpty(Eval("PDF") as string) %>' NavigateUrl='<%# "~/Company/InternshipDocument/" + Eval("PDF") %>'></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Company Details">
    <ItemTemplate>
        <asp:HyperLink ID="lnkViewCompany" runat="server" 
            NavigateUrl='<%# "~/Admin/CompanyDetails.aspx?CompanyID=" + Eval("CompanyID") %>' 
            Text="View Company" CssClass="btn btn-info btn-sm" />
    </ItemTemplate>
</asp:TemplateField>

          <asp:TemplateField HeaderText="Actions">
    <ItemTemplate>
        <asp:Button ID="btnApprove" runat="server" CommandName="Approve" 
            CommandArgument='<%# Eval("JobInternshipID") %>' Text="Approve" 
            CssClass="btn-approve" 
            OnClientClick="return confirm('Are you sure you want to approve this listing?');" />

        <asp:Button ID="btnReject" runat="server" CommandName="Reject" 
            CommandArgument='<%# Eval("JobInternshipID") %>' Text="Reject" 
            CssClass="btn-reject" 
            OnClientClick="return confirm('Are you sure you want to reject this listing?');" />
    </ItemTemplate>
</asp:TemplateField>




        </Columns>
    </asp:GridView>

</asp:Content>

