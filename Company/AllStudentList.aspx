<%@ Page Title="" Language="C#" MasterPageFile="~/Company/CompanyMasterPage.master" AutoEventWireup="true" CodeFile="AllStudentList.aspx.cs" Inherits="Company_AllStudentList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
    body {
        background: #f4f6f9;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    h2 {
        color: #333;
        font-weight: 600;
    }

    .table {
        border-collapse: collapse;
        width: 100%;
        background: #fff;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    }

    .table th {
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        padding: 12px;
        text-align: left;
        font-size: 14px;
        letter-spacing: 0.5px;
    }

    .table td {
        padding: 10px;
        border-bottom: 1px solid #eee;
        font-size: 14px;
        color: #333;
    }

    .table tr:hover {
        background-color: #f9f9f9;
        transition: 0.3s;
    }

    .table img {
        transition: transform 0.3s ease;
    }

    .table img:hover {
        transform: scale(1.2);
    }

    /* Resume link */
    .table a {
        text-decoration: none;
        color: #667eea;
        font-weight: 500;
    }

    .table a:hover {
        text-decoration: underline;
    }

    /* Status badge */
    .status-badge {
        padding: 5px 10px;
        border-radius: 20px;
        color: white;
        font-size: 12px;
        font-weight: 500;
        display: inline-block;
    }

    .status-approved {
        background-color: #28a745;
    }

    .status-rejected {
        background-color: #dc3545;
    }

    .status-pending {
        background-color: #ffc107;
        color: black;
    }

    .status-default {
        background-color: #6c757d;
    }
    .search-box {
    width: 300px;
    padding: 8px 12px;
    border-radius: 6px;
    border: 1px solid #ccc;
    margin-right: 10px;
}

.search-btn {
    padding: 8px 15px;
    background: #667eea;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

.search-btn:hover {
    background: #5a67d8;
}

.reset-btn {
    padding: 8px 15px;
    background: #dc3545;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

.reset-btn:hover {
    background: #c82333;
}
.search-container {
    display: flex;
    justify-content: center;   /* center horizontally */
    align-items: center;
    gap: 10px;
    margin: 20px 0;
}

.search-box {
    width: 300px;
    padding: 8px 12px;
    border-radius: 6px;
    border: 1px solid #ccc;
}

.search-btn {
    padding: 8px 15px;
    background: #667eea;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

.search-btn:hover {
    background: #5a67d8;
}

.reset-btn {
    padding: 8px 15px;
    background: #dc3545;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

.reset-btn:hover {
    background: #c82333;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <div class="search-container">
    <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box" 
        Placeholder="🔍 Search by name, email, mobile, year..." />

    <asp:Button ID="btnSearch" runat="server" Text="Search" 
        CssClass="search-btn" OnClick="btnSearch_Click" />

    <asp:Button ID="Button1" runat="server" Text="Reset" 
        CssClass="reset-btn" OnClick="btnReset_Click" />
</div>
   <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="false" 
        CssClass="table" Width="100%" BorderStyle="Solid" BorderWidth="1px">

        <Columns>
            <asp:BoundField DataField="s_id" HeaderText="Student ID" />
            <asp:BoundField DataField="name" HeaderText="Name" />
            <asp:BoundField DataField="email" HeaderText="Email" />
            <asp:BoundField DataField="mobile" HeaderText="Mobile" />
           <asp:BoundField DataField="current_year" HeaderText="Year" />


<asp:TemplateField HeaderText="Resume">
    <ItemTemplate>
        <a href='<%# ResolveUrl("~/Uploads/Resumes/" + Eval("resume")) %>' target="_blank">
            📄 View Resume
        </a>
    </ItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Photo">
    <ItemTemplate>
        <img src='<%# ResolveUrl("~/Uploads/Photos/" + Eval("photo")) %>' 
             width="50" height="50" 
             style="border-radius:50%; object-fit:cover;" />
    </ItemTemplate>
</asp:TemplateField>
          <asp:BoundField DataField="ApplicationStatus" HeaderText="Application Status" />
        </Columns>

    </asp:GridView>

</asp:Content>