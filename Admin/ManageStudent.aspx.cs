using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ManageStudent : System.Web.UI.Page
{
    string strConn = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadStudents();
        }
    }

    private void LoadStudents()
    {
        using (SqlConnection conn = new SqlConnection(strConn))
        {
            string query = @"SELECT id, s_id, name,dob, mobile, gender, 
                                    photo, resume, status 
                             FROM Student_Registration";
            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvStudents.DataSource = dt;
            gvStudents.DataBind();
        }
    }

    protected void gvStudents_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "UpdateStatus")
        {
            int studentId = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            DropDownList ddlStatus = (DropDownList)row.FindControl("ddlStatus");

            int result = 0;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string query = "UPDATE Student_Registration SET status=@status WHERE id=@id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@id", studentId);
                conn.Open();
                result = cmd.ExecuteNonQuery();
            }

            if (result > 0)
            {
                string script = @"<script>
                    Swal.fire({
                        title: 'Success!',
                        text: 'Student status updated successfully.',
                        icon: 'success',
                        confirmButtonColor: '#3085d6',
                        confirmButtonText: 'OK'
                    });
                </script>";
                ScriptManager.RegisterStartupScript(this, GetType(), "SuccessAlert", script, false);
            }
            else
            {
                string script = @"<script>
                    Swal.fire({
                        title: 'Error!',
                        text: 'Unable to update status. Please try again.',
                        icon: 'error',
                        confirmButtonColor: '#d33',
                        confirmButtonText: 'Retry'
                    });
                </script>";
                ScriptManager.RegisterStartupScript(this, GetType(), "ErrorAlert", script, false);
            }

            LoadStudents();
        }
    }
}
