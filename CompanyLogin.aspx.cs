using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;


public partial class AdminLogin : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    BasicCode b = new BasicCode();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT status,c_id, cname,ISNULL(photo, '~/Company/Companyimage/default-logo.png') AS photo FROM Company_Registration WHERE hremail = @Email AND password = @Password";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Email", txtemail.Text);
            cmd.Parameters.AddWithValue("@Password", txtpassword.Text);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                string status = reader["status"].ToString();
                // Store Company ID and Name in Session
                Session["CompanyID"] = reader["c_id"].ToString();
                Session["CompanyName"] = reader["cname"].ToString();
                Session["photo"] = reader["photo"].ToString();
                Session.Add("cname", reader["cname"].ToString());
                Session.Add("cid", reader["c_id"].ToString());
                // Redirect to Company Dashboard
                if (status == "Approved")
                {
                    Response.Redirect("~/Company/CompanyDashboard.aspx");
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

            conn.Close();
        }
    }


}