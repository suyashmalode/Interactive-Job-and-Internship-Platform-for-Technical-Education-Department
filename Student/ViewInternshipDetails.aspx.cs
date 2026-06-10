using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Student_ViewInternshipDetails : System.Web.UI.Page
{
    string strConn = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["ID"] != null)
            {
                LoadDetails(Request.QueryString["ID"]);
            }
        }
    }

    void LoadDetails(string internshipID)
    {
        using (SqlConnection con = new SqlConnection(strConn))
        {
            SqlCommand cmd = new SqlCommand("SELECT * FROM JobInternshipDetails WHERE JobInternshipID=@ID", con);
            cmd.Parameters.AddWithValue("@ID", internshipID);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                lblTitle.Text = dr["Title"].ToString();
                lblDescription.Text = dr["Description"].ToString();
                lblLocation.Text = dr["Location"].ToString();
                lblEligibility.Text = dr["Eligibility"].ToString();
                lblSalary.Text = dr["Salary"].ToString();
                lblPostedDate.Text = dr["PostedDate"].ToString();
                lblLastDate.Text = dr["LastDateToApply"].ToString();

                // ⭐ PDF Load
                if (!string.IsNullOrEmpty(dr["PDF"].ToString()))
                {
                    hlPDF.NavigateUrl = "~/Company/InternshipDocument/" + dr["PDF"].ToString();
                }
                else
                {
                    hlPDF.Text = "No PDF Available";
                    hlPDF.Enabled = false;
                    hlPDF.CssClass = "text-danger";  // red text
                }
            }
        }
    }
}
