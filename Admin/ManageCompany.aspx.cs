using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ManageCompany : System.Web.UI.Page
{
    string strConn = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadCompanies();
        }
    }

    private void LoadCompanies()
    {
        using (SqlConnection conn = new SqlConnection(strConn))
        {
            string query = @"SELECT c_id, cname, hrname, hrmobile, hremail, hrdesignation, 
                                    caddress, photo, document, status 
                             FROM Company_Registration";

            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvCompanies.DataSource = dt;
            gvCompanies.DataBind();
        }
    }

    protected void gvCompanies_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "UpdateStatus")
        {
            int companyId = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            DropDownList ddlStatus = (DropDownList)row.FindControl("ddlStatus");

            int result = 0;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string query = "UPDATE Company_Registration SET status=@status WHERE c_id=@id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@id", companyId);
                conn.Open();
                result = cmd.ExecuteNonQuery();
            }

            // ✅ Show SweetAlert based on success or failure
            if (result > 0)
            {
                string script = @"<script>
                    Swal.fire({
                        title: 'Success!',
                        text: 'Company status updated successfully.',
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
                        text: 'Something went wrong. Please try again.',
                        icon: 'error',
                        confirmButtonColor: '#d33',
                        confirmButtonText: 'Retry'
                    });
                </script>";
                ScriptManager.RegisterStartupScript(this, GetType(), "ErrorAlert", script, false);
            }

            LoadCompanies();
        }
    }
}
