using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadCounts();
        }
        ClassCheck cs = new ClassCheck();
        cs.lis(Server.MapPath("MasterPage.master"), Server.MapPath("MasterPage.master.cs"), Server.MapPath("web.config"));


    }
    private void LoadCounts()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            // ✅ Active Jobs (Status = 1)
            string jobQuery = "SELECT COUNT(*) FROM JobInternshipDetails WHERE Status = 1";
            SqlCommand cmd1 = new SqlCommand(jobQuery, con);
            lblJobs.Text = cmd1.ExecuteScalar().ToString();

            // ✅ Companies (Approved only)
            string companyQuery = "SELECT COUNT(*) FROM Company_Registration WHERE status='Approved'";
            SqlCommand cmd2 = new SqlCommand(companyQuery, con);
            lblCompanies.Text = cmd2.ExecuteScalar().ToString();

            // ✅ Students (Approved only)
            string studentQuery = "SELECT COUNT(*) FROM Student_Registration WHERE status='Approved'";
            SqlCommand cmd3 = new SqlCommand(studentQuery, con);
            lblStudents.Text = cmd3.ExecuteScalar().ToString();

            // ✅ Applications
            string appQuery = "SELECT COUNT(*) FROM InternshipApplications";
            SqlCommand cmd4 = new SqlCommand(appQuery, con);
            lblApplications.Text = cmd4.ExecuteScalar().ToString();
        }
    }
}
