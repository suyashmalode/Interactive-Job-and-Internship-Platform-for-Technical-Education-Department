<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CompanyRegistration.aspx.cs" Inherits="Admin_CompanyRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
  /* ===== PAGE BACKGROUND ===== */
body {
    font-family: 'Segoe UI', sans-serif;
    background: linear-gradient(135deg, #0f172a, #1e293b, #111827);
    margin: 0;
    padding: 40px 0;
}

/* ===== MAIN CARD ===== */
.container1 {
    padding: 40px;
    background: rgba(255, 255, 255, 0.12);
    backdrop-filter: blur(25px);
    border-radius: 25px;
    margin: auto;
    max-width: 550px;
    box-shadow: 0 25px 70px rgba(0, 0, 0, 0.7);
    border: 1px solid rgba(255, 255, 255, 0.25);
    animation: fadeIn 0.8s ease-in-out;
    display: flex;
    flex-direction: column;
}

/* Animation */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px);}
    to { opacity: 1; transform: translateY(0);}
}

/* ===== HEADINGS ===== */
.container1 h2 {
    font-weight: 800;
    font-size: 26px;
    color: #000;
}

.container1 p {
    color: #000;
    font-size: 14px;
}

/* ===== INPUT FIELDS ===== */
input[type=text],
input[type=password],
input[type=email],
input[type=tel],
input[type=file],
select,
textarea {
    width: 100%;
    padding: 14px 16px;
    margin: 8px 0 20px 0;
    border-radius: 12px;
    border: 1px solid rgba(0,0,0,0.4);
    background: rgba(255,255,255,0.95);
    color: #000;
    font-size: 14px;
    transition: all 0.3s ease;
}

/* Hover effect */
input:hover,
textarea:hover,
select:hover {
    transform: scale(1.02);
}

/* Focus glow */
input:focus,
textarea:focus,
select:focus {
    border-color: #2563eb;
    box-shadow: 0 0 15px rgba(37,99,235,0.6);
    outline: none;
    transform: scale(1.03);
}

/* ===== BUTTON ===== */
.registerbtn {
    background: linear-gradient(135deg, #2563eb, #1d4ed8);
    color: white;
    padding: 15px 0;
    border: none;
    border-radius: 14px;
    font-size: 17px;
    font-weight: 700;
    cursor: pointer;
    transition: all 0.3s ease;
    letter-spacing: 0.5px;
}

.registerbtn:hover {
    transform: translateY(-4px);
    box-shadow: 0 15px 35px rgba(37,99,235,0.7);
}

/* ===== LABELS ===== */
label {
    font-weight: 600;
    font-size: 14px;
    color: #000;
}

/* ===== VALIDATION STYLE ===== */
span[style*="color:#dc3545"],
.aspNetDisabled {
    font-size: 12px;
    font-weight: 500;
}

/* ===== SIGNIN BOX ===== */
.signin {
    margin-top: 25px;
    padding: 18px;
    border-radius: 20px;
    background: rgba(255,255,255,0.15);
    backdrop-filter: blur(15px);
    text-align: center;
    color: #000;
}

.signin a {
    color: #2563eb;
    font-weight: 600;
    text-decoration: none;
}

.signin a:hover {
    text-decoration: underline;
}

/* ===== RESPONSIVE ===== */
@media(max-width: 576px) {
    .container1 {
        width: 90%;
        padding: 25px;
    }
}

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container1">
        <h2>Company Registration Form</h2>
        <p>Please fill in this form to create an account.</p>
        <hr />

        <label for="txtcompanyname"><b>Company Name</b></label>
        <asp:TextBox ID="txtcompanyname" placeholder="Enter Company Name" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Company Name is required" ForeColor="#dc3545" ControlToValidate="txtcompanyname" Display="Dynamic" />

        <label for="txthrname"><b>HR Name</b></label>
        <asp:TextBox ID="txthrname" placeholder="Enter HR Name" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="HR Name is required" ForeColor="#dc3545" ControlToValidate="txthrname" Display="Dynamic" />

        <label for="txthrmobile"><b>HR Mobile</b></label>
        <asp:TextBox ID="txthrmobile" placeholder="Enter HR Mobile" MaxLength="10" runat="server" TextMode="Phone"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1"  runat="server" ErrorMessage="HR Mobile is required" ForeColor="#dc3545" ControlToValidate="txthrmobile" Display="Dynamic" />

        <label for="txthremail"><b>HR Email ID</b></label>
        <asp:TextBox ID="txthremail" placeholder="Enter HR Email ID" runat="server" TextMode="Email"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="HR Email is required" ForeColor="#dc3545" ControlToValidate="txthremail" Display="Dynamic" />

        <label for="txtdesignation"><b>HR Designation</b></label>
        <asp:TextBox ID="txtdesignation" placeholder="Enter HR Designation" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="HR Designation is required" ForeColor="#dc3545" ControlToValidate="txtdesignation" Display="Dynamic" />

        <label for="txtcompanyaddress"><b>Company Address</b></label>
        <asp:TextBox ID="txtcompanyaddress" placeholder="Enter Company Address" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Company Address is required" ForeColor="#dc3545" ControlToValidate="txtcompanyaddress" Display="Dynamic" />

        <label for="txtpassword"><b>Password</b></label>
        <asp:TextBox ID="txtpassword" placeholder="Enter Password" runat="server" TextMode="Password"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Password is required" ForeColor="#dc3545" ControlToValidate="txtpassword" Display="Dynamic" />

        <label for="fuclogo"><b>Company Logo</b></label>
        <asp:FileUpload ID="fuclogo" runat="server" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Company Logo is required" ForeColor="#dc3545" ControlToValidate="fuclogo" Display="Dynamic" />

        <label for="fuDocument"><b>Company Document (e.g. Registration Certificate)</b></label>
        <asp:FileUpload ID="fuDocument" runat="server" />
           <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Document is required" ForeColor="#dc3545" ControlToValidate="fuDocument" Display="Dynamic" />
 

        <hr />

        <asp:Button ID="btnsubmit" class="registerbtn" runat="server" Text="Register" OnClick="btnsubmit_Click" />
    </div>

    <div class="container1 signin">
        <p>Already have an account? <a href="CompanyLogin.aspx">Sign in</a>.</p>
    </div>
</asp:Content>
