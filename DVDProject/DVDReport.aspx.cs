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
    public partial class DVDReport : System.Web.UI.Page
    {
        int currentDvdID;
        protected void Page_Load(object sender, EventArgs e)
        {
            string param = Request.Params.Get("dvdId");
            //string param = Request.Params.Get(0).Substring(5);
            currentDvdID = Int32.Parse(param);

            loadCurrentDvdInfo();
            loadPurchaseCustomers();

        }

        protected void loadCurrentDvdInfo()
        {
            SqlConnection conn;
            SqlCommand comm;
            SqlDataReader reader;
            string connectionString =
                ConfigurationManager.ConnectionStrings["Dvd117"].ConnectionString;
            conn = new SqlConnection(connectionString);
            comm = new SqlCommand("SELECT DVDId, title, primaryArtist, price, CaraRating, ImdbRating, releaseDate, quantityInStock, coverImageUrl FROM DVD WHERE DVDId = @DVDId", conn);
            comm.Parameters.Add("@DVDId", System.Data.SqlDbType.Int);
            comm.Parameters["@DVDId"].Value = currentDvdID;
            try
            {
                conn.Open();
                reader = comm.ExecuteReader();
                if (reader.Read())
                {
                    DVDIdLabel.Text ="Dvd ID: <strong>"+ reader["DVDId"].ToString()+"</strong>";
                    titleLabel.Text = "Title: <strong>" + reader["title"].ToString() + "</strong>";
                    releaseDateLabel.Text = "Release Date: <strong>" + reader["releaseDate"].ToString() + "</strong>";
                    primaryArtistLabel.Text = "Primary Artist: <strong>" + reader["primaryArtist"].ToString() + "</strong>";
                    priceLabel.Text = "Price: <strong>" + reader["price"].ToString() + "</strong>";
                    CaraRatingLabel.Text = "CaraRating: <strong>" + reader["CaraRating"].ToString() + "</strong>";
                    ImdbRatingLabel.Text = "IMDB Rating: <strong>" + reader["ImdbRating"].ToString() + "</strong>";
                    quantityInStockLabel.Text = "Quantity In Stock: <strong>" + reader["quantityInStock"].ToString() + "</strong>";
                    //soldquantityLabel.Text ="Total Quantity Sold: "+ reader["soldquantity"].ToString();
                    DvdImage.ImageUrl = reader["coverImageUrl"].ToString();
                }
                reader.Close();
            }
            finally
            {
                conn.Close();
            }
        }

        public void loadPurchaseCustomers()
        {
            SqlConnection conn;
            SqlCommand comm;
            SqlDataReader reader;
            string connectionString =
                ConfigurationManager.ConnectionStrings["Dvd117"].ConnectionString;
            conn = new SqlConnection(connectionString);
            comm = new SqlCommand("SELECT Customer.customerId, customerName, email FROM Customer JOIN DVDPurchase ON Customer.customerId=DVDPurchase.customerId WHERE DVDId = @DVDId", conn);
            comm.Parameters.Add("@DVDId", System.Data.SqlDbType.Int);
            comm.Parameters["@DVDId"].Value = currentDvdID;
            try
            {
                conn.Open();
                reader = comm.ExecuteReader();
                customerDataList.DataSource = reader;
                customerDataList.DataBind();
                soldquantityLabel.Text = "Total Quantity Sold: <strong>" + customerDataList.Items.Count+"</strong>";
                reader.Close();
            }
            finally
            {
                conn.Close();
            }
        }

    }
}