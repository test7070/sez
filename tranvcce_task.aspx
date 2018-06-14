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
                        
                        --領
						select '領' task,date1 datea,cust,straddr addr,product,containerno1 addr,mount,ordeno,ordenoq,'1'idno from tranvcce 
						where carno1=@t_carno and date1<=@t_datea and isnull(isfinish,0)=0 and isnull(issend1,0)=0
						union all
						--送
						select '送' task,date2 datea,cust,straddr addr,product,containerno1 addr,mount,ordeno,ordenoq,'2'idno from tranvcce 
						where cardno2=@t_carno and date2<=@t_datea and isnull(isfinish,0)=0 and isnull(issend2,0)=0
						union all
						--收
						select '收' task,date3 datea,cust,straddr addr,product,containerno1 addr,mount,ordeno,ordenoq,'3'idno from tranvcce 
						where cardno3=@t_carno and date3<=@t_datea and isnull(isfinish,0)=0 and isnull(issend3,0)=0
						union all
						--交
						select '交' task,date4 datea,cust,straddr addr,product,containerno1 addr,mount,ordeno,ordenoq,'4'idno from tranvcce 
						where cardno4=@t_carno and date4<=@t_datea and isnull(isfinish,0)=0 and isnull(issend4,0)=0
						order by datea,ordeno,idno
                    
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