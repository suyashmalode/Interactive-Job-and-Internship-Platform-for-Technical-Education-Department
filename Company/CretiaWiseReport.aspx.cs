using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;

public partial class Admin_CretiaWiseReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            pnlResults.Visible = false; // Hide table on page load
        }
    }

    //protected void btnSearch_Click(object sender, EventArgs e)
    //{
    //    // Get values from textboxes (set to "0" if empty)
    //    string sscMin = string.IsNullOrEmpty(txtSSC.Text.Trim()) ? "0" : txtSSC.Text.Trim();
    //    string hscMin = string.IsNullOrEmpty(txtHSC.Text.Trim()) ? "0" : txtHSC.Text.Trim();
    //    string diplomaMin = string.IsNullOrEmpty(txtDiploma.Text.Trim()) ? "0" : txtDiploma.Text.Trim();
    //    string beMin = string.IsNullOrEmpty(txtBE.Text.Trim()) ? "0" : txtBE.Text.Trim();

    //    // Ensure input is numeric
    //    if (!float.TryParse(sscMin, out float sscValue)) sscValue = 0;
    //    if (!float.TryParse(hscMin, out float hscValue)) hscValue = 0;
    //    if (!float.TryParse(diplomaMin, out float diplomaValue)) diplomaValue = 0;
    //    if (!float.TryParse(beMin, out float beValue)) beValue = 0;

    //    // SQL Query - Ensure proper conversion and replacement
    //    string query = @"SELECT * FROM [Student_Registration] 
    //                     WHERE TRY_CAST(REPLACE(sscper, '%', '') AS FLOAT) >= @SSC
    //                     OR TRY_CAST(REPLACE(hscper, '%', '') AS FLOAT) >= @HSC
    //                     OR TRY_CAST(REPLACE(dipper, '%', '') AS FLOAT) >= @Diploma
    //                     OR TRY_CAST(REPLACE(beagg, '%', '') AS FLOAT) >= @BE";

    //    // Database Connection
    //    string connStr = ConfigurationManager.ConnectionStrings["PlacementPortalConnectionString"].ConnectionString;
    //    using (SqlConnection conn = new SqlConnection(connStr))
    //    {
    //        using (SqlCommand cmd = new SqlCommand(query, conn))
    //        {
    //            cmd.Parameters.AddWithValue("@SSC", sscValue);
    //            cmd.Parameters.AddWithValue("@HSC", hscValue);
    //            cmd.Parameters.AddWithValue("@Diploma", diplomaValue);
    //            cmd.Parameters.AddWithValue("@BE", beValue);

    //            conn.Open();
    //            SqlDataReader reader = cmd.ExecuteReader();
    //            DataTable dt = new DataTable();
    //            dt.Load(reader);
    //            if (dt.Rows.Count > 0)
    //            {
    //                pnlResults.Visible = true; // Show table when data is found
    //                Repeater1.DataSource = dt;
    //                Repeater1.DataBind();
    //            }
    //            else
    //            {
    //                pnlResults.Visible = false; // Hide if no data found
    //            }

    //            // Bind data to the Repeater
    //            //Repeater1.DataSource = dt;
    //            //Repeater1.DataBind();

    //        }
    //    }
    //}

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        // Start building SQL query dynamically
        StringBuilder queryBuilder = new StringBuilder("SELECT * FROM [Student_Registration] WHERE 1=1");

        // List of parameters to avoid SQL injection
        List<SqlParameter> parameters = new List<SqlParameter>();

        if (!string.IsNullOrEmpty(txtSSC.Text.Trim()))
        {
            queryBuilder.Append(" AND TRY_CAST(REPLACE(sscper, '%', '') AS FLOAT) >= @SSC");
            parameters.Add(new SqlParameter("@SSC", float.Parse(txtSSC.Text.Trim())));
        }

        if (!string.IsNullOrEmpty(txtHSC.Text.Trim()))
        {
            queryBuilder.Append(" AND TRY_CAST(REPLACE(hscper, '%', '') AS FLOAT) >= @HSC");
            parameters.Add(new SqlParameter("@HSC", float.Parse(txtHSC.Text.Trim())));
        }

        if (!string.IsNullOrEmpty(txtDiploma.Text.Trim()))
        {
            queryBuilder.Append(" AND TRY_CAST(REPLACE(dipper, '%', '') AS FLOAT) >= @Diploma");
            parameters.Add(new SqlParameter("@Diploma", float.Parse(txtDiploma.Text.Trim())));
        }

        if (!string.IsNullOrEmpty(txtBE.Text.Trim()))
        {
            queryBuilder.Append(" AND TRY_CAST(REPLACE(beagg, '%', '') AS FLOAT) >= @BE");
            parameters.Add(new SqlParameter("@BE", float.Parse(txtBE.Text.Trim())));
        }

        // If no criteria are provided, stop execution
        if (parameters.Count == 0)
        {
            pnlResults.Visible = false;
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowAlert",
                "Swal.fire({ title: 'Error', text: 'Please enter at least one filter value!', icon: 'error' });", true);
            return;
        }

        // Database connection
        string connStr = ConfigurationManager.ConnectionStrings["PlacementPortalConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            using (SqlCommand cmd = new SqlCommand(queryBuilder.ToString(), conn))
            {
                cmd.Parameters.AddRange(parameters.ToArray());
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(reader);

                if (dt.Rows.Count > 0)
                {
                    pnlResults.Visible = true; // Show table when data is found
                    Repeater1.DataSource = dt;
                    Repeater1.DataBind();
                }
                else
                {
                    pnlResults.Visible = false; // Hide if no data found
                    ScriptManager.RegisterStartupScript(this, GetType(), "ShowAlert",
                        "Swal.fire({ title: 'No Results', text: 'No students meet the selected criteria.', icon: 'info' });", true);
                }
            }
        }
    }
}


  
