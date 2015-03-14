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
    public partial class CustomerReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SqlConnection conn;
                SqlCommand comm;
                SqlDataReader reader;
                string connectionString = ConfigurationManager.ConnectionStrings["Dvd117"].ConnectionString;
                conn = new SqlConnection(connectionString);
                comm = new SqlCommand("SELECT customerId, customerName from Customer", conn);
                try
                {
                    conn.Open();
                    reader = comm.ExecuteReader();
                    customerList.DataSource = reader;
                    customerList.DataValueField = "customerId";
                    customerList.DataTextField = "customerName";
                    customerList.DataBind();
                    reader.Close();
                    populatingData();
                }
                finally
                {
                    conn.Close();
                }
            }

        }

        protected void customerList_SelectedIndexChanged(object sender, EventArgs e)
        {
            populatingData();
        }

        protected void populatingData()
        {
            SqlConnection conn;
            SqlCommand comm;
            SqlDataReader reader;
            string connectionString = ConfigurationManager.ConnectionStrings["Dvd117"].ConnectionString;
            conn = new SqlConnection(connectionString);
            comm = new SqlCommand("SELECT DVD.DVDId, title, price, coverImageUrl, purchaseDate FROM DVD JOIN DVDPurchase ON DVD.DVDId = DVDPurchase.DVDId WHERE customerId=@customerId", conn);
            comm.Parameters.Add("@customerId", System.Data.SqlDbType.Int);
            comm.Parameters["@customerId"].Value = customerList.SelectedItem.Value;
            try
            {
                conn.Open();
                reader = comm.ExecuteReader();
                customerDVDList.DataSource = reader;
                customerDVDList.DataBind();
                reader.Close();
            }
            finally
            {
                conn.Close();
            }
        }
        
    }
}