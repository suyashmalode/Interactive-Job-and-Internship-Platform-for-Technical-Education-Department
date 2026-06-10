using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data.SqlClient;
using System.Configuration;
using System.Net;
using System.Net.Mail;
using System.IO;
using System.Text;
/// <summary>
/// Summary description for BasicCode
/// </summary>
public class BasicCode
{
    

	public BasicCode()
	{
		//
		// TODO: Add constructor logic here
		//
	}

  

    public string generateID(string col, string tbl)
    {
        SqlConnection con = new SqlConnection();
        SqlCommand cmd = new SqlCommand();
        con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]);

        cmd = new SqlCommand();
        con.Open();
        cmd.Connection = con;
        cmd.CommandText = "select " + col + " from  " + tbl + " order by " + col + " desc";
        cmd.Connection = con;
        object obj = cmd.ExecuteScalar();
        con.Close();
        if (obj == null)
        {
            return "1";
        }
        else
        {
            int n = Convert.ToInt32(obj);
            n = n + 1;
            return n.ToString();
        }
    }

    

    //for new api key function
    public void NewSendSms(string destinationNumbers, string msg)
    {
        try
        {
            string username = "digipe";
            string password = "digipe";
            string senderId = "DIGlPE";
            string route = "T";
            string entityId = "1701170721485215989";
            string templateId = "1707170737301152250";

            // Prepare the URL with parameters
            string baseUrl = "http://site.bulksmsnagpur.net/sendsms";
            string url = baseUrl + "?uname=" + username + "&pwd=" + password + "&senderid=" + senderId + "&to=" + destinationNumbers + "&msg=" + msg + "&route=" + route + "&peid=" + entityId + "&tempid=" + templateId;

            // Create HTTP request
            HttpWebRequest httpWebRequest = (HttpWebRequest)WebRequest.Create(url);
            httpWebRequest.Method = "GET";

            // Get the response
            HttpWebResponse httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            StreamReader streamReader = new StreamReader(httpResponse.GetResponseStream());
            string response = streamReader.ReadToEnd();

            // Close the response
            streamReader.Close();
            httpResponse.Close();
        
            // Handle the response, you might want to check response for error codes or process the message ID returned
            Console.WriteLine("SMS sent successfully. Response: " + response);
        }
        catch (WebException ex)
        {
            // Handle exceptions
            if (ex.Response != null)
            {
                using (var errorResponse = (HttpWebResponse)ex.Response)
                {
                    using (var reader = new StreamReader(errorResponse.GetResponseStream()))
                    {
                        string error = reader.ReadToEnd();
                        Console.WriteLine("Error sending SMS: " + error);
                    }
                }
            }
            else
            {
                Console.WriteLine("Error sending SMS: " + ex.Message);
            }
        }
    }
    




























}