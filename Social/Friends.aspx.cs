using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
public partial class Friends : System.Web.UI.Page
{
    int sessionUserId;
    string state;

    private void InitUsersAndState()
    {
        if (Session["userid"] == null)
        {
            sessionUserId = -1;
            state = "guest";
            return;
        }

        sessionUserId = int.Parse(Session["userid"].ToString());
        state = "user";
    }

    private void DisplayMenuItems()
    {
        if (state == "guest")
        {
            HomeB.Visible = true;
            HomeB.PostBackUrl = "Login.aspx";
            PeopleB.Visible = true;
            PeopleB.PostBackUrl = "People.aspx";
            MyFriendsB.Visible = false;
            GroupsB.Visible = true;
            GroupsB.PostBackUrl = "Groups.aspx";
            MyGroupsB.Visible = false;
            LogoutB.Visible = false;

        }
        else
        {
            HomeB.Visible = true;
            HomeB.PostBackUrl = "ProfileDetails.aspx?userid=" + sessionUserId.ToString();
            PeopleB.Visible = true;
            PeopleB.PostBackUrl = "People.aspx";
            MyFriendsB.Visible = true;
            MyFriendsB.PostBackUrl = "Friends.aspx";
            GroupsB.Visible = true;
            GroupsB.PostBackUrl = "Groups.aspx";
            MyGroupsB.Visible = true;
            MyGroupsB.PostBackUrl = "MyGroups.aspx";
            LogoutB.Visible = true;

        }

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        InitUsersAndState();
        DisplayMenuItems();
    }

    protected void ImageButton1_Click(object sender, CommandEventArgs e)
    {
        Response.Redirect("ProfileDetails.aspx?userid=" + e.CommandArgument.ToString());
    }

    protected void LogoutB_Click(object sender, EventArgs e)
    {
        Session["userid"] = null;
        Response.Redirect("Login.aspx");
    }

    protected void Button1_Click(object sender, CommandEventArgs e)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
        connection.Open();
        int idtoDelete = int.Parse(e.CommandArgument.ToString());
        string query = "delete from Friendships where (user1Id = @u1 and user2Id = @u2)" +
            " or (user1Id = @u2 and user2Id = @u1)";
        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@u1", idtoDelete);
        command.Parameters.AddWithValue("@u2", sessionUserId);
        command.ExecuteNonQuery();
        DataList2.DataBind();
        
        connection.Close();
    }
}