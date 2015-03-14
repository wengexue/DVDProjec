<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Purchase.aspx.cs" Inherits="DVDProject.Purchase" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Purchase DVD:</h1>
    <asp:Label ID="dbErrorMessage" ForeColor="Red" runat="server" />
    <br />
    <asp:DataList ID="DVDPurchse" runat="server" >
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
                        <asp:PlaceHolder ID="extraDetailsHolder" runat="server" Visible="true">
                            Price: <strong><%#Eval("price")%></strong><br />
                            CaraRating: <strong><%#Eval("CaraRating")%></strong><br />
                            IMDB Rating: <strong><%#Eval("ImdbRating")%></strong><br />
                            Quantity In Stock: <strong><%#Eval("quantityInStock")%></strong><br />
                        </asp:PlaceHolder>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>

        </ItemTemplate>
    </asp:DataList>
    <br />
    <h2>Customer Information:</h2>
    <p>
        Customer Name:
            <asp:TextBox ID="nameTextBox" runat="server" Text='' />
            &nbsp;
            <asp:RequiredFieldValidator ID="customerNameReq" runat="server"
                ControlToValidate="nameTextBox" ForeColor="Red"
                ErrorMessage="Please enter your name!"
                Display="Dynamic" />
            <asp:RegularExpressionValidator ID="regName" runat="server" ForeColor="Red"
               ControlToValidate="nameTextBox" 
               ValidationExpression="^[a-zA-Z'.\s]{1,50}"
               ErrorMessage="Enter a valid name" /> 
    </p>
    <p>
        Customer Email:
            <asp:TextBox ID="emailTextBox" runat="server" Text='' />
            &nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                ControlToValidate="emailTextBox" ForeColor="Red"
                ErrorMessage="Please enter your email!"
                Display="Dynamic" />
            <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ForeColor="Red"
                ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                ControlToValidate="emailTextBox" ErrorMessage="Invalid Email Format"></asp:RegularExpressionValidator>
    </p>
    <asp:Button ID="buyButton" runat="server" Text="Buy It Now!" OnClick="buyButton_Click" />
</asp:Content>
