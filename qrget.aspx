<%@ Page Language="C#" Debug="true" %>
    <script language="c#" runat="server">
         public class msg
        {
        	public string worker;
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
                
                /*判斷機台 並寫入入庫時間 目前只有5個機台*/
                query = "update b set time5=(case when right(n,2)='-5' then @datea+' '+@timea else time5 end) ,worker5=(case when right(n,2)='-5' then @worker else worker5 end) ";
                query += ",time4=(case when right(n,2)='-4' then @datea+' '+@timea else time4 end),worker4=(case when right(n,2)='-4' then @worker else worker4 end) ";
                query += ",time3=(case when right(n,2)='-3' then @datea+' '+@timea else time3 end),worker3=(case when right(n,2)='-3' then @worker else worker3 end) ";
                query += ",time2=(case when right(n,2)='-2' then @datea+' '+@timea else time2 end),worker2=(case when right(n,2)='-2' then @worker else worker2 end) ";
                query += ",time1=(case when right(n,2) not in ('-2','-3','-4','-5') then @datea+' '+@timea else time1 end)";
                query += ",worker1=(case when right(n,2) not in ('-2','-3','-4','-5') then @worker else worker1 end)";
                query += " from dbo.fnSplit(@qrcode) a left join workjs b on a.n like b.noa+'-'+b.noq+'%' where b.noa!=''";
                
                /*query = "insert cubu"+item.datea.Substring(0,3)+" (noa,noq,datea,uno,worker,productno,product,storeno,store,mount,weight,radius,width,dime,lengthb,b.memo)"
				+"select b.noa,right('00'+cast(ROW_NUMBER() over (order by n)+cast(isnull((select MAX(noq) from view_cubu where noa=b.noa),'000') as int) as nvarchar(50)),3),@datea"
				+",a.n,@timea,b.productno,b.product,'','',b.mount,b.weight,0,0,0,b.lengthb,b.memo from dbo.fnSplit(@qrcode) a left join workjs b on a.n=b.noa+'-'+b.noq";*/

                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(query, conn);

				cmd.Parameters.AddWithValue("@worker", item.worker);
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