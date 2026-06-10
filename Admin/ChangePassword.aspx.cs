using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_ChangePassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Assuming Admin_ID is stored in Session after login
            if (Session["Admin_ID"] != null)
            {
                LoadCurrentAdmin();
            }
            else
            {
                Response.Redirect("~/Admin/Login.aspx");
            }
        }
    }

    private void LoadCurrentAdmin()
    {
        int adminId = Convert.ToInt32(Session["Admin_ID"]);
        string cs = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();
            string query = "SELECT Username FROM Admin_Login WHERE Admin_ID=@AdminID";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@AdminID", adminId);
                txtCurrentUsername.Text = cmd.ExecuteScalar()?.ToString();
            }
        }
    }

    protected void btnChange_Click(object sender, EventArgs e)
    {
        if (Session["Admin_ID"] == null)
        {
            Response.Redirect("~/Admin/Login.aspx");
            return;
        }

        int adminId = Convert.ToInt32(Session["Admin_ID"]);
        string currentPassword = txtCurrentPassword.Text.Trim();
        string newUsername = txtNewUsername.Text.Trim();
        string newPassword = txtNewPassword.Text.Trim();

        string cs = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            // If a new password is provided, verify the current password
            if (!string.IsNullOrEmpty(newPassword))
            {
                string checkQuery = "SELECT Password FROM Admin_Login WHERE Admin_ID=@AdminID";
                using (SqlCommand cmdCheck = new SqlCommand(checkQuery, con))
                {
                    cmdCheck.Parameters.AddWithValue("@AdminID", adminId);
                    string dbPassword = cmdCheck.ExecuteScalar()?.ToString();

                    if (dbPassword != currentPassword)
                    {
                        lblMessage.Text = "Current password is incorrect!";
                        return;
                    }
                }
            }

            // Build dynamic update query
            string updateQuery = "UPDATE Admin_Login SET ";
            bool addComma = false;
            SqlCommand cmdUpdate = new SqlCommand();
            cmdUpdate.Connection = con;

            if (!string.IsNullOrEmpty(newUsername))
            {
                updateQuery += "Username=@NewUsername";
                cmdUpdate.Parameters.AddWithValue("@NewUsername", newUsername);
                addComma = true;
            }

            if (!string.IsNullOrEmpty(newPassword))
            {
                if (addComma) updateQuery += ", ";
                updateQuery += "Password=@NewPassword";
                cmdUpdate.Parameters.AddWithValue("@NewPassword", newPassword);
            }

            if (cmdUpdate.Parameters.Count == 0)
            {
                lblMessage.Text = "Enter a new username or password to update.";
                return;
            }

            updateQuery += " WHERE Admin_ID=@AdminID";
            cmdUpdate.Parameters.AddWithValue("@AdminID", adminId);
            cmdUpdate.CommandText = updateQuery;

            int rows = cmdUpdate.ExecuteNonQuery();
            if (rows > 0)
            {
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Credentials updated successfully!";

                if (!string.IsNullOrEmpty(newUsername))
                    txtCurrentUsername.Text = newUsername;

                txtCurrentPassword.Text = "";
                txtNewPassword.Text = "";
                txtNewUsername.Text = "";
            }
            else
            {
                lblMessage.Text = "Update failed. Please try again.";
            }
        }
    }
}
