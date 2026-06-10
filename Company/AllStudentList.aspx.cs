using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Company_AllStudentList : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadStudents("");
        }
    }

    void LoadStudents(string searchText)
    {
        string query = @"
        SELECT 
            s.s_id,
            s.name,
            s.email,
            s.mobile,
            s.current_year,
            s.resume,
            s.photo,
            ISNULL(ia.Status, 'Not Applied') AS ApplicationStatus
        FROM Student_Registration s
        LEFT JOIN InternshipApplications ia 
            ON s.s_id = ia.StudentID
        WHERE 
            s.name LIKE @search OR
            s.email LIKE @search OR
            s.mobile LIKE @search OR
            s.current_year LIKE @search OR
            s.s_id LIKE @search
        ORDER BY s.registration_date DESC";

        SqlCommand cmd = new SqlCommand(query, con);
        cmd.Parameters.AddWithValue("@search", "%" + searchText + "%");

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        gvStudents.DataSource = dt;
        gvStudents.DataBind();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadStudents(txtSearch.Text.Trim());
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        txtSearch.Text = "";
        LoadStudents("");
    }
}