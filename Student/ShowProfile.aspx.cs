using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class Student_ShowProfile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlDataSource1.SelectCommand = "SELECT * FROM [Student_Registration] WHERE  [s_id] ='"+Session["id"]+"' ";


    }


    protected void btnResume_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        string id = btn.CommandArgument;
        Response.Redirect("ResumeBuild.aspx?s_id=" + Server.UrlEncode(id));
    }
}