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
    public partial class AdminTools : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindList();
            }
        }

        protected void DVDList_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "EditDVD")
            {
                DVDList.EditItemIndex = e.Item.ItemIndex;
                BindList();
            }
            else if (e.CommandName == "DeleteDVD")
            {
                int DVDId = Convert.ToInt32(e.CommandArgument);
                SqlConnection conn;
                SqlCommand comm1, comm2;
                string connectionString = ConfigurationManager.ConnectionStrings["Dvd117"].ConnectionString;
                conn = new SqlConnection(connectionString);
                comm1 = new SqlCommand("DELETE FROM DVDpurchase WHERE DVDId = @DVDId", conn);
                comm1.Parameters.Add("@DVDId", System.Data.SqlDbType.Int);
                comm1.Parameters["@DVDId"].Value = DVDId;

                comm2 = new SqlCommand("DELETE FROM DVD WHERE DVDId = @DVDId", conn);
                comm2.Parameters.Add("@DVDId", System.Data.SqlDbType.Int);
                comm2.Parameters["@DVDId"].Value = DVDId;
                try
                {
                    conn.Open();
                    //delete purchased DVD items related this DVDID
                    comm1.ExecuteNonQuery();
                    //delete this DVD
                    comm2.ExecuteNonQuery();
                }
                catch
                {
                    dbErrorMessage.Text = "Error deleting DVD! <br />";
                }
                finally
                {
                    conn.Close();
                }
                BindList();
            }
            else if (e.CommandName == "UpdateDVD")
            {
                int DVDId = Convert.ToInt32(e.CommandArgument);
                TextBox titleTextBox = (TextBox)e.Item.FindControl("titleTextBox");
                string newtitle = titleTextBox.Text;
                TextBox releaseDateTextBox = (TextBox)e.Item.FindControl("releaseDateTextBox");
                DateTime newreleaseDate = Convert.ToDateTime(releaseDateTextBox.Text);
                TextBox primaryArtistTextBox = (TextBox)e.Item.FindControl("primaryArtistTextBox");
                string newprimaryArtist = primaryArtistTextBox.Text;
                TextBox priceTextBox = (TextBox)e.Item.FindControl("priceTextBox");
                float newprice = Single.Parse(priceTextBox.Text);
                TextBox CaraRatingTextBox = (TextBox)e.Item.FindControl("CaraRatingTextBox");
                string newCaraRating = CaraRatingTextBox.Text;
                TextBox ImdbRatingTextBox = (TextBox)e.Item.FindControl("ImdbRatingTextBox");
                int newImdbRating = Convert.ToInt32(ImdbRatingTextBox.Text);
                TextBox quantityInStockTextBox = (TextBox)e.Item.FindControl("quantityInStockTextBox");
                int newquantityInStock = Convert.ToInt32(quantityInStockTextBox.Text);
                UpdateItem(DVDId, newtitle, newreleaseDate, newprimaryArtist, newprice, newCaraRating, newImdbRating, newquantityInStock);
                DVDList.EditItemIndex = -1;
                BindList();
            }
            else if (e.CommandName == "CancelEditing")
            {
                DVDList.EditItemIndex = -1;
                BindList();
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindList();
        }

        protected void BindList()
        {
            SqlConnection conn;
            SqlCommand comm;
            SqlDataReader reader;
            string connectionString =
                ConfigurationManager.ConnectionStrings["Dvd117"].ConnectionString;
            conn = new SqlConnection(connectionString);
            string sqlstr = "SELECT DVDId, title, primaryArtist, price, CaraRating, ImdbRating, releaseDate, quantityInStock, coverImageUrl FROM DVD ORDER BY " + sortingDropDownList.SelectedItem.Value;
            comm = new SqlCommand(sqlstr, conn);
            try
            {
                conn.Open();
                reader = comm.ExecuteReader();
                DVDList.DataSource = reader;
                DVDList.DataBind();
                reader.Close();
            }
            finally
            {
                conn.Close();
            }
        }

        protected void UpdateItem(int DVDId, string title, DateTime releaseDate, string primaryArtist, float price, string CaraRating, int ImdbRating, int quantityInStock)
        {
            SqlConnection conn;
            SqlCommand comm;
            string connectionString = ConfigurationManager.ConnectionStrings["Dvd117"].ConnectionString;
            conn = new SqlConnection(connectionString);
            comm = new SqlCommand("UPDATE DVD SET title =@title, releaseDate =@releaseDate,  primaryArtist =@primaryArtist, " +
                   "price =@price, CaraRating =@CaraRating, ImdbRating =@ImdbRating, quantityInStock =@quantityInStock " +
                   "WHERE DVDId = @DVDId", conn);
            comm.Parameters.Add("@DVDId", System.Data.SqlDbType.Int);
            comm.Parameters["@DVDId"].Value = DVDId;
            comm.Parameters.Add("@title", System.Data.SqlDbType.NVarChar, 128);
            comm.Parameters["@title"].Value = title;
            comm.Parameters.Add("@releaseDate", System.Data.SqlDbType.Date);
            comm.Parameters["@releaseDate"].Value = releaseDate;
            comm.Parameters.Add("@primaryArtist", System.Data.SqlDbType.NVarChar, 128);
            comm.Parameters["@primaryArtist"].Value = primaryArtist;
            comm.Parameters.Add("@price", System.Data.SqlDbType.Money);
            comm.Parameters["@price"].Value = price;
            comm.Parameters.Add("@CaraRating", System.Data.SqlDbType.NVarChar, 5);
            comm.Parameters["@CaraRating"].Value = CaraRating;
            comm.Parameters.Add("@ImdbRating", System.Data.SqlDbType.Int);
            comm.Parameters["@ImdbRating"].Value = ImdbRating;
            comm.Parameters.Add("@quantityInStock", System.Data.SqlDbType.Int);
            comm.Parameters["@quantityInStock"].Value = quantityInStock;
            try
            {
                conn.Open();
                comm.ExecuteNonQuery();
            }
            finally
            {
                conn.Close();
            }
        }


        protected void saveButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                SqlConnection conn;
                SqlCommand comm;
                string connectionString = ConfigurationManager.ConnectionStrings["Dvd117"].ConnectionString;
                conn = new SqlConnection(connectionString);
                comm = new SqlCommand("INSERT INTO DVD (title, releaseDate, " +
                             "primaryArtist, price, CaraRating, ImdbRating, quantityInStock) " +
                             "VALUES (@title, @releaseDate, @primaryArtist, " +
                             "@price, @CaraRating, @ImdbRating, @quantityInStock)", conn);
                comm.Parameters.Add("@title", System.Data.SqlDbType.NVarChar, 128);
                comm.Parameters["@title"].Value = titleTextBox.Text;
                comm.Parameters.Add("@releaseDate", System.Data.SqlDbType.Date);
                comm.Parameters["@releaseDate"].Value = releaseDateTextBox.Text;
                comm.Parameters.Add("@primaryArtist", System.Data.SqlDbType.NVarChar, 128);
                comm.Parameters["@primaryArtist"].Value = primaryArtistTextBox.Text;
                comm.Parameters.Add("@price", System.Data.SqlDbType.Money);
                comm.Parameters["@price"].Value = priceTextBox.Text;
                comm.Parameters.Add("@CaraRating", System.Data.SqlDbType.NVarChar, 5);
                comm.Parameters["@CaraRating"].Value = CaraRatingDropDownList.SelectedItem.Value;
                comm.Parameters.Add("@ImdbRating", System.Data.SqlDbType.Int);
                comm.Parameters["@ImdbRating"].Value = ImdbRatingTextBox.Text;
                comm.Parameters.Add("@quantityInStock", System.Data.SqlDbType.Int);
                comm.Parameters["@quantityInStock"].Value = quantityInStockTextBox.Text;
                try
                {
                    conn.Open();
                    comm.ExecuteNonQuery();
                }
                catch
                {
                    dbErrorMessage.Text = "Error adding the DVD! <br/>";
                }
                finally
                {
                    conn.Close();
                }
                //Response.Redirect("AdminTools.aspx");
                AddDVDPanel.Visible = false;
                DVDListPanel.Visible = true;
                BindList();
            }
        }

        protected void cancelButton_Click(object sender, EventArgs e)
        {
            AddDVDPanel.Visible = false;
            DVDListPanel.Visible = true;
            titleTextBox.Text = "";
            releaseDateTextBox.Text = "";
            primaryArtistTextBox.Text = "";
            priceTextBox.Text = "";
            CaraRatingDropDownList.SelectedIndex=0;
            ImdbRatingTextBox.Text = "";
            quantityInStockTextBox.Text = "";
        }

        protected void addDVDButton_Click(object sender, EventArgs e)
        {
            AddDVDPanel.Visible = true;
            DVDListPanel.Visible = false;
        }



    }
}