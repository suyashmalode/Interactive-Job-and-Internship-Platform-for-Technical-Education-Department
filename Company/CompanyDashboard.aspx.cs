using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class CompanyDashboard : System.Web.UI.Page
{
    private string connStr = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDashboardData();
        }
    }

    private void LoadDashboardData()
    {
        if (Session["CompanyID"] == null)
        {
            Response.Redirect("~/CompanyLogin.aspx");
            return;
        }

        int companyId = Convert.ToInt32(Session["CompanyID"]);

        using (SqlConnection con = new SqlConnection(connStr))
        {
            con.Open();

            // Total students who applied for this company's internships
            string totalStudentsQuery = @"
                SELECT COUNT(DISTINCT s_id)
                FROM Student_Registration 
              ";

            // Applications received
            string applicationsReceivedQuery = @"
                SELECT COUNT(*)
                FROM InternshipApplications ia
                INNER JOIN JobInternshipDetails j ON ia.InternshipID = j.JobInternshipID
                WHERE j.CompanyID = @CompanyID";

            // Applications accepted
            string applicationsAcceptedQuery = @"
                SELECT COUNT(*)
                FROM InternshipApplications ia
                INNER JOIN JobInternshipDetails j ON ia.InternshipID = j.JobInternshipID
                WHERE j.CompanyID = @CompanyID AND ia.Status = 'Accepted'";

            // Applications rejected
            string applicationsRejectedQuery = @"
                SELECT COUNT(*)
                FROM InternshipApplications ia
                INNER JOIN JobInternshipDetails j ON ia.InternshipID = j.JobInternshipID
                WHERE j.CompanyID = @CompanyID AND ia.Status = 'Rejected'";

            // Total internships posted by company
            string totalInternshipsQuery = @"
                SELECT COUNT(*)
                FROM JobInternshipDetails
                WHERE CompanyID = @CompanyID";

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@CompanyID", companyId);

            // Execute each query and assign to labels
            cmd.CommandText = totalStudentsQuery;
            lblTotalStudents.Text = cmd.ExecuteScalar()?.ToString() ?? "0";

            cmd.CommandText = applicationsReceivedQuery;
            lblApplicationsReceived.Text = cmd.ExecuteScalar()?.ToString() ?? "0";

            cmd.CommandText = applicationsAcceptedQuery;
            lblApplicationsAccepted.Text = cmd.ExecuteScalar()?.ToString() ?? "0";

            cmd.CommandText = applicationsRejectedQuery;
            lblApplicationsRejected.Text = cmd.ExecuteScalar()?.ToString() ?? "0";

            cmd.CommandText = totalInternshipsQuery;
            lblTotalInternships.Text = cmd.ExecuteScalar()?.ToString() ?? "0";
        }
    }
}
