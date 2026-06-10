<%@ Page Title="Add Job/Internship" Language="C#" MasterPageFile="~/Company/CompanyMasterPage.master" AutoEventWireup="true" CodeFile="AddJobInternshipdetails.aspx.cs" Inherits="Company_AddJobInternshipdetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .form-container {
            max-width: 700px;
            margin: 40px auto;
            background: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 18px rgb(0 0 0 / 0.15);
        }
        .validation-summary-errors {
            color: #dc3545;
            margin-bottom: 15px;
        }
        #<%= lblMessage.ClientID %> {
            margin-bottom: 15px;
            font-weight: 600;
        }
        .modal-body {
            max-height: 400px;
            overflow-y: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        table th {
            background-color: #007bff;
            color: white;
        }
        .btn-edit {
            margin-bottom: 20px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Button ID="btnOpenModal" runat="server" CssClass="btn btn-warning btn-edit" Text="Edit Existing Job/Internship" OnClientClick="$('#jobModal').modal('show'); return false;" />

    <div class="form-container">
        <h2 class="mb-4 text-primary">Post Job / Internship</h2>

        <asp:Label ID="lblMessage" runat="server" CssClass="text-success"></asp:Label>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validation-summary-errors" />

        <asp:HiddenField ID="hfJobID" runat="server" />

        <div class="form-floating mb-3">
            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="Job/Internship Title"></asp:TextBox>
            <label for="<%= txtTitle.ClientID %>">Job/Internship Title</label>
            <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle" ErrorMessage="Title is required" CssClass="text-danger small" Display="Dynamic" />
        </div>

        <div class="form-floating mb-3">
            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" placeholder="Job/Internship Description"></asp:TextBox>
            <label for="<%= txtDescription.ClientID %>">Job/Internship Description</label>
            <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription" ErrorMessage="Description is required" CssClass="text-danger small" Display="Dynamic" />
        </div>

        <div class="form-floating mb-3">
            <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="Location (e.g. City or Remote)"></asp:TextBox>
            <label for="<%= txtLocation.ClientID %>">Location (e.g. City or Remote)</label>
        </div>

        <div class="mb-3">
            <label for="<%= ddlJobType.ClientID %>" class="form-label">Job Type</label>
            <asp:DropDownList ID="ddlJobType" runat="server" CssClass="form-select">
                <asp:ListItem Text="Select Job Type" Value="" />
              
                <asp:ListItem Text="Internship" Value="Internship" />
                <asp:ListItem Text="Job" Value="Job" />
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvJobType" runat="server" ControlToValidate="ddlJobType" InitialValue="" ErrorMessage="Please select job type" CssClass="text-danger small" Display="Dynamic" />
        </div>

        <div class="row g-3">
            <div class="col-md-6 form-floating">
                <asp:TextBox ID="txtLastDate" runat="server" CssClass="form-control" TextMode="Date" placeholder="Last Date to Apply"></asp:TextBox>
                <label for="<%= txtLastDate.ClientID %>">Last Date to Apply</label>
            </div>
            <div class="col-md-6 form-floating">
                <asp:TextBox ID="txtSalary" runat="server" CssClass="form-control" placeholder="Salary / Stipend (optional)"></asp:TextBox>
                <label for="<%= txtSalary.ClientID %>">Salary / Stipend (optional)</label>
            </div>
        </div>

        <div class="form-floating mt-3 mb-3">
            <asp:TextBox ID="txtEligibility" runat="server" CssClass="form-control" placeholder="Eligibility Criteria"></asp:TextBox>
            <label for="<%= txtEligibility.ClientID %>">Eligibility Criteria</label>
        </div>
        <h5 class="mt-3 text-primary">Academic Criteria</h5>

<div class="row">
    <div class="col-md-4 mb-2">
        <asp:TextBox ID="txtSSC" runat="server" CssClass="form-control" placeholder="Min 10th %" />
    </div>
    <div class="col-md-4 mb-2">
        <asp:TextBox ID="txtHSC" runat="server" CssClass="form-control" placeholder="Min 12th %" />
    </div>
</div>

<div class="row">
    <div class="col-md-3 mb-2">
        <asp:TextBox ID="txtC1" runat="server" CssClass="form-control" placeholder="Y1 CGPA" />
    </div>
    <div class="col-md-3 mb-2">
        <asp:TextBox ID="txtC2" runat="server" CssClass="form-control" placeholder="Y2 CGPA" />
    </div>
    <div class="col-md-3 mb-2">
        <asp:TextBox ID="txtC3" runat="server" CssClass="form-control" placeholder="Y3 CGPA" />
    </div>
    <div class="col-md-3 mb-2">
        <asp:TextBox ID="txtC4" runat="server" CssClass="form-control" placeholder="Y4 CGPA" />
    </div>
</div>
        <div class="form-floating mb-3">
            <asp:TextBox ID="txtContactEmail" runat="server" CssClass="form-control" placeholder="Contact Email"></asp:TextBox>
            <label for="<%= txtContactEmail.ClientID %>">Contact Email</label>
            <asp:RequiredFieldValidator ID="rfvContactEmail" runat="server" ControlToValidate="txtContactEmail" ErrorMessage="Contact Email is required" CssClass="text-danger small" Display="Dynamic" />
        </div>

        <div class="form-floating mb-4">
            <asp:TextBox ID="txtContactPhone" runat="server" CssClass="form-control" placeholder="Contact Phone (optional)"></asp:TextBox>
            <label for="<%= txtContactPhone.ClientID %>">Contact Phone (optional)</label>
        </div>
        <div class="form-group mb-4">
            <label for="<%= FileUploadDoc.ClientID %>">Upload Internship Document (PDF)</label>
            <asp:FileUpload ID="FileUploadDoc" runat="server" CssClass="form-control" />
            <small class="text-muted">Only PDF files are allowed (max 5 MB)</small>
            <asp:HyperLink ID="lnkExistingPDF" runat="server" Text="View Existing Document" Target="_blank"
                                        CssClass="text-info d-block mb-3" 
                                        Visible='<%# !string.IsNullOrEmpty(Eval("PDF") as string) %>'
                                        NavigateUrl='<%# "~/Company/InternshipDocument/" + Eval("PDF") %>' />
        </div>

        <asp:HiddenField ID="hfExistingPDF" runat="server" />

        <asp:Button ID="btnSubmit" runat="server" Text="Post Job/Internship" CssClass="btn btn-primary w-100 py-3 fs-5" OnClick="btnSubmit_Click" />
        <div class="d-flex justify-content-between mt-3">
            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-success" OnClick="btnUpdate_Click" Enabled="false" />
            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger" OnClick="btnDelete_Click" Enabled="false" />
            <asp:Button ID="btncancel" runat="server" Text="Cancel" CssClass="btn-close-white" OnClick="btncancel_Click" Enabled="false" />
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="jobModal" tabindex="-1" role="dialog" aria-labelledby="jobModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Select Job/Internship to Edit</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="font-size: 30px;">
                        &times;
                    </button>
                </div>
                <div class="modal-body">
                    <asp:Repeater ID="rptJobs" runat="server" OnItemCommand="rptJobs_ItemCommand">
                        <HeaderTemplate>
                            <table class="table table-bordered table-hover">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>Title</th>
                                        <th>Type</th>
                                        <th>Location</th>
                                        <th>Last Date</th>
                                        <th>PDF</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("Title") %></td>
                                <td><%# Eval("JobType") %></td>
                                <td><%# Eval("Location") %></td>
                                <td><%# Eval("LastDateToApply", "{0:yyyy-MM-dd}") %></td>
                                <td>
                                    <asp:HyperLink ID="lnkExistingPDF" runat="server" Text="View Existing Document" Target="_blank"
                                        CssClass="text-info d-block mb-3" 
                                        Visible='<%# !string.IsNullOrEmpty(Eval("PDF") as string) %>'
                                        NavigateUrl='<%# "~/Company/InternshipDocument/" + Eval("PDF") %>' />
                                </td>
                              <td>
    <%# GetStatusText(Eval("Status")) %>
</td>


                                <td>
<asp:Button ID="btnSelect" runat="server" Text="Select" CommandName="Select" 
    CommandArgument='<%# Eval("JobInternshipID") %>' CssClass="btn btn-primary btn-sm" CausesValidation="false" 
    Visible='<%# Convert.ToInt32(Eval("Status")) == 1 %>' />
<span class="text-muted" Visible='<%# Convert.ToInt32(Eval("Status")) != 1 %>'></span>
                                    
                                    <span class="text-muted" Visible='<%# Convert.ToInt32(Eval("Status")) != 1 %>'></span>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                                </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
