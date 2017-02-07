 <%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        public class ParaIn
        {
            public string userno,namea,carno,datea;
        }
        
        public void Page_Load()
        {
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            Response.ContentEncoding = encoding;
            int formSize = Request.TotalBytes;
            byte[] formData = Request.BinaryRead(formSize);
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            string t_out = "";
            try
            {
	            string t_db = HttpUtility.UrlDecode(Request.Headers["database"]);
	            if (t_db == null || t_db.Length == 0)
	                t_db = "dc";
	
	            var itemIn = serializer.Deserialize<ParaIn>(encoding.GetString(formData));
	            if (itemIn == null)
	            {
	                ParaIn para = new ParaIn();

                    para.userno = "Z001";  // 使用者編號
                    para.namea = "軒威電腦";  // 使用者名稱
                    para.carno = "KA-001";  // 車牌
                    para.datea = "106/01/24";  // 日期
                    
	                itemIn = para;
	            }
	             
				string DCConnectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=" + t_db;
	            System.Data.DataTable dt = new System.Data.DataTable();   
                using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(DCConnectionString))
                {
                    System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                    connSource.Open();

                    string queryString = @"
                    	declare @t_userno nvarchar(50)= @userno
                        declare @t_namea nvarchar(50)= @namea
                        declare @t_carno nvarchar(50)= @carno
                        declare @t_datea nvarchar(50)= @datea
                    
						select case when b.chk1=1 then '提貨' else '' end
						+case when b.chk1=1 and b.chk2=1 then ',' else '' end 
						+case when b.chk2=1 then '卸貨' else '' end
						+case when b.noa is null then '回廠' else '' end  task
						,c.datea,a.cust,a.addr,a.product,a.address,a.mount,a.noa,a.noq,a.accy
						from view_tranvccet a 
						left join view_tranvcces b on a.noa=b.noa and a.ordeno=b.ordeno and a.no2=b.no2
						left join view_tranvcce c on a.noa=c.noa
						where isnull(a.enda,0)!=1 and a.carno=@t_carno and c.datea<=@t_datea
					";
					
					System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
					cmd.Parameters.AddWithValue("@userno", itemIn.userno);
                    cmd.Parameters.AddWithValue("@namea", itemIn.namea);
                    cmd.Parameters.AddWithValue("@carno", itemIn.carno);
                    cmd.Parameters.AddWithValue("@datea", itemIn.datea);
					//cmd.ExecuteNonQuery();
                    adapter.SelectCommand = cmd;
                    adapter.Fill(dt);
					connSource.Close();
				}
				t_out = (dt.Rows.Count > 0 ? "" : "無派車任務資料");
				
	            foreach (System.Data.DataRow r in dt.Rows)
	            {
                    Response.Write(System.DBNull.Value.Equals(r.ItemArray[0]) ? "" : (System.String)r.ItemArray[0]+"###");
                    Response.Write(System.DBNull.Value.Equals(r.ItemArray[1]) ? "" : (System.String)r.ItemArray[1]+"###");
                    Response.Write(System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2]+"###");
                    Response.Write(System.DBNull.Value.Equals(r.ItemArray[3]) ? "" : (System.String)r.ItemArray[3]+"###");
                    Response.Write(System.DBNull.Value.Equals(r.ItemArray[4]) ? "" : (System.String)r.ItemArray[4]+"###");
                    Response.Write(System.DBNull.Value.Equals(r.ItemArray[5]) ? "" : (System.String)r.ItemArray[5]+"###");
                    Response.Write(System.DBNull.Value.Equals(r.ItemArray[6]) ? "" : r.ItemArray[6].ToString()+"###");
                    Response.Write(System.DBNull.Value.Equals(r.ItemArray[7]) ? "" : (System.String)r.ItemArray[7]+"###");
                    Response.Write(System.DBNull.Value.Equals(r.ItemArray[8]) ? "" : (System.String)r.ItemArray[8]+"###");
                    Response.Write(System.DBNull.Value.Equals(r.ItemArray[9]) ? "" : (System.String)r.ItemArray[9]);
                    
                    Response.Write("<BR>");
	            }
				
            }
            catch (Exception ex) {
                t_out = "Error=" + ex.Message + "\r\n" + ex.StackTrace;
            }
            Response.Write(t_out);
        }
    </script>