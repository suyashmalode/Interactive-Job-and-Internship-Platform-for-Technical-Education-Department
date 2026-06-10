using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_RejectedStudentList : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadRejectedStudents();
        }
    }

    void LoadRejectedStudents()
    {
        string query = @"
        SELECT 
            s.s_id,
            s.name,
            s.email,
            s.mobile,
            j.Title,
            ia.ApplicationDate,
            ia.Status,
            ia.ResumePath,
            ia.Comments
        FROM InternshipApplications ia
        INNER JOIN Student_Registration s ON ia.StudentID = s.s_id
        INNER JOIN JobInternshipDetails j ON ia.InternshipID = j.JobInternshipID
        WHERE ia.Status = 'Rejected'
        ORDER BY ia.ApplicationDate DESC";

        SqlDataAdapter da = new SqlDataAdapter(query, con);
        DataTable dt = new DataTable();
        da.Fill(dt);

        gvRejected.DataSource = dt;
        gvRejected.DataBind();
    }
}