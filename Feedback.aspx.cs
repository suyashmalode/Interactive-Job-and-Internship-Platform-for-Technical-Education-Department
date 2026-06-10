using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class Feedback : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Optional: Set default rating
        
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string name = txtName.Text.Trim();
        string company = txtCompany.Text.Trim();
        string rating = ddlRating.SelectedValue;
        string feedback = txtFeedback.Text.Trim();

        string query = "INSERT INTO Feedbacks (sname, cname, rate, feedbacktext) VALUES (@StudentName, @CompanyName, @Rating, @FeedbackText)";

        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@StudentName", name);
                cmd.Parameters.AddWithValue("@CompanyName", company);
                cmd.Parameters.AddWithValue("@Rating", rating);
                cmd.Parameters.AddWithValue("@FeedbackText", feedback);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                lblMessage.Text = "Feedback submitted successfully!";
                ClearForm();
            }
        }
    }

    private void ClearForm()
    {
        txtName.Text = "";
        txtCompany.Text = "";
        txtFeedback.Text = "";
        
    }
}