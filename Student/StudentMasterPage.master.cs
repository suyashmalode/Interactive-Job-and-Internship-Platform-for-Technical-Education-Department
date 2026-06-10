using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class User_UserMasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["name"] != null)
            {
                litStudentName.Text = Session["name"].ToString();
            }
            else
            {
                Response.Redirect("~/StudentLogin.aspx"); // Redirect if not logged in
            }

            if (Session["photo"] != null)
            {
                string logoPath = "~/Uploads/Photos/" + Session["photo"].ToString(); // Assuming image is in 'Uploads' folder
                imgCompanyLogo.ImageUrl = ResolveUrl(logoPath);
            }
            else
            {
                imgCompanyLogo.ImageUrl = "~/Images/default-logo.png"; // Fallback if no logo is found
            }

        }
        SetActiveMenu();
    }
    private void SetActiveMenu()
    {
        string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);

        // Remove "active" from all links first
        lnkHome.CssClass = "nav-link";
        lnkProfile.CssClass = "nav-link";
       // lnkExperience.CssClass = "dropdown-item";
        //lnkProject.CssClass = "dropdown-item";
        lnkJobDescription.CssClass = "nav-link";
        //lnkShowProfile.CssClass = "nav-link";
        //lnkPlacementStatus.CssClass = "nav-link";
       // HyperLink1.CssClass = "nav-link";
        // Apply active class to the current page link
        switch (currentPage)
        {
            case "Dashboard.aspx":
                lnkHome.CssClass += " active";
                break;
            case "UpdateProfile.aspx":
                lnkProfile.CssClass += " active";
                break;
            case "AddCompanyWorkExperienceDetails.aspx":
            //    lnkExperience.CssClass += " active";
            //    break;
            //case "AddProject.aspx":
            //    lnkProject.CssClass += " active";
            //    break;
            case "ViewJobDiscription.aspx":
                lnkJobDescription.CssClass += " active";
                break;
            //case "ShowProfile.aspx":
            //    lnkShowProfile.CssClass += " active";
            //    break;
            //case "ViewPlacementStatus.aspx":
            //    lnkPlacementStatus.CssClass += " active";
            //    break;
            //case "Interview.aspx":
            //    HyperLink1.CssClass += " active";
            //    break;
        }
    }
    public string GetActiveClass(string pageName)
    {
        string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
        return currentPage.Equals(pageName, StringComparison.OrdinalIgnoreCase) ? "nav-link active" : "nav-link";
    }

}
