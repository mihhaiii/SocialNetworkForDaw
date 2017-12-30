using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Anon1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string id = Request.QueryString["userid"].ToString();
        FriendsFunctions ff = new FriendsFunctions();
        ff.AddFriendRequest(int.Parse(Session["userid"].ToString()), int.Parse(id));
        Response.Redirect("People.aspx");
    }
}