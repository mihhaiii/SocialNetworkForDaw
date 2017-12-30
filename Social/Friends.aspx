<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Friends.aspx.cs" Inherits="Friends" %>

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
        </div>
        <p class="auto-style1">
            <strong>My friends</strong></p>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT distinct Friendships.user1Id, Friendships.user2Id, Users.Id, Users.Name, Users.Surname, Users.Email, Users.Sex, Users.ImagePath FROM Friendships, Users  where ( Friendships.user1Id = Users.Id and 
     Friendships.user2Id = @userid )  or   ( Friendships.user2Id = Users.Id and   Friendships.user1Id = @userid ) 


">
            <SelectParameters>
                <asp:SessionParameter Name="userid" SessionField="userid" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
            <asp:DataList ID="DataList2" runat="server" DataSourceID="SqlDataSource2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="0px" CellPadding="10" CellSpacing="10" DataKeyField="Id" RepeatColumns="3">
                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                <ItemStyle BackColor="White" ForeColor="#003399" />
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server"  CommandArgument='<%# Eval("Id") %>' Height="100px" ImageUrl='<%# Eval("ImagePath","~/Images/{0}") %>' OnCommand="ImageButton1_Click" Width="100px" />
                    <br />
                    Name:
                    <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                    <br />
                    Surname:
                    <asp:Label ID="SurnameLabel" runat="server" Text='<%# Eval("Surname") %>' />
                    <br />
                    Email:
                    <asp:Label ID="EmailLabel" runat="server" Text='<%# Eval("Email") %>' />
                    <br />
                    Sex:
                    <asp:Label ID="SexLabel" runat="server" Text='<%# Eval("Sex") %>' />
                    <br />
                    <asp:Button ID="ButtonDelete" runat="server" CommandArgument='<%# Eval("Id") %>' OnCommand="Button1_Click" Text="Delete" />
                    <br />
<br />
                </ItemTemplate>
                <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            </asp:DataList>
    </form>
</body>
</html>
