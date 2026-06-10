<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="~/StudentRegistration.aspx.cs" Inherits="Registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        /* ===== FONTS ===== */
@import url('https://fonts.googleapis.com/css2?family=Syne:wght@600;700;800&family=Inter:wght@300;400;500&display=swap');

/* ===== BACKGROUND ===== */
body {
    background: #050816;
    font-family: 'Inter', sans-serif;
    overflow-x: hidden;
}

/* animated gradient */
body::before {
    content: '';
    position: fixed;
    inset: 0;
    background:
        radial-gradient(circle at 20% 20%, rgba(99,102,241,0.25), transparent 40%),
        radial-gradient(circle at 80% 70%, rgba(236,72,153,0.25), transparent 40%),
        radial-gradient(circle at 50% 50%, rgba(6,182,212,0.15), transparent 50%);
    animation: moveBg 10s infinite alternate ease-in-out;
    z-index: 0;
}

@keyframes moveBg {
    from { transform: scale(1); }
    to { transform: scale(1.2); }
}

/* ===== CARD ===== */
.container1 {
    position: relative;
    z-index: 1;
    padding: 55px;
    border-radius: 28px;
    background: #5f728f;
    backdrop-filter: blur(40px);
    border: 1px solid rgba(255,255,255,0.1);
    box-shadow:
        0 0 0 1px rgba(99,102,241,0.2),
        0 30px 80px rgba(0,0,0,0.7);
    max-width: 900px;
    margin: 50px auto;
    animation: fadeUp 0.9s ease;
}

@keyframes fadeUp {
    from { opacity: 0; transform: translateY(40px); }
    to { opacity: 1; transform: translateY(0); }
}

/* glowing top line */
.container1::before {
    content: '';
    position: absolute;
    top: 0;
    left: 40px;
    right: 40px;
    height: 3px;
    background: linear-gradient(90deg, #6366f1, #06b6d4, #ec4899);
    border-radius: 0 0 6px 6px;
}

/* ===== HEADINGS ===== */
.container1 h1 {
    font-family: 'Syne', sans-serif;
    font-weight: 800;
    font-size: 34px;
    color: #fff;
}

.container1 p {
    color: rgba(255,255,255,0.6);
}

/* ===== GRID ===== */
.form-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 24px 32px;
}

/* ===== LABEL ===== */
label {
    font-size: 11px;
    letter-spacing: 1px;
    text-transform: uppercase;
    color: rgba(255,255,255,0.6);
}

/* ===== INPUT ===== */
input, select {
    width: 100%;
    padding: 14px 16px;
    border-radius: 14px;
    border: 1px solid rgba(255,255,255,0.12);
    background: rgba(255,255,255,0.06);
    color: black;
    font-size: 14px;
    transition: all 0.25s ease;
}

input::placeholder {
    color: rgba(255,255,255,0.4);
}

/* hover */
input:hover, select:hover {
    border-color: #6366f1;
}

/* focus glow */
input:focus, select:focus {
    border-color: #6366f1;
    box-shadow:
        0 0 0 2px rgba(99,102,241,0.3),
        0 0 20px rgba(99,102,241,0.3);
    background: rgba(99,102,241,0.08);
}

/* ===== BUTTON ===== */
.registerbtn {
    margin-top: 10px;
    padding: 16px;
    border-radius: 16px;
    border: none;
    background: linear-gradient(135deg,#6366f1,#4f46e5,#06b6d4);
    color: #fff;
    font-weight: 700;
    letter-spacing: 1.2px;
    cursor: pointer;
    transition: all 0.3s ease;
}

.registerbtn:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 30px rgba(99,102,241,0.6);
}

/* ===== VALIDATORS ===== */
.validator {
    color: #f87171;
    font-size: 11px;
}

/* ===== SIGNIN ===== */
.signin {
    margin-top: 30px;
    padding: 18px;
    border-radius: 16px;
    background: rgba(255,255,255,0.05);
    text-align: center;
}

.signin a {
    color: #6366f1;
    font-weight: 600;
}

/* ===== MOBILE ===== */
@media (max-width: 768px) {
    .form-grid {
        grid-template-columns: 1fr;
    }

    .container1 {
        padding: 30px;
    }
}
.field {
    display: flex;
    flex-direction: column;
    gap: 6px;
}
.field {
    display: flex;
    flex-direction: column;
    gap: 6px;
}

/* CGPA section sits below the grid, uses its own mini 2-col grid */
.cgpa-section {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 22px 32px;
    margin-top: 24px;
}

.cgpa-field {
    display: none; /* JS overrides this */
}

@media (max-width: 768px) {
    .cgpa-section {
        grid-template-columns: 1fr;
    }
}
    </style>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        function handleYearChange() {
            var ddl = document.getElementById('<%= ddlYear.ClientID %>');
            var year = ddl.value;

            var years = ['year1', 'year2', 'year3', 'year4', 'backlogDiv'];
            years.forEach(function (id) {
                document.getElementById(id).style.display = 'none';
            });

            if (year >= 1) { document.getElementById('year1').style.display = 'block'; document.getElementById('backlogDiv').style.display = 'block'; }
            if (year >= 2) document.getElementById('year2').style.display = 'block';
            if (year >= 3) document.getElementById('year3').style.display = 'block';
            if (year >= 4) document.getElementById('year4').style.display = 'block';
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container1 col-lg-6">
        <h1>Student Registration Form</h1>
        <p>Please fill in this form to create an account.</p>
        <hr>

        <div class="form-grid">

            <div class="field">
                <label style="color:black">Student ID</label>
                <asp:TextBox  ID="txtStudentID" placeholder="Enter Student ID" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvID" runat="server" ControlToValidate="txtStudentID"
                    ErrorMessage="Student ID is required" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="field">
                <label>Name</label>
                <asp:TextBox ID="txtname" placeholder="Enter Name" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtname"
                    ErrorMessage="Name is required" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="field">
            <label style="color:black">Email</label>
                <asp:TextBox ID="txtemail" placeholder="Enter Email" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtemail"
                    ErrorMessage="Email is required" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtemail"
                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                    ErrorMessage="Enter a valid email address" CssClass="validator" Display="Dynamic"></asp:RegularExpressionValidator>
            </div>

            <div class="field">
               <label style="color:black">Gender</label>
                <asp:DropDownList ID="ddlGender" runat="server">
                    <asp:ListItem Text="Select Gender" Value="" />
                    <asp:ListItem Text="Male" Value="Male" />
                    <asp:ListItem Text="Female" Value="Female" />
                    <asp:ListItem Text="Other" Value="Other" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvGender" runat="server"
                    ControlToValidate="ddlGender" InitialValue=""
                    ErrorMessage="Please select gender" CssClass="validator" Display="Dynamic">
                </asp:RequiredFieldValidator>
            </div>

            <div class="field">
                <label style="color:black">Skills</label>
                <asp:TextBox ID="txtskills" placeholder="Enter Skills"  runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvskill" runat="server" ControlToValidate="txtskills"
                    ErrorMessage="Skills are required" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revSkills" runat="server" ControlToValidate="txtskills"
                    ValidationExpression="^[a-zA-Z,#.\s]+$" ErrorMessage="Enter valid skills"
                    CssClass="validator" Display="Dynamic"></asp:RegularExpressionValidator>
            </div>

            <div class="field">
                 <label style="color:black">Date of Birth</label>
                <asp:TextBox ID="txtDob" runat="server" TextMode="Date"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDob" runat="server" ControlToValidate="txtDob"
                    ErrorMessage="Date of Birth is required" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="field">
                <label style="color:black">Year</label>
                <asp:DropDownList ID="ddlYear" runat="server" AutoPostBack="true"
                    OnSelectedIndexChanged="ddlYear_SelectedIndexChanged">
                    <asp:ListItem Text="Select Year" Value="" />
                    <asp:ListItem Text="1" Value="1" />
                    <asp:ListItem Text="2" Value="2" />
                    <asp:ListItem Text="3" Value="3" />
                    <asp:ListItem Text="4" Value="4" />
                </asp:DropDownList>
            </div>

            <div class="field">
                <label style="color:black">10th Percentage</label>
                <asp:TextBox ID="txt10th" runat="server" placeholder="Enter 10th %"></asp:TextBox>
            </div>

            <div class="field">
                 <label style="color:black">12th Percentage</label>
                <asp:TextBox ID="txt12th" runat="server" placeholder="Enter 12th %"></asp:TextBox>
            </div>

            <div class="field">
                 <label style="color:black">Mobile Number</label>
                <asp:TextBox ID="txtMobile" runat="server" placeholder="Enter Mobile No" MaxLength="10"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtMobile"
                    ErrorMessage="Mobile number is required" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revMobile" runat="server" ControlToValidate="txtMobile"
                    ValidationExpression="^[0-9]{10}$" ErrorMessage="Enter a valid 10-digit number"
                    CssClass="validator" Display="Dynamic"></asp:RegularExpressionValidator>
            </div>

            <div class="field">
                 <label style="color:black">Password</label>
                <asp:TextBox ID="txtpassword" placeholder="Enter Password" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtpassword"
                    ErrorMessage="Password is required" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="field">
                <label style="color:black">Confirm Password</label>
                <asp:TextBox ID="txtrepeatpass" placeholder="Repeat Password" runat="server" TextMode="Password"></asp:TextBox>
                <asp:CompareValidator ID="cvPassword" runat="server" ErrorMessage="Passwords do not match!"
                    ControlToValidate="txtrepeatpass" ControlToCompare="txtpassword"
                    CssClass="validator" Display="Dynamic"></asp:CompareValidator>
            </div>

            <div class="field">
               <label style="color:black">Upload Photo</label>
                <asp:FileUpload ID="fuPhoto" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvPhoto" runat="server" ControlToValidate="fuPhoto"
                    ErrorMessage="Please upload a photo" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="field">
              <label style="color:black">Upload Resume (PDF)</label>
                <asp:FileUpload ID="fuResume" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvResume" runat="server" ControlToValidate="fuResume"
                    ErrorMessage="Please upload your resume" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

        </div>

        <%-- CGPA SECTION: outside the grid, always renders cleanly --%>
        <div class="cgpa-section">

            <div id="year1" runat="server" class="field cgpa-field" style="display:none;">
               <label style="color:black">1st Year CGPA</label>
                <asp:TextBox ID="txtY1" runat="server" placeholder="Enter CGPA"></asp:TextBox>
            </div>

            <div id="year2" runat="server" class="field cgpa-field" style="display:none;">
             <label style="color:black">2nd Year CGPA</label>
                <asp:TextBox ID="txtY2" runat="server" placeholder="Enter CGPA"></asp:TextBox>
            </div>

            <div id="year3" runat="server" class="field cgpa-field" style="display:none;">
               <label style="color:black">3rd Year CGPA</label>
                <asp:TextBox ID="txtY3" runat="server" placeholder="Enter CGPA"></asp:TextBox>
            </div>

            <div id="year4" runat="server" class="field cgpa-field" style="display:none;">
               <label style="color:black">4th Year CGPA</label>
                <asp:TextBox ID="txtY4" runat="server" placeholder="Enter CGPA"></asp:TextBox>
            </div>

            <div id="backlogDiv" runat="server" class="field cgpa-field" style="display:none;">
             <label style="color:black">Backlog Count</label>
                <asp:TextBox ID="txtbacklog" runat="server" placeholder="Enter Backlog count"></asp:TextBox>
            </div>

        </div>

        <asp:Button ID="btnsubmit" class="registerbtn full-width" runat="server"
            Text="Register" OnClick="btnsubmit_Click" CausesValidation="true" />

        <div class="signin">
            <p>Already have an account? <a href="StudentLogin.aspx">Sign in</a>.</p>
        </div>
    </div>
</asp:Content>