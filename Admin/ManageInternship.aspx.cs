using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class Admin_ManageInternship : System.Web.UI.Page
{
    private string connStr = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
            LoadJobListings();
        }
    }

    private void LoadJobListings()
    {
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string sql = @"SELECT JobInternshipID, CompanyID, Title, JobType, Location, PostedDate, LastDateToApply, Status, PDF
                           FROM JobInternshipDetails
                           ORDER BY PostedDate DESC";

            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                con.Open();
                DataTable dt = new DataTable();
                dt.Load(cmd.ExecuteReader());
                gvJobListings.DataSource = dt;
                gvJobListings.DataBind();
            }
        }
    }

    protected void gvJobListings_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Approve" || e.CommandName == "Reject")
        {
            int jobId = Convert.ToInt32(e.CommandArgument);
            int newStatus = (e.CommandName == "Approve") ? 1 : 0; // 1=Approved, 0=Pending or Rejected

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = "UPDATE JobInternshipDetails SET Status=@Status WHERE JobInternshipID=@JobInternshipID";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@Status", newStatus);
                    cmd.Parameters.AddWithValue("@JobInternshipID", jobId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            lblAdminMessage.Text = (newStatus == 1) ? "Listing approved successfully." : "Listing rejected.";
            LoadJobListings();
        }
    }
}
