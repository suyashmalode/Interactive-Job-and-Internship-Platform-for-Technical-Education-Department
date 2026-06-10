<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="AdminDashboard.aspx.cs" Inherits="Admin_AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
       <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        .dashboard-container {
            padding: 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Poppins', sans-serif;
            position: relative;
            overflow: hidden;
        }
        
        .dashboard-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><defs><pattern id="grid" width="100" height="100" patternUnits="userSpaceOnUse"><path d="M 100 0 L 0 0 0 100" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="1"/></pattern></defs><rect width="100%" height="100%" fill="url(%23grid)"/></svg>');
            opacity: 0.3;
            pointer-events: none;
        }
        
        .dashboard-title {
            font-size: 42px;
            font-weight: 700;
            color: #fff;
            margin-bottom: 40px;
            text-align: center;
            text-shadow: 0 4px 12px rgba(0,0,0,0.2);
            letter-spacing: 1px;
            animation: fadeInDown 0.8s ease;
            position: relative;
            z-index: 1;
        }
        
        .dashboard-title::after {
            content: '';
            display: block;
            width: 100px;
            height: 4px;
            background: linear-gradient(90deg, #fff, transparent);
            margin: 15px auto 0;
            border-radius: 2px;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            margin-bottom: 30px;
            position: relative;
            z-index: 1;
        }
        
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }
        
        @keyframes glow {
            0%, 100% {
                box-shadow: 0 8px 24px rgba(0,0,0,0.15), 0 0 0 0 rgba(255,255,255,0.3);
            }
            50% {
                box-shadow: 0 12px 32px rgba(0,0,0,0.2), 0 0 20px 5px rgba(255,255,255,0.2);
            }
        }
        
        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 35px 30px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.15);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            border: 1px solid rgba(255,255,255,0.3);
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.6s ease forwards;
            opacity: 0;
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, transparent 0%, rgba(255,255,255,0.3) 100%);
            opacity: 0;
            transition: opacity 0.4s ease;
        }
        
        .stat-card:hover::before {
            opacity: 1;
        }
        
        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:nth-child(3) { animation-delay: 0.3s; }
        .stat-card:nth-child(4) { animation-delay: 0.4s; }
        .stat-card:nth-child(5) { animation-delay: 0.5s; }
        
        .stat-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 20px 40px rgba(0,0,0,0.25);
        }
        
        .stat-card::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            border-radius: 20px 0 0 20px;
            transition: width 0.4s ease;
        }
        
        .stat-card:hover::after {
            width: 100%;
            opacity: 0.1;
        }
        
        .stat-card.students::after {
            background: linear-gradient(180deg, #4CAF50, #45a049);
        }
        
        .stat-card.companies::after {
            background: linear-gradient(180deg, #2196F3, #1976D2);
        }
        
        .stat-card.internships::after {
            background: linear-gradient(180deg, #FF9800, #F57C00);
        }
        
        .stat-card.applied::after {
            background: linear-gradient(180deg, #9C27B0, #7B1FA2);
        }
        
        .stat-card.rejected::after {
            background: linear-gradient(180deg, #F44336, #D32F2F);
        }
        
        .stat-icon-wrapper {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
            transition: all 0.4s ease;
            position: relative;
            z-index: 1;
        }
        
        .stat-card:hover .stat-icon-wrapper {
            transform: rotate(360deg) scale(1.1);
        }
        
        .stat-card.students .stat-icon-wrapper {
            background: linear-gradient(135deg, #4CAF50, #45a049);
            box-shadow: 0 8px 16px rgba(76, 175, 80, 0.3);
        }
        
        .stat-card.companies .stat-icon-wrapper {
            background: linear-gradient(135deg, #2196F3, #1976D2);
            box-shadow: 0 8px 16px rgba(33, 150, 243, 0.3);
        }
        
        .stat-card.internships .stat-icon-wrapper {
            background: linear-gradient(135deg, #FF9800, #F57C00);
            box-shadow: 0 8px 16px rgba(255, 152, 0, 0.3);
        }
        
        .stat-card.applied .stat-icon-wrapper {
            background: linear-gradient(135deg, #9C27B0, #7B1FA2);
            box-shadow: 0 8px 16px rgba(156, 39, 176, 0.3);
        }
        
        .stat-card.rejected .stat-icon-wrapper {
            background: linear-gradient(135deg, #F44336, #D32F2F);
            box-shadow: 0 8px 16px rgba(244, 67, 54, 0.3);
        }
        
        .stat-icon {
            font-size: 40px;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.2));
        }
        
        .stat-number {
            font-size: 48px;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 12px;
            position: relative;
            z-index: 1;
            transition: all 0.3s ease;
        }
        
        .stat-card:hover .stat-number {
            transform: scale(1.1);
        }
        
        .stat-label {
            font-size: 18px;
            color: #555;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 600;
            margin-bottom: 8px;
            position: relative;
            z-index: 1;
        }
        
        .stat-description {
            font-size: 14px;
            color: #888;
            line-height: 1.6;
            font-weight: 400;
            position: relative;
            z-index: 1;
        }
        
        .stat-trend {
            display: inline-block;
            margin-top: 15px;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            background: rgba(76, 175, 80, 0.1);
            color: #4CAF50;
            position: relative;
            z-index: 1;
        }
        
        @media (max-width: 768px) {
            .dashboard-container {
                padding: 20px;
            }
            
            .dashboard-title {
                font-size: 32px;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .stat-number {
                font-size: 38px;
            }
        }
        
        @media (prefers-reduced-motion: reduce) {
            .stat-card,
            .stat-icon-wrapper,
            .stat-number {
                animation: none;
                transition: none;
            }
        }
    </style>

    <div class="dashboard-container">
        <h1 class="dashboard-title">📊 Admin Dashboard</h1>
        
<div class="stats-grid">

    <!-- Total Students Card -->
    <asp:HyperLink ID="hlStudents" runat="server" NavigateUrl="~/Admin/ManageStudent.aspx" CssClass="card-link">
        <div class="stat-card students">
            <div class="stat-icon-wrapper">
                <div class="stat-icon">👨‍🎓</div>
            </div>
            <div class="stat-number">
                <asp:Label ID="lblTotalStudents" runat="server" Text="0"></asp:Label>
            </div>
            <div class="stat-label">Total Students</div>
            <div class="stat-description">Registered students in the portal</div>
            <div class="stat-trend">↗ Active</div>
        </div>
    </asp:HyperLink>

    <!-- Total Companies Card -->
    <asp:HyperLink ID="hlCompanies" runat="server" NavigateUrl="~/Admin/ManageCompany.aspx" CssClass="card-link">
        <div class="stat-card companies">
            <div class="stat-icon-wrapper">
                <div class="stat-icon">🏢</div>
            </div>
            <div class="stat-number">
                <asp:Label ID="lblTotalCompanies" runat="server" Text="0"></asp:Label>
            </div>
            <div class="stat-label">Total Companies</div>
            <div class="stat-description">Registered companies</div>
            <div class="stat-trend">↗ Growing</div>
        </div>
    </asp:HyperLink>

    <!-- Total Internships Card -->
    <asp:HyperLink ID="hlInternships" runat="server" NavigateUrl="~/Admin/ManageInternship.aspx" CssClass="card-link">
        <div class="stat-card internships">
            <div class="stat-icon-wrapper">
                <div class="stat-icon">💼</div>
            </div>
            <div class="stat-number">
                <asp:Label ID="lblTotalInternships" runat="server" Text="0"></asp:Label>
            </div>
            <div class="stat-label">Total Internships</div>
            <div class="stat-description">Available internship positions</div>
            <div class="stat-trend">↗ Available</div>
        </div>
    </asp:HyperLink>

    <!-- Applied Students Card -->
    <asp:HyperLink ID="hlApplied" runat="server" NavigateUrl="~/Admin/ApprovestudentList.aspx" CssClass="card-link">
        <div class="stat-card applied">
            <div class="stat-icon-wrapper">
                <div class="stat-icon">📝</div>
            </div>
            <div class="stat-number">
                <asp:Label ID="lblAppliedStudents" runat="server" Text="0"></asp:Label>
            </div>
            <div class="stat-label">Applied Students</div>
            <div class="stat-description">Students who applied for internships</div>
            <div class="stat-trend">↗ Engaged</div>
        </div>
    </asp:HyperLink>

    <!-- Rejected Applications Card -->
    <asp:HyperLink ID="hlRejected" runat="server" NavigateUrl="~/Admin/RejectedStudentList.aspx" CssClass="card-link">
        <div class="stat-card rejected">
            <div class="stat-icon-wrapper">
                <div class="stat-icon">❌</div>
            </div>
            <div class="stat-number">
                <asp:Label ID="lblRejectedApplications" runat="server" Text="0"></asp:Label>
            </div>
            <div class="stat-label">Rejected Applications</div>
            <div class="stat-description">Applications that were rejected</div>
            <div class="stat-trend">↓ Tracked</div>
        </div>
    </asp:HyperLink>

</div>    </div>
</asp:Content>