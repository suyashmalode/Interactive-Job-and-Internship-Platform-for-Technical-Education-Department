using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

public partial class Student_CompanyDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string companyId = Request.QueryString["companyId"];
            if (!string.IsNullOrEmpty(companyId))
            {
                LoadCompanyDetails(companyId);
            }
            else
            {
                Response.Write("<script>alert('Company ID missing'); window.history.back();</script>");
            }
        }
    }

    private void LoadCompanyDetails(string companyId)
    {
        string connStr = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;

        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = @"SELECT cname, caddress, hremail, hrmobile, document, photo 
                             FROM Company_Registration 
                             WHERE c_id = @CompanyID";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@CompanyID", companyId);
                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        lblName.Text = "<label>Name:</label> <span class='value'>" + dr["cname"].ToString() + "</span>";
                        lblAddress.Text = "<label>Address:</label> <span class='value'>" + dr["caddress"].ToString() + "</span>";
                        lblEmail.Text = "<label>Email:</label> <span class='value'>" + dr["hremail"].ToString() + "</span>";
                        lblPhone.Text = "<label>Phone:</label> <span class='value'>" + dr["hrmobile"].ToString() + "</span>";

                        // Company Logo
                        if (dr["photo"] != DBNull.Value && !string.IsNullOrEmpty(dr["photo"].ToString()))
                        {
                            string logoPath = "~/Company/Companyimage/" + dr["photo"].ToString();
                            imgLogo.ImageUrl = logoPath;
                        }
                        else
                        {
                            imgLogo.ImageUrl = "~/images/no-logo.png"; // default fallback
                        }

                        // Company Document
                        if (dr["document"] != DBNull.Value && !string.IsNullOrEmpty(dr["document"].ToString()))
                        {
                            string documentPath = "~/Company/CompanyDocuments/" + dr["document"].ToString();
                            lnkDocument.NavigateUrl = documentPath;
                            lnkDocument.Visible = true;
                        }
                        else
                        {
                            lnkDocument.Visible = false;
                        }
                    }
                    else
                    {
                        Response.Write("<script>alert('Company not found'); window.history.back();</script>");
                    }
                }
            }
        }
    }
}
