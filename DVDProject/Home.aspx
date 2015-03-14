<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="DVDProject.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Browse DVD Collection:</h1>
    <br />

    Sort by:
    <asp:DropDownList ID="sortingDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
        <asp:ListItem Value="title">Title</asp:ListItem>
        <asp:ListItem Value="primaryArtist">Artist</asp:ListItem>
        <asp:ListItem Value="releaseDate">Release Date</asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />

    <asp:DataList ID="DVDList" runat="server" OnItemCommand="DVDList_ItemCommand">
        <ItemTemplate>
            <asp:Table runat="server" CellPadding="3"
                GridLines="None" HorizontalAlign="Left">
                <asp:TableRow>
                    <asp:TableCell>
                        <img src='<%#Eval("coverImageUrl") %>' width="60" height="90" />
                    </asp:TableCell>
                    <asp:TableCell>
                        Dvd ID: <strong><%#Eval("DVDId")%></strong><br />
                        Title: <strong><%#Eval("title")%></strong><br />
                        Release Date: <strong><%#Eval("releaseDate")%></strong><br />
                        Primary Artist: <strong><%#Eval("primaryArtist")%></strong><br />
                        <asp:PlaceHolder ID="extraDetailsHolder" runat="server" Visible="false">
                            Price: <strong><%#Eval("price")%></strong><br />
                            CaraRating: <strong><%#Eval("CaraRating")%></strong><br />
                            IMDB Rating: <strong><%#Eval("ImdbRating")%></strong><br />
                            Quantity In Stock: <strong><%#Eval("quantityInStock")%></strong><br />
                        </asp:PlaceHolder>
                        <asp:LinkButton ID="detailsButton" runat="server" Width="85"
                            Text='More Details...      '                            
                            CommandName="MoreDetailsPlease"
                            CommandArgument='0' />
                        <asp:LinkButton ID="buyButton" runat="server" Width="50"
                            Text='Buy It!      '
                            CommandName="BuyIt"
                            CommandArgument='<%#Eval("DVDId")%>' />
                        <asp:LinkButton ID="viewreportButton" runat="server"
                            Text='View Report'
                            CommandName="ViewReport"
                            CommandArgument='<%#Eval("DVDId")%>' />

                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>


        </ItemTemplate>

        <SeparatorTemplate>
            <hr />
        </SeparatorTemplate>
    </asp:DataList>


</asp:Content>
