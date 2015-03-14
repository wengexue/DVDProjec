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
    public partial class Home : System.Web.UI.Page
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
            if (e.CommandName == "MoreDetailsPlease")
            {
                LinkButton moreButton = (LinkButton)e.Item.FindControl("detailsButton");
                PlaceHolder myPlaceholder;
                myPlaceholder = (PlaceHolder)e.Item.FindControl("extraDetailsHolder");
                if (e.CommandArgument.ToString() == "0")
                {
                    myPlaceholder.Visible = true;
                    moreButton.CommandArgument = "1";
                    moreButton.Text = "Less Details...";
                }
                else
                {
                    myPlaceholder.Visible = false;
                    moreButton.CommandArgument = "0";
                    moreButton.Text = "More Details...";
                }
            }
            if (e.CommandName == "BuyIt")
            {
                LinkButton buybtn = (LinkButton)e.Item.FindControl("buyButton");
                string selectedId = buybtn.CommandArgument;
                Response.Redirect(string.Format("~/Purchase.aspx?dvdId={0}", selectedId));
            }
            if (e.CommandName == "ViewReport")
            {
                LinkButton viewbtn = (LinkButton)e.Item.FindControl("viewreportButton");
                string selectedId = viewbtn.CommandArgument;
                Response.Redirect(string.Format("~/DVDReport.aspx?dvdId={0}", selectedId));
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


    }
}