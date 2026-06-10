<%@ Page Title="" Language="C#" MasterPageFile="~/Company/CompanyMasterPage.master" AutoEventWireup="true" CodeFile="ViewAppliedCandidate.aspx.cs" Inherits="Company_ViewAppliedCandidate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <h5>Applied Students for Your Internships</h5>
        <asp:GridView ID="GridViewCandidates" runat="server" AutoGenerateColumns="false"
            CssClass="table table-bordered table-striped"
            OnRowCommand="GridViewCandidates_RowCommand"
            OnRowDataBound="GridViewCandidates_RowDataBound">

            <Columns>
                <asp:TemplateField HeaderText="#" ItemStyle-HorizontalAlign="Center">
                    <ItemStyle Width="40px" />
                    <HeaderStyle Width="40px" />
                    <ItemTemplate>
                        <asp:Label ID="lblSerialNumber" runat="server" Text=""></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="StudentID" HeaderText="Student ID" />

                <asp:BoundField DataField="StudentName" HeaderText="Student Name" />

                <asp:BoundField DataField="ApplicationDate" HeaderText="Application Date" DataFormatString="{0:dd MMM yyyy HH:mm}" />

                <asp:BoundField DataField="Status" HeaderText="Status" />

                <asp:TemplateField HeaderText="Resume">
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkResume" runat="server" CssClass="btn btn-primary btn-sm"
                            NavigateUrl='<%# Eval("ResumePath") %>' Target="_blank" Text="View Resume" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Details">
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkDetails" runat="server" CssClass="btn btn-info btn-sm"
                            NavigateUrl='<%# "ViewStudentDetails.aspx?ApplicationID=" + Eval("ApplicationID") + "&StudentID=" + Eval("StudentID") %>'
                            Text="View Student Details" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnApprove" runat="server" CommandName="Approve" CommandArgument='<%# Eval("ApplicationID") %>'
                            CssClass="btn btn-success btn-sm me-1" Text="Approve" />
                        <asp:Button ID="btnReject" runat="server" CommandName="Reject" CommandArgument='<%# Eval("ApplicationID") %>'
                            CssClass="btn btn-danger btn-sm" Text="Reject" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
