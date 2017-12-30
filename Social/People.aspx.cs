using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
public partial class People : System.Web.UI.Page
{
    int sessionUserId;
    string state;
    FriendsFunctions ff = new FriendsFunctions();
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

    protected void SetFriendsStatus()
    {
       if(state == "guest")
        {
            return;
        }
       // DataList1.DataBind();
        foreach (DataListItem item in DataList1.Items)
        {
            LinkButton btn = item.FindControl("LinkButton1") as LinkButton;
            if (btn != null)
            {
                int currUserId = int.Parse(btn.CommandArgument.ToString());
                if (sessionUserId == currUserId)
                {
                    btn.Text = "Me";
                }
                else
                {
                   
                    if(ff.AreFriends(currUserId, sessionUserId))
                    {
                        btn.Text = "Friends";

                    }
                    else if (ff.HasInvited(sessionUserId, currUserId))
                    {
                        btn.Text = "Friend Request Sent";
                       
                    }
                    else
                    {
                        btn.Text = "Send Friend Request";
                        btn.PostBackUrl = "Anon1.aspx?userid="+ btn.CommandArgument.ToString();
                        btn.Attributes.Add("onclick", "ButtonAddFRPostBack()");
                        //btn.OnClientClick = "ButtonAddFRPostBack";
                    }
                }
                
            }
        }
        
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        DataList1.DataBind();
        InitUsersAndState();
        DisplayMenuItems();

        SetFriendsStatus();
    }

    protected void ImageButton1_Click(object sender, CommandEventArgs e)
    {
        string id = e.CommandArgument.ToString();
        Response.Redirect("ProfileDetails.aspx?userid=" + id);
    }


    protected void LogoutB_Click(object sender, EventArgs e)
    {
        Session["userid"] = null;
        Response.Redirect("Login.aspx");
    }

    protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }

    protected void ImageButton1_Click1(object sender, ImageClickEventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {

    }

    protected void ButtonAddFRPostBack(object sender, EventArgs e)
    {
        var b = sender as Button;
        int id = int.Parse(b.CommandArgument.ToString());
        ff.AddFriendRequest(sessionUserId, id);
    }

    

}