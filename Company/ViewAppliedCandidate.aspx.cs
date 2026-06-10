using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Company_ViewAppliedCandidate : System.Web.UI.Page
{
    private string connStr = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindGrid();
        }
    }

    private void BindGrid()
    {
        if (Session["CompanyID"] == null)
        {
            Response.Redirect("~/CompanyLogin.aspx");
            return;
        }

        int companyId = Convert.ToInt32(Session["CompanyID"]);

        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = @"
                SELECT 
                    ia.ApplicationID,
                    s.s_id AS StudentID,
                    s.name AS StudentName,
                    ia.ApplicationDate,
                    ia.Status,
                    '~/Uploads/Resumes/' + s.resume AS ResumePath
                FROM InternshipApplications ia
                INNER JOIN Student_Registration s ON ia.StudentID = s.s_id
                INNER JOIN JobInternshipDetails j ON ia.InternshipID = j.JobInternshipID
                WHERE j.CompanyID = @CompanyID
                ORDER BY ia.ApplicationDate DESC";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@CompanyID", companyId);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            GridViewCandidates.DataSource = dt;
            GridViewCandidates.DataBind();
        }
    }

    protected void GridViewCandidates_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Approve" || e.CommandName == "Reject")
        {
            int applicationId = Convert.ToInt32(e.CommandArgument);
            string newStatus = e.CommandName == "Approve" ? "Accepted" : "Rejected";

            UpdateApplicationStatus(applicationId, newStatus);
            BindGrid();  // Refresh GridView after update

            string message = "Application has been " + newStatus.ToLower() + " successfully.";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + message + "');", true);
        }
    }

    private void UpdateApplicationStatus(int applicationId, string status)
    {
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "UPDATE InternshipApplications SET Status = @Status WHERE ApplicationID = @ApplicationID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@ApplicationID", applicationId);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }

    protected void GridViewCandidates_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // Calculate the row number (1-based)
            int serialNumber = e.Row.RowIndex + 1;

            // Find the label in the first cell and set text
            Label lblSerialNumber = (Label)e.Row.FindControl("lblSerialNumber");
            if (lblSerialNumber != null)
            {
                lblSerialNumber.Text = serialNumber.ToString();
            }
        }
    }
}
