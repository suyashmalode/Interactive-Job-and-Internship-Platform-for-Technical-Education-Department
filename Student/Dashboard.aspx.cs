using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class User_Dashboard : System.Web.UI.Page
{
    private string connStr = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDashboardData();
        }
    }

    private void BindDashboardData()
    {
        if (Session["id"] == null)
        {
            Response.Redirect("~/StudentLogin.aspx");
            return;
        }

        string studentId = Convert.ToString(Session["id"]);

        using (SqlConnection con = new SqlConnection(connStr))
        {
            con.Open();

            // Total companies
            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(DISTINCT c_id) FROM Company_Registration", con))
            {
                lblTotalCompanies.Text = cmd.ExecuteScalar().ToString() ?? "0";
            }

            // Total internships available
            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM JobInternshipDetails", con))
            {
                lblTotalInternships.Text = cmd.ExecuteScalar().ToString() ?? "0";
            }

            // My total applications
            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM InternshipApplications WHERE StudentID = @StudentID", con))
            {
                cmd.Parameters.AddWithValue("@StudentID", studentId);
                lblMyApplications.Text = cmd.ExecuteScalar().ToString() ?? "0";
            }

            // My accepted applications
            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM InternshipApplications WHERE StudentID = @StudentID AND Status = 'Accepted'", con))
            {
                cmd.Parameters.AddWithValue("@StudentID", studentId);
                lblAcceptedApplications.Text = cmd.ExecuteScalar().ToString() ?? "0";
            }

            // My rejected applications
            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM InternshipApplications WHERE StudentID = @StudentID AND Status = 'Rejected'", con))
            {
                cmd.Parameters.AddWithValue("@StudentID", studentId);
                lblRejectedApplications.Text = cmd.ExecuteScalar().ToString() ?? "0";
            }
        }
    }
}
