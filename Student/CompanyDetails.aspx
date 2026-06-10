<%@ Page Title="Company Details" Language="C#" MasterPageFile="~/Student/StudentMasterPage.master" AutoEventWireup="true" CodeFile="CompanyDetails.aspx.cs" Inherits="Student_CompanyDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

    <style>

        /* Header Banner */
        .header-banner {
            background: linear-gradient(135deg, #0d6efd, #6f42c1);
            padding: 40px 20px;
            border-radius: 12px;
            color: white;
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
            text-align: center;
            margin-bottom: 35px;
        }

        .header-banner h1 {
            font-size: 36px;
            font-weight: 700;
        }

        .company-card {
            background: #ffffff;
            border-radius: 18px;
            padding: 35px;
            max-width: 850px;
            margin: auto;
            box-shadow: 0 12px 28px rgba(0,0,0,0.12);
            border-left: 6px solid #0d6efd;
        }

        .logo-wrapper {
            text-align: center;
        }

        .logo-wrapper img {
            width: 170px;
            height: 170px;
            border-radius: 12px;
            object-fit: cover;
            border: 3px solid #e5e5e5;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            margin-bottom: 20px;
        }

        .info-row {
            font-size: 18px;
            padding: 15px 0;
            border-bottom: 1px solid #f2f2f2;
        }

        .info-row i {
            color: #0d6efd;
            width: 30px;
        }

        .document-btn {
            margin-top: 15px;
            display: inline-block;
            padding: 10px 22px;
            background: #212529;
            color: white;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
        }

        .document-btn:hover {
            background: #000;
            text-decoration: none;
        }

    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<!-- Header Section -->
<div class="container">
    <div class="header-banner">
        <h1><i class="fa-solid fa-building"></i> Company Details</h1>
        <p style="margin-top: 8px;">Explore all the details of the selected company.</p>
    </div>
</div>

<!-- Company Card -->
<div class="container">
    <div class="company-card">

        <!-- Logo -->
        <div class="logo-wrapper">
            <asp:Image ID="imgLogo" runat="server" AlternateText="Company Logo" />
        </div>

        <!-- Company Name -->
        <div class="info-row">
            <i class="fa-solid fa-building"></i>
            <strong>Company Name:</strong>
            <asp:Label ID="lblName" runat="server"></asp:Label>
        </div>

        <!-- Address -->
        <div class="info-row">
            <i class="fa-solid fa-location-dot"></i>
            <strong>Address:</strong>
            <asp:Label ID="lblAddress" runat="server"></asp:Label>
        </div>

        <!-- Email -->
        <div class="info-row">
            <i class="fa-solid fa-envelope"></i>
            <strong>Email:</strong>
            <asp:Label ID="lblEmail" runat="server"></asp:Label>
        </div>

        <!-- Phone -->
        <div class="info-row">
            <i class="fa-solid fa-phone"></i>
            <strong>Phone:</strong>
            <asp:Label ID="lblPhone" runat="server"></asp:Label>
        </div>

        <!-- Document -->
        <div class="mt-3 text-center">
            <asp:HyperLink ID="lnkDocument" runat="server" 
                CssClass="document-btn"
                Target="_blank"
                Text="View Company Document"
                Visible="false"></asp:HyperLink>
        </div>

    </div>
</div>

</asp:Content>
