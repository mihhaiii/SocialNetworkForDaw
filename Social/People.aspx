<%@ Page Language="C#" AutoEventWireup="true" CodeFile="People.aspx.cs" Inherits="People" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">

        .auto-style1 {
            font-size: x-large;
        }
        .auto-style10 {
            width: 31px;
        }
        .auto-style2 {
            width: 49px;
        }
        .auto-style8 {
            width: 60px;
        }
        .auto-style9 {
            width: 57px;
        }
        .auto-style6 {
            width: 139px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table class="auto-style1">
                <tr>
                    <td class="auto-style10">
                        <asp:Button ID="HomeB" runat="server" Text="Home" Width="50px" />
                    </td>
                    <td class="auto-style2">
                        <asp:Button ID="PeopleB" runat="server" Text="People" Width="50px" />
                    </td>
                    <td class="auto-style8">
                        <asp:Button ID="MyFriendsB" runat="server" Text="My Friends" Width="76px" />
                    </td>
                    <td class="auto-style2">
                        <asp:Button ID="GroupsB" runat="server" Text="Groups" Width="50px" />
                    </td>
                    <td class="auto-style9">
                        <asp:Button ID="MyGroupsB" runat="server" Text="My Groups" Width="74px" />
                    </td>
                    <td class="auto-style6">
                        <asp:Button ID="LogoutB" runat="server" OnClick="LogoutB_Click" Text="Logout" Width="50px" />
                    </td>
                </tr>
            </table>
            <br />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Name], [Surname], [Sex], [ImagePath], [Id] FROM [Users]" OnSelecting="SqlDataSource1_Selecting"></asp:SqlDataSource>
            People page<br />
        </div>
        <asp:DataList ID="DataList1" runat="server" CellPadding="10" CellSpacing="10" DataKeyField="Id" DataSourceID="SqlDataSource1" RepeatColumns="7" Width="382px" >
            <ItemTemplate>
                <asp:ImageButton ID="ImageButton1" runat="server" CommandArgument='<%# Eval("Id") %>' ImageUrl='<%# Eval("ImagePath", "~/Images/{0}") %>' OnCommand="ImageButton1_Click" Height="130px" Width="147px" OnClick="ImageButton1_Click1" />
                <br />
                Name:
                <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                <br />
                Surname:
                <asp:Label ID="SurnameLabel" runat="server" Text='<%# Eval("Surname") %>' />
                <br />
                Sex:
                <asp:Label ID="SexLabel" runat="server" Text='<%# Eval("Sex") %>' />
                <br />
                <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("Id") %>'>LinkButton</asp:LinkButton>
                <br />
            </ItemTemplate>
        </asp:DataList>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
