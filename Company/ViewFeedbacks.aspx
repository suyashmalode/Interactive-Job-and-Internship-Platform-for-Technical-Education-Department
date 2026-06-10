<%@ Page Title="" Language="C#" MasterPageFile="~/Company/CompanyMasterPage.master" AutoEventWireup="true" CodeFile="ViewFeedbacks.aspx.cs" Inherits="Company_ViewFeedbacks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
        .feedback-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            padding: 30px;
        }

        .feedback-card {
            width: 300px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 20px;
            transition: transform 0.3s ease;
        }

        .feedback-card:hover {
            transform: scale(1.03);
        }

        .feedback-header {
            font-weight: bold;
            font-size: 18px;
            margin-bottom: 10px;
            color: #007bff;
        }

        .feedback-rating {
            color: gold;
            font-size: 16px;
            margin-bottom: 10px;
        }
        .feedback-title{
          text-align: center;
            font-size: 30px;
            font-weight: bold;
            color: #007bff; /* Blue color */
            margin-bottom: 30px;
        }
        .feedback-text {
            font-size: 15px;
            color: #333;
        }

        .no-feedback {
            text-align: center;
            font-size: 18px;
            color: #666;
            margin-top: 50px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="feedback-wrapper">
        <div class="feedback-title">Student Feedbacks</div>

        
    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
            <HeaderTemplate>
                <div class="feedback-list">
            </HeaderTemplate>
        <ItemTemplate>
              <div class="feedback-card">
                    <div class="feedback-student"><%# Eval("sname") %></div>
                    <div class="feedback-rating">
                        <%# new String('★', Convert.ToInt32(Eval("rate"))) + new String('☆', 5 - Convert.ToInt32(Eval("rate"))) %>
                    </div>
                    <div class="feedback-text"><%# Eval("feedbacktext") %></div>
                </div>
              <FooterTemplate>
                </div>
            </FooterTemplate>

        </ItemTemplate>
    </asp:Repeater>

<asp:Label ID="lblMessage" runat="server" CssClass="no-feedback" Visible="false" />
    </div>   
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Carrier_Portal %>" SelectCommand="SELECT * FROM [Feedbacks] WHERE ([cname] = @cname)">
        <SelectParameters>
            <asp:SessionParameter Name="cname" SessionField="cname" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
   
</asp:Content>

