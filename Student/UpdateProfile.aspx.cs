using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

public partial class User_EditProfile : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    private string upath2;
    private string photoPath;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]);
            cmd = new SqlCommand();
            con.Open();
            cmd.CommandText = @"Select * From Student_Registration Where s_id=@id";
            cmd.Parameters.AddWithValue("@id", Session["id"]);
            cmd.Connection = con;
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                string id = Convert.ToString(dr["s_id"]);
                string name = Convert.ToString(dr["name"]);
                string currentyear = Convert.ToString(dr["current_year"]);
               
                string password = Convert.ToString(dr["password"]);
                string skill = Convert.ToString(dr["skill"]);
                string gender = Convert.ToString(dr["gender"]);
                //string dob = Convert.ToString(dr["dob"]);
                txtDOB.Text = dr["dob"] != DBNull.Value ? Convert.ToDateTime(dr["dob"]).ToString("yyyy-MM-dd") : "";

                
           
                string mobile = Convert.ToString(dr["mobile"]);
                string email = Convert.ToString(dr["email"]);
              
                string photo = dr["photo"] != DBNull.Value ? dr["photo"].ToString() : "adminimage.png";
                imgPreview.ImageUrl = "~/Uploads/Photos/" + photo;






                txtStudentID.Text = id.ToString();
                txtname.Text = name;
                txtskill.Text = skill;
               
                txtpassword.Text = password;
                txtcurrentyear.Text = currentyear;
                ddlGender.SelectedValue = gender;
           
                  txtEmail.Text = email;
                txtDOB.TextMode = TextBoxMode.Date;
                txtMobile.Text = mobile;
               
                
            }
            con.Close();
        }
    }
















    protected void btnSubmit_Click1(object sender, EventArgs e)
    {
        con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]);
        string studentId = Session["id"].ToString(); // Logged-in student ID
        string folderPath = Server.MapPath("~/Uploads/Photos/");  // Photo folder path
        string newFileName = ""; // Declare here so accessible below

        try
        {
            con.Open();

            // Check if email exists for other users before update
            SqlCommand checkEmailCmd = new SqlCommand("SELECT COUNT(*) FROM Student_Registration WHERE email = @Email AND s_id != @StudentID", con);
            checkEmailCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim().ToLower());
            checkEmailCmd.Parameters.AddWithValue("@StudentID", studentId);
            int emailExists = (int)checkEmailCmd.ExecuteScalar();
            if (emailExists > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Email already exists. Please use a different email.');", true);
                return;
            }

            string existingPhoto = null;
            // Get existing photo filename
            SqlCommand getPhotoCmd = new SqlCommand("SELECT photo FROM Student_Registration WHERE s_id = @StudentID", con);
            getPhotoCmd.Parameters.AddWithValue("@StudentID", studentId);
            object result = getPhotoCmd.ExecuteScalar();
            if (result != null && result != DBNull.Value)
                existingPhoto = result.ToString();

            // If new file uploaded
            if (fuphoto.HasFile)
            {
                // Delete old photo if exists
                if (!string.IsNullOrEmpty(existingPhoto) && existingPhoto.ToLower() != "adminimage.png")
                {
                    string oldFilePath = Path.Combine(folderPath, existingPhoto);
                    if (File.Exists(oldFilePath))
                    {
                        File.Delete(oldFilePath);
                    }
                }

                string fileExtension = Path.GetExtension(fuphoto.FileName);
                string cleanStudentId = studentId.StartsWith("D_") ? studentId.Substring(2) : studentId;

                // Assign to the outer variable, NOT redeclare
                newFileName = "D_" + cleanStudentId + "_photo" + fileExtension;

                string savePath = Path.Combine(folderPath, newFileName);
                fuphoto.SaveAs(savePath);

                // verify saved
                if (!File.Exists(savePath))
                {
                    Response.Write("<script>alert('Error saving file. Please try again.');</script>");
                    return;
                }
            }
            else
            {
                newFileName = existingPhoto ?? "adminimage.png";
            }

            // Now update database with new values including photo filename
            string query = @"UPDATE Student_Registration 
             SET name = @Name, 
                 password = @Password, 
                 gender = @Gender, dob = @DOB,skill=@skill,  
                 mobile = @Mobile, 
                 email = @Email, 
                 photo = @photo
             WHERE s_id = @StudentID";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@StudentID", studentId);
            cmd.Parameters.AddWithValue("@Name", txtname.Text.Trim());
            cmd.Parameters.AddWithValue("@Password", txtpassword.Text.Trim());
            cmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue);
            cmd.Parameters.AddWithValue("@DOB", txtDOB.Text);
            cmd.Parameters.AddWithValue("@skill", txtskill.Text.Trim());
            cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim().ToLower());
            cmd.Parameters.AddWithValue("@photo", newFileName);

            int rowsAffected = cmd.ExecuteNonQuery();
            if (rowsAffected > 0)
            {
                string script = @"
                Swal.fire({
                    title: 'Success',
                    text: 'Profile updated successfully!',
                    icon: 'success'
                }).then(function() {
                    window.location = '/Student/UpdateProfile.aspx';
                });";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "success", script, true);
            }
            else
            {
                Response.Write("<script>alert('Update failed. Please try again.');</script>");
            }
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('An error occurred: " + ex.Message + "');</script>");
        }
        finally
        {
            con.Close();
        }
    }
}




