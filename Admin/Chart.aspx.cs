using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_Chart : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadChartData();
        }
    }

    private void LoadChartData()
    {
        try
        {
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }

            // Get Total Companies
            string companyQuery = "SELECT COUNT(*) FROM Company_Registration";
            SqlCommand cmdCompanies = new SqlCommand(companyQuery, con);
            int totalCompanies = Convert.ToInt32(cmdCompanies.ExecuteScalar());
            TotalCompanies.Value = totalCompanies.ToString();

            // Get Total Internships
            string internshipQuery = "SELECT COUNT(*) FROM JobInternshipDetails";
            SqlCommand cmdInternships = new SqlCommand(internshipQuery, con);
            int totalInternships = Convert.ToInt32(cmdInternships.ExecuteScalar());
            TotalInternships.Value = totalInternships.ToString();

            // Get Total Rejected Applications
            string rejectedQuery = "SELECT COUNT(*) FROM InternshipApplications WHERE Status = 'Rejected'";
            SqlCommand cmdRejected = new SqlCommand(rejectedQuery, con);
            int totalRejected = Convert.ToInt32(cmdRejected.ExecuteScalar());
            TotalRejectedApplications.Value = totalRejected.ToString();

            // Get Total Pending Applications
            string pendingQuery = "SELECT COUNT(*) FROM InternshipApplications WHERE Status = 'Pending'";
            SqlCommand cmdPending = new SqlCommand(pendingQuery, con);
            int totalPending = Convert.ToInt32(cmdPending.ExecuteScalar());
            TotalPendingApplications.Value = totalPending.ToString();

            // Get Total Approved Applications
            string approvedQuery = "SELECT COUNT(*) FROM InternshipApplications WHERE Status = 'Approved'";
            SqlCommand cmdApproved = new SqlCommand(approvedQuery, con);
            int totalApproved = Convert.ToInt32(cmdApproved.ExecuteScalar());
            TotalApprovedApplications.Value = totalApproved.ToString();

            // Get Total Students
            string studentQuery = "SELECT COUNT(*) FROM Student_Registration";
            SqlCommand cmdStudents = new SqlCommand(studentQuery, con);
            int totalStudents = Convert.ToInt32(cmdStudents.ExecuteScalar());
            TotalStudents.Value = totalStudents.ToString();
        }
        catch (Exception ex)
        {
            // Log error or display message
            Response.Write("<script>alert('Error loading chart data: " + ex.Message + "');</script>");
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }
}