using System;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.UI;

public partial class Registration : System.Web.UI.Page
{
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.AppSettings["LIS"];
        using (SqlConnection con = new SqlConnection(connStr))
        {
            con.Open();
            string sid = txtStudentID.Text.Trim();

            // Check for duplicate Student ID
            string checkQuery = "SELECT COUNT(*) FROM Student_Registration WHERE s_id = @id";
            SqlCommand checkCmd = new SqlCommand(checkQuery, con);
            checkCmd.Parameters.AddWithValue("@id", sid);
            int count = (int)checkCmd.ExecuteScalar();
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "exists",
                    "Swal.fire('Student ID Exists!','Please try another ID.','error');", true);
                return;
            }
            string email = txtemail.Text.Trim();
            // Check for duplicate Student ID
            string checkQuery1 = "SELECT COUNT(*) FROM Student_Registration WHERE email = @email";
            SqlCommand checkCmd1 = new SqlCommand(checkQuery1, con);
            checkCmd1.Parameters.AddWithValue("@email", email);
            int count1 = (int)checkCmd1.ExecuteScalar();
            if (count1 > 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "exists",
                    "Swal.fire('Email Already Exists!','Please try another with Email.','error');", true);
                return;
            }
            // File uploads
            string photoFileName = null;
            string resumeFileName = null;

            if (fuPhoto.HasFile)
            {
                string ext = Path.GetExtension(fuPhoto.FileName).ToLower();
                if (ext == ".jpg" || ext == ".jpeg" || ext == ".png")
                {
                    string folder = Server.MapPath("~/Uploads/Photos/");
                    if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);
                    photoFileName = sid + "_photo" + ext;
                    fuPhoto.SaveAs(Path.Combine(folder, photoFileName));
                }
            }

            if (fuResume.HasFile)
            {
                string ext = Path.GetExtension(fuResume.FileName).ToLower();
                if (ext == ".pdf" || ext == ".doc" || ext == ".docx")
                {
                    string folder = Server.MapPath("~/Uploads/Resumes/");
                    if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);
                    resumeFileName = sid + "_resume" + ext;
                    fuResume.SaveAs(Path.Combine(folder, resumeFileName));
                }
            }

            // Insert Query (now includes gender, dob, mobile)
            string insertQuery = @"INSERT INTO Student_Registration
(s_id, name, email, gender, dob, skill, mobile, password, photo, resume, status, registration_date, current_year,
 SSC_Percentage, HSC_Percentage, Year1_CGPA, Year2_CGPA, Year3_CGPA, Year4_CGPA,BacklogCount)
VALUES
(@id, @name, @email, @gender, @dob, @skill, @mobile, @password, @photo, @resume, 'Pending', GETDATE(), @current_year,
 @ssc, @hsc, @y1, @y2, @y3, @y4,@BacklogCount)";
            SqlCommand cmd = new SqlCommand(insertQuery, con);
            // Y1 CGPA
            object y1Value = DBNull.Value;
            if (!string.IsNullOrEmpty(txtY1.Text))
            {
                decimal y1;
                if (decimal.TryParse(txtY1.Text, out y1))
                    y1Value = y1;
            }

            // Y2 CGPA
            object y2Value = DBNull.Value;
            if (!string.IsNullOrEmpty(txtY2.Text))
            {
                decimal y2;
                if (decimal.TryParse(txtY2.Text, out y2))
                    y2Value = y2;
            }

            // Y3 CGPA
            object y3Value = DBNull.Value;
            if (!string.IsNullOrEmpty(txtY3.Text))
            {
                decimal y3;
                if (decimal.TryParse(txtY3.Text, out y3))
                    y3Value = y3;
            }

            // Y4 CGPA
            object y4Value = DBNull.Value;
            if (!string.IsNullOrEmpty(txtY4.Text))
            {
                decimal y4;
                if (decimal.TryParse(txtY4.Text, out y4))
                    y4Value = y4;
            }

            // Backlog Count
            object backlogValue = DBNull.Value;
            if (!string.IsNullOrEmpty(txtbacklog.Text))
            {
                int backlog;
                if (int.TryParse(txtbacklog.Text, out backlog))
                    backlogValue = backlog;
            }

            // Then add parameters to SQL
            cmd.Parameters.AddWithValue("@id", sid);
            cmd.Parameters.AddWithValue("@name", txtname.Text.Trim());
            cmd.Parameters.AddWithValue("@email", txtemail.Text.Trim());
            cmd.Parameters.AddWithValue("@current_year", ddlYear.SelectedValue.Trim());
            cmd.Parameters.AddWithValue("@gender", ddlGender.SelectedValue);
            cmd.Parameters.AddWithValue("@dob", txtDob.Text);
            cmd.Parameters.AddWithValue("@skill", txtskills.Text);
            cmd.Parameters.AddWithValue("@ssc", string.IsNullOrEmpty(txt10th.Text) ? (object)DBNull.Value : Convert.ToDecimal(txt10th.Text));
            cmd.Parameters.AddWithValue("@hsc", string.IsNullOrEmpty(txt12th.Text) ? (object)DBNull.Value : Convert.ToDecimal(txt12th.Text));
            cmd.Parameters.AddWithValue("@y1", y1Value);
            cmd.Parameters.AddWithValue("@y2", y2Value);
            cmd.Parameters.AddWithValue("@y3", y3Value);
            cmd.Parameters.AddWithValue("@y4", y4Value);
            cmd.Parameters.AddWithValue("@BacklogCount", backlogValue);
            cmd.Parameters.AddWithValue("@mobile", txtMobile.Text.Trim());
            cmd.Parameters.AddWithValue("@password", txtpassword.Text.Trim());
            cmd.Parameters.AddWithValue("@photo", (object)photoFileName ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@resume", (object)resumeFileName ?? DBNull.Value);

            int result = cmd.ExecuteNonQuery();

            if (result > 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "success",
                    "Swal.fire('Registration Successful!','Your account is pending approval.','success');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "fail",
                    "Swal.fire('Error!','Something went wrong, try again later.','error');", true);
            }
        }

        clear();
    }
    protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        int index = ddlYear.SelectedIndex;

        year1.Style["display"] = "none";
        year2.Style["display"] = "none";
        year3.Style["display"] = "none";
        year4.Style["display"] = "none";
        backlogDiv.Style["display"] = "none";

        switch (index)
        {
            case 1:
                year1.Style["display"] = "block";
                backlogDiv.Style["display"] = "block";
                break;
            case 2:
                year1.Style["display"] = "block";
                year2.Style["display"] = "block";
                backlogDiv.Style["display"] = "block";
                break;
            case 3:
                year1.Style["display"] = "block";
                year2.Style["display"] = "block";
                year3.Style["display"] = "block";
                backlogDiv.Style["display"] = "block";
                break;
            case 4:
                year1.Style["display"] = "block";
                year2.Style["display"] = "block";
                year3.Style["display"] = "block";
                year4.Style["display"] = "block";
                backlogDiv.Style["display"] = "block";
                break;
        }
    }
    protected void clear()
    {
        txtStudentID.Text = "";
        txtname.Text = "";
        ddlYear.SelectedValue = "";
        ddlGender.SelectedIndex = 0;
        txtemail.Text = "";
        txtskills.Text = "";
        txtDob.Text = "";
        txtMobile.Text = "";
        txtpassword.Text = "";
        txtrepeatpass.Text = "";
        txt10th.Text = "";
        txt12th.Text = "";
        txtY1.Text = "";
       
        txtY2.Text = "";
        txtY3.Text = "";
        txtY4.Text = "";
    }
}
