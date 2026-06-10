using System;
using System.Configuration;
using System.Data.SqlClient;

public partial class Admin_CompanyDetails : System.Web.UI.Page
{
    private string connStr = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (int.TryParse(Request.QueryString["CompanyID"], out int companyId))
            {
                LoadCompanyDetails(companyId);
            }
            else
            {
                lblMessage.Text = "Invalid Company ID.";
            }
        }
    }

    private void LoadCompanyDetails(int companyId)
    {
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string sql = @"SELECT cname, hremail, hrmobile, caddress, photo, document 
                       FROM Company_Registration WHERE c_id = @CompanyID";

            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@CompanyID", companyId);
                con.Open();

                using (var reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        lblCompanyName.Text = reader["cname"].ToString();
                        lblEmail.Text = reader["hremail"].ToString();
                        lblPhone.Text = reader["hrmobile"].ToString();
                        lblAddress.Text = reader["caddress"].ToString();

                        // Show photo if exists
                        if (reader["photo"] != DBNull.Value && !string.IsNullOrEmpty(reader["photo"].ToString()))
                        {
                            imgCompanyPhoto.ImageUrl = "~/Company/Companyimage/" + reader["photo"].ToString();
                            imgCompanyPhoto.Visible = true;
                        }
                        else
                        {
                            imgCompanyPhoto.Visible = false;
                        }

                        // Show document link if exists
                        if (reader["document"] != DBNull.Value && !string.IsNullOrEmpty(reader["document"].ToString()))
                        {
                            hlDocument.NavigateUrl = "~/Company/CompanyDocuments/" + reader["document"].ToString();
                            hlDocument.Visible = true;
                        }
                        else
                        {
                            hlDocument.Visible = false;
                        }
                    }
                    else
                    {
                        lblMessage.Text = "Company not found.";
                    }
                }
            }
        }
    }
}
