 <%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        public class ParaIn
        {
            public string userno, namea, carno, datea, gpsdata;
            //使用者帳號,名稱,車牌,日期,gps位置(時間1^lat1,lng1#時間2^lat2,lng2)
        }
    
        public void Page_Load()
        {
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            Response.ContentEncoding = encoding;
            int formSize = Request.TotalBytes;
            byte[] formData = Request.BinaryRead(formSize);
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            string t_out = "";
            System.Data.DataTable dt = new System.Data.DataTable();
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
                    para.carno = "000-00"; //車牌
                    para.datea = "2017/01/01"; //日期
                    para.gpsdata = "00:00^22.6687286,120.3082085";  // gps位置
	                itemIn = para;
	            }
	             
				string DCConnectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=" + t_db;
	                
                using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(DCConnectionString))
                {
                    System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                    connSource.Open();

                    string queryString = @"
                        declare @t_userno nvarchar(50)= @userno
                        declare @t_namea nvarchar(50)= @namea
                        declare @t_carno nvarchar(50)= @carno
                        declare @t_datea nvarchar(50)= @datea
                        declare @t_gpsdata nvarchar(MAX)= @gpsdata
                        
                        declare @t_udate nvarchar(50)= CONVERT (VARCHAR(20), GETDATE(),20 ) --上傳日期
                        
                        declare @t_err nvarchar(50)='上傳失敗，請確定網路是否正常!!'

                        IF OBJECT_ID('tempdb..#bbm')is not null
                        BEGIN
	                        drop table #bbm
                        END

                        create table #bbm(
	                        noa nvarchar(50),
	                        latitude nvarchar(50),
	                        longitude nvarchar(50),
	                        carno nvarchar(50),
	                        driverno nvarchar(50),
	                        driver nvarchar(50),
	                        datea nvarchar(50),
	                        timea nvarchar(50),
	                        updatea nvarchar(50)
                        )

                        BEGIN TRY
	                        --處理單位換算
	                        if(len(@t_gpsdata)>0)
	                        begin
		                        declare @str nvarchar(MAX)=@t_gpsdata+'#'
		                        declare @str2 nvarchar(MAX)=''
		                        declare @timea nvarchar(50)=''
		                        declare @lat nvarchar(50)=''
		                        declare @long nvarchar(50)='' 
		
		                        while(LEN(@str)>0)
		                        begin
			                        set @str2=dbo.split(@str,'#',0)
			                        set @timea=dbo.split(dbo.split(@str2,'#',1),'^',0)
			                        set @lat=dbo.split(dbo.split(dbo.split(@str2,'#',1),'^',1),',',0)
			                        set @long=dbo.split(dbo.split(dbo.split(@str2,'#',1),'^',1),',',1)
			
			                        insert #bbm(noa,latitude,longitude,carno,driverno,driver,datea,timea,updatea)
			                        select '',@lat,@long,@t_carno,@t_userno,@t_namea,@t_datea,@timea,@t_udate
			
			                        set @str=SUBSTRING(@str,CHARINDEX('#',@str)+1,LEN(@str))
		                        end
	                        end

	                        if((select count(*) from #bbm)>0)
	                        begin
								insert location(noa,latitude,longitude,carno,driverno,driver,datea,timea,updatea)
		                        select noa,latitude,longitude,carno,driverno,driver,datea,timea,updatea from #bbm
		                        
		                        set @t_err=''
	                        end
                        END TRY
                        BEGIN CATCH
                        END CATCH

                        select @t_err

                        IF OBJECT_ID('tempdb..#bbm')is not null
                        BEGIN
	                        drop table #bbm
                        END
					";
					
					System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                    cmd.Parameters.AddWithValue("@userno", itemIn.userno);
                    cmd.Parameters.AddWithValue("@namea", itemIn.namea);
                    cmd.Parameters.AddWithValue("@carno", itemIn.carno);
                    cmd.Parameters.AddWithValue("@datea", itemIn.datea);
                    cmd.Parameters.AddWithValue("@gpsdata", itemIn.gpsdata);
					//cmd.ExecuteNonQuery();
                    adapter.SelectCommand = cmd;
                    adapter.Fill(dt);
					connSource.Close();
				}
				
	            foreach (System.Data.DataRow r in dt.Rows)
	            {
                    t_out=System.DBNull.Value.Equals(r.ItemArray[0]) ? "" : (System.String)r.ItemArray[0];
	            }

                t_out = (itemIn.gpsdata.Length == 0 ? "" : t_out);
				
            }
            catch (Exception ex) {
                t_out = "Error=" + ex.Message + "\r\n" + ex.StackTrace;
            }
            
            Response.Write(t_out);
        }
    </script>

