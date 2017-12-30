using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
public partial class ProfileDetails : System.Web.UI.Page
{
    int sessionUserId;
    int profileUserId;
    string state;
    FriendsFunctions ff = new FriendsFunctions();
    List<String> myPicturesPaths;
    List<String> myCommentsList;
    List<int> myPicturesIds;
    private void InitUsersAndState()
    {
        profileUserId = int.Parse(Request.QueryString["userid"].ToString());
        if (Session["userid"] == null)
        {
            sessionUserId = -1;
            state = "guest";
            return;
        }

        sessionUserId = int.Parse(Session["userid"].ToString());
        if (sessionUserId == profileUserId)
        {
            state = "myprofile";
            return;
        }
        
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
        connection.Open();
        string query = "select count(*) from Friendships where" + 
            " (user1Id = @sessionUser and user2Id=@profileUser) or" +
            "(user2Id = @sessionUser and user1Id=@profileUser)";
        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@sessionUser", sessionUserId);
        command.Parameters.AddWithValue("@profileUser", profileUserId);
        int result = int.Parse(command.ExecuteScalar().ToString());
        if (result > 0)
        {
            // friends
            state = "friendprofile";
        } 
        else
        {
            // not friends
            state = "nonfriendprofile";
        }
        connection.Close();
    }
    static private int currImageCount = 0;
    private void DisplayMenuItems()
    {
        DataList1.Visible = false;
        LabelFR.Visible = false;
        if (state=="guest")
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
            ButtonAdd.Visible = false;
        }
        else
        {
            HomeB.Visible = true;
            HomeB.PostBackUrl = "ProfileDetails.aspx?userid="+sessionUserId.ToString();
            PeopleB.Visible = true;
            PeopleB.PostBackUrl = "People.aspx";
            MyFriendsB.Visible = true;
            MyFriendsB.PostBackUrl = "Friends.aspx";
            GroupsB.Visible = true;
            GroupsB.PostBackUrl = "Groups.aspx";
            MyGroupsB.Visible = true;
            MyGroupsB.PostBackUrl = "MyGroups.aspx";
            LogoutB.Visible = true;
            if (state == "nonfriendprofile")
                ButtonAdd.Visible = true;
            else
                ButtonAdd.Visible = false; 
        }
       if (state == "myprofile")
        {
            DataList1.Visible = true;
            LabelFR.Visible = true;
        }
    }

    void SetUpMessages()
    {
        if (!(state == "friendprofile" || state == "nonfriendprofile"))
        {
            LabelMsg.Visible = false;
            TextBoxMain.Visible = false;
            TextBoxSend.Visible = false;
            ButtonSendMsg.Visible = false;
            return;
        }
        LabelMsg.Visible = true;
        TextBoxMain.Visible = true;
        TextBoxSend.Visible = true;
        ButtonSendMsg.Visible = true;
        string allMessages = ff.GetAllMessages(sessionUserId, profileUserId);
        TextBoxMain.Text = allMessages;
        
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        InitUsersAndState();

        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
        connection.Open();
        string query = "select ImagePath from Users where Id = '" + profileUserId + "'";
        SqlCommand command = new SqlCommand(query, connection);
        string imagePath = command.ExecuteScalar().ToString();
        ProfilePicture.ImageUrl = "~/Images/" + imagePath;
        connection.Close();

        DisplayMenuItems();
       
        SetUpMessages();
        ff.GetPicturesOfUser(profileUserId, ref myPicturesPaths,ref myPicturesIds);
        
        myCommentsList = new List<string>();
        if (myPicturesIds != null)
        {
            foreach (int id in myPicturesIds)
            {
                myCommentsList.Add(ff.GetCommentsOfImg(id));
            }
        }
        
        DisplayMyPictures();
    }
    void DisplayMyPictures()
    {
        FileUploadImages.Visible = false; ButtonAddImage.Visible = false;
        ButtonDelete.Visible = false;
        if (state=="myprofile")
        {
            FileUploadImages.Visible = true; ButtonAddImage.Visible = true;
            ButtonDelete.Visible = true;
        }
        if (myPicturesPaths == null ||
            myPicturesPaths.Count == 0 ||
            currImageCount < 0 || currImageCount >= myPicturesPaths.Count)
        {
            currImageCount = 0;
            ImageMain.ImageUrl = null;
            return;
        }
        ImageMain.ImageUrl = "~/Images/" + myPicturesPaths[currImageCount];
        Literal1.Text = "Picture: " + (currImageCount+1).ToString() + "/"
            + myPicturesPaths.Count.ToString();
        TextBoxComments.Text = myCommentsList[currImageCount];
    }

    protected void ButtonAdd_Click(object sender, EventArgs e)
    {
        ff.AddFriendRequest(sessionUserId, profileUserId);
        ButtonAdd.Text = "Friend Request Sent";
        ButtonAdd.OnClientClick = null;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("FriendshipsDb.aspx");
           
    }


    protected void LogoutB_Click(object sender, EventArgs e)
    {
        Session["userid"] = null;
        Response.Redirect("Login.aspx");
    }

    protected void ImageButton1_Click(object sender, CommandEventArgs e)
    {
        string id = e.CommandArgument.ToString();
        Response.Redirect("ProfileDetails.aspx?userid=" + id);
    }

    protected void ButtonAccept_Click(object sender, CommandEventArgs e)
    {
        int fromUser = int.Parse(e.CommandArgument.ToString());
        // accept user proposal
        // 1. delete entry in requests table and rebound data list
        // 2. add friendship to the friendships table
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
        connection.Open();
        // 1.
        string query1 = "delete from FriendRequests where UserSent = @s and UserReceived = @r";
        SqlCommand command1 = new SqlCommand(query1, connection);
        command1.Parameters.AddWithValue("@s", fromUser);
        command1.Parameters.AddWithValue("@r", sessionUserId);
        command1.ExecuteNonQuery();
        DataList1.DataBind();
        connection.Close();
        // 2.
        connection.Open();
        string query2 = "insert into Friendships (User1Id, User2Id) values(@u1, @u2)";
        SqlCommand command2 = new SqlCommand(query2, connection);
        command2.Parameters.AddWithValue("@u1", fromUser);
        command2.Parameters.AddWithValue("@u2", sessionUserId);
        command2.ExecuteNonQuery();

        connection.Close();
    }

    protected void ButtonDecline_Click(object sender, CommandEventArgs e)
    {
        int fromUser = int.Parse(e.CommandArgument.ToString());
        // decline user proposal
        // 1. delete entry in requests table and rebound data list
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
        connection.Open();
        string query1 = "delete from FriendRequests where UserSent = @s and UserReceived = @r";
        SqlCommand command1 = new SqlCommand(query1, connection);
        command1.Parameters.AddWithValue("@s", fromUser);
        command1.Parameters.AddWithValue("@r", sessionUserId);
        command1.ExecuteNonQuery();
        DataList1.DataBind();

        connection.Close();

    }


    protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void ButtonSendMsg_Click(object sender, EventArgs e)
    {
        string message = TextBoxSend.Text.ToString();
        ff.AddMessage(sessionUserId, profileUserId, message);
        TextBoxSend.Text = "";
        Response.Redirect("ProfileDetails.aspx?userid=" + profileUserId.ToString());
    }

    protected void ButtonAddImage_Click(object sender, EventArgs e)
    {
        string filePath = FileUploadImages.FileName.ToString();
        ff.AddImage(sessionUserId, filePath);
        Reload();
    }
    void Reload()
    {
        Response.Redirect("ProfileDetails.aspx?userid=" + profileUserId.ToString());
    }

    protected void ImageButtonLeft_Click(object sender, ImageClickEventArgs e)
    {
        currImageCount--;
        if (currImageCount < 0)
            currImageCount = 0;
        Reload();
    }

    protected void ImageButtonRight_Click(object sender, ImageClickEventArgs e)
    {
        currImageCount++;
        if (currImageCount >= myPicturesPaths.Count)
        {
            currImageCount = myPicturesPaths.Count - 1;
        }
        Reload();
    }

    protected void Button1_Click1(object sender, EventArgs e)
    {
        if (currImageCount < 0 || myPicturesPaths.Count == 0) return;
        ff.DeletePicture(myPicturesIds[currImageCount]);
        Reload();
    }

    protected void ButtonSubComment_Click(object sender, EventArgs e)
    {
       
        string text = TextBoxSubComment.Text.ToString();
        ff.AddComment(myPicturesIds[currImageCount], text, sessionUserId);
        Reload();
    }

    protected void TextBoxSend_TextChanged(object sender, EventArgs e)
    {

    }
}
