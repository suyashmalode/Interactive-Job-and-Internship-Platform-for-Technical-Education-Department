<%@ Page Title="" Language="C#" MasterPageFile="~/Company/CompanyMasterPage.master" AutoEventWireup="true" CodeFile="ViewStudentDetails.aspx.cs" Inherits="Company_ViewStudentDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: #f0f2f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card {
            max-width: 800px;
            margin: 3rem auto;
            padding: 2rem 2.5rem;
            border-radius: 1rem;
            box-shadow: 0 8px 24px rgb(0 0 0 / 0.1);
            background: #ffffff;
        }
        .header-text {
            font-weight: 900;
            color: #004085;
            letter-spacing: 0.1em;
            text-align: center;
            text-transform: uppercase;
            margin-bottom: 2rem;
            user-select: none;
        }
        dt {
            font-weight: 700;
            color: #0d6efd;
            font-size: 1.1rem;
            margin-bottom: 0.3rem;
        }
        dd {
            margin-bottom: 1.5rem;
            font-size: 1.15rem;
            color: #343a40;
            word-break: break-word;
        }
        .btn-resume {
            background: linear-gradient(135deg, #0069d9, #004085);
            color: #fff;
            font-weight: 700;
            padding: 0.6rem 1.5rem;
            border-radius: 0.5rem;
            border: none;
            box-shadow: 0 4px 15px rgb(0 64 128 / 0.3);
            transition: all 0.3s ease;
            display: inline-block;
            text-decoration: none !important;
        }
        .btn-resume:hover,
        .btn-resume:focus {
            background: linear-gradient(135deg, #004085, #002752);
            box-shadow: 0 6px 20px rgb(0 64 128 / 0.6);
            color: #fff !important;
            text-decoration: none;
        }
        .student-photo {
            width: 180px;
            height: 180px;
            object-fit: cover;
            border-radius: 1rem;
            box-shadow: 0 4px 12px rgb(0 0 0 / 0.15);
            border: 3px solid #0d6efd;
        }
        @media (max-width: 767.98px) {
            .card {
                padding: 1.5rem 1.5rem;
                margin: 2rem 1rem;
            }
            dt, dd {
                font-size: 1rem;
            }
            .btn-resume {
                width: 100%;
                text-align: center;
            }
            .student-photo {
                width: 100%;
                height: auto;
                margin-bottom: 1.5rem;
                border-radius: 1rem;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Panel ID="pnlDetails" runat="server" Visible="false" CssClass="card">
        <h1 class="header-text">Student Application Details</h1>

        <div class="row align-items-center">
            <div class="col-md-4 text-center mb-4 mb-md-0">
                <asp:Image ID="imgPhoto" runat="server" CssClass="student-photo" AlternateText="Student Photo" />
            </div>
            <div class="col-md-8">
                <dl>
                    <dt>Name:</dt>
                    <dd><asp:Label ID="lblName" runat="server" /></dd>

                    <dt>Email:</dt>
                    <dd><asp:Label ID="lblEmail" runat="server" /></dd>

                    <dt>Mobile:</dt>
                    <dd><asp:Label ID="lblMobile" runat="server" /></dd>

                    

                    <dt>Application Date:</dt>
                    <dd><asp:Label ID="lblAppDate" runat="server" /></dd>

                    <dt>Status:</dt>
                    <dd><asp:Label ID="lblStatus" runat="server" /></dd>

                  

                  
                </dl>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlNotFound" runat="server" Visible="false" CssClass="alert alert-danger text-center fw-bold fs-5">
        Student application not found.
    </asp:Panel>
</asp:Content>
