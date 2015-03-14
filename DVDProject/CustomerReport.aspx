<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CustomerReport.aspx.cs" Inherits="DVDProject.CustomerReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <br />
    Customer:
    <asp:DropDownList ID="customerList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="customerList_SelectedIndexChanged" />
    <br />
    <h1>DVD's Purchase:</h1>

    <asp:DataList ID="customerDVDList" runat="server">
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
                        Price: <strong><%#Eval("price")%></strong><br />
                        Purchase Date: <strong><%#Eval("purchaseDate")%></strong><br />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </ItemTemplate>

        <SeparatorTemplate>
            <hr />
        </SeparatorTemplate>
    </asp:DataList>
</asp:Content>
