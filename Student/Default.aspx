<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Student_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="mx-auto max-w-screen-2xl bg-white p-4 md:p-6 2xl:p-10">
        <div class="card">
            <div class="bb ze ki xn 2xl:ud-px-0">
                <div class="tc sf yo zf kq">
                    <div class="ro">

    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
         <ItemTemplate>
                                <div class="event-item mb-4 p-4 border border-secondary rounded">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <!-- Project Image -->
                                            <img src='<%# "../Startup/logo/" + Eval("ProjectImage") %>' alt="Project Image" class="img-fluid rounded">
                                        </div>
                                        <div class="col-md-8">
                                            <!-- Project Details -->
                                            <h3 class="event-title"><%# Eval("cname") %></h3>
                                            <p class="event-description"><%# Eval("Description") %></p>
                                            
                                            <ul class="list-unstyled">
                                                <li><span class="font-weight-bold">Author: </span><b><%# Eval("FirmName") %></b></li>
                                                <li><span class="font-weight-bold">Published On: </span><b><%# Eval("date_posted", "{0:dd-MM-yyyy}") %></b></li>
                                                <li><span class="font-weight-bold">Required Skills: </span><b><%# Eval("req_skill") %></b></li>
                                                <li><span class="font-weight-bold">Salary Range: </span><b><%# Eval("salary_range") %></b></li>
                                                <li><span class="font-weight-bold">Location: </span><b><%# Eval("location") %></b></li>
                                                <li><span class="font-weight-bold">Requirements: </span><b><%# Eval("requirements") %></b></li>
                                            </ul>
                                            
                                            <div class="mt-3">
                                                <!-- Video Link -->
                                                <a href='<%# Eval("videolink") %>' class="btn btn-primary" target="_blank">Watch Video</a>
                                                <!-- Website Link -->
                                                <a href='<%# Eval("Website") %>' class="btn btn-secondary" target="_blank">Visit Website</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
    </asp:Repeater>
  </div>
                </div>
            </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PlacementPortalConnectionString %>" SelectCommand="SELECT [cname], [year], [pdf], [campingdate], [time], [venue], [link], [sscper], [hscper], [dipper], [beagg], [designation] FROM [Job_Discription]"></asp:SqlDataSource>



</asp:Content>

