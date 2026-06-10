using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


public partial class AdminLogin : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
    
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        using(SqlConnection con = new SqlConnection(cs))
        {
            con.Open();
            string query = @"select * from Admin_Login where Username=@username AND Password=@password";

            using (SqlCommand cmd = new SqlCommand(query,con))
            {
                cmd.Parameters.AddWithValue("@username", txtusername.Text);
                cmd.Parameters.AddWithValue("@password", txtpassword.Text);

                SqlDataReader reader = cmd.ExecuteReader();
                if(reader.HasRows)
                {
                    reader.Read(); // Move to the first row
                    Session.Add("Admin_ID", reader["Admin_ID"].ToString()); // store Admin_ID, not username
                    Response.Redirect("~/Admin/AdminDashboard.aspx");
                }
                else
                {
                    string script = @"<script>
            Swal.fire({
              title: 'Incorrect Credential.!',
              text: 'Retry Again...',
              icon: 'info'
            });
        </script>";
                    ScriptManager.RegisterStartupScript(this, GetType(), "ErrorAlert", script, false);

                }
            }
        }
    }
}