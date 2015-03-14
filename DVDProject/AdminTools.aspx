<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminTools.aspx.cs" Inherits="DVDProject.AdminTools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h1>Administer DVD Collection:</h1>
    <asp:Label ID="dbErrorMessage" ForeColor="Red" runat="server" />
    <asp:Panel ID="DVDListPanel" runat="server" Visible="true">
        <asp:Button ID="addDVDButton" runat="server" Text="Add DVD" OnClick="addDVDButton_Click" /><br />
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
                            <asp:PlaceHolder ID="extraDetailsHolder" runat="server" Visible="true">Price: <strong><%#Eval("price")%></strong><br />
                                CaraRating: <strong><%#Eval("CaraRating")%></strong><br />
                                IMDB Rating: <strong><%#Eval("ImdbRating")%></strong><br />
                                Quantity In Stock: <strong><%#Eval("quantityInStock")%></strong><br />
                            </asp:PlaceHolder>
                            <asp:LinkButton ID="editButton" runat="server" Width="70"
                                Text='Edit DVD'
                                CommandName="EditDVD"
                                CommandArgument='<%#Eval("DVDId")%>' />
                            <asp:LinkButton ID="deleteButton" runat="server" Width="70"
                                Text='Delete DVD'
                                CommandName="DeleteDVD"
                                CommandArgument='<%#Eval("DVDId")%>' />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:Table runat="server" CellPadding="3"
                    GridLines="None" HorizontalAlign="Left">
                    <asp:TableRow>
                        <asp:TableCell>
                        <img src='<%#Eval("coverImageUrl") %>' width="60" height="90" />
                        </asp:TableCell><asp:TableCell>
                            Dvd ID: <strong><%#Eval("DVDId")%></strong><br />
                            Title:
                            <asp:TextBox ID="titleTextBox" runat="server" Text='<%# Eval("title")%>' />&nbsp;
                            <asp:RequiredFieldValidator ID="titleReq" runat="server"
                                ControlToValidate="titleTextBox" ForeColor="Red"
                                ErrorMessage="Please enter the title!"
                                Display="Dynamic" />
                            <br />
                            Release Date:
                            <asp:TextBox ID="releaseDateTextBox" runat="server" Text='<%#Eval("releaseDate")%>' />&nbsp;
                            <asp:RequiredFieldValidator ID="releaseDateReq" runat="server"
                                ControlToValidate="releaseDateTextBox" ForeColor="Red"
                                ErrorMessage="Please enter release date!"
                                Display="Dynamic" />
                            <br />
                            Primary Artist: 
                            <asp:TextBox ID="primaryArtistTextBox" runat="server" Text='<%# Eval("primaryArtist")%>' />&nbsp;
                            <asp:RequiredFieldValidator ID="primaryArtistReq" runat="server"
                                ControlToValidate="primaryArtistTextBox" ForeColor="Red"
                                ErrorMessage="Please enter primary artist!"
                                Display="Dynamic" />
                            <br />
                            Price: 
                            <asp:TextBox ID="priceTextBox" runat="server" Text='<%# Eval("price")%>' />&nbsp;
                            <asp:RequiredFieldValidator ID="priceReq" runat="server"
                                ControlToValidate="priceTextBox" ForeColor="Red"
                                ErrorMessage="Please enter price!"
                                Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="priceRegularExpressionValidator" runat="server" ForeColor="Red"
                                ControlToValidate="priceTextBox"
                                ValidationExpression="^\d+(\.\d\d\d\d)?$"
                                ErrorMessage="Enter a valid price" />
                            <br />
                            CaraRating: 
                            <asp:TextBox ID="CaraRatingTextBox" runat="server" Text='<%# Eval("CaraRating")%>' />(G, PG, PG-13, R, NC-17)&nbsp;
                            <asp:RegularExpressionValidator ID="regCaraRating" runat="server" ForeColor="Red"
                                ControlToValidate="CaraRatingTextBox"
                                ValidationExpression="G|PG|PG-13|R|NC-17"
                                ErrorMessage="Enter a valid rating" />
                            <asp:RequiredFieldValidator ID="Req" runat="server"
                                ControlToValidate="CaraRatingTextBox" ForeColor="Red"
                                ErrorMessage="Please enter the rating!"
                                Display="Dynamic" />
                            <br />
                            IMDB Rating: 
                            <asp:TextBox ID="ImdbRatingTextBox" runat="server" Text='<%# Eval("ImdbRating")%>' />&nbsp;
                            <asp:RequiredFieldValidator ID="ImdbRatingReq" runat="server"
                                ControlToValidate="ImdbRatingTextBox" ForeColor="Red"
                                ErrorMessage="Please enter ImdbRating!"
                                Display="Dynamic" />
                            <asp:RangeValidator ID="ImdbRatingRangeValidator" runat="server"
                                ControlToValidate="ImdbRatingTextBox" Type="Integer"
                                ErrorMessage="Rating must be between 1 and 10" ForeColor="Red"
                                MaximumValue="10" MinimumValue="1"></asp:RangeValidator>
                            <br />
                            Quantity In Stock: 
                            <asp:TextBox ID="quantityInStockTextBox" runat="server" Text='<%# Eval("quantityInStock")%>' />&nbsp;
                            <asp:RequiredFieldValidator ID="quantityInStockReq" runat="server"
                                ControlToValidate="quantityInStockTextBox" ForeColor="Red"
                                ErrorMessage="Please enter quantity In Stock!"
                                Display="Dynamic" />
                            <asp:CompareValidator ID="quantityInStockCompareValidator" runat="server"
                                Operator="GreaterThan" ValueToCompare="0" ForeColor="Red"
                                ControlToValidate="quantityInStockTextBox" ErrorMessage="Quantity In Stock must be greater than 0"
                                Type="Integer"></asp:CompareValidator>
                            <br />
                            <asp:Button ID="updateButton" runat="server" Width="70"
                                Text='Update'
                                CommandName="UpdateDVD"
                                CommandArgument='<%#Eval("DVDId")%>' />
                            <asp:Button ID="cancelButton" runat="server" CausesValidation="False" Width="70"
                                Text='Cancel'
                                CommandName="CancelEditing"
                                CommandArgument='<%#Eval("DVDId")%>' />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </EditItemTemplate>
            <SeparatorTemplate>
                <hr />
            </SeparatorTemplate>
        </asp:DataList>
    </asp:Panel>

    <asp:Panel ID="AddDVDPanel" runat="server" Visible="false">
        <p>
            Title:
            <asp:TextBox ID="titleTextBox" runat="server"></asp:TextBox>&nbsp;
            <asp:RequiredFieldValidator ID="titleReq" runat="server"
                ControlToValidate="titleTextBox" ForeColor="Red"
                ErrorMessage="Please enter the title!"
                Display="Dynamic" />
        </p>
        <p>
            Release Date:
            <asp:TextBox ID="releaseDateTextBox" runat="server" TextMode="Date"></asp:TextBox>&nbsp;
            <asp:RequiredFieldValidator ID="releaseDateReq" runat="server"
                ControlToValidate="releaseDateTextBox" ForeColor="Red"
                ErrorMessage="Please enter release date!"
                Display="Dynamic" />
        </p>
        <p>
            Primary Artist:
            <asp:TextBox ID="primaryArtistTextBox" runat="server"></asp:TextBox>&nbsp;
            <asp:RequiredFieldValidator ID="primaryArtistReq" runat="server"
                ControlToValidate="primaryArtistTextBox" ForeColor="Red"
                ErrorMessage="Please enter primary artist!"
                Display="Dynamic" />
        </p>
        <p>
            Price:
            <asp:TextBox ID="priceTextBox" runat="server" TextMode="Number"></asp:TextBox>&nbsp;
            <asp:RequiredFieldValidator ID="priceReq" runat="server"
                ControlToValidate="priceTextBox" ForeColor="Red"
                ErrorMessage="Please enter price!"
                Display="Dynamic" />
            <asp:CompareValidator ID="priceCompareValidator" runat="server"
                Operator="GreaterThanEqual" ValueToCompare="0" ForeColor="Red"
                ControlToValidate="priceTextBox" ErrorMessage="Price must be greater or equal than 0"
                Type="Integer"></asp:CompareValidator>
        </p>
        <p>
            CaraRating:
            <asp:DropDownList ID="CaraRatingDropDownList" Width="130" Height="25" runat="server">
                <asp:ListItem>Select a rating</asp:ListItem>
                <asp:ListItem>G</asp:ListItem>
                <asp:ListItem>PG</asp:ListItem>
                <asp:ListItem>PG-13</asp:ListItem>
                <asp:ListItem>R</asp:ListItem>
                <asp:ListItem>NC-17</asp:ListItem>
            </asp:DropDownList>&nbsp;
            <asp:RequiredFieldValidator ID="CaraRatingReq"
                runat="server" ErrorMessage="Please make a selection"
                ControlToValidate="CaraRatingDropDownList" ForeColor="Red"
                InitialValue="Select a rating">
            </asp:RequiredFieldValidator>
        </p>
        <p>
            Imdb Rating:
            <asp:TextBox ID="ImdbRatingTextBox" runat="server" TextMode="Number"></asp:TextBox>(1-10)&nbsp;
            <asp:RequiredFieldValidator ID="ImdbRatingReq" runat="server"
                ControlToValidate="ImdbRatingTextBox" ForeColor="Red"
                ErrorMessage="Please enter ImdbRating!"
                Display="Dynamic" />
            <asp:RangeValidator ID="ImdbRatingRangeValidator" runat="server"
                ControlToValidate="ImdbRatingTextBox" Type="Integer"
                ErrorMessage="Rating must be between 1 and 10" ForeColor="Red"
                MaximumValue="10" MinimumValue="1"></asp:RangeValidator>
        </p>
        <p>
            Quantity In Stock:
            <asp:TextBox ID="quantityInStockTextBox" runat="server" TextMode="Number"></asp:TextBox>&nbsp;
            <asp:RequiredFieldValidator ID="quantityInStockReq" runat="server"
                ControlToValidate="quantityInStockTextBox" ForeColor="Red"
                ErrorMessage="Please enter quantity In Stock!"
                Display="Dynamic" />
            <asp:CompareValidator ID="quantityInStockCompareValidator" runat="server"
                Operator="GreaterThan" ValueToCompare="0" ForeColor="Red"
                ControlToValidate="quantityInStockTextBox" ErrorMessage="Quantity In Stock must be greater than 0"
                Type="Integer"></asp:CompareValidator>
        </p>
        <br />
        <asp:Button ID="saveButton" runat="server" Text="Save" OnClick="saveButton_Click" Style="margin-right: 5px; height: 26px" />
        <asp:Button ID="cancelButton" runat="server" Text="Cancel" CausesValidation="False" OnClick="cancelButton_Click" Style="height: 26px" />
    </asp:Panel>


</asp:Content>
