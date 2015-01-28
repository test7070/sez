<%@ Page Language="C#" Debug="true" %>
    <script language="c#" runat="server">
        public void Page_Load()
        {
            string source = Request.QueryString["source"];
            string catalog = Request.QueryString["catalog"];
            string tablea = Request.QueryString["tablea"];
            string fielda = Request.QueryString["field"];
            string swhere = Request.QueryString["swhere"];

            string connstring = "Data Source=" + source + ",1799;Network Library=DBMSSOCN;Initial Catalog=" + catalog + ";User ID=sa;Password=artsql963";
            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection();
            conn.ConnectionString = connstring;
            try
            {
                conn.Open();
                string query ="";
                if (swhere == null)
                {
                    if (fielda == null)
                        query = "select * from " + tablea;
                    else
                        query = "select " + fielda + " from " + tablea;
                }
                else
                {
                    if (fielda == null)
                        query = "select * from " + tablea + "where=" + swhere;
                    else
                        query = "select " + fielda + " from " + tablea + "where=" + swhere;
                }
                
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(query, conn); 
                //cmd.ExecuteNonQuery();
                System.Data.SqlClient.SqlDataReader dr = cmd.ExecuteReader();
                
                Response.Clear();
                Response.ContentType = "application/text; charset=utf-8";
                while (dr.Read())
                {
                    for (int i = 0; i < dr.FieldCount; i++)
                    {
                        Response.Write(dr[i].ToString()+"^^");
                    }
                    Response.Write("<BR>");
                }
            }
            catch (Exception ex)
            {
                Response.Clear();
                Response.Write("error!!");
            }
            finally
            {
                conn.Close();
            }          
        }
        
    </script>
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
    <head>
        <meta charset="utf-8">
        <title>android Read</title>

    </head>
    <body>

    </body>
</html>