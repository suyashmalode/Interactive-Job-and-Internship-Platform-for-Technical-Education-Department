using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class Company_ForgetPassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string companyname = txtcompanyname.Text.Trim();

        if (string.IsNullOrEmpty(companyname))
        {
            lblMessage.Text = "Please enter your Company Name.";
            return;
        }

        string connectionString = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT password FROM Company_Registration WHERE cname = @cname";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@cname", companyname);

            con.Open();
            object result = cmd.ExecuteScalar();

            if (result != null)
            {
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Your password is: " + result.ToString();
            }
            else
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Invalid Company ID. Please try again.";
            }
        }
    }
}
