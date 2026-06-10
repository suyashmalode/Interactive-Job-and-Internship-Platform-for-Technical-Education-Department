<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentMasterPage.master" AutoEventWireup="true" CodeFile="UpdateProfile.aspx.cs" Inherits="User_EditProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <style>
        /* General Page Styling */
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }

        /* Form Container */
        .container {
            max-width: 900px;
            margin: auto;
        }

        /* Form Styling */
        .card {
            border-radius: 15px;
            background: #ffffff;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        /* Labels */
        .form-label {
            font-weight: bold;
        }

        /* Input Fields */
        .form-control, .form-select {
            border-radius: 8px;
            padding: 10px;
        }

        /* Button */
        .btn-primary {
            background: #007bff;
            border-radius: 15px;
        }

        /* Image Preview */
        #imgPreview {
            width: 120px;
            height: 120px;
            border-radius: 10px;
            border: 2px solid #ccc;
            margin-top: 10px;
        }
        #imgPreview {
    border: 2px solid #ccc;
    padding: 5px;
    object-fit: cover;
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
     <div class="container mt-4">
        <div class="card p-4">
            <h3 class="text-center mb-4">Update Profile</h3>
            <div class="row">
                <h4 class="text-center mt-4">Profile Picture</h4>
          <div class="text-center">
    <!-- Image Preview -->
<asp:Image ID="imgPreview" runat="server" Width="100px" Height="100px" />
<asp:FileUpload ID="fuphoto" runat="server" onchange="previewImage(event)" />

    <!-- File Upload -->
    <%--<asp:FileUpload ID="fuphoto" runat="server" CssClass="form-control mt-2" onchange="previewImage(this)" />--%>
</div>

           
            <div class="row">
                <div class="col-md-4 mb-3">
                    <label class="form-label"><b>Student ID</b></label>
                    <asp:TextBox ID="txtStudentID" runat="server" CssClass="form-control" Readonly></asp:TextBox>
                </div>
                <div class="col-md-4 mb-3">
                    <label class="form-label"><b>Name</b></label>
                    <asp:TextBox ID="txtname" runat="server" CssClass="form-control"  ></asp:TextBox>
                </div>
                <div class="col-md-4 mb-3">
                    <label class="form-label"><b>Gender</b></label>
                    <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control"  >
                        <asp:ListItem Text="Select Gender" Value="" />
                        <asp:ListItem Text="Male" Value="Male" />
                        <asp:ListItem Text="Female" Value="Female" />
                        <asp:ListItem Text="Other" Value="Other" />
                    </asp:DropDownList>
                </div>
            </div>
 <div class="row">
                 <div class="col-md-4 mb-3">
                    <label class="form-label"><b>Current Year</b></label>
                    <asp:TextBox ID="txtcurrentyear" runat="server" TextMode="SingleLine" CssClass="form-control"></asp:TextBox>
                </div>
        <div class="col-md-4 mb-3">
                    <label class="form-label"><b>Skill</b></label>
                    <asp:TextBox ID="txtskill" runat="server" TextMode="SingleLine" CssClass="form-control"></asp:TextBox>
                </div>
            <div class="row">
                 <div class="col-md-4 mb-3">
                    <label class="form-label"><b>Date Of Birth</b></label>
                    <asp:TextBox ID="txtDOB" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                </div>
                 <div class="col-md-4 mb-3">
                    <label class="form-label"><b>Mobile</b></label>
                    <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                 <div class="col-md-4 mb-3">
                    <label class="form-label"><b>Email</b></label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="row">
                  <div class="col-md-4 mb-3">
                    <label class="form-label"><b>Password</b></label>
                    <asp:TextBox ID="txtpassword" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
           
               
                </div>
       
            <div class="text-center mt-3">
                <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click1" Text="Update Profile" CssClass="btn btn-primary" />
            </div>
        </div>
    </div>
         </div>
      <script>
          document.getElementById("btnSubmit").addEventListener("click", function () {
              var newEntry = document.querySelector(".experience-entry").cloneNode(true);
              document.getElementById("experienceSection").appendChild(newEntry);
          });
            </script> 
   </asp:Content>

