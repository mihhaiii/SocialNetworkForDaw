using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ButtonRegister_Click(object sender, EventArgs e)
    {
        string enteredName = TextBoxName.Text.ToString().Replace(" ", "");
        string enteredSurname = TextBoxSurname.Text.ToString().Replace(" ", "");
        string enteredEmail = TextBoxEmail.Text.ToString().Replace(" ", "");
        string enteredPassword = TextBoxPass.Text.ToString().Replace(" ", "");
        string enteredSex = RadioButtonListSex.SelectedValue.ToString().Replace(" ", "");
        string enteredImagePath = FileUploadPicture.FileName.ToString().Replace(" ", "");

        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
        connection.Open();
        string query = "select count(*) from Users where Email ='" + enteredEmail + "'";
        SqlCommand c1 = new SqlCommand(query, connection);
        int countUsers = int.Parse(c1.ExecuteScalar().ToString());
        connection.Close();
        if (countUsers != 0)
        {
            Response.Write("user already exists");
        }
        else
        {
            connection.Open();
            string iq = "insert into Users (Name, Surname, Email, Password, Sex, ImagePath) "
                + " values(@name, @surname, @email, @password, @sex, @imagePath) ";
            SqlCommand cq = new SqlCommand(iq, connection);
            //cq.Parameters.AddWithValue("@id", new Guid().ToString());
            cq.Parameters.AddWithValue("@name", enteredName);
            cq.Parameters.AddWithValue("@surname", enteredSurname);
            cq.Parameters.AddWithValue("@email", enteredEmail);
            cq.Parameters.AddWithValue("@password", enteredPassword);
            cq.Parameters.AddWithValue("@sex", enteredSex);
            cq.Parameters.AddWithValue("@imagePath", enteredImagePath);
            cq.ExecuteNonQuery();
            connection.Close();
            Response.Redirect("Database.aspx");
        }
    }

    protected void ButtonLogin_Click(object sender, EventArgs e)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
        connection.Open();

        string enteredLogin = TextBoxUn.Text.ToString().Replace(" ","");
        string enteredPass = TextBoxPassword.Text.ToString().Replace(" ","");

        string query = "select count(*) from Users where Email = '" + enteredLogin + "'";
        SqlCommand command = new SqlCommand(query, connection);
        int usersCount = int.Parse(command.ExecuteScalar().ToString());
        connection.Close();
        if (usersCount == 0)
        {
            // no such user
            Response.Write("log in failed");
        } 
        else
        {
            connection.Open();
            string query1 = "select Password from Users where Email = '" + enteredLogin + "'";
            SqlCommand command1 = new SqlCommand(query1, connection);
            string databasePass = command1.ExecuteScalar().ToString();
            string query2 = "select Id from Users where Email = '" + enteredLogin + "'";
            SqlCommand command2 = new SqlCommand(query2, connection);
            string databaseId = command2.ExecuteScalar().ToString();
            int userId = int.Parse(databaseId);
            connection.Close();
            databasePass.Replace(" ", "");
            if(enteredPass != databasePass)
            {
                Response.Write("log in failed");
            }
            else
            {
                Session["userid"] = databaseId;
                Response.Redirect("ProfileDetails.aspx"+"?userid="+Session["userid"]);
            }
        }
        

    }

    protected void ButtonPeople_Click(object sender, EventArgs e)
    {
        Response.Redirect("People.aspx?who=all");
    }
}