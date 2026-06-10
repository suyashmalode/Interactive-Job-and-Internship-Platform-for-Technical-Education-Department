<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>

    /* ================= SECTION SPACING ================= */
    .section-padding {
        padding: 80px 0;
    }

    /* ================= STATS ================= */
    .stats-box {
        background: white;
        padding: 30px;
        border-radius: 15px;
        text-align: center;
        box-shadow: 0 10px 25px rgba(0,0,0,0.08);
        transition: 0.3s;
    }

    .stats-box:hover {
        transform: translateY(-8px);
    }

    .stats-box h2 {
        font-weight: 700;
        color: #243b55;
    }

    /* ================= FEATURE CARDS ================= */
    .feature-card {
        background: rgba(255,255,255,0.8);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        padding: 30px;
        text-align: center;
        transition: 0.4s;
        box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    }

    .feature-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 20px 40px rgba(0,0,0,0.15);
    }

    .feature-card i {
        font-size: 40px;
        color: #ff512f;
        margin-bottom: 15px;
    }

    /* ================= JOB CARD ================= */
    .job-card {
        background: white;
        border-radius: 15px;
        padding: 25px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.08);
        transition: 0.3s;
    }

    .job-card:hover {
        transform: translateY(-5px);
    }

    .job-card h5 {
        font-weight: 600;
        color: #243b55;
    }

    .badge-custom {
        background: linear-gradient(45deg, #ff512f, #dd2476);
        color: white;
        padding: 5px 10px;
        border-radius: 20px;
        font-size: 12px;
    }

    /* ================= CTA ================= */
    .cta-section {
        background: linear-gradient(135deg, #141e30, #243b55);
        color: white;
        text-align: center;
        padding: 70px 0;
        border-radius: 20px;
    }

    .cta-section h2 {
        font-weight: 700;
    }

</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="hero-section">
    <div class="container">
        <h1>Find Your Dream Job & Internship</h1>
        <p>Connecting Students with Top Companies Across India</p>
        <a href="StudentRegistration.aspx" class="btn hero-btn">Get Started</a>
    </div>
</div>
<!-- ================= STATS SECTION ================= -->
<div class="container section-padding">
    <div class="row text-center">

        <div class="col-md-3 mb-4">
            <div class="stats-box">
                <i class="fas fa-briefcase fa-2x mb-2 text-primary"></i>
                <h2><asp:Label ID="lblJobs" runat="server" Text="0"></asp:Label></h2>
                <p>Active Jobs</p>
            </div>
        </div>

        <div class="col-md-3 mb-4">
            <div class="stats-box">
                <i class="fas fa-building fa-2x mb-2 text-success"></i>
                <h2><asp:Label ID="lblCompanies" runat="server" Text="0"></asp:Label></h2>
                <p>Companies</p>
            </div>
        </div>

        <div class="col-md-3 mb-4">
            <div class="stats-box">
                <i class="fas fa-user-graduate fa-2x mb-2 text-warning"></i>
                <h2><asp:Label ID="lblStudents" runat="server" Text="0"></asp:Label></h2>
                <p>Students</p>
            </div>
        </div>

        <div class="col-md-3 mb-4">
            <div class="stats-box">
                <i class="fas fa-file-alt fa-2x mb-2 text-danger"></i>
                <h2><asp:Label ID="lblApplications" runat="server" Text="0"></asp:Label></h2>
                <p>Applications</p>
            </div>
        </div>

    </div>
</div>

<!-- ================= FEATURES SECTION ================= -->
<div class="container section-padding">
    <div class="text-center mb-5">
        <h2 class="fw-bold">Why Choose Our Platform?</h2>
        <p class="text-muted">Smart, Secure & Reliable Job Portal</p>
    </div>

    <div class="row">

        <div class="col-md-4 mb-4">
            <div class="feature-card">
                <i class="fas fa-user-graduate"></i>
                <h5>For Students</h5>
                <p>Find internships and jobs from top companies easily and quickly.</p>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="feature-card">
                <i class="fas fa-building"></i>
                <h5>For Companies</h5>
                <p>Post jobs and hire skilled candidates efficiently.</p>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="feature-card">
                <i class="fas fa-shield-alt"></i>
                <h5>Secure Platform</h5>
                <p>Safe authentication and verified company registrations.</p>
            </div>
        </div>

    </div>
</div>


<!-- ================= LATEST JOBS SECTION ================= -->



<!-- ================= CALL TO ACTION ================= -->
<div class="container mb-5">
    <div class="cta-section">
        <h2>Ready to Start Your Career Journey?</h2>
        <p class="mt-3">Register today and connect with top recruiters.</p>
        <a href="StudentRegistration.aspx" class="btn btn-warning mt-3 px-4">Join Now</a>
    </div>
</div>

</asp:Content>
