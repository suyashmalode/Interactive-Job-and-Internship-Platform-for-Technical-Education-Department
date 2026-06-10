using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_Report : System.Web.UI.Page
{
    string strConn = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;
    DataTable dtReports;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadApplicationReports();
        }
    }

    private void LoadApplicationReports()
    {
        string query = @"
            SELECT 
                j.JobInternshipID,
                j.Title,
                c.cname AS CompanyName,
                COUNT(a.ApplicationID) AS TotalApplications,
                SUM(CASE WHEN UPPER(LTRIM(RTRIM(a.Status))) = 'PENDING' THEN 1 ELSE 0 END) AS PendingCount,
                SUM(CASE WHEN UPPER(LTRIM(RTRIM(a.Status))) = 'ACCEPTED' THEN 1 ELSE 0 END) AS ApprovedCount,
                SUM(CASE WHEN UPPER(LTRIM(RTRIM(a.Status))) = 'REJECTED' THEN 1 ELSE 0 END) AS RejectedCount
            FROM JobInternshipDetails j
            INNER JOIN Company_Registration c ON j.CompanyID = c.c_id
            LEFT JOIN InternshipApplications a ON j.JobInternshipID = a.InternshipID
            GROUP BY j.JobInternshipID, j.Title, c.cname
            ORDER BY TotalApplications DESC";

        using (SqlConnection con = new SqlConnection(strConn))
        {
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            dtReports = new DataTable();
            da.Fill(dtReports);

            gvApplicationReports.DataSource = dtReports;
            gvApplicationReports.DataBind();
        }
    }

    // Helper method for footer totals
    public string GetColumnTotal(string columnName)
    {
        if (dtReports == null) return "0";
        int total = 0;
        foreach (DataRow row in dtReports.Rows)
        {
            total += Convert.ToInt32(row[columnName]);
        }
        return total.ToString();
    }
}
