<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FriendshipsDb.aspx.cs" Inherits="FriendshipsDb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Friendships]"></asp:SqlDataSource>
        </div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" />
                <asp:BoundField DataField="user1Id" HeaderText="user1Id" SortExpression="user1Id" />
                <asp:BoundField DataField="user2Id" HeaderText="user2Id" SortExpression="user2Id" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
