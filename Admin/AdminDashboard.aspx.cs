using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_AdminDashboard : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDashboardStats();
        }
    }

    private void LoadDashboardStats()
    {
        try
        {
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }

            // Get Total Students Count
            string studentQuery = "SELECT COUNT(*) FROM Student_Registration";
            SqlCommand cmdStudents = new SqlCommand(studentQuery, con);
            int totalStudents = Convert.ToInt32(cmdStudents.ExecuteScalar());
            lblTotalStudents.Text = totalStudents.ToString();

            // Get Total Companies Count
            string companyQuery = "SELECT COUNT(*) FROM Company_Registration";
            SqlCommand cmdCompanies = new SqlCommand(companyQuery, con);
            int totalCompanies = Convert.ToInt32(cmdCompanies.ExecuteScalar());
            lblTotalCompanies.Text = totalCompanies.ToString();

            // Get Total Internships Count
            string internshipQuery = "SELECT COUNT(*) FROM JobInternshipDetails";
            SqlCommand cmdInternships = new SqlCommand(internshipQuery, con);
            int totalInternships = Convert.ToInt32(cmdInternships.ExecuteScalar());
            lblTotalInternships.Text = totalInternships.ToString();

            // Get Total Applied Students Count (Distinct students who applied)
            string appliedQuery = "SELECT COUNT(DISTINCT StudentID) FROM InternshipApplications";
            SqlCommand cmdApplied = new SqlCommand(appliedQuery, con);
            int appliedStudents = Convert.ToInt32(cmdApplied.ExecuteScalar());
            lblAppliedStudents.Text = appliedStudents.ToString();

            // Get Rejected Applications Count
            string rejectedQuery = "SELECT COUNT(*) FROM InternshipApplications WHERE Status = 'Rejected'";
            SqlCommand cmdRejected = new SqlCommand(rejectedQuery, con);
            int rejectedApplications = Convert.ToInt32(cmdRejected.ExecuteScalar());
            lblRejectedApplications.Text = rejectedApplications.ToString();
        }
        catch (Exception ex)
        {
            // Log error or display message
            Response.Write("<script>alert('Error loading dashboard: " + ex.Message + "');</script>");
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