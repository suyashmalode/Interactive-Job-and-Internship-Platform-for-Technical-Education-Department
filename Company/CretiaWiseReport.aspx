<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="CretiaWiseReport.aspx.cs" Inherits="Admin_CretiaWiseReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  <title>Criteria Wise Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  
           
       
        <!-- Search Form -->
        <div class="card p-4 mb-4">
            <h5>Enter Minimum Percentage for Each Category:</h5>

            <div class="row mb-2">
                <div class="col-md-3">
                    <label>SSC Percentage:</label>
                    <asp:TextBox ID="txtSSC" runat="server" CssClass="form-control" Placeholder="Please Enter Marks"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <label>HSC Percentage:</label>
                    <asp:TextBox ID="txtHSC" runat="server" CssClass="form-control" Placeholder="Please Enter Marks"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <label>Diploma Percentage:</label>
                    <asp:TextBox ID="txtDiploma" runat="server" CssClass="form-control" Placeholder="Please Enter Marks"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <label>BE Percentage:</label>
                    <asp:TextBox ID="txtBE" runat="server" CssClass="form-control" Placeholder="Please Enter Marks"></asp:TextBox>
                </div>

            </div>
                       <asp:Button ID="btnSearch" runat="server" Width="100px"  Text="Search" CssClass="btn btn-primary mt-3" OnClick="btnSearch_Click" />

        <!-- Results Table -->
      <br />
            <br />
              <asp:Panel ID="pnlResults" runat="server" Visible="false">
                <table class="table table-bordered" id="table">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Branch</th>
                          <%--  <th>Session</th>--%>
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
                
             <tbody>

 
            <asp:Repeater ID="Repeater1" runat="server" >
        <ItemTemplate>
             <tr>
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
                                     
                   
        </ItemTemplate>
            </asp:Repeater>
        <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PlacementPortalConnectionString %>" SelectCommand=""></asp:SqlDataSource>--%>
           
        </tbody>
                    </table>
                  </asp:Panel>
           </div>
    
</asp:Content>

