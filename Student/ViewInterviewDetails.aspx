<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentMasterPage.master" AutoEventWireup="true" CodeFile="ViewInterviewDetails.aspx.cs" Inherits="Student_ViewInterviewDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <style>
        .interview-container {
            width: 95%;
            margin: 40px auto;
            font-family: 'Segoe UI', sans-serif;
        }

        .table-heading {
            text-align: center;
            font-size: 24px;
            color: #007bff;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .interview-table {
            width: 100%;
            border-collapse: collapse;
        }

        .interview-table th, .interview-table td {
            border: 1px solid #dee2e6;
            padding: 12px 14px;
            text-align: center;
        }

        .interview-table th {
            background-color: #007bff;
            color: white;
        }

        .interview-table tr:nth-child(even) {
            background-color: #f2f6fc;
        }

        .interview-table tr:hover {
            background-color: #e6f0ff;
        }

        .prep-section {
            margin-top: 50px;
            padding: 20px;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            border-radius: 10px;
        }

        .prep-section h3 {
            color: #007bff;
            font-weight: bold;
        }

        .prep-links {
            list-style-type: none;
            padding-left: 0;
        }

        .prep-links li {
            margin-bottom: 10px;
        }

        .prep-links a {
            text-decoration: none;
            color: #333;
        }

        .prep-links a:hover {
            color: #007bff;
            text-decoration: underline;
        }
    </style>   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="container">
                 <h5>Your Interview Schedule</h5>

         <table class="interview-table">
            <tr>
               
                <th>Interview Date</th>
                <th>Time</th>
                <th>Mode</th>
                <th>Round</th>
                <th>Status</th>
                <th>Remarks</th>
            </tr>
         <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
             <ItemTemplate>
                <tr>
                <td><%# Eval("InterviewDate", "{0:dd MMM yyyy}") %></td>
                <td><%# Eval("InterviewTime") %></td>
                <td><%# Eval("InterviewMode") %></td>
                <td><%# Eval("InterviewRound") %></td>
                <td><%# Eval("InterviewStatus") %></td>
                <td><%# Eval("Remarks") %></td>
            </tr>
             </ItemTemplate>
                  
         </asp:Repeater>
              </table>
         <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Carrier_Portal %>" SelectCommand="SELECT * FROM [Interviews] WHERE ([StudentID] = @StudentID)">
             <SelectParameters>
                 <asp:SessionParameter Name="StudentID" SessionField="id" Type="String" />
             </SelectParameters>
         </asp:SqlDataSource>
    </div>
     <div class="prep-section">
    <h3>Interview Preparation Resources</h3>
    <ul class="prep-links">
        <li><a href="https://www.w3schools.com" target="_blank">W3Schools – Web Development Basics</a></li>
        <li><a href="https://www.geeksforgeeks.org/placement-interview-questions/" target="_blank">GeeksforGeeks – Interview Questions</a></li>
        <li><a href="https://www.javatpoint.com/interview-questions-and-answers" target="_blank">JavaTpoint – Interview Q&A</a></li>
        <li><a href="https://leetcode.com" target="_blank">LeetCode – Coding Practice</a></li>
        <li><a href="https://interviewbit.com" target="_blank">InterviewBit – Tech Interview Prep</a></li>
    </ul>
</div>
</asp:Content>

