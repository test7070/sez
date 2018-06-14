 <%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        public class ParaIn
        {
            public string userno,namea,noa,noq,idno;
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
                    para.noa = "";
                    para.noq = "";
                    para.idno = ""; 
                    
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
                        declare @t_noa nvarchar(50)= @noa
                        declare @t_noq nvarchar(50)= @noq
                        declare @t_idno nvarchar(50)= @idno
                        
                        declare @t_udate nvarchar(50)= CONVERT (VARCHAR(20), GETDATE(),20 ) --上傳日期
                    	
                    	if(@t_idno='1')
                    	begin
                    		update tranvcce
                    		set issend1=1,msg1=@t_udate
                    		where ordeno=@noa and ordenoq=@t_noq
                    	end
                    	
                    	if(@t_idno='2')
                    	begin
                    		update tranvcce
                    		set issend2=1,msg2=@t_udate
                    		where ordeno=@noa and ordenoq=@t_noq
                    	end
                    	
                    	if(@t_idno='3')
                    	begin
                    		update tranvcce
                    		set issend3=1,msg3=@t_udate
                    		where ordeno=@noa and ordenoq=@t_noq
                    	end
                    	
						if(@t_idno='4')
                    	begin
                    		update tranvcce
                    		set issend4=1,msg4=@t_udate
                    		where ordeno=@noa and ordenoq=@t_noq
                    	end
						
					";
					
					System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
					cmd.Parameters.AddWithValue("@userno", itemIn.userno);
                    cmd.Parameters.AddWithValue("@namea", itemIn.namea);
                    cmd.Parameters.AddWithValue("@noa", itemIn.noa);
                    cmd.Parameters.AddWithValue("@noq", itemIn.noq);
                    cmd.Parameters.AddWithValue("@idno", itemIn.idno);
					//cmd.ExecuteNonQuery();
                    adapter.SelectCommand = cmd;
                    adapter.Fill(dt);
					connSource.Close();
				}
				t_out = (dt.Rows.Count > 0 ? "" : "更新成功");
            }
            catch (Exception ex) {
                t_out = "Error=" + ex.Message + "\r\n" + ex.StackTrace;
            }
            Response.Write(t_out);
        }
    </script>