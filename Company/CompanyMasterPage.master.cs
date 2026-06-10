using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class User_UserMasterPage : System.Web.UI.MasterPage
{
    string connString = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["CompanyID"] != null)
            {
                litCompanyName.Text = Session["cname"] != null ? Session["cname"].ToString() : "Company";

                int companyId = Convert.ToInt32(Session["CompanyID"]);
                LoadCompanyPhoto(companyId);
            }
            else
            {
                Response.Redirect("~/CompanyLogin.aspx");
            }
        }
    }

    private void LoadCompanyPhoto(int companyId)
    {
        using (SqlConnection con = new SqlConnection(connString))
        {
            string query = "SELECT photo FROM Company_Registration WHERE c_id = @CompanyID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@CompanyID", companyId);
                con.Open();

                object photoObj = cmd.ExecuteScalar();
                if (photoObj != null && photoObj != DBNull.Value)
                {
                    string photoFileName = photoObj.ToString();

                    // Check if file exists on server (optional)
                    string physicalPath = Server.MapPath("~/Company/Companyimage/" + photoFileName);
                    if (System.IO.File.Exists(physicalPath))
                    {
                        imgCompanyLogo.ImageUrl = ResolveUrl("~/Company/Companyimage/" + photoFileName);
                    }
                    else
                    {
                        // File missing, fallback to default
                        imgCompanyLogo.ImageUrl = ResolveUrl("~/Images/default-logo.png");
                    }
                }
                else
                {
                    // No photo in DB, fallback to default
                    imgCompanyLogo.ImageUrl = ResolveUrl("~/Images/default-logo.png");
                }
            }
        }
    }

    protected string GetActiveClass(string pageName)
    {
        string currentPage = System.IO.Path.GetFileName(Request.Path);
        return currentPage.Equals(pageName, StringComparison.OrdinalIgnoreCase) ? "active" : "";
    }

    protected string GetDropdownActiveClass()
    {
        string currentPage = System.IO.Path.GetFileName(Request.Path);
        string[] reportPages = { "CretiaWiseReport.aspx", "NAACReport.aspx", "NBAReport.aspx", "SummaryReport.aspx", "ViewPlacedStudent.aspx" };

        foreach (string reportPage in reportPages)
        {
            if (currentPage.Equals(reportPage, StringComparison.OrdinalIgnoreCase))
            {
                return "active";
            }
        }
        return "";
    }
}
