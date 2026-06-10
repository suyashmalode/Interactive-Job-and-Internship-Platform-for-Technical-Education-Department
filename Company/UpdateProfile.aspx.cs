using System;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.UI;

public partial class Company_UpdateProfile : System.Web.UI.Page
{
    string connString = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadCompanyData();
        }
    }

    private void LoadCompanyData()
    {
        if (Session["CompanyID"] != null)
        {
            int companyId = Convert.ToInt32(Session["CompanyID"]);

            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = "SELECT cname, hrname, hrmobile, hremail, hrdesignation, caddress, photo, document, password FROM Company_Registration WHERE c_id = @CompanyID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CompanyID", companyId);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        txtcompanyname.Text = reader["cname"].ToString();
                        txthrname.Text = reader["hrname"].ToString();
                        txthrmobile.Text = reader["hrmobile"].ToString();
                        txthremail.Text = reader["hremail"].ToString();
                        txtdesignation.Text = reader["hrdesignation"].ToString();
                        txtcompanyaddress.Text = reader["caddress"].ToString();
                        txtpassword.Text = reader["password"].ToString();

                        // 🖼️ Load Photo
                        if (!string.IsNullOrEmpty(reader["photo"].ToString()))
                        {
                            imgPreview.ImageUrl = "~/Company/Companyimage/" + reader["photo"].ToString();
                            ViewState["photo"] = reader["photo"].ToString();
                        }

                        // 📄 Load Document
                        if (!string.IsNullOrEmpty(reader["document"].ToString()))
                        {
                            lnkExistingDoc.NavigateUrl = "~/Company/CompanyDocuments/" + reader["document"].ToString();
                            lnkExistingDoc.Visible = true;
                            ViewState["document"] = reader["document"].ToString();
                        }
                    }
                }
            }
        }
        else
        {
            Response.Redirect("CompanyLogin.aspx");
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        if (Session["CompanyID"] != null)
        {
            int companyId = Convert.ToInt32(Session["CompanyID"]);
            string oldPhoto = ViewState["photo"]?.ToString() ?? "";
            string oldDoc = ViewState["document"]?.ToString() ?? "";

            string newPhotoFile = oldPhoto;
            string newDocFile = oldDoc;

            // 🖼️ Handle Photo Upload
            if (fuphoto.HasFile)
            {
                try
                {
                    // delete old image physically if exists
                    if (!string.IsNullOrEmpty(oldPhoto))
                    {
                        string oldPath = Server.MapPath("~/Company/Companyimage/" + oldPhoto);
                        if (File.Exists(oldPath))
                            File.Delete(oldPath);
                    }

                    // save new image
                    newPhotoFile = companyId + "_" + Path.GetFileName(fuphoto.FileName);
                    string newPath = Server.MapPath("~/Company/Companyimage/" + newPhotoFile);
                    fuphoto.SaveAs(newPath);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "imgError",
                        $"Swal.fire('Error', 'Error saving image: {ex.Message}', 'error');", true);
                    return;
                }
            }

            // 📄 Handle Document Upload
            if (fuDocument.HasFile)
            {
                try
                {
                    string ext = Path.GetExtension(fuDocument.FileName).ToLower();
                    if (ext == ".pdf" || ext == ".doc" || ext == ".docx")
                    {
                        // delete old document physically if exists
                        if (!string.IsNullOrEmpty(oldDoc))
                        {
                            string oldDocPath = Server.MapPath("~/Company/CompanyDocuments/" + oldDoc);
                            if (File.Exists(oldDocPath))
                                File.Delete(oldDocPath);
                        }

                        // save new document
                        newDocFile = companyId + "_document" + ext;
                        string docPath = Server.MapPath("~/Company/CompanyDocuments/" + newDocFile);
                        fuDocument.SaveAs(docPath);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "invalidDoc",
                            "Swal.fire('Invalid File!', 'Only PDF or Word files allowed.', 'error');", true);
                        return;
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "docError",
                        $"Swal.fire('Error', 'Error saving document: {ex.Message}', 'error');", true);
                    return;
                }
            }

            // 📝 Update Database
            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = @"UPDATE Company_Registration 
                                 SET cname=@CompanyName, hrname=@HRName, hrmobile=@HRMobile, 
                                     hremail=@HREmail, hrdesignation=@HRDesignation, 
                                     caddress=@CompanyAddress, password=@Password, 
                                     photo=@photo, document=@document
                                 WHERE c_id=@CompanyID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CompanyName", txtcompanyname.Text);
                    cmd.Parameters.AddWithValue("@HRName", txthrname.Text);
                    cmd.Parameters.AddWithValue("@HRMobile", txthrmobile.Text);
                    cmd.Parameters.AddWithValue("@HREmail", txthremail.Text);
                    cmd.Parameters.AddWithValue("@HRDesignation", txtdesignation.Text);
                    cmd.Parameters.AddWithValue("@CompanyAddress", txtcompanyaddress.Text);
                    cmd.Parameters.AddWithValue("@Password", txtpassword.Text);
                    cmd.Parameters.AddWithValue("@photo", newPhotoFile);
                    cmd.Parameters.AddWithValue("@document", newDocFile);
                    cmd.Parameters.AddWithValue("@CompanyID", companyId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // 🔁 Update UI
            imgPreview.ImageUrl = "~/Company/Companyimage/" + newPhotoFile;
            if (!string.IsNullOrEmpty(newDocFile))
            {
                lnkExistingDoc.NavigateUrl = "~/Company/CompanyDocuments/" + newDocFile;
                lnkExistingDoc.Visible = true;
            }

            // ✅ SweetAlert Success
            string script = @"
    Swal.fire({
        title: 'Success',
        text: 'Profile updated successfully!',
        icon: 'success'
    }).then(function() {
        window.location = '/Company/UpdateProfile.aspx';
    });";

            ScriptManager.RegisterStartupScript(this, this.GetType(), "success", script, true);

        }
    }
}
