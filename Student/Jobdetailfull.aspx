<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentMasterPage.master" AutoEventWireup="true" CodeFile="Jobdetailfull.aspx.cs" Inherits="Student_ViewJobDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <script type="text/javascript">
          function showUploadPanel() {
              var panel = document.getElementById('<%= pnlUpload.ClientID %>');
              if (panel) {
                  panel.style.display = 'block';
              } else {
                  console.log("Panel not found!");
              }
          }
    </script>
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        
       
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
<%--    <asp:Label ID="lblshow" ForeColor="red" runat="server" Text="Label"></asp:Label>--%>
    <br /> <br />
    <div class="card">
            <div class="bb ze ki xn 2xl:ud-px-0">
                <div class="tc sf yo zf kq">
                    <div class="ro">

                        
                         </div>
                </div><asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" >
                       <ItemTemplate>
                                <div class="event-item mb-4 p-4 border border-secondary rounded">
                                    <div class="row">
                                       <div class="col-md-4">
                                      <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource3">
                    <ItemTemplate>
 
                                            <!-- Project Image -->
                                            
<img src='<%# ResolveUrl("../Company/Companyimage/") + Eval("photo") %>' alt="Project Image" class="img-fluid rounded" />                                            

 
                                          
                                                
                    </ItemTemplate>
                </asp:Repeater>
                                </div>            
                                            
                                        <div class="col-md-8">
                                            <!-- Project Details -->
                                            <h3 class="event-title"><%# Eval("cname") %></h3>
                                            <p class="event-description"><%# Eval("year") %></p>
                                            
                                            <ul class="list-unstyled">
                                                <li><span class="font-weight-bold">Company Name: </span><b><%# Eval("cname") %></b></li>
                                                <li><span class="font-weight-bold">Camping Date: </span><b><%# Eval("campingdate", "{0:dd-MM-yyyy}") %></b></li>
                                                <li><span class="font-weight-bold">Time: </span><b><%# Eval("time") %></b></li>
                                                <li><span class="font-weight-bold">Venue: </span><b><%# Eval("Venue") %></b></li>
                                                <li><span class="font-weight-bold">Criteria for SSC percentage: </span><b><%# Eval("sscper") %></b></li>
                                                <li><span class="font-weight-bold">Criteria For HSC Percentage: </span><b><%# Eval("hscper") %></b></li>
                                                <li><span class="font-weight-bold">Criteria For Diploma Percentage: </span><b><%# Eval("dipper") %></b></li>
                                                <li><span class="font-weight-bold">Criteria For BE Aggregate: </span><b><%# Eval("beagg") %></b></li>

                                                </ul>
                                            
                                            <div class="mt-3">
                                                <!-- Video Link -->
                                                <a href='<%# Eval("link") %>' class="btn btn-primary" target="_blank">Registration Link</a>
                                                <!-- Website Link -->
                                                <a href='<%# Eval("pdf") %>' class="btn btn-secondary" target="_blank">Job Related PDF</a>

<asp:Button ID="btnApply" runat="server" OnClick="btnApply_Click"  Text="Apply" CssClass="btn btn-secondary"  />
<%--<asp:Button ID="btnUpload" runat="server" Text="Upload Document" CssClass="btn btn-primary" OnClientClick="showUploadPanel(); return false;" />--%>

<!-- Upload Panel (Initially Hidden) -->
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:Panel ID="pnlUpload" runat="server" CssClass="upload-panel mt-3" Style="display: none;">
            <div class="border p-3 rounded bg-light">
                <h5>Upload Your Document</h5>
                  <div class="mb-2">
            <asp:TextBox ID="txtStudentID" runat="server" CssClass="form-control" ></asp:TextBox>
        </div>
                <div class="mb-2">
                    <asp:TextBox ID="txtDocName" runat="server" CssClass="form-control" placeholder="Enter Document Name"></asp:TextBox>
                </div>
                <div class="mb-2">
                    <asp:FileUpload ID="fuDocument" runat="server" CssClass="form-control" />
                </div>
                <asp:Button ID="btnSaveDoc" runat="server" Text="Save" CssClass="btn btn-success"  />
            </div>
        </asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>



                                          </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            
                            
                        </asp:Repeater>
                
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:Carrier_Portal %>" SelectCommand="SELECT [photo] FROM [Company_Registration] WHERE ([cname] = @cname)">
                       <SelectParameters>
                <asp:Parameter DefaultValue="cname" Name="cname" Type="String" />
            </SelectParameters>
                </asp:SqlDataSource>
            </div>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Carrier_Portal %>" SelectCommand="SELECT * FROM [Job_Discription] WHERE ([jd_id] = @jd_id)">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="jd_id" QueryStringField="jd_id" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>


    </div>
  
</asp:Content>

