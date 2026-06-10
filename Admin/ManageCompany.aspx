<%@ Page Title="Manage Companies" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master"
    AutoEventWireup="true" CodeFile="ManageCompany.aspx.cs" Inherits="Admin_ManageCompany" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <div class="container mt-4">
        <h3 class="mb-3">Company Details</h3>

        <asp:GridView ID="gvCompanies" runat="server" AutoGenerateColumns="False"
            CssClass="table table-bordered table-hover text-center align-middle"
            DataKeyNames="c_id" OnRowCommand="gvCompanies_RowCommand">
            <Columns>

            
                <asp:BoundField DataField="c_id" HeaderText="ID" ReadOnly="true" />

             <asp:TemplateField HeaderText="Logo">
    <ItemTemplate>
        <img src='<%# ResolveUrl("~/Company/Companyimage/") + Eval("photo") %>'
             alt="Logo" 
             style="width:60px;height:60px;border-radius:50px;object-fit:cover;border:1px solid #ccc;" />
    </ItemTemplate>
</asp:TemplateField>


                <asp:BoundField DataField="cname" HeaderText="Company Name" />
                <asp:BoundField DataField="hremail" HeaderText="Email" />
                <asp:BoundField DataField="hrmobile" HeaderText="Contact No" />
                <asp:BoundField DataField="caddress" HeaderText="Address" />
<%--                <asp:BoundField DataField="city" HeaderText="City" />--%>
<%--                <asp:BoundField DataField="website" HeaderText="Website" />--%>

                <asp:TemplateField HeaderText="Document">
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkDocument" runat="server"
                            Text="View Document"
                            NavigateUrl='<%# "~/Company/CompanyDocuments/" + Eval("document") %>'
                            Target="_blank"></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select form-select-sm"
                            SelectedValue='<%# Eval("status") %>'>
                            <asp:ListItem Text="Pending" Value="Pending" />
                            <asp:ListItem Text="Approved" Value="Approved" />
                            <asp:ListItem Text="Rejected" Value="Rejected" />
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnUpdate" runat="server" Text="Update"
                            CssClass="btn btn-primary btn-sm"
                            CommandName="UpdateStatus"
                            CommandArgument='<%# Eval("c_id") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
