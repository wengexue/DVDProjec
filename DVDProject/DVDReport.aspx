<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DVDReport.aspx.cs" Inherits="DVDProject.DVDReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <br />
    <asp:Table runat="server" CellPadding="3"
        GridLines="None" HorizontalAlign="Left">
        <asp:TableRow>
            <asp:TableCell>
                <asp:Image ID="DvdImage" runat="server" Width="60" Height="90"/>

            </asp:TableCell>
            <asp:TableCell>
                <asp:Label ID="DVDIdLabel" runat="server" Text=""></asp:Label><br />
                <asp:Label ID="titleLabel" runat="server" Text=""></asp:Label><br />
                <asp:Label ID="releaseDateLabel" runat="server" Text=""></asp:Label><br />
                <asp:Label ID="primaryArtistLabel" runat="server" Text=""></asp:Label><br />
                <asp:Label ID="priceLabel" runat="server" Text=""></asp:Label><br />
                <asp:Label ID="CaraRatingLabel" runat="server" Text=""></asp:Label><br />
                <asp:Label ID="ImdbRatingLabel" runat="server" Text=""></asp:Label><br />
                <asp:Label ID="quantityInStockLabel" runat="server" Text=""></asp:Label><br />
                <asp:Label ID="soldquantityLabel" runat="server" Text=""></asp:Label><br />
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    <br style="clear:both" />

    <br />
    <h1 style="clear:both">Purchasing Customers:</h1>
    <asp:DataList ID="customerDataList" runat="server">
        <ItemTemplate>
            Customer ID: <strong><%#Eval("customerId")%></strong><br />
            Name: <strong><%#Eval("customerName")%></strong><br />
            Email <strong><%#Eval("email")%></strong>
        </ItemTemplate>
        <SeparatorTemplate>
            <hr />
        </SeparatorTemplate>
    </asp:DataList>

</asp:Content>
