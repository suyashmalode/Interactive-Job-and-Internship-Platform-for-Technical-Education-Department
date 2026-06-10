using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class UserLogin : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    BasicCode b = new BasicCode();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]);
        cmd = new SqlCommand();
        con.Open();
        cmd.CommandText = @"Select s_id,name,photo,Status From Student_Registration  Where s_id=@id And password=@pass";
        cmd.Parameters.AddWithValue("@id", txtstudentid.Text);
        cmd.Parameters.AddWithValue("@pass", txtpassword.Text);
        cmd.Connection = con;
        SqlDataReader dr = cmd.ExecuteReader();

        if (dr.Read())
        {
            string status = dr["Status"].ToString();
            string userId = dr["s_id"].ToString();
            string studentName = dr["name"].ToString();
            string photo = dr["photo"].ToString();

            Session.Add("id", userId);
            Session.Add("name", studentName);
            Session.Add("photo", photo);
            if (status == "Approved")
            {
                Response.Redirect("~/Student/Dashboard.aspx");
            }
            else if (status == "Pending")
            {
                string script = @"<script>
            Swal.fire({
              title: 'Account Pending!',
              text: 'Your registration is awaiting admin approval. Please check back later.',
              icon: 'info'
            });
        </script>";
                ScriptManager.RegisterStartupScript(this, GetType(), "PendingAlert", script, false);
            }
            else if (status == "Rejected")
            {
                string script = @"<script>
            Swal.fire({
              title: 'Access Denied!',
              text: 'Your registration was rejected by the admin. Please contact support.',
              icon: 'error'
            });
        </script>";
                ScriptManager.RegisterStartupScript(this, GetType(), "RejectedAlert", script, false);
            }

        }
        else
        {
            // Show SweetAlert on failed login
            string script = @"<script>
                                Swal.fire({
                                  title: 'Login Failed!',
                                  text: 'Invalid username or password. Please try again!',
                                  icon: 'error'
                                });
                              </script>";
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowAlert", script, false);
        }

    }
}