<%@ Page Title="Internship Application Reports" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="Admin_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <style>
        /* Report Title */
        .report-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #2c3e50;
        }

        /* Styled GridView */
        .report-table {
            width: 100%;
            border-collapse: collapse;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .report-table th {
            background-color: #3498db;
            color: white;
            text-align: center;
            padding: 10px;
            font-size: 16px;
        }

        .report-table td {
            padding: 8px;
            text-align: center;
            font-size: 14px;
        }

        .report-table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .report-table tr:hover {
            background-color: #d0e7ff;
        }

        /* Status coloring */
        .pending {
            color: #e67e22; /* orange */
            font-weight: bold;
        }

        .approved {
            color: #27ae60; /* green */
            font-weight: bold;
        }

        .rejected {
            color: #c0392b; /* red */
            font-weight: bold;
        }

        /* Footer totals */
        .report-footer {
            font-weight: bold;
            background-color: #ecf0f1;
        }
    </style>
    <div class="report-title">Internship Application Reports</div>

    <asp:GridView ID="gvApplicationReports" runat="server" AutoGenerateColumns="False" CssClass="report-table"
        GridLines="None" ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="JobInternshipID" HeaderText="Internship ID" FooterText="Totals" />
            <asp:BoundField DataField="Title" HeaderText="Internship Title" />
            <asp:BoundField DataField="CompanyName" HeaderText="Company" />
            <asp:BoundField DataField="TotalApplications" HeaderText="Total Applications" FooterStyle-HorizontalAlign="Center" />
            <asp:TemplateField HeaderText="Pending" FooterStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <span class="pending"><%# Eval("PendingCount") %></span>
                </ItemTemplate>
                <FooterTemplate>
                    <%# GetColumnTotal("PendingCount") %>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Approved" FooterStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <span class="approved"><%# Eval("ApprovedCount") %></span>
                </ItemTemplate>
                <FooterTemplate>
                    <%# GetColumnTotal("ApprovedCount") %>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Rejected" FooterStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <span class="rejected"><%# Eval("RejectedCount") %></span>
                </ItemTemplate>
                <FooterTemplate>
                    <%# GetColumnTotal("RejectedCount") %>
                </FooterTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
