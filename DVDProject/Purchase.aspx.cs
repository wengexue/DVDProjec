using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;



namespace DVDProject
{
    public partial class Purchase : System.Web.UI.Page
    {

        int purchaseDvdID;
 
        protected void Page_Load(object sender, EventArgs e)
        {
            purchaseDvdID = Int32.Parse(Request.Params.Get("dvdId"));

            if (!IsPostBack)
            {
                SqlConnection conn;
                SqlCommand comm;
                SqlDataReader reader;
                string connectionString =
                    ConfigurationManager.ConnectionStrings["Dvd117"].ConnectionString;
                conn = new SqlConnection(connectionString);
                comm = new SqlCommand("SELECT DVDId, title, primaryArtist, price, CaraRating, ImdbRating, releaseDate, quantityInStock, coverImageUrl FROM DVD WHERE DVDId = @DVDId", conn);
                comm.Parameters.Add("@DVDId", System.Data.SqlDbType.Int);
                comm.Parameters["@DVDId"].Value = purchaseDvdID;
                try
                {
                    conn.Open();
                    reader = comm.ExecuteReader();
                    DVDPurchse.DataSource = reader;
                    DVDPurchse.DataBind();
                    reader.Close();
                }
                finally
                {
                    conn.Close();
                }
            }
        }



        protected void buyButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                SqlConnection conn;
                SqlCommand comm;
                string connectionString =
                    ConfigurationManager.ConnectionStrings["Dvd117"].ConnectionString;
                conn = new SqlConnection(connectionString);
                comm = new SqlCommand("spPurchaseDvd", conn);
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                comm.Parameters.Add("@DVDID", System.Data.SqlDbType.Int);
                comm.Parameters["@DVDID"].Value = purchaseDvdID;
                comm.Parameters.Add("@CustomerName", System.Data.SqlDbType.NVarChar, 128);
                comm.Parameters["@CustomerName"].Value = nameTextBox.Text;
                comm.Parameters.Add("@CustomerEmail", System.Data.SqlDbType.NVarChar, 50);
                comm.Parameters["@CustomerEmail"].Value = emailTextBox.Text;
                try
                {
                    conn.Open();
                    comm.ExecuteNonQuery();
                }
                catch
                {
                    dbErrorMessage.Text = "Error purchasing the DVD! <br/>";
                }
                finally
                {
                    conn.Close();
                }
                Response.Redirect("Home.aspx");
            }
        }


    }
}