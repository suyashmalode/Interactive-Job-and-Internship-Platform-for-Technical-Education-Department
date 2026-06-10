using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_InternshipDetails : System.Web.UI.Page
{
    string strConn = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;

    int currentYear = 0;
    decimal ssc = 0, hsc = 0, c1 = 0, c2 = 0, c3 = 0, c4 = 0;
    int backlog = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadStudentData();
            LoadFilters();
            BindInternshipDetails();
        }
    }

    // ================= STUDENT DATA =================
    void LoadStudentData()
    {
        if (Session["id"] == null)
        {
            Response.Redirect("~/Login.aspx");
            return;
        }

        using (SqlConnection con = new SqlConnection(strConn))
        {
            string sql = @"SELECT current_year,
                                  SSC_Percentage,
                                  HSC_Percentage,
                                  Year1_CGPA,
                                  Year2_CGPA,
                                  Year3_CGPA,
                                  Year4_CGPA,
                                  ISNULL(BacklogCount,0) AS Backlog
                           FROM Student_Registration
                           WHERE s_id=@id";

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@id", Session["id"]);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                currentYear = Convert.ToInt32(dr["current_year"]);
                backlog = Convert.ToInt32(dr["Backlog"]);

                ssc = GetDecimal(dr["SSC_Percentage"]);
                hsc = GetDecimal(dr["HSC_Percentage"]);
                c1 = GetDecimal(dr["Year1_CGPA"]);
                c2 = GetDecimal(dr["Year2_CGPA"]);
                c3 = GetDecimal(dr["Year3_CGPA"]);
                c4 = GetDecimal(dr["Year4_CGPA"]);
            }
        }
    }
    protected void gvInternships_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ViewDetails")
        {
            Response.Redirect("ViewInternshipDetails.aspx?ID=" + e.CommandArgument);
        }
        else if (e.CommandName == "ViewCompany")
        {
            Response.Redirect("CompanyDetails.aspx?CompanyID=" + e.CommandArgument);
        }
        else if (e.CommandName == "Apply")
        {
            int internshipID = Convert.ToInt32(e.CommandArgument);
            ApplyForInternship(internshipID);
        }
        else if (e.CommandName == "ViewStatus")
        {
            int internshipID = Convert.ToInt32(e.CommandArgument);
            ShowApplicationStatus(internshipID);
        }
    }
    private void ShowApplicationStatus(int internshipID)
    {
        if (Session["id"] == null)
            return;

        string studentID = Session["id"].ToString();
        string status = "Not Applied";

        using (SqlConnection con = new SqlConnection(strConn))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
            SELECT Status 
            FROM InternshipApplications
            WHERE StudentID=@sid AND InternshipID=@iid", con);

            cmd.Parameters.AddWithValue("@sid", studentID);
            cmd.Parameters.AddWithValue("@iid", internshipID);

            object result = cmd.ExecuteScalar();

            if (result != null)
            {
                string dbStatus = result.ToString();

                if (dbStatus == "Pending")
                    status = "⏳ Pending";
                else if (dbStatus == "Approved")
                    status = "✅ Accepted";
                else if (dbStatus == "Rejected")
                    status = "❌ Rejected";
            }
        }

        // Show popup
        ScriptManager.RegisterStartupScript(this, GetType(), "popup",
            $"ShowStatusPopup('{status}')", true);
    }

    // ================= MAIN GRID =================
    void BindInternshipDetails()
    {
        // ❌ BACKLOG CHECK
        if (backlog > 0)
        {
            gvInternships.DataSource = null;
            gvInternships.DataBind();

            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                "alert('You are not eligible due to backlog.');", true);
            return;
        }

        using (SqlConnection con = new SqlConnection(strConn))
        {
            con.Open();

            string query = @"
        SELECT 
            i.CompanyID,
            i.JobInternshipID,
            i.Title,
            i.Description,
            i.Location,
            i.JobType,
            i.Salary,
            i.Eligibility,
            c.cname
        FROM JobInternshipDetails i
        INNER JOIN Company_Registration c 
            ON i.CompanyID = c.c_id
        WHERE i.Status = 1

        -- YEAR FILTER
        AND (
                (@year IN (1,2,3) AND i.JobType = 'Internship')
             OR (@year = 4 AND i.JobType IN ('Job','Full-time'))
            )

        -- SSC / HSC FILTER
        AND (@ssc >= ISNULL(i.MinSSC, 0))
        AND (@hsc >= ISNULL(i.MinHSC, 0))

        -- 🔥 CGPA FILTER BASED ON CURRENT YEAR
        AND
        (
            (@year = 1 AND @c1 >= ISNULL(i.MinCGPA1, 0))

         OR (@year = 2 AND 
                @c1 >= ISNULL(i.MinCGPA1, 0)
            AND @c2 >= ISNULL(i.MinCGPA2, 0)
         )

         OR (@year = 3 AND 
                @c1 >= ISNULL(i.MinCGPA1, 0)
            AND @c2 >= ISNULL(i.MinCGPA2, 0)
            AND @c3 >= ISNULL(i.MinCGPA3, 0)
         )

         OR (@year = 4 AND 
                @c1 >= ISNULL(i.MinCGPA1, 0)
            AND @c2 >= ISNULL(i.MinCGPA2, 0)
            AND @c3 >= ISNULL(i.MinCGPA3, 0)
            AND @c4 >= ISNULL(i.MinCGPA4, 0)
         )
        )
        ";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@year", currentYear);
            cmd.Parameters.AddWithValue("@ssc", ssc);
            cmd.Parameters.AddWithValue("@hsc", hsc);
            cmd.Parameters.AddWithValue("@c1", c1);
            cmd.Parameters.AddWithValue("@c2", c2);
            cmd.Parameters.AddWithValue("@c3", c3);
            cmd.Parameters.AddWithValue("@c4", c4);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvInternships.DataSource = dt;
            gvInternships.DataBind();

            // OPTIONAL: No data message
            if (dt.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "nodata",
                    "alert('No internships match your criteria.');", true);
            }
        }
    }
    // ================= APPLY =================
    private void ApplyForInternship(int internshipID)
    {
        if (Session["id"] == null)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                "alert('Session expired. Please login again.');", true);
            return;
        }

        string studentID = Session["id"].ToString();
        string resumePath = "";

        using (SqlConnection con = new SqlConnection(strConn))
        {
            con.Open();

            // 🔹 STEP 1: Get student resume
            SqlCommand getResume = new SqlCommand(
                "SELECT resume FROM Student_Registration WHERE s_id=@sid", con);

            getResume.Parameters.AddWithValue("@sid", studentID);

            object res = getResume.ExecuteScalar();
            if (res != null)
                resumePath = res.ToString();

            // 🔹 STEP 2: Check already applied
            SqlCommand checkCmd = new SqlCommand(@"
            SELECT COUNT(*) FROM InternshipApplications
            WHERE StudentID=@sid AND InternshipID=@iid", con);

            checkCmd.Parameters.AddWithValue("@sid", studentID);
            checkCmd.Parameters.AddWithValue("@iid", internshipID);

            if (Convert.ToInt32(checkCmd.ExecuteScalar()) > 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    "alert('You already applied for this internship.');", true);
                return;
            }

            // 🔹 STEP 3: Insert with ResumePath
            SqlCommand insertCmd = new SqlCommand(@"
            INSERT INTO InternshipApplications
            (StudentID, InternshipID, ApplicationDate, Status, ResumePath)
            VALUES (@sid, @iid, GETDATE(), 'Pending', @resume)", con);

            insertCmd.Parameters.AddWithValue("@sid", studentID);
            insertCmd.Parameters.AddWithValue("@iid", internshipID);
            insertCmd.Parameters.AddWithValue("@resume", resumePath);

            insertCmd.ExecuteNonQuery();
        }

        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
            "alert('Application submitted successfully!');", true);
    }



    // ================= HELPERS =================
    decimal GetDecimal(object val)
    {
        if (val == DBNull.Value) return 0;
        decimal.TryParse(val.ToString(), out decimal d);
        return d;
    }
    protected void FilterChanged(object sender, EventArgs e)
    {
        BindInternshipDetails();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindInternshipDetails();
    }
    protected void gvInternships_Sorting(object sender, GridViewSortEventArgs e)
    {
        BindInternshipDetails();
    }
    private void LoadFilters()
    {
        using (SqlConnection con = new SqlConnection(strConn))
        {
            con.Open();

            SqlCommand cmdLoc = new SqlCommand(
                "SELECT DISTINCT Location FROM JobInternshipDetails WHERE Status=1", con);

            ddlLocation.DataSource = cmdLoc.ExecuteReader();
            ddlLocation.DataBind();
            ddlLocation.Items.Insert(0, new ListItem("All Locations", ""));

            con.Close();
            con.Open();

            SqlCommand cmdComp = new SqlCommand(
                "SELECT c_id, cname FROM Company_Registration", con);

            ddlCompany.DataSource = cmdComp.ExecuteReader();
            ddlCompany.DataBind();
            ddlCompany.Items.Insert(0, new ListItem("All Companies", ""));
        }
    }
}