using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Company_AddJobInternshipdetails : System.Web.UI.Page
{
    private string connStr = ConfigurationManager.ConnectionStrings["Carrier_Portal"].ConnectionString;

    protected int CompanyID
    {
        get
        {
            if (Session["CompanyID"] == null)
            {
                Response.Redirect("~/CompanyLogin.aspx");
                return 0;
            }
            return Convert.ToInt32(Session["CompanyID"]);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadJobs();
        }
    }

    // ================= INSERT =================
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        string fileName = UploadPDF();

        using (SqlConnection con = new SqlConnection(connStr))
        {
            string sql = @"INSERT INTO JobInternshipDetails
(CompanyID, Title, Description, Location, JobType, PostedDate, LastDateToApply,
 Salary, Eligibility, ContactEmail, ContactPhone, Status, PDF,
  MinSSC, MinHSC, MinCGPA1, MinCGPA2, MinCGPA3, MinCGPA4)
VALUES
(@CompanyID, @Title, @Description, @Location, @JobType, GETDATE(),
 @LastDateToApply, @Salary, @Eligibility, @ContactEmail, @ContactPhone, 1, @PDF,
  @ssc, @hsc, @c1, @c2, @c3, @c4)";
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@CompanyID", CompanyID);
                AddParameters(cmd);
                cmd.Parameters.AddWithValue("@PDF", (object)fileName ?? DBNull.Value);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        lblMessage.Text = "Job/Internship posted successfully but it will get approve by admin and then get visible to students.";
        ClearForm();
        LoadJobs();
    }

    // ================= UPDATE =================
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        if (string.IsNullOrEmpty(hfJobID.Value))
        {
            lblMessage.Text = "Select a record first.";
            return;
        }

        string fileName = hfExistingPDF.Value;

        if (FileUploadDoc.HasFile)
        {
            fileName = UploadPDF();
        }

        using (SqlConnection con = new SqlConnection(connStr))
        {
            string sql = @"UPDATE JobInternshipDetails
SET Title=@Title, Description=@Description, Location=@Location, JobType=@JobType,
    LastDateToApply=@LastDateToApply, Salary=@Salary, Eligibility=@Eligibility,
    ContactEmail=@ContactEmail, ContactPhone=@ContactPhone, PDF=@PDF,
     MinSSC=@ssc, MinHSC=@hsc,
    MinCGPA1=@c1, MinCGPA2=@c2, MinCGPA3=@c3, MinCGPA4=@c4
WHERE JobInternshipID=@JobInternshipID AND CompanyID=@CompanyID";
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@JobInternshipID", Convert.ToInt32(hfJobID.Value));
                cmd.Parameters.AddWithValue("@CompanyID", CompanyID);
                AddParameters(cmd);
                cmd.Parameters.AddWithValue("@PDF", (object)fileName ?? DBNull.Value);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        lblMessage.Text = "Updated successfully.";
        ClearForm();
        LoadJobs();
    }

    // ================= DELETE (SOFT DELETE) =================
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(hfJobID.Value))
        {
            lblMessage.Text = "Select a record first.";
            return;
        }

        using (SqlConnection con = new SqlConnection(connStr))
        {
            string sql = "UPDATE JobInternshipDetails SET Status = 0 WHERE JobInternshipID=@ID AND CompanyID=@CompanyID";

            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@ID", Convert.ToInt32(hfJobID.Value));
                cmd.Parameters.AddWithValue("@CompanyID", CompanyID);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        lblMessage.Text = "Deleted successfully.";
        ClearForm();
        LoadJobs();
    }

    // ================= FILE UPLOAD =================
    private string UploadPDF()
    {
        if (!FileUploadDoc.HasFile) return null;

        if (Path.GetExtension(FileUploadDoc.FileName).ToLower() != ".pdf")
        {
            lblMessage.Text = "Only PDF allowed.";
            return null;
        }

        if (FileUploadDoc.PostedFile.ContentLength > 5 * 1024 * 1024)
        {
            lblMessage.Text = "Max 5MB allowed.";
            return null;
        }

        string fileName = DateTime.Now.Ticks + "_" + Path.GetFileName(FileUploadDoc.FileName);
        string path = Server.MapPath("~/Company/InternshipDocument/");

        if (!Directory.Exists(path))
            Directory.CreateDirectory(path);

        FileUploadDoc.SaveAs(Path.Combine(path, fileName));

        return fileName;
    }

    // ================= LOAD ALL JOBS =================
    private void LoadJobs()
    {
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string sql = @"SELECT JobInternshipID, Title, JobType, Location, LastDateToApply, PDF, Status
                           FROM JobInternshipDetails
                           WHERE CompanyID=@CompanyID
                           ORDER BY JobInternshipID DESC";

            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@CompanyID", CompanyID);
                con.Open();

                rptJobs.DataSource = cmd.ExecuteReader();
                rptJobs.DataBind();
            }
        }
    }

    // ================= LOAD SELECTED JOB =================
    private void LoadJobDetails(int id)
    {
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string sql = "SELECT * FROM JobInternshipDetails WHERE JobInternshipID=@ID AND CompanyID=@CompanyID";

            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@ID", id);
                cmd.Parameters.AddWithValue("@CompanyID", CompanyID);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    hfJobID.Value = dr["JobInternshipID"].ToString();
                    txtTitle.Text = dr["Title"].ToString();
                    txtDescription.Text = dr["Description"].ToString();
                    txtLocation.Text = dr["Location"].ToString();
                    ddlJobType.SelectedValue = dr["JobType"].ToString();
                    txtLastDate.Text = dr["LastDateToApply"] == DBNull.Value ? "" :
                        Convert.ToDateTime(dr["LastDateToApply"]).ToString("yyyy-MM-dd");
            //   txt.Text = dr["CGPA"] == DBNull.Value ? "" : dr["CGPA"].ToString();
                    txtSSC.Text = dr["MinSSC"] == DBNull.Value ? "" : dr["MinSSC"].ToString();
                    txtHSC.Text = dr["MinHSC"] == DBNull.Value ? "" : dr["MinHSC"].ToString();
                    txtC1.Text = dr["MinCGPA1"] == DBNull.Value ? "" : dr["MinCGPA1"].ToString();
                    txtC2.Text = dr["MinCGPA2"] == DBNull.Value ? "" : dr["MinCGPA2"].ToString();
                    txtC3.Text = dr["MinCGPA3"] == DBNull.Value ? "" : dr["MinCGPA3"].ToString();
                    txtC4.Text = dr["MinCGPA4"] == DBNull.Value ? "" : dr["MinCGPA4"].ToString();
                    txtSalary.Text = dr["Salary"].ToString();
                    txtEligibility.Text = dr["Eligibility"].ToString();
                    txtContactEmail.Text = dr["ContactEmail"].ToString();
                    txtContactPhone.Text = dr["ContactPhone"].ToString();

                    hfExistingPDF.Value = dr["PDF"] == DBNull.Value ? "" : dr["PDF"].ToString();

                    // Button control
                    btnSubmit.Visible = false;
                    btnUpdate.Visible = true;
                    btnDelete.Visible = true;
                    btncancel.Visible = true;
                }
            }
        }
    }

    // ================= REPEATER SELECT =================
    protected void rptJobs_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Select")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            LoadJobDetails(id);

            ScriptManager.RegisterStartupScript(this, this.GetType(),
                "hide", "$('#jobModal').modal('hide');", true);
        }
    }

    // ================= PARAMETERS =================
    private void AddParameters(SqlCommand cmd)
    {
        cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
        cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
        cmd.Parameters.AddWithValue("@Location", txtLocation.Text.Trim());
        cmd.Parameters.AddWithValue("@JobType", ddlJobType.SelectedValue);
      //  cmd.Parameters.AddWithValue("@cgpa", GetDecimal(txtCGPA.Text));
        cmd.Parameters.AddWithValue("@ssc", GetDecimal(txtSSC.Text));
        cmd.Parameters.AddWithValue("@hsc", GetDecimal(txtHSC.Text));
        cmd.Parameters.AddWithValue("@c1", GetDecimal(txtC1.Text));
        cmd.Parameters.AddWithValue("@c2", GetDecimal(txtC2.Text));
        cmd.Parameters.AddWithValue("@c3", GetDecimal(txtC3.Text));
        cmd.Parameters.AddWithValue("@c4", GetDecimal(txtC4.Text));
        if (DateTime.TryParse(txtLastDate.Text, out DateTime dt))
            cmd.Parameters.AddWithValue("@LastDateToApply", dt);
        else
            cmd.Parameters.AddWithValue("@LastDateToApply", DBNull.Value);

        cmd.Parameters.AddWithValue("@Salary",
            string.IsNullOrWhiteSpace(txtSalary.Text) ? DBNull.Value : (object)txtSalary.Text);

        cmd.Parameters.AddWithValue("@Eligibility", txtEligibility.Text.Trim());
        cmd.Parameters.AddWithValue("@ContactEmail", txtContactEmail.Text.Trim());

        cmd.Parameters.AddWithValue("@ContactPhone",
            string.IsNullOrWhiteSpace(txtContactPhone.Text) ? DBNull.Value : (object)txtContactPhone.Text);
    }

    // ================= STATUS TEXT =================
    protected string GetStatusText(object status)
    {
        int s = Convert.ToInt32(status);
        if (s == 0) return "Pending";
        if (s == 1) return "Approved";
        if (s == 2) return "Rejected";
        return "Unknown";
    }

    // ================= CLEAR =================
    private void ClearForm()
    {
        hfJobID.Value = "";
        txtTitle.Text = "";
        txtDescription.Text = "";
        txtLocation.Text = "";
        ddlJobType.SelectedIndex = 0;
        txtLastDate.Text = "";
        txtSalary.Text = "";
        txtEligibility.Text = "";
        txtContactEmail.Text = "";
        txtContactPhone.Text = "";
        hfExistingPDF.Value = "";

        btnSubmit.Visible = true;
        btnUpdate.Visible = false;
        btnDelete.Visible = false;
        btncancel.Visible = false;
    }
    private object GetDecimal(string val)
    {
        if (decimal.TryParse(val, out decimal d))
            return d;
        return DBNull.Value;
    }

    protected void btncancel_Click(object sender, EventArgs e)
    {
        ClearForm();
    }
}