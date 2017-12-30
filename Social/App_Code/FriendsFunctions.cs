using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
/// <summary>
/// Summary description for FriendsFunctions
/// </summary>
/// 
public class FriendsFunctions
{
    SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
    public string GetCommentsAtImgAndUser(string path, int userid)
    {
        string result = "";
        int pictureId = GetPictureId(path, userid);
        connection.Open();
        string query = "select Name, Text from Users, CommentsImage  " 
            + " where Users.Id = CommentsImage.UserId and CommentsImage.ImageId = @picid";
        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@picid", pictureId);
        SqlDataReader reader = command.ExecuteReader();
        while (reader.Read())
        {
            string s = String.Format("{0}: {1}", reader[0], reader[1]);
            result += s;
        }
        connection.Close();
        return result;
    }

    public void SetProfileVis(int userid, string what)
    {
        connection.Open();
        string query = "update Users set UserVis = @wh where Id=@myid";
            

        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@myid", userid);
        command.Parameters.AddWithValue("@wh", what);

        command.ExecuteNonQuery();
        connection.Close();
    }
    public bool IsProfilePrivate(int userid)
    {
        connection.Open();
        string query = "select UserVis from Users where Id=@myid";


        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@myid", userid);
        var res = command.ExecuteScalar();
        connection.Close();
        if (res.ToString() == "Private")
        {
            return true; // it's public
        }
        return false;               
       
    }
    public void DeleteProfile(int userid)
    {
        connection.Open();
        string query = "delete from Users where Id=@myid";


        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@myid", userid);
        command.ExecuteNonQuery();
        connection.Close();
    }
    public bool IsUserAdmin(int userid)
    {
        connection.Open();
        string query = "select Admin from Users where Id=@myid";


        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@myid", userid);
        var res = command.ExecuteScalar();
        connection.Close();
        if (res.ToString() == "Admin")
        {
            return true;
        }
        return false;

    }
    public void AddComment(int imgid, string text, int userid)
    {
        connection.Open();
        string query = "insert into CommentsImage (Text, ImageId, UserId)" + 
            " values(@txt, @img, @usr)";

        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@txt", text);
        command.Parameters.AddWithValue("@img", imgid);
        command.Parameters.AddWithValue("@usr", userid);
        command.ExecuteNonQuery();
        connection.Close();
       
    }
    public int GetPictureId(string filePath, int userid)
    {
        connection.Open();
        string query = "select Id from Images where ImagePath=@path and UserId=@id";

        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@id", userid);
        command.Parameters.AddWithValue("@path", filePath);
        int id = int.Parse(command.ExecuteScalar().ToString());
        connection.Close();
        return id;
    }
    public void DeletePicture(int imgId)
    {
        connection.Open();
        string query = "delete from Images where Id=@imgId";

        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@imgId", imgId);
        command.ExecuteNonQuery();
        connection.Close();
    }
    public string GetCommentsOfImg(int imgId)
    {
        string res = "";
        connection.Open();
        string query = "select Name, Text from Users, CommentsImage  "
           + " where Users.Id = CommentsImage.UserId and CommentsImage.ImageId = @picid";

        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@picid", imgId);
        SqlDataReader reader = command.ExecuteReader();
        while (reader.Read())
        {
            res+=String.Format("{0}: {1}\n", reader[0], reader[1]);
        }
        connection.Close();
        return res;            
    }
    public  void GetPicturesOfUser(int userid, ref List<string> paths, ref List<int> ids)
    {
        paths = new List<string>();
        ids = new List<int>();

        connection.Open();
        SqlCommand c1 = new SqlCommand("select count(*) from Images", connection);
        int re = int.Parse(c1.ExecuteScalar().ToString());
        connection.Close();
        connection.Open();
        string query = "select ImagePath, Id from Images where UserId = @id";

        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@id", userid);
        SqlDataReader reader = command.ExecuteReader();

        
        if (reader.FieldCount!=0)
        {
            while (reader.Read())
            {
                if (reader[0]!=null)
                paths.Add(String.Format("{0}", reader[0].ToString()));
                if (reader[1]!=null)
                ids.Add(int.Parse(reader[1].ToString()));
            }
        }
       
        connection.Close();
    }

    public void AddImage(int userid, string filePath)
    {
        connection.Open();
        string query = "insert into Images (UserId, ImagePath) values(@id, @path)";

        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@id", userid);
        command.Parameters.AddWithValue("@path", filePath);
        command.ExecuteNonQuery();
        connection.Close();
    }

    public string GetAllMessages(int from, int to)
    {
        string all = "";
        connection.Open();
        string query = "select Messages.Text, Users.Name from Messages, Users where " +
            " Messages.userSentId = Users.Id and "
            + " ((Messages.userSentId=@u1 and Messages.userReceivedId=@u2) or  " +
              "(Messages.userSentId=@u2 and Messages.userReceivedId=@u1))";
        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@u1", from);
        command.Parameters.AddWithValue("@u2", to);
        SqlDataReader reader = command.ExecuteReader();
        while (reader.Read())
        {
            string s = String.Format("{0}: {1}", reader[1], reader[0]);
            all += s+"\n";   
        }
        connection.Close();
        return all;   
    }
    public void AddMessage(int from, int to, string message)
    {
        connection.Open();
        string query = "insert into Messages (userSentId, userReceivedId, Text) " +
            " values(@us, @ur, @t)";
        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@us", from);
        command.Parameters.AddWithValue("@ur", to);
        command.Parameters.AddWithValue("@t", message);
        // command.Parameters.AddWithValue("@d", DateTime.Now);
        command.ExecuteNonQuery();
        connection.Close();
    }
    public void AddFriendRequest(int id1, int id2)
    {
        connection.Open();
        string q = "insert into FriendRequests (UserSent, UserReceived, State) values(@u1, @u2, @s)";
        SqlCommand c = new SqlCommand(q, connection);
        c.Parameters.AddWithValue("@u1", id1);
        c.Parameters.AddWithValue("@u2", id2);
        c.Parameters.AddWithValue("@s", "pending");
        c.ExecuteNonQuery();
        connection.Close();
    }
    public bool AreFriends(int userid1, int userid2)
    {
        connection.Open();
        string query = "select count(*) from Friendships where (User1Id=@u1 and User2Id=@u2) " +
            " or (User1Id=@u2 and User2Id=@u1)";
        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@u1", userid1);
        command.Parameters.AddWithValue("@u2", userid2);
        int result = int.Parse(command.ExecuteScalar().ToString());

        connection.Close();
        if (result != 0)
            return true;
        else
            return false;
    }
    public bool HasInvited(int userid1, int userid2)
    {
        connection.Open();
        string query = "select count(*) from FriendRequests where (UserSent=@u1 and UserReceived=@u2) ";
        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@u1", userid1);
        command.Parameters.AddWithValue("@u2", userid2);
        int result = int.Parse(command.ExecuteScalar().ToString());

        connection.Close();
        if (result != 0)
            return true;
        else
            return false;
    }
}