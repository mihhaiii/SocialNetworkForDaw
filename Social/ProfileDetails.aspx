<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProfileDetails.aspx.cs" Inherits="ProfileDetails" %>

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
        .auto-style12 {
            width: 89%;
        }
        .auto-style11 {
            width: 136px;
        }
        .auto-style14 {
            width: 76px;
        }
        .auto-style16 {
            width: 100%;
        }
        .auto-style17 {
            height: 23px;
        }
        .auto-style19 {
            height: 23px;
            width: 197px;
            text-align: center;
        }
        .auto-style20 {
            width: 197px;
        }
        .auto-style21 {
            height: 23px;
            text-align: right;
            width: 122px;
        }
        .auto-style22 {
            height: 23px;
            text-align: left;
            width: 78px;
        }
        .auto-style23 {
            width: 197px;
            text-align: center;
        }
        .auto-style25 {
            width: 78px;
        }
        .auto-style26 {
            width: 122px;
        }
        .auto-style27 {
            width: 122px;
            height: 30px;
        }
        .auto-style28 {
            width: 197px;
            height: 30px;
            text-align: center;
        }
        .auto-style29 {
            width: 78px;
            height: 30px;
        }
        .auto-style30 {
            height: 30px;
        }
        .auto-style32 {
            width: 81px;
        }
        .auto-style33 {
            width: 45px;
        }
        .auto-style34 {
            width: 38px;
        }
        .auto-style35 {
            width: 65px;
        }
        .auto-style36 {
            margin-left: 18px;
        }
        .auto-style37 {
            text-align: center;
            height: 383px;
        }
        .auto-style38 {
            margin-left: 0px;
        }
        .auto-style39 {
            text-align: center;
            height: 34px;
        }
        .auto-style40 {
            width: 45px;
            height: 34px;
        }
        .auto-style41 {
            width: 81px;
            height: 34px;
        }
        .auto-style42 {
            width: 38px;
            height: 34px;
        }
        .auto-style43 {
            width: 76px;
            height: 34px;
        }
        .auto-style44 {
            width: 45px;
            height: 383px;
        }
        .auto-style45 {
            width: 81px;
            height: 383px;
        }
        .auto-style46 {
            width: 38px;
            height: 383px;
        }
        .auto-style47 {
            width: 76px;
            height: 383px;
        }
        .auto-style48 {
            width: 158px;
        }
        .auto-style49 {
            width: 99px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
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
        <p class="auto-style1">
            <strong>
            <asp:Label ID="LabelPD" runat="server" EnableTheming="True" Text="Profile Details"></asp:Label>
&nbsp;
            <asp:Label ID="LabelAdmin" runat="server" ForeColor="Red" Text="Admin privileges" Visible="False"></asp:Label>
            </strong></p>
        <div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Name], [Surname], [Email], [Sex], [ImagePath] FROM [Users] WHERE ([Id] = @Id)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="Id" QueryStringField="userid" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        &nbsp;<asp:Button ID="ButtonDelPR" runat="server" ForeColor="Red" Text="Delete Profile" Visible="False" />
        </div>
        <table class="auto-style12">
            <tr>
                <td class="auto-style35" rowspan="4">
        <p class="auto-style11">
            <asp:Image ID="ProfilePicture" runat="server" Height="108px" Width="111px" />
            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Horizontal" Height="50px" Width="125px">
                <EditRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                <Fields>
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname" />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                    <asp:BoundField DataField="Sex" HeaderText="Sex" SortExpression="Sex" />
                </Fields>
                <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
            </asp:DetailsView>
        </p>
                </td>
                <td class="auto-style39"><strong>
                    <asp:Label ID="LabelMsg" runat="server" ClientIDMode="Static" Text="Messages"></asp:Label>
                    </strong></td>
                <td class="auto-style40"></td>
                <td class="auto-style41"></td>
                <td class="auto-style42"></td>
                <td class="auto-style43"></td>
            </tr>
            <tr>
                <td class="auto-style37">
                    <asp:TextBox ID="TextBoxMain" runat="server" Height="206px" ReadOnly="True" TextMode="MultiLine" Width="197px"></asp:TextBox>
                    <asp:TextBox ID="TextBoxSend" runat="server" CssClass="auto-style36" Height="22px"  Width="274px"></asp:TextBox>
                    <asp:Button ID="ButtonSendMsg" runat="server" OnClick="ButtonSendMsg_Click" Text="Send" />
                </td>
                <td class="auto-style44">
                    <table class="auto-style16">
                        <tr>
                            <td class="auto-style26">&nbsp;</td>
                            <td class="auto-style20">
                                <asp:Literal ID="Literal1" runat="server" Text="Pictures Added by User:"></asp:Literal>
                            </td>
                            <td class="auto-style25">&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style21">
                                <asp:ImageButton ID="ImageButtonLeft" runat="server" Height="20px" ImageUrl="~/Images/left.png" OnClick="ImageButtonLeft_Click" Width="20px" />
                            </td>
                            <td class="auto-style19">
                                <asp:Image ID="ImageMain" runat="server" GenerateEmptyAlternateText="True" Height="250px" Width="255px" />
                            </td>
                            <td class="auto-style22">
                                <asp:ImageButton ID="ImageButtonRight" runat="server" Height="20px" ImageUrl="~/Images/right.png" OnClick="ImageButtonRight_Click" Width="20px" />
                            </td>
                            <td class="auto-style17">
                                <asp:FileUpload ID="FileUploadImages" runat="server" />
                                <asp:Button ID="ButtonAddImage" runat="server" OnClick="ButtonAddImage_Click" Text="Add Picture" ValidationGroup="gr1" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="FileUploadImages" ErrorMessage="you must choose a picture" ForeColor="Red" ValidationGroup="gr1"></asp:RequiredFieldValidator>
                                <br />
                                <br />
                                <asp:Button ID="ButtonDelete" runat="server" OnClick="Button1_Click1" Text="Delete" />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style26">&nbsp;</td>
                            <td class="auto-style23">
                                <asp:TextBox ID="TextBoxComments" runat="server" Height="97px" ReadOnly="True" TextMode="MultiLine" Width="248px"></asp:TextBox>
                            </td>
                            <td class="auto-style25">&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style27"></td>
                            <td class="auto-style28">
                                <asp:TextBox ID="TextBoxSubComment" runat="server" CssClass="auto-style38" Width="242px"></asp:TextBox>
                                <asp:Button ID="ButtonSubComment" runat="server" OnClick="ButtonSubComment_Click" Text="Add" />
                            </td>
                            <td class="auto-style29"></td>
                            <td class="auto-style30"></td>
                        </tr>
                    </table>
                </td>
                <td class="auto-style45"></td>
                <td class="auto-style46"></td>
                <td class="auto-style47"></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td class="auto-style33">&nbsp;</td>
                <td class="auto-style32">&nbsp;</td>
                <td class="auto-style34">&nbsp;</td>
                <td class="auto-style14">&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td class="auto-style33">&nbsp;</td>
                <td class="auto-style32">&nbsp;</td>
                <td class="auto-style34">&nbsp;</td>
                <td class="auto-style14">&nbsp;</td>
            </tr>
        </table>
        <table class="auto-style16">
            <tr>
                <td class="auto-style48">
                    <asp:Label ID="ProfileVisLabel" runat="server" Text="Set Profile Visibility"></asp:Label>
                </td>
                <td class="auto-style49">
                    <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                        <asp:ListItem Selected="True">Public</asp:ListItem>
                        <asp:ListItem>Private</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
                <td>
                    <asp:Button ID="PVSetButton" runat="server" Text="Set" OnClick="PVSetButton_Click" />
                </td>
            </tr>
        </table>
        <p>
            <asp:Button ID="ButtonAdd" runat="server" OnClick="ButtonAdd_Click" Text="Send Friend Request" Width="183px" />
        </p>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT distinct FriendRequests.UserReceived, FriendRequests.UserSent, FriendRequests.State, Users.Id, Users.Name, Users.Surname, Users.ImagePath FROM FriendRequests CROSS JOIN Users where FriendRequests.State = 'pending' and FriendRequests.UserSent = Users.Id and FriendRequests.UserReceived = @me ">
            <SelectParameters>
                <asp:SessionParameter Name="me" SessionField="userid" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <asp:Label ID="LabelFR" runat="server" Text="Friend Requests :"></asp:Label>
        <br />
        <asp:DataList ID="DataList1" runat="server" CellPadding="10" CellSpacing="10" DataKeyField="Id" DataSourceID="SqlDataSource2" RepeatColumns="3">
            <ItemTemplate>
                <br />
                Name:
                <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                <br />
                Surname:
                <asp:Label ID="SurnameLabel" runat="server" Text='<%# Eval("Surname") %>' />
                <br />
                <asp:ImageButton ID="ImageButton1" runat="server" CommandArgument='<%# Eval("Id") %>' Height="70px" ImageUrl='<%# Eval("ImagePath", "~/Images/{0}") %>' OnCommand="ImageButton1_Click" Width="70px" />
                <br />
                <asp:Button ID="ButtonAccept" runat="server" Text="Accept" OnCommand="ButtonAccept_Click" CommandArgument='<%# Eval("Id") %>'  />
                <asp:Button ID="ButtonDecline" runat="server" Text="Decline" OnCommand="ButtonDecline_Click" CommandArgument='<%# Eval("Id") %>' />
<br />
            </ItemTemplate>
        </asp:DataList>
        <table class="auto-style16">
            <tr>
                <td class="auto-style26">&nbsp;</td>
                <td class="auto-style20">&nbsp;</td>
                <td class="auto-style25">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </form>
    <p>
        &nbsp;</p>
</body>
</html>
