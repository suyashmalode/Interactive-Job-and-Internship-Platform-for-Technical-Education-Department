using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_CompanyRegistration : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]);
        con.Open();

        // 1. Check if company already registered
        string checkQuery = "SELECT COUNT(*) FROM Company_Registration WHERE cname = @cname OR hremail = @hremail";
        SqlCommand checkCmd = new SqlCommand(checkQuery, con);
        checkCmd.Parameters.AddWithValue("@cname", txtcompanyname.Text.Trim());
        checkCmd.Parameters.AddWithValue("@hremail", txthremail.Text.Trim());

        int exists = (int)checkCmd.ExecuteScalar();

        if (exists > 0)
        {
            string script = "alert('Company already registered with this name or HR email!');";
            ClientScript.RegisterStartupScript(this.GetType(), "CompanyExists", script, true);
            con.Close();
            return;
        }

        // 2. Insert new company with empty photo and document (for now)
        string insertQuery = @"
        INSERT INTO Company_Registration 
        (cname, hrname, hrmobile, hremail, hrdesignation, caddress, password, photo, document, status) 
        VALUES 
        (@cname, @hrname, @hrmobile, @hremail, @hrdesignation, @caddress, @password, '', '', 'Pending');
        SELECT SCOPE_IDENTITY();"; // Get inserted company id

        int newCompanyId = 0;
        using (SqlCommand cmd = new SqlCommand(insertQuery, con))
        {
            cmd.Parameters.AddWithValue("@cname", txtcompanyname.Text.Trim());
            cmd.Parameters.AddWithValue("@hrname", txthrname.Text.Trim());
            cmd.Parameters.AddWithValue("@hrmobile", txthrmobile.Text.Trim());
            cmd.Parameters.AddWithValue("@hremail", txthremail.Text.Trim());
            cmd.Parameters.AddWithValue("@hrdesignation", txtdesignation.Text.Trim());
            cmd.Parameters.AddWithValue("@caddress", txtcompanyaddress.Text.Trim());
            cmd.Parameters.AddWithValue("@password", txtpassword.Text.Trim());

            // Execute and get new company ID
            object result = cmd.ExecuteScalar();
            if (result != null)
                newCompanyId = Convert.ToInt32(result);
        }

        if (newCompanyId > 0)
        {
            string logoFileName = "";
            string docFileName = "";

            // Save company logo
            if (fuclogo.HasFile)
            {
                string logoExtension = System.IO.Path.GetExtension(fuclogo.FileName);
                logoFileName = "Company_" + newCompanyId + logoExtension;
                string logoPath = Server.MapPath("/Company/Companyimage/") + logoFileName;
                fuclogo.SaveAs(logoPath);
            }

            // Save company document
            if (fuDocument.HasFile)
            {
                string docExtension = System.IO.Path.GetExtension(fuDocument.FileName);
                docFileName = "Company_" + newCompanyId + docExtension;
                string docPath = Server.MapPath("/Company/CompanyDocuments/") + docFileName;
                fuDocument.SaveAs(docPath);
            }

            // Update company record with file names
            string updateQuery = "UPDATE Company_Registration SET photo=@photo, document=@document WHERE c_id=@cid";
            using (SqlCommand updateCmd = new SqlCommand(updateQuery, con))
            {
                updateCmd.Parameters.AddWithValue("@photo", logoFileName);
                updateCmd.Parameters.AddWithValue("@document", docFileName);
                updateCmd.Parameters.AddWithValue("@cid", newCompanyId);

                updateCmd.ExecuteNonQuery();
            }

            ClearFields();
            string successScript = "alert('Company Registered Successfully!'); window.location='';";
            ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", successScript, true);
        }
        else
        {
            Response.Write("<script>alert('Registration Failed!');</script>");
        }

        con.Close();
    }

    private void ClearFields()
    {
        txtcompanyname.Text = "";
        txtdesignation.Text = "";
        txthremail.Text = "";
        txthrmobile.Text = "";
        txtcompanyaddress.Text = "";
        txthrname.Text = "";
        txtpassword.Text = "";
    }
}
