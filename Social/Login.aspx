<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 156px;
        }
        .auto-style3 {
            width: 147px;
        }
        .auto-style4 {
            width: 156px;
            text-align: right;
        }
        .auto-style5 {
            width: 147px;
            height: 23px;
            text-align: right;
        }
        .auto-style6 {
            height: 23px;
        }
        .auto-style7 {
            width: 147px;
            text-align: right;
        }
        .auto-style8 {
            width: 174px;
        }
        .auto-style9 {
            height: 23px;
            width: 174px;
        }
        .auto-style10 {
            font-size: x-large;
        }
        .auto-style11 {
            width: 190px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <a href="Database.aspx">database</a><br />
            <br />
            <asp:Button ID="ButtonPeople" runat="server" OnClick="ButtonPeople_Click" Text="People" />
        </div>
        <p class="auto-style10">
            <strong>Welcome to Facebook</strong></p>
        <p>
            <br />
            Log In</p>
        <table class="auto-style1">
            <tr>
                <td class="auto-style4">Email</td>
                <td class="auto-style11">
                    <asp:TextBox ID="TextBoxUn" runat="server" Width="180px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxUn" ErrorMessage="email required" ForeColor="Red" ValidationGroup="LoginGroup"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style4">Password</td>
                <td class="auto-style11">
                    <asp:TextBox ID="TextBoxPassword" runat="server" Width="180px" TextMode="Password"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBoxPassword" ErrorMessage="password required" ForeColor="Red" ValidationGroup="LoginGroup"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">&nbsp;</td>
                <td class="auto-style11">
                    <asp:Button ID="ButtonLogin" runat="server" OnClick="ButtonLogin_Click" Text="Log In" ValidationGroup="LoginGroup" />
                    <input id="Reset1" type="reset" value="reset" /></td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <p>
            Register</p>
        <table class="auto-style1">
            <tr>
                <td class="auto-style7">Name</td>
                <td class="auto-style8">
                    <asp:TextBox ID="TextBoxName" runat="server" Width="180px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBoxName" ErrorMessage="name required" ForeColor="Red" ValidationGroup="RegisterGroup"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style7">Surname</td>
                <td class="auto-style8">
                    <asp:TextBox ID="TextBoxSurname" runat="server" Width="180px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBoxSurname" ErrorMessage="surname required" ForeColor="Red" ValidationGroup="RegisterGroup"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style7">Email</td>
                <td class="auto-style8">
                    <asp:TextBox ID="TextBoxEmail" runat="server" Width="180px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TextBoxEmail" ErrorMessage="email required" ForeColor="Red" ValidationGroup="RegisterGroup"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBoxEmail" ErrorMessage="invalid email address" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="RegisterGroup"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style5">Password</td>
                <td class="auto-style9">
                    <asp:TextBox ID="TextBoxPass" runat="server" Width="180px" TextMode="Password"></asp:TextBox>
                </td>
                <td class="auto-style6">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TextBoxPass" ErrorMessage="password required" ForeColor="Red" ValidationGroup="RegisterGroup"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style7">Repeat Password</td>
                <td class="auto-style8">
                    <asp:TextBox ID="TextBoxRPass" runat="server" Width="180px" TextMode="Password"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="TextBoxRPass" ErrorMessage="repeat password" ForeColor="Red" ValidationGroup="RegisterGroup"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="TextBoxPass" ControlToValidate="TextBoxRPass" ErrorMessage="passwords do not match" ForeColor="Red" ValidationGroup="RegisterGroup"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style7">Sex</td>
                <td class="auto-style8">
                    <asp:RadioButtonList ID="RadioButtonListSex" runat="server">
                        <asp:ListItem>Male</asp:ListItem>
                        <asp:ListItem>Female</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="RadioButtonListSex" ErrorMessage="sex required" ForeColor="Red" ValidationGroup="RegisterGroup"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style7">Picture of you</td>
                <td class="auto-style8">
                    <asp:FileUpload ID="FileUploadPicture" runat="server" />
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="FileUploadPicture" ErrorMessage="picture required" ForeColor="Red" ValidationGroup="RegisterGroup"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style8">
                    <asp:Button ID="ButtonRegister" runat="server" OnClick="ButtonRegister_Click" Text="Register" ValidationGroup="RegisterGroup" />
                    <input id="Reset2" type="reset" value="reset" /></td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </form>
</body>
</html>
