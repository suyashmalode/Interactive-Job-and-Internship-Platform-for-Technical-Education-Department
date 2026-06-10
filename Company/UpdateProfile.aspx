<%@ Page Title="" Language="C#" MasterPageFile="~/Company/CompanyMasterPage.master" AutoEventWireup="true" CodeFile="UpdateProfile.aspx.cs" Inherits="Company_UpdateProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: black;
        }

        .container1 {
            padding: 16px;
            background-color: white;
            margin: auto;
            display: flex;
            flex-direction: column;
            max-width: 500px;
            border-radius: 10px;
        }

        input[type=text], input[type=password], select {
            width: 100%;
            padding: 15px;
            margin: 5px 0 22px 0;
            display: inline-block;
            border: 1px solid #ccc;
            background: #f1f1f1;
            border-radius: 5px;
            font-size: 16px;
        }

        input:focus, select:focus {
            background-color: #ddd;
            outline: none;
        }

        .registerbtn {
            background-color: #3b82f6;
            color: white;
            padding: 16px 20px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 100%;
            opacity: 0.9;
            border-radius: 5px;
            font-size: 18px;
        }

        .registerbtn:hover {
            opacity: 1;
        }

        .signin {
            background-color: #f1f1f1;
            text-align: center;
            padding: 10px;
            border-radius: 5px;
        }
    </style>
     <script>
        function previewImage(event) {
            var reader = new FileReader();
            reader.onload = function () {
                var img = document.getElementById('<%= imgPreview.ClientID %>');
                img.src = reader.result;
            };
            reader.readAsDataURL(event.target.files[0]);
        }
     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="container1">
        <h1> Update Profile </h1>
        <hr>

          
     <asp:Image ID="imgPreview" runat="server" Width="100px" Height="100px" />
<asp:FileUpload ID="fuphoto" runat="server" onchange="previewImage(event)" />
          <br />
        <label for="txtcompanyname"><b>Company Name</b></label>
        <asp:TextBox ID="txtcompanyname" placeholder="Enter Company Name" runat="server"></asp:TextBox>
      <%--  <asp:RequiredFieldValidator ID="rfvCompanyName" runat="server" ErrorMessage="Required field" 
            ForeColor="Red" ControlToValidate="txtcompanyname" Display="Dynamic"></asp:RequiredFieldValidator>--%>

        <label for="txthrname"><b>HR Name</b></label>
        <asp:TextBox ID="txthrname" placeholder="Enter HR Name" runat="server"></asp:TextBox>
       <%-- <asp:RequiredFieldValidator ID="rfvHRName" runat="server" ErrorMessage="Required field" 
            ForeColor="Red" ControlToValidate="txthrname" Display="Dynamic"></asp:RequiredFieldValidator>--%>

        <label for="txthrmobile"><b>HR Mobile</b></label>
        <asp:TextBox ID="txthrmobile" placeholder="Enter HR Mobile" runat="server"></asp:TextBox>
       <%-- <asp:RequiredFieldValidator ID="rfvHRMobile" runat="server" ErrorMessage="Required field" 
            ForeColor="Red" ControlToValidate="txthrmobile" Display="Dynamic"></asp:RequiredFieldValidator>--%>

        <label for="txthremail"><b>HR Email ID</b></label>
        <asp:TextBox ID="txthremail" placeholder="Enter HR Email ID" runat="server"></asp:TextBox>
  <%--      <asp:RequiredFieldValidator ID="rfvHREmail" runat="server" ErrorMessage="Required field" 
            ForeColor="Red" ControlToValidate="txthremail" Display="Dynamic"></asp:RequiredFieldValidator>--%>

        <label for="txtdesignation"><b>HR Designation</b></label>
        <asp:TextBox ID="txtdesignation" placeholder="Enter HR Designation" runat="server"></asp:TextBox>
     <%--   <asp:RequiredFieldValidator ID="rfvDesignation" runat="server" ErrorMessage="Required field" 
            ForeColor="Red" ControlToValidate="txtdesignation" Display="Dynamic"></asp:RequiredFieldValidator>--%>

        <label for="txtcompanyaddress"><b>Company Address</b></label>
        <asp:TextBox ID="txtcompanyaddress" placeholder="Enter Address" runat="server"></asp:TextBox>
      <%--  <asp:RequiredFieldValidator ID="rfvCompanyAddress" runat="server" ErrorMessage="Required field" 
            ForeColor="Red" ControlToValidate="txtcompanyaddress" Display="Dynamic"></asp:RequiredFieldValidator>--%>

        <label for="txtpassword"><b>Password</b></label>
        <asp:TextBox ID="txtpassword" placeholder="Enter Password" runat="server" TextMode="singleline"></asp:TextBox>
       <%-- <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Required field" 
            ForeColor="Red" ControlToValidate="txtpassword" Display="Dynamic"></asp:RequiredFieldValidator>--%>

    
       <%-- <asp:RequiredFieldValidator ID="rfvLogo" runat="server" ErrorMessage="Required field" 
            ForeColor="Red" ControlToValidate="fuclogo" Display="Dynamic"></asp:RequiredFieldValidator>--%>

        <hr>
          <label for="document"><b>Company Document</b></label>
<asp:FileUpload ID="fuDocument" runat="server" CssClass="form-control" />
<asp:HyperLink ID="lnkExistingDoc" runat="server" 
               Text="View Current Document" 
               Target="_blank" 
               Visible="false"></asp:HyperLink>
<hr />

        
        <!-- Update Button -->
        <asp:Button ID="btnUpdate" class="registerbtn" runat="server" Text="Update" OnClick="btnUpdate_Click"  />

    </div>

    <%--<div class="container1 signin">
        <p>Already have an account? <a href="CompanyLogin.aspx">Sign in</a>.</p>
    </div>--%>

</asp:Content>

