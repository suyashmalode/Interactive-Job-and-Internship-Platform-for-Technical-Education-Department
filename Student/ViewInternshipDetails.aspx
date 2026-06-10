<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentMasterPage.master" AutoEventWireup="true" CodeFile="ViewInternshipDetails.aspx.cs" Inherits="Student_ViewInternshipDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        .detail-card {
            border-radius: 18px;
            background: #ffffff;
            padding: 35px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.12);
            border-left: 6px solid #0d6efd;
        }

        .detail-heading {
            font-weight: 700;
            font-size: 32px;
            color: #0d6efd;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .detail-row strong {
            width: 180px;
            display: inline-block;
            color: #222;
        }

        .detail-row {
            padding: 12px 0;
            border-bottom: 1px solid #efefef;
            font-size: 17px;
        }

        .pdf-btn {
            padding: 10px 20px;
            border-radius: 30px;
            font-weight: 600;
        }

        .gradient-bg {
            background: linear-gradient(135deg, #0d6efd, #6610f2);
            color: white;
            padding: 35px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        .label-title {
            font-size: 20px;
            font-weight: 600;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="container mt-4">

    <!-- Header Section -->
    <div class="gradient-bg text-center">
        <h1 class="detail-heading" style="color:white"><i class="fa-solid fa-briefcase" ></i> Internship Details</h1>
        <p class="mb-0">Explore complete details of the selected internship opportunity.</p>
    </div>

    <!-- Details Card -->
    <div class="detail-card">

        <div class="detail-row">
            <strong><i class="fa-solid fa-heading text-primary"></i> Title:</strong>
            <asp:Label ID="lblTitle" runat="server" CssClass="label-title"></asp:Label>
        </div>

        <div class="detail-row">
            <strong><i class="fa-solid fa-file-lines text-primary"></i> Description:</strong>
            <asp:Label ID="lblDescription" runat="server"></asp:Label>
        </div>

        <div class="detail-row">
            <strong><i class="fa-solid fa-location-dot text-primary"></i> Location:</strong>
            <asp:Label ID="lblLocation" runat="server"></asp:Label>
        </div>

        <div class="detail-row">
            <strong><i class="fa-solid fa-user-check text-primary"></i> Eligibility:</strong>
            <asp:Label ID="lblEligibility" runat="server"></asp:Label>
        </div>

        <div class="detail-row">
            <strong><i class="fa-solid fa-indian-rupee-sign text-primary"></i> Salary:</strong>
            <asp:Label ID="lblSalary" runat="server"></asp:Label>
        </div>

        <div class="detail-row">
            <strong><i class="fa-solid fa-calendar-plus text-primary"></i> Posted Date:</strong>
            <asp:Label ID="lblPostedDate" runat="server"></asp:Label>
        </div>

        <div class="detail-row">
            <strong><i class="fa-solid fa-calendar-check text-primary"></i> Last Date:</strong>
            <asp:Label ID="lblLastDate" runat="server"></asp:Label>
        </div>

        <div class="detail-row text-center mt-3">
            <asp:HyperLink ID="hlPDF" runat="server" 
                Text="View Related PDF Document"
                CssClass="btn btn-dark pdf-btn"
                Target="_blank" />
        </div>

    </div>
</div>

</asp:Content>
