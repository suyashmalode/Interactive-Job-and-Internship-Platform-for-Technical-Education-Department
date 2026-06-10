<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AdminLogin.aspx.cs" Inherits="AdminLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
/*body {
    font-family: 'Segoe UI', sans-serif;
    background: linear-gradient(135deg, #0f172a, #1e293b);
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}*/

/* Main Login Card */
.container1 {
    padding: 40px;
    background: rgba(255, 255, 255, 0.08);
    backdrop-filter: blur(15px);
    border-radius: 20px;
    box-shadow: 0 15px 40px rgba(0, 0, 0, 0.5);
    margin: 20px auto;
    display: flex;
    flex-direction: column;
    color: white;
    border: 1px solid rgba(255, 255, 255, 0.2);
    animation: fadeIn 0.8s ease-in-out;
}

/* Headings */
.container1 h1 {
    font-weight: 700;
    color: #ffffff;
}

.container1 p {
    color: #cbd5e1;
}

/* Input Fields */
input[type=text],
input[type=password],
.aspNetTextBox {
    width: 100%;
    padding: 14px 18px;
    margin: 8px 0 20px 0;
    border-radius: 12px;
    border: 1px solid rgba(255,255,255,0.3);
    background: rgba(255,255,255,0.1);
    color: black;
    font-size: 15px;
    transition: all 0.3s ease;
}

input[type=text]:focus,
input[type=password]:focus {
    background: rgba(255,255,255,0.2);
    border-color: #3b82f6;
    box-shadow: 0 0 10px #3b82f6;
    outline: none;
}

/* Labels */
label {
    font-weight: 600;
    margin-bottom: 5px;
}

/* Login Button */
.registerbtn {
    background: linear-gradient(135deg, #3b82f6, #2563eb);
    color: white;
    padding: 14px;
    border: none;
    border-radius: 12px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
}

.registerbtn:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 20px rgba(59, 130, 246, 0.6);
}

/* Forgot password link */
a {
    color: #60a5fa;
    text-decoration: none;
    font-weight: 500;
}

a:hover {
    text-decoration: underline;
}

/* Sign in section */
.signin {
    margin-top: 15px;
    border-radius: 15px;
    padding: 15px;
    background: rgba(255,255,255,0.05);
    color: white;
}

/* Animation */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Responsive */
@media (max-width: 768px) {
    .container1 {
        padding: 25px;
    }
}
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="container1 col-lg-6" style="">
    <h1 style="font-family:'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif; color:black">Admin Login</h1>
    <p style="font-style:italic; color:black">Please enter your email and password to login.</p>
    <hr>

    <label for="txtemail" style="color:black" ><b>Email</b></label>
    <asp:TextBox ID="txtusername" class="border border-dark" placeholder="Enter Admin Email" runat="server"></asp:TextBox>

    <label for="psw" style="color:black"><b>Password</b></label>
    <asp:TextBox ID="txtpassword" class="border border-dark" placeholder="Enter Password" runat="server" TextMode="Password"></asp:TextBox>
         <asp:Label ID="lblshow" runat="server" Text=""></asp:Label>
    <p style="text-align: right; margin-top: -15px;">
<%--    <a href="ForgetPassword.aspx">Forgot Password?</a>--%>
</p>
    <hr>
    <asp:Button ID="Button1" class="registerbtn" runat="server" Text="Login" OnClick="Button1_Click" />
  </div>
  
  <%--<div class="container1 signin">
    <p>Don't have an account? <a href="StudentRegistration.aspx">Sign up</a>.</p>
  </div>--%>
</asp:Content>

