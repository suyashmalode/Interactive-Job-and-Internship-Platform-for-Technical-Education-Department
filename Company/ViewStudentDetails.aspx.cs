using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Company_ViewStudentDetails : System.Web.UI.Page
{
    private readonly string connStr = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int applicationId;
            string studentId = Request.QueryString["StudentID"];

            if (int.TryParse(Request.QueryString["ApplicationID"], out applicationId) && !string.IsNullOrEmpty(studentId))
            {
                LoadStudentDetails(applicationId, studentId);
            }
            else
            {
                ShowNotFound();
            }
        }
    }

    private void LoadStudentDetails(int applicationId, string studentId)
    {
        string query = @"
            SELECT 
                s.name, s.email, s.mobile,  s.photo,
                ia.ApplicationDate, ia.Status, ia.Comments
            FROM Student_Registration s
            INNER JOIN InternshipApplications ia ON s.s_id = ia.StudentID
            WHERE ia.ApplicationID = @ApplicationID AND s.s_id = @StudentID";

        using (SqlConnection con = new SqlConnection(connStr))
        using (SqlCommand cmd = new SqlCommand(query, con))
        {
            cmd.Parameters.AddWithValue("@ApplicationID", applicationId);
            cmd.Parameters.AddWithValue("@StudentID", studentId);

            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                pnlDetails.Visible = true;
                pnlNotFound.Visible = false;

                lblName.Text = reader["name"].ToString();
                lblEmail.Text = reader["email"].ToString();
                lblMobile.Text = reader["mobile"].ToString();
               // lblDegree.Text = reader["degree"].ToString();
              //  lblSkills.Text = reader["skills"].ToString();

                DateTime appDate;
                if (DateTime.TryParse(reader["ApplicationDate"].ToString(), out appDate))
                    lblAppDate.Text = appDate.ToString("dd MMM yyyy HH:mm");
                else
                    lblAppDate.Text = "N/A";

                lblStatus.Text = reader["Status"].ToString();
               // lblComments.Text = reader["Comments"].ToString();

                string resumePath = reader["photo"].ToString();
                imgPhoto.ImageUrl = "~/Uploads/Photos/" + resumePath;
            }
            else
            {
                ShowNotFound();
            }
        }
    }

    private void ShowNotFound()
    {
        pnlDetails.Visible = false;
        pnlNotFound.Visible = true;
    }
}
