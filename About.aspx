<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="About.aspx.cs" Inherits="About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<style>

/* ================= BANNER ================= */

.about-banner {
    background: linear-gradient(rgba(20,30,48,0.7), rgba(36,59,85,0.8)),
                url('https://images.unsplash.com/photo-1521737604893-d14cc237f11d') center/cover no-repeat;
    height: 350px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    text-align: center;
}

.about-banner h1 {
    font-size: 45px;
    font-weight: 700;
}

/* ================= SECTION SPACING ================= */

.section-padding {
    padding: 80px 0;
}

/* ================= GLASS CARD ================= */

.glass-card {
    background: rgba(255,255,255,0.85);
    backdrop-filter: blur(10px);
    border-radius: 20px;
    padding: 30px;
    box-shadow: 0 15px 35px rgba(0,0,0,0.1);
    transition: 0.4s;
}

.glass-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 25px 45px rgba(0,0,0,0.2);
}

.glass-card i {
    font-size: 40px;
    color: #ff512f;
    margin-bottom: 15px;
}

/* ================= FEATURE GRID ================= */

.feature-box {
    background: white;
    padding: 25px;
    border-radius: 15px;
    text-align: center;
    transition: 0.3s;
    box-shadow: 0 10px 25px rgba(0,0,0,0.08);
}

.feature-box:hover {
    transform: translateY(-8px);
}

.feature-box i {
    font-size: 35px;
    color: #243b55;
    margin-bottom: 10px;
}

/* ================= CONTACT SECTION ================= */

.contact-section {
    background: linear-gradient(135deg, #141e30, #243b55);
    color: white;
    border-radius: 20px;
    padding: 50px;
}

.contact-section i {
    color: #ffc107;
    margin-right: 10px;
}

.section-title {
    font-weight: 700;
    margin-bottom: 20px;
}

</style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<!-- ================= BANNER ================= -->
<div class="about-banner">
    <div>
        <h1>About Our Career Portal</h1>
        <p class="lead">Empowering Students • Connecting Companies • Building Futures</p>
    </div>
</div>

<!-- ================= INTRO ================= -->
<div class="container section-padding text-center">
    <h2 class="section-title">Welcome to Career Service Portal</h2>
    <p class="lead mt-3">
        We are a modern digital platform connecting talented students with top recruiters. 
        Our goal is to simplify hiring, enhance employability, and create meaningful career opportunities.
    </p>
</div>

<!-- ================= MISSION & VISION ================= -->
<div class="container section-padding">
    <div class="row">

        <div class="col-md-6 mb-4">
            <div class="glass-card text-center">
                <i class="fas fa-bullseye"></i>
                <h4 class="fw-bold">Our Mission</h4>
                <p>
                    To bridge the gap between students and companies by offering a secure, 
                    innovative, and efficient recruitment platform that enhances employability.
                </p>
            </div>
        </div>

        <div class="col-md-6 mb-4">
            <div class="glass-card text-center">
                <i class="fas fa-eye"></i>
                <h4 class="fw-bold">Our Vision</h4>
                <p>
                    To become the leading digital career ecosystem recognized for innovation, 
                    inclusivity, and empowering future professionals globally.
                </p>
            </div>
        </div>

    </div>
</div>

<!-- ================= WHY CHOOSE US ================= -->
<div class="container section-padding">
    <div class="text-center mb-5">
        <h2 class="section-title">Why Choose Us?</h2>
    </div>

    <div class="row g-4">

        <div class="col-md-4">
            <div class="feature-box">
                <i class="fas fa-robot"></i>
                <h5>Smart Job Matching</h5>
                <p>AI-powered recommendations based on skills and interests.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="feature-box">
                <i class="fas fa-file-alt"></i>
                <h5>Resume Builder</h5>
                <p>Professional tools to create job-ready resumes.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="feature-box">
                <i class="fas fa-check-circle"></i>
                <h5>Verified Companies</h5>
                <p>Trusted recruiters and genuine job opportunities.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="feature-box">
                <i class="fas fa-user-tie"></i>
                <h5>Career Mentorship</h5>
                <p>Guidance from industry professionals.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="feature-box">
                <i class="fas fa-shield-alt"></i>
                <h5>Secure Platform</h5>
                <p>Advanced authentication and secure data protection.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="feature-box">
                <i class="fas fa-globe"></i>
                <h5>Nationwide Reach</h5>
                <p>Connecting talent with companies across India.</p>
            </div>
        </div>

    </div>
</div>

<!-- ================= CONTACT ================= -->
<div class="container mb-5">
    <div class="contact-section text-center">
        <h2 class="fw-bold mb-4">Contact Us</h2>
        <p><i class="fas fa-envelope"></i> support@carrierserviceportal.com</p>
        <p><i class="fas fa-phone"></i> +91-9876543210</p>
        <p><i class="fas fa-map-marker-alt"></i> 123 Career Street, Job City, India</p>
    </div>
</div>

</asp:Content>
