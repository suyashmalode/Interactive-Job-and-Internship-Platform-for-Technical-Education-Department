<%@ Page Title="Company Dashboard" Language="C#" MasterPageFile="~/Company/CompanyMasterPage.master" AutoEventWireup="true" CodeFile="CompanyDashboard.aspx.cs" Inherits="CompanyDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    
    <style>
        /* 🔥 Powerful Background */
        body {
            background: linear-gradient(135deg, rgba(40, 48, 72, 0.9), rgba(133, 147, 152, 0.9)),
                        url('https://images.unsplash.com/photo-1521791055366-0d553872125f');
            background-size: cover;
            background-attachment: fixed;
            background-position: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: white !important;
        }

        /* Custom Dashboard Card to avoid Bootstrap override */
        .dashboard-card {
            border-radius: 25px !important;
            backdrop-filter: blur(12px);
            background: rgba(255, 255, 255, 0.12);
            color: #fff;
            box-shadow: 0 10px 35px rgba(0, 0, 0, 0.35);
            transition: all 0.3s ease-in-out;
            height: 260px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 25px;
        }

        .dashboard-card:hover {
            transform: translateY(-12px) scale(1.02);
            box-shadow: 0 18px 55px rgba(0, 0, 0, 0.55);
        }

        .card-title {
            font-weight: 700;
            font-size: 1.4rem;
        }

        .card-number {
            font-size: 3.2rem;
            font-weight: 900;
            margin-top: 10px;
        }

        .icon {
            font-size: 3.8rem;
            margin-bottom: 12px;
        }

        /* Gradient overlays on cards */
        .bg-gradient-1 { background: linear-gradient(135deg, #667eea, #764ba2); }
        .bg-gradient-2 { background: linear-gradient(135deg, #f7971e, #ffd200); color: #212529; }
        .bg-gradient-3 { background: linear-gradient(135deg, #6a11cb, #2575fc); }
        .bg-gradient-4 { background: linear-gradient(135deg, #56ab2f, #a8e063); color: #212529; }
        .bg-gradient-5 { background: linear-gradient(135deg, #e43a15, #e65245); }

        h2 {
            color: #fff;
        }
        .card-link {
    text-decoration: none;
    display: block;
    cursor: pointer;
}
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container my-5">
    <h2 class="text-center mb-5 fw-bold" style="color:white">Company Dashboard</h2>

    <div class="row g-4 justify-content-center">

        <!-- Total Students -->
        <div class="col-12 col-sm-6 col-md-4 col-lg-2">
            <asp:HyperLink runat="server" NavigateUrl="~/Company/AllStudentList.aspx" CssClass="card-link">
                <div class="dashboard-card bg-gradient-1">
                    <i class="fa-solid fa-users icon"></i>
                    <div class="card-title">Total Students</div>
                    <div class="card-number">
                        <asp:Label ID="lblTotalStudents" runat="server" Text="0" />
                    </div>
                </div>
            </asp:HyperLink>
        </div>

        <!-- Applications Received -->
        <div class="col-12 col-sm-6 col-md-4 col-lg-2">
            <asp:HyperLink runat="server" NavigateUrl="~/Company/ViewAppliedCandidate.aspx" CssClass="card-link">
                <div class="dashboard-card bg-gradient-2">
                    <i class="fa-solid fa-file-circle-check icon"></i>
                    <div class="card-title">Applications Received</div>
                    <div class="card-number">
                        <asp:Label ID="lblApplicationsReceived" runat="server" Text="0" />
                    </div>
                </div>
            </asp:HyperLink>
        </div>

        <!-- Applications Accepted -->
        <div class="col-12 col-sm-6 col-md-4 col-lg-2">
            <asp:HyperLink runat="server" NavigateUrl="~/Company/ViewAppliedCandidate.aspx" CssClass="card-link">
                <div class="dashboard-card bg-gradient-3">
                    <i class="fa-solid fa-thumbs-up icon"></i>
                    <div class="card-title">Applications Accepted</div>
                    <div class="card-number">
                        <asp:Label ID="lblApplicationsAccepted" runat="server" Text="0" />
                    </div>
                </div>
            </asp:HyperLink>
        </div>

        <!-- Applications Rejected -->
        <div class="col-12 col-sm-6 col-md-4 col-lg-2">
            <asp:HyperLink runat="server" NavigateUrl="~/Company/ViewAppliedCandidate.aspx" CssClass="card-link">
                <div class="dashboard-card bg-gradient-4">
                    <i class="fa-solid fa-thumbs-down icon"></i>
                    <div class="card-title">Applications Rejected</div>
                    <div class="card-number">
                        <asp:Label ID="lblApplicationsRejected" runat="server" Text="0" />
                    </div>
                </div>
            </asp:HyperLink>
        </div>

        <!-- My Internships -->
        <div class="col-12 col-sm-6 col-md-4 col-lg-2">
            <asp:HyperLink runat="server" NavigateUrl="~/Company/ViewAppliedCandidate.aspx" CssClass="card-link">
                <div class="dashboard-card bg-gradient-5">
                    <i class="fa-solid fa-briefcase icon"></i>
                    <div class="card-title">My Total Internships</div>
                    <div class="card-number">
                        <asp:Label ID="lblTotalInternships" runat="server" Text="0" />
                    </div>
                </div>
            </asp:HyperLink>
        </div>

    </div>
</div>
</asp:Content>
