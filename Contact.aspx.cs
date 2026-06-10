using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class Contact : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    BasicCode b = new BasicCode();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void sendButton_Click(object sender, EventArgs e)
    {
        con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]);
        cmd = new SqlCommand();
        con.Open();
        cmd.CommandText = @"Insert Into Contact (id,name,email,subject,message)
                        Values (@id,@name,@email,@subject,@message)";
        cmd.Parameters.AddWithValue("@id", b.generateID("id", "Contact"));
        cmd.Parameters.AddWithValue("@name", txtname.Text);
        cmd.Parameters.AddWithValue("@email", txtemail.Text);
        cmd.Parameters.AddWithValue("@subject", txtsubject.Text);
        cmd.Parameters.AddWithValue("@message", txtmessage.Text);

        cmd.Connection = con;
        int n = cmd.ExecuteNonQuery();
        if (n > 0)
        {
            string script = @"<script>
                                Swal.fire({
                                  title: 'Thank You For Contact Us!',
                                  text: 'click ok to continue!',
                                  icon: 'success'
                                });
                             </script>";

            ScriptManager.RegisterStartupScript(this, GetType(), "ShowAlert", script, false);
        }
    }
}