<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="DVDProject.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <br />
    <h1>Login Here Please:</h1>
    <p>
        Username:<br />
        <asp:TextBox ID="usernameTextBox" runat="server"></asp:TextBox>
        &nbsp;
        <asp:RequiredFieldValidator id ="usernameReq" runat ="server" 
            ControlToValidate ="usernameTextBox"  SetFocusOnError = "true" ForeColor="Red"
            ErrorMessage ="Username is required!"  /> 
    </p>
    <p>
        Password:<br />
        <asp:TextBox ID="passwordTextBox" TextMode="Password" runat="server"></asp:TextBox>
        &nbsp;
        <asp:RequiredFieldValidator id ="passwordReq" runat ="server" 
            ControlToValidate ="passwordTextBox" SetFocusOnError = "true" ForeColor="Red"
            ErrorMessage ="Password is required!"  />
    </p>
    <asp:Button ID="loginButton" runat="server" Text="Login" OnClick="loginButton_Click" />
</asp:Content>
