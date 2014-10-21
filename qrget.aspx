<%@ Page Language="C#" Debug="true" %>
    <script language="c#" runat="server">
         public class msg
        {
			public string datea;
			public string timea;
            public string qrcode;
        }
        public void Page_Load()
        {
            Encoding encoding = System.Text.Encoding.UTF8;
            Response.ContentEncoding = encoding;
            int formSize = Request.TotalBytes;
            byte[] formData = Request.BinaryRead(formSize);
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            var item = serializer.Deserialize<msg>(System.Text.Encoding.UTF8.GetString(formData));
            string connstring = "Data Source=59.125.143.171,1799;Network Library=DBMSSOCN;Initial Catalog=ST;User ID=sa;Password=artsql963";      
            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection();
            conn.ConnectionString = connstring;
            string query = "";
            try
            {
                
                conn.Open();
								
                query = "insert cubu"+item.datea.Substring(0,3)+" (noa,noq,datea,uno,memo,productno,storeno,mount,weight,radius,width,dime,lengthb)"
				+"select @datea,right('00'+cast(ROW_NUMBER() over (order by n)+cast(isnull((select MAX(noq) from view_cubu where datea=@datea),'000') as int) as nvarchar(50)),3),@datea"
				+",n,@timea,'','',0,0,0,0,0,0 from dbo.fnSplit(@qrcode)";

                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(query, conn);

                cmd.Parameters.AddWithValue("@datea", item.datea);
				cmd.Parameters.AddWithValue("@timea", item.timea);
				cmd.Parameters.AddWithValue("@qrcode", item.qrcode);
                
                cmd.ExecuteNonQuery();
                
                /*Response.Clear();
                Response.ContentType = "application/text; charset=utf-8";
                Response.Write(item.qrcode + ':' +clientIP);*/
            }
            catch (Exception ex)
            {
                // Get stack trace for the exception with source file information
                var st = new System.Diagnostics.StackTrace(ex, true);
                // Get the top stack frame
                var frame = st.GetFrame(0);
                // Get the line number from the stack frame
                var line = frame.GetFileLineNumber();

                Response.Clear();
                Response.ContentType = "application/text; charset=utf-8";
                Response.Write(line.ToString() + ':' + ex.Message);
            }
            finally
            {
                conn.Close();
            }          
        }
        
    </script>