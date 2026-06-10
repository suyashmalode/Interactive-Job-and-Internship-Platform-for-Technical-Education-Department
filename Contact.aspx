<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        /* Add your custom CSS styles here */
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br /><br />
    <div class="col-md-6" style="margin:auto;">
        <div class="wow fadeInUp" data-wow-delay="0.5s">
            <div class="row g-3">
                <div class="col-md-6">
                    <div class="form-floating">
                        <asp:TextBox ID="txtname" CssClass="form-control" runat="server" placeholder="Your Name"></asp:TextBox>
                        <label for="name">Your Name</label>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-floating">
                        <asp:TextBox ID="txtemail" CssClass="form-control" runat="server" placeholder="Your Email"></asp:TextBox>
                        <label for="email">Your Email</label>
                    </div>
                </div>
                <div class="col-12">
                    <div class="form-floating">
                        <asp:TextBox ID="txtsubject" CssClass="form-control" runat="server" placeholder="Subject"></asp:TextBox>
                        <label for="subject">Subject</label>
                    </div>
                </div>
                <div class="col-12">
                    <div class="form-floating">
                        <asp:TextBox ID="txtmessage" CssClass="form-control" runat="server" TextMode="MultiLine" Rows="3" placeholder="Leave a message here"></asp:TextBox>
                        <label for="message">Message</label>
                    </div>
                </div>
                <div class="col-12">
                    <asp:Button ID="sendButton" CssClass="btn btn-primary w-100 py-3" runat="server" Text="Send Message" OnClick="sendButton_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script>
    document.getElementById("Button1").addEventListener("click", function () {
        var resumeElement = document.querySelector(".resume-container"); // Select the resume container

        if (!resumeElement) {
            alert("Error: Resume not found!");
            return;
        }

        html2canvas(resumeElement, {
            scale: 2,  // Increase quality
            useCORS: true,  // Handle cross-origin images
            allowTaint: true
        }).then(canvas => {
            var imgData = canvas.toDataURL("image/png"); // Convert to image

            var { jsPDF } = window.jspdf;
            var pdf = new jsPDF("p", "mm", "a4");

            var imgWidth = 190;
            var imgHeight = (canvas.height * imgWidth) / canvas.width;

            pdf.addImage(imgData, "PNG", 10, 10, imgWidth, imgHeight);
            pdf.save("Resume.pdf"); // Download as Resume.pdf

        }).catch(err => {
            console.error("PDF generation error:", err);
            alert("Failed to generate PDF!");
        });
    });
</script>