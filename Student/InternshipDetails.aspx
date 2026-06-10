<%@ Page Title="Internship Details" Language="C#" MasterPageFile="~/Student/StudentMasterPage.master"
    AutoEventWireup="true" CodeFile="InternshipDetails.aspx.cs" Inherits="Student_InternshipDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        h2 {
            font-weight: 700;
            letter-spacing: .8px;
            margin-bottom: 20px;
            color: #2c3e50;
        }

        .table thead {
            background: #2c3e50;
            color: white;
        }

        .btn-custom {
            border-radius: 25px !important;
            padding: 6px 18px !important;
            font-weight: 600;
        }

        .btn-success { background-color: #2ecc71 !important; border: none; }
        .btn-warning { background-color: #f39c12 !important; border: none; }
        .btn-info { background-color: #3498db !important; border: none; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-4">
    <h5 class="text-center">Available Internships</h5>
    <div class="row mb-3">

    <div class="col-md-3">
        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
            Placeholder="Search by Title"></asp:TextBox>
    </div>

    <div class="col-md-3">
        <asp:DropDownList ID="ddlLocation" runat="server"
            CssClass="form-select" AutoPostBack="true"
            OnSelectedIndexChanged="FilterChanged">
        </asp:DropDownList>
    </div>
        <br />

    <div class="col-md-3">
        <asp:DropDownList ID="ddlCompany" runat="server"
            CssClass="form-select" AutoPostBack="true"
            OnSelectedIndexChanged="FilterChanged">
        </asp:DropDownList>
    </div>
<div class="col-md-3">
    <asp:TextBox ID="txtSkill" runat="server"
        CssClass="form-control"
        Placeholder="Filter by Skill"></asp:TextBox>
</div>

<div class="col-md-3">
    <asp:DropDownList ID="ddlJobType" runat="server"
        CssClass="form-select" AutoPostBack="true"
        OnSelectedIndexChanged="FilterChanged">
        <asp:ListItem Text="All Types" Value=""></asp:ListItem>
        <asp:ListItem Text="Internship" Value="Internship"></asp:ListItem>
        <asp:ListItem Text="Full-time" Value="Full-time"></asp:ListItem>
        <asp:ListItem Text="Job" Value="Job"></asp:ListItem>
    </asp:DropDownList>
</div>
        <br />
     <div class="col-md-3">
        <asp:Button ID="btnSearch" runat="server"
            Text="Search"
            CssClass="btn btn-primary w-100"
            OnClick="btnSearch_Click" />
    </div>
</div>
   

    <asp:GridView ID="gvInternships" runat="server"
        AutoGenerateColumns="False"
        CssClass="table table-striped table-bordered shadow"
        OnRowCommand="gvInternships_RowCommand" 
        AllowSorting="True"
        OnSorting="gvInternships_Sorting">

        <Columns>
            <asp:BoundField HeaderText="ID" DataField="JobInternshipID" SortExpression="JobInternshipID" />
            <asp:BoundField HeaderText="Title" DataField="Title" SortExpression="Title" />
            <asp:BoundField HeaderText="Description" DataField="Description" SortExpression="Description" />
            <asp:BoundField HeaderText="Location" DataField="Location" SortExpression="Location" />
            <asp:BoundField HeaderText="Company" DataField="cname" SortExpression="cname" />

            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnApply" runat="server" Text="Apply"
                        CssClass="btn btn-success btn-custom"
                        CommandName="Apply"
                        CommandArgument='<%# Eval("JobInternshipID") %>' />

                    &nbsp;

                    <asp:Button ID="btnViewDetails" runat="server" Text="View Internship Details"
                        CommandName="ViewDetails"
                        CommandArgument='<%# Eval("JobInternshipID") %>'
                        CssClass="btn btn-warning btn-custom" />

                    &nbsp;

                    <asp:Button ID="btnViewCompany" runat="server" Text="View Company Details"
                        CommandName="ViewCompany"
                        CommandArgument='<%# Eval("CompanyID") %>'
                        CssClass="btn btn-info btn-custom" />

                    <asp:Button ID="btnViewStatus" runat="server" Text="View Status"
                        CssClass="btn btn-primary btn-custom"
                        CommandName="ViewStatus"
                        CommandArgument='<%# Eval("JobInternshipID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>

    </asp:GridView>
</div>

<asp:HiddenField ID="hfInternshipID" runat="server" />

<!-- Status Modal -->
<div class="modal fade" id="statusModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius:20px;">
            <div class="modal-header bg-primary text-white" style="border-radius:20px 20px 0 0;">
                <h5 class="modal-title">Application Status</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body text-center">
                <h2 id="lblStatusText" class="fw-bold"></h2>
            </div>

            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script>
    function ShowStatusPopup(status) {
        document.getElementById("lblStatusText").innerHTML = status;
        var modal = new bootstrap.Modal(document.getElementById("statusModal"));
        modal.show();
    }
</script>

</asp:Content>
