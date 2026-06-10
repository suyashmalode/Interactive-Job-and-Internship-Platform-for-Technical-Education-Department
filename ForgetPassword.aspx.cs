using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class ForgetPassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string studentID = txtStudentID.Text.Trim();

        if (string.IsNullOrEmpty(studentID))
        {
            lblMessage.Text = "Please enter your Student ID.";
            return;
        }

        string connectionString = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT password FROM Student_Registration WHERE s_id = @StudentID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@StudentID", studentID);

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
                lblMessage.Text = "Invalid Student ID. Please try again.";
            }
        }
    }
}
