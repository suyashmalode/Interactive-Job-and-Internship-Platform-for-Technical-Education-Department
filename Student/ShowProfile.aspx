<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentMasterPage.master" AutoEventWireup="true" CodeFile="ShowProfile.aspx.cs" Inherits="Student_ShowProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="container mt-5">
        <div class="card shadow-lg p-4">
            <h3 class="text-center mb-4">Student Profile</h3>
            <div class="table-responsive">
                <table class="table table-bordered table-hover table-striped">
                    <thead class="table-primary">
                        <tr>
                            
                            <th>Photo</th>
                            <th>Name</th>
                            <th>Branch</th>
                            <th>Session</th>
                            <th>University</th>
                            <th>Gender</th>
                            <th>Date of Birth</th>
                            <th>SSC %</th>
                            <th>SSC School</th>
                            <th>HSC %</th>
                            <th>HSC College</th>
                            <th>Diploma Percentage</th>
                            <th>Diploma College</th>
                            <th>BE Aggregate</th>
                            <th>BE College</th>
                            <th>Mobile</th>
                            <th>Email</th>
                            <th>Address</th>
                           
                        </tr>
                    </thead>
                    <tbody>
   
                           
             
                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
               
                    <ItemTemplate>
                        <tr>
                           
                                   
                                   <td>
                                        <img src='/Student/photo/<%# Eval("photo") %>' class="img-fluid rounded-circle" 
                                             style="width: 50px; height: 50px;" />
                                    </td>
                                    <td><%# Eval("name") %></td>
                                    <td><%# Eval("branch") %></td>
                                    <td><%# Eval("session") %></td>
                                    <td><%# Eval("beuniversityname") %></td>
                                    <td><%# Eval("gender") %></td>
                                    <td><%# Eval("dob") %></td>
                                   
                                    <td><%# Eval("sscper") %></td>
                            <td><%# Eval("sscschool") %></td>
                                    <td><%# Eval("hscper") %></td>
                             <td><%# Eval("hsccolg") %></td>
                                                         <td><%# Eval("dipper") %></td>
                                                         <td><%# Eval("dipcolg") %></td>


                                    <td><%# Eval("beagg") %></td>
                             <td><%# Eval("becolg") %></td>
                                    <td><%# Eval("mobile") %></td>
                                    <td><%# Eval("email") %></td>
                                    <td><%# Eval("localadd") %></td>
                                     

                                    
                                    <td>
                                        <asp:Button ID="btnResume" runat="server" CssClass="btn btn-primary" 
                                            Text="Build Resume" PostBackUrl='<%# "ResumeBuild.aspx?s_id=" + Eval("s_id").ToString() %>' />
                                    </td>
                                </tr>
                </ItemTemplate>
                  
                </asp:Repeater>
                </tbody>
                    </table>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Carrier_Portal %>" SelectCommand="SELECT * FROM [Student_Registration] WHERE ([s_id] = @s_id)">
                    <SelectParameters>
                        <asp:SessionParameter Name="s_id" SessionField="id" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                
            </div>
        </div>
    </div>
           
</asp:Content>

