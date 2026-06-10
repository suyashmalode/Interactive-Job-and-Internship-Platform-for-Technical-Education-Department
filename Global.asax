<%@ Application Language="C#" %>

<script runat="server">

    private static System.Threading.Timer cleanupTimer;

    void Application_Start(object sender, EventArgs e) 
    {
        // Run immediately and then every 24 hours
        cleanupTimer = new System.Threading.Timer(DeletePassedOutStudents,
                                                  null,
                                                  TimeSpan.Zero,
                                                  TimeSpan.FromHours(24));
    }
    
    private void DeletePassedOutStudents(object state)
    {
        try
        {
            string conStr = System.Configuration.ConfigurationManager
                            .ConnectionStrings["Carrier_Portal"]
                            .ConnectionString;

            using (System.Data.SqlClient.SqlConnection con =
                   new System.Data.SqlClient.SqlConnection(conStr))
            {
                con.Open();

                string query = @"
                DELETE IA
                FROM InternshipApplications IA
                INNER JOIN Student_Registration SR
                    ON IA.StudentID = SR.s_id
                WHERE SR.current_year = 3
                AND DATEADD(YEAR, 1, SR.registration_date) <= GETDATE();

                DELETE FROM Student_Registration
                WHERE current_year = 3
                AND DATEADD(YEAR, 1, registration_date) <= GETDATE();
                ";

                System.Data.SqlClient.SqlCommand cmd =
                    new System.Data.SqlClient.SqlCommand(query, con);

                cmd.ExecuteNonQuery();
            }
        }
        catch
        {
            // Optional: Add logging if needed
        }
    }

    void Application_End(object sender, EventArgs e) { }
    void Application_Error(object sender, EventArgs e) { }
    void Session_Start(object sender, EventArgs e) { }
    void Session_End(object sender, EventArgs e) { }

</script>
