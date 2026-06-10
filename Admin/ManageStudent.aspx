<%@ Page Title="Manage Students" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" 
    AutoEventWireup="true" CodeFile="ManageStudent.aspx.cs" Inherits="Admin_ManageStudent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <div class="container mt-4">
        <h3 class="mb-3 text-center">Manage Student Registrations</h3>

        <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
            OnRowCommand="gvStudents_RowCommand" DataKeyNames="id">
            <Columns>
                <asp:BoundField DataField="s_id" HeaderText="Student ID" />
                <asp:BoundField DataField="name" HeaderText="Name" />
                <asp:BoundField DataField="dob" HeaderText="Date of Birth" />
                <asp:BoundField DataField="mobile" HeaderText="Mobile" />
                <asp:BoundField DataField="gender" HeaderText="Gender" />
<asp:TemplateField HeaderText="Photo">
    <ItemTemplate>
        <img src='<%# ResolveUrl("~/Uploads/Photos/" + Eval("photo")) %>' 
             alt="Student Photo" 
             style="width:70px; height:70px; border-radius:50%;" />
    </ItemTemplate>
</asp:TemplateField>


                <asp:TemplateField HeaderText="Resume">
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkResume" runat="server"
                            Text="View Resume" 
                            NavigateUrl='<%# "~/Uploads/Resumes/" + Eval("resume") %>'
                            Target="_blank"></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select"
                            SelectedValue='<%# Eval("status") %>'>
                            <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                            <asp:ListItem Text="Approved" Value="Approved"></asp:ListItem>
                            <asp:ListItem Text="Blocked" Value="Blocked"></asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnUpdate" runat="server" Text="Update"
                            CssClass="btn btn-primary btn-sm"
                            CommandName="UpdateStatus"
                            CommandArgument='<%# Eval("id") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
