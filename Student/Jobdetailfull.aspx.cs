using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

public partial class Student_ViewJobDetails : System.Web.UI.Page
{
    private readonly object btnApply;

    protected void Page_Load(object sender, EventArgs e)
    {
    }







    protected void btnApply_Click(object sender, EventArgs e)
    {




        // Get student ID from session
        string studentID = Session["id"]?.ToString();
        if (string.IsNullOrEmpty(studentID))
        {
            Response.Write("<script>alert('Please log in to apply.');</script>");
            return;
        }

        // Get job ID from query string
        string jobID = Request.QueryString["jd_id"];
        if (string.IsNullOrEmpty(jobID))
        {
            Response.Write("<script>alert('Invalid Job ID.');</script>");
            return;
        }

        // Database connection string
        string connStr = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            // Check if student has already applied for this job
            string checkQuery = "SELECT COUNT(*) FROM Job_Applications WHERE s_id = @studentID AND jd_id = @jobID";
            SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
            checkCmd.Parameters.AddWithValue("@studentID", studentID);
            checkCmd.Parameters.AddWithValue("@jobID", jobID);

            int existingApplications = (int)checkCmd.ExecuteScalar();
            if (existingApplications > 0)
            {
                Response.Write("<script>alert('You have already applied for this job.');</script>");
                return;
            }


            // Get student marks
            string studentQuery = "SELECT sscper, hscper, dipper, beagg FROM Student_Registration WHERE s_id = @studentID";
            SqlCommand studentCmd = new SqlCommand(studentQuery, conn);
            studentCmd.Parameters.AddWithValue("@studentID", studentID);

            SqlDataReader studentReader = studentCmd.ExecuteReader();
            if (!studentReader.Read())
            {
                Response.Write("<script>alert('Student record not found!');</script>");
                return;
            }

            // Parse student marks safely
            float studentSSC = 0, studentHSC = 0, studentDiploma = 0, studentBE = 0;
            float.TryParse(studentReader["sscper"]?.ToString().Trim(), out studentSSC);
            float.TryParse(studentReader["hscper"]?.ToString().Trim(), out studentHSC);
            float.TryParse(studentReader["dipper"]?.ToString().Trim(), out studentDiploma);
            float.TryParse(studentReader["beagg"]?.ToString().Trim(), out studentBE);

            studentReader.Close(); // Close reader before executing another query

            // Get job criteria
            string jobQuery = "SELECT sscper, hscper, dipper, beagg FROM Job_Discription WHERE jd_id = @jobID";
            SqlCommand jobCmd = new SqlCommand(jobQuery, conn);
            jobCmd.Parameters.AddWithValue("@jobID", jobID);

            SqlDataReader jobReader = jobCmd.ExecuteReader();
            if (!jobReader.Read())
            {
                Response.Write("<script>alert('Job details not found!');</script>");
                return;
            }

            // Parse job criteria safely
            float jobSSC = 0, jobHSC = 0, jobDiploma = 0, jobBE = 0;
            float.TryParse(jobReader["sscper"]?.ToString().Trim(), out jobSSC);
            float.TryParse(jobReader["hscper"]?.ToString().Trim(), out jobHSC);
            float.TryParse(jobReader["dipper"]?.ToString().Trim(), out jobDiploma);
            float.TryParse(jobReader["beagg"]?.ToString().Trim(), out jobBE);

            jobReader.Close();

            // Eligibility check
            if (studentSSC < jobSSC || studentHSC < jobHSC || studentDiploma < jobDiploma || studentBE < jobBE)
            {
                Response.Write("<script>alert('You do not meet the eligibility criteria for this job.');</script>");
                return;
            }

            // Insert application record
            string insertQuery = "INSERT INTO Job_Applications (s_id, jd_id, applicationdate) VALUES (@studentID, @jobID, GETDATE())";
            SqlCommand insertCmd = new SqlCommand(insertQuery, conn);
            insertCmd.Parameters.AddWithValue("@studentID", studentID);
            insertCmd.Parameters.AddWithValue("@jobID", jobID);

            int rowsAffected = insertCmd.ExecuteNonQuery();
            if (rowsAffected > 0)
            {
                Response.Write("<script>alert('You Are Eligible! Application submitted successfully!');</script>");
                // object btnApply = null;
                //Response.Redirect("UploadDocuments.aspx"); // Redirect to the document upload page
                
                pnlUpload.Visible = true;
                
            }
            else
            {
                Response.Write("<script>alert('Application submission failed.');</script>");
                
            }
        }
    }
    protected void btnSaveDoc_Click(object sender, EventArgs e)
    {
        if (fuDocument.HasFile)
        {
            string studentID = Session["id"]?.ToString();




            // Ensure the directory exists



            // Insert document record in DB
            string connStr = ConfigurationManager.ConnectionStrings["PlacementPortalConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string insertDocQuery = "INSERT INTO Upload_Documents (s_id,uploaddate,filename,image ) VALUES (@studentID, @docdate, @docname,@image)";
                SqlCommand cmd = new SqlCommand(insertDocQuery, conn);
                cmd.Parameters.AddWithValue("@studentID", studentID);
                cmd.Parameters.AddWithValue("@docdate", DateTime.Now);
                cmd.Parameters.AddWithValue("@docname", txtDocName.Text.Trim());


                cmd.ExecuteNonQuery();
                if (fuDocument.HasFile)
                {
                    string ppath = Server.MapPath("~/Student/Documents/") + fuDocument.FileName;
                    fuDocument.SaveAs(ppath);
                    cmd.Parameters.AddWithValue("@doc", fuDocument.FileName);
                }
            }

            Response.Write("<script>alert('Document uploaded successfully!');</script>");
            //pnlUpload.Visible = false;// Enable apply button after document upload
        }
        else
        {
            Response.Write("<script>alert('Please select a file to upload.');</script>");
        }
    }


}

