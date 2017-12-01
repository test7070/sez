<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
    	//國泰世華 
        public class ParaIn
        {
            public string bgqbno;
            public string egqbno;
            public string fontsize = "14";
        }
        
        public class Para
        {
            public string a01;//日期
            public string a02;//受款人
            public string a03;//金額
            public string a04;//金額下方備註

            public string b01;//年
            public string b02;//月
            public string b03;//日
            public string b04;//憑票支付
            public string b05;//NT
            public string b06;//新台幣
        }
        
        System.IO.MemoryStream stream = new System.IO.MemoryStream();
        string connectionString = "";
        public void Page_Load()
        {
        	string db = "dc";
        	if(Request.QueryString["db"] !=null && Request.QueryString["db"].Length>0)
        		db= Request.QueryString["db"];
        	connectionString = "Data Source=nt3,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database="+db;

			var item = new ParaIn();
            if (Request.QueryString["bno"] != null && Request.QueryString["bno"].Length > 0)
            {
                item.bgqbno = Request.QueryString["bno"];
            }
            if (Request.QueryString["eno"] != null && Request.QueryString["eno"].Length > 0)
            {
                item.egqbno = Request.QueryString["eno"];
            }
            if (Request.QueryString["fontsize"] != null && Request.QueryString["fontsize"].Length > 0)
            {
                item.fontsize = Request.QueryString["fontsize"];
            }

            //資料
            System.Data.DataTable dt = new System.Data.DataTable();
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(connectionString))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString = @"declare @tmps table(
		gno nvarchar(3),
		noa nvarchar(20),
		gqbno nvarchar(20),
		compno nvarchar(20),
		comp nvarchar(50),
		datea nvarchar(10),
		[money] float,
		cmoney1 nvarchar(20),
		cmoney2  nvarchar(20),
		memo nvarchar(max),
		indate nvarchar(20)
	)
	insert into @tmps 
	select '0',noa,gqbno,tcompno,tcomp,indate,isnull([money],0),'','',case when LEN(comp)>0 then comp else memo end,indate 
	from gqb where (gqbno between @t_bgqbno and @t_egqbno) order by gqbno
	------------------------------------------------------------------------------
	declare @string nvarchar(max)
	set @string='壹貳參肆伍陸柒捌玖'
	
	declare @gqbno nvarchar(20)
	declare @money int
	declare @result nvarchar(max)
	declare @tmp nvarchar(4)
	declare @n int
	declare @cmoney nvarchar(max)
	
	declare cursor_table cursor for
	select gqbno,[money]  from  @tmps
	open cursor_table
	fetch next from cursor_table
	into @gqbno,@money
	while(@@FETCH_STATUS <> -1)
	begin
		set @result = ''
		set @cmoney = CAST(@money as nvarchar)
		set @n=0
		
		if @n=0
		begin
			if(@money=0)
				set @result = '零元整'
			else
				set @result = '元整'
		end
		while LEN(@cmoney)>0
		begin
			set @tmp = REVERSE(LEFT(REVERSE(@cmoney),4))
			if @n=1 
				set @result = '萬'+@result
			if @n=2
				set @result = '億'+@result
			set @result  =  substring(@string,CAST(@tmp as int)%10,1)+@result 
			---------------------------------------------------------------------
			if CAST(@tmp as int)=10 or  floor(CAST(@tmp as int)%100/10)!=0
				set @result = '拾'+@result
			set @result  =  substring(@string,floor((CAST(@tmp as int)%100)/10),1)+@result 
			---------------------------------------------------------------------
			if floor((CAST(@tmp as int)%100)/10)=0 and floor((CAST(@tmp as int)%1000)/100)!=0  and  not(CAST(@tmp as int)%100=0)     
				set @result = '零'+@result
			---------------------------------------------------------------------
			if CAST(@tmp as int)=100 or  floor(CAST(@tmp as int)%1000/100)!=0
				set @result = '佰'+@result
			set @result  =  substring(@string,floor((CAST(@tmp as int)%1000)/100),1)+@result 
			---------------------------------------------------------------------
			if  floor((CAST(@tmp as int)%1000)/100)=0 and floor((CAST(@tmp as int)%10000)/1000)!=0 and  not(CAST(@tmp as int)%1000=0)    
				set @result = '零'+@result	
			---------------------------------------------------------------------
			if CAST(@tmp as int)=1000 or  floor(CAST(@tmp as int)%10000/1000)!=0
				set @result = '仟'+@result
			set @result  =  substring(@string,floor((CAST(@tmp as int)%10000)/1000),1)+@result 
			if(LEN(@cmoney)<=4)
			begin
				set  @cmoney = ''
			end
			else
			begin
				set @cmoney = REVERSE(SUBSTRING(REVERSE(@cmoney),5,LEN(@cmoney)-4))
				set @n=@n+1
			end	
		end
		
		update @tmps set cmoney1=reverse(substring(reverse(convert(nvarchar(15),CONVERT(money,@money),1)),4,12))
		,cmoney2=@result  where  gqbno=@gqbno
		
		fetch next from cursor_table
		into @gqbno,@money
	end
	close cursor_table
	deallocate cursor_table
	
	declare @memo nvarchar(max)
	declare @tmpString nvarchar(max)
	declare @maxcount int
	set @maxcount = 10--顯示的個數 (全形2,半形1)
	
	declare cursor_table cursor for
	select gqbno,memo from  @tmps
	open cursor_table
	fetch next from cursor_table
	into @gqbno,@memo
	while(@@FETCH_STATUS <> -1)
	begin
		select @string = @memo,@tmpString='',@n = 0
		while(LEN(@string)>0)
		begin
			set @n = @n + case when UNICODE(LEFT(@string,1))>5000 then 2 else 1 end	
			if(@n<=@maxcount)
			begin
				set @tmpString = @tmpString + LEFT(@string,1)
				set @string = substring(@string,2,len(@string)-1)
			end
			else
			begin
				set @string=''
			end
		end
		update @tmps set memo=@tmpString where gqbno=@gqbno
		
		fetch next from cursor_table
		into @gqbno,@memo
	end
	close cursor_table
	deallocate cursor_table
	
	select datea a01
		,case when len(ISNULL(b.nick,''))>0 then b.nick else left(a.comp,4)end a02
		,a.cmoney1 a03
		,a.memo a04
		,LEFT(a.indate,3) b01
		,SUBSTRING(a.indate,5,2) b02
		,RIGHT(a.indate,2) b03
		,a.comp b04
		,a.cmoney1 b05
		,a.cmoney2 b06
	from @tmps a
	left join tgg b on a.compno=b.noa
	order  by  gqbno,gno;";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.Parameters.AddWithValue("@t_bgqbno", item.bgqbno);
                cmd.Parameters.AddWithValue("@t_egqbno", item.egqbno);
                adapter.SelectCommand = cmd;
                adapter.Fill(dt);
                connSource.Close();
            }
            ArrayList gqbLabel = new ArrayList();
            foreach (System.Data.DataRow r in dt.Rows)
            {
                Para pa = new Para();
                pa.a01 = System.DBNull.Value.Equals(r.ItemArray[0]) ? "" : (System.String)r.ItemArray[0];
                pa.a02 = System.DBNull.Value.Equals(r.ItemArray[1]) ? "" : (System.String)r.ItemArray[1];
                pa.a03 = System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2];
                pa.a04 = System.DBNull.Value.Equals(r.ItemArray[3]) ? "" : (System.String)r.ItemArray[3];
                pa.b01 = System.DBNull.Value.Equals(r.ItemArray[4]) ? "" : (System.String)r.ItemArray[4];
                pa.b02 = System.DBNull.Value.Equals(r.ItemArray[5]) ? "" : (System.String)r.ItemArray[5];
                pa.b03 = System.DBNull.Value.Equals(r.ItemArray[6]) ? "" : (System.String)r.ItemArray[6];
                pa.b04 = System.DBNull.Value.Equals(r.ItemArray[7]) ? "" : (System.String)r.ItemArray[7];
                pa.b05 = System.DBNull.Value.Equals(r.ItemArray[8]) ? "" : (System.String)r.ItemArray[8];
                pa.b06 = System.DBNull.Value.Equals(r.ItemArray[9]) ? "" : (System.String)r.ItemArray[9];
                gqbLabel.Add(pa);
            }
            //-----PDF--------------------------------------------------------------------------------------------------
            // W*H  28.3,28.133   21.59*8.5
            int shiftX = -17,shiftY = -8;
            var doc1 = new iTextSharp.text.Document(new iTextSharp.text.Rectangle(611,226), 0, 0, 0, 0);
            iTextSharp.text.pdf.PdfWriter pdfWriter = iTextSharp.text.pdf.PdfWriter.GetInstance(doc1, stream);
            //font
            iTextSharp.text.pdf.BaseFont bfChinese = iTextSharp.text.pdf.BaseFont.CreateFont( (Environment.OSVersion.Version.Major==10 ?@"C:\windows\fonts\msjh.ttc,0" :  @"C:\windows\fonts\msjh.ttf")  , iTextSharp.text.pdf.BaseFont.IDENTITY_H, iTextSharp.text.pdf.BaseFont.NOT_EMBEDDED);
            iTextSharp.text.pdf.BaseFont bfNumber = iTextSharp.text.pdf.BaseFont.CreateFont(@"C:\windows\fonts\ariblk.ttf", iTextSharp.text.pdf.BaseFont.IDENTITY_H, iTextSharp.text.pdf.BaseFont.NOT_EMBEDDED);
            //iTextSharp.text.pdf.BaseFont bfChinese = iTextSharp.text.pdf.BaseFont.CreateFont(@"C:\windows\fonts\DFT_L7.ttf", iTextSharp.text.pdf.BaseFont.IDENTITY_H, iTextSharp.text.pdf.BaseFont.NOT_EMBEDDED);
            //iTextSharp.text.pdf.BaseFont bfNumber = iTextSharp.text.pdf.BaseFont.CreateFont(@"C:\windows\fonts\DFT_L7.ttf", iTextSharp.text.pdf.BaseFont.IDENTITY_H, iTextSharp.text.pdf.BaseFont.NOT_EMBEDDED);
            
            doc1.Open();
            iTextSharp.text.pdf.PdfContentByte cb = pdfWriter.DirectContent;
            if (gqbLabel.Count == 0)
            {
                cb.SetColorFill(iTextSharp.text.BaseColor.RED);
                cb.BeginText();
                cb.SetFontAndSize(bfChinese, 30);
                cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, "無資料", 20, 20, 0);
                cb.EndText();
            }
            else
            {
                for (int i = 0; i < gqbLabel.Count; i++)
                {
                	//shiftY += 1;
                    if (i != 0)
                    {
                        //Insert page
                        doc1.NewPage();
                    }
                    
                    //TEXT
                    cb.SetColorFill(iTextSharp.text.BaseColor.BLACK);
                    cb.BeginText();
                    cb.SetFontAndSize(bfChinese, 12);
                    //日期  YYY/MM/DD
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)gqbLabel[i]).a01, 43 + shiftX, 160 + shiftY, 0);
                    //公司簡稱
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)gqbLabel[i]).a02, 43 + shiftX, 138 + shiftY, 0);
                   	//金額
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)gqbLabel[i]).a03, 43 + shiftX, 112 + shiftY, 0);
                    //備註
                    //cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)gqbLabel[i]).a04, 43 + shiftX, 42 + shiftY, 0);

                    cb.SetFontAndSize(bfChinese, 9);
                    //年
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)gqbLabel[i]).b01, 362 + shiftX, 186 + shiftY, 0);
                    //月
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)gqbLabel[i]).b02, 393 + shiftX, 186 + shiftY, 0);
                    //日
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)gqbLabel[i]).b03, 425 + shiftX, 186 + shiftY, 0);

                    cb.SetFontAndSize(bfChinese, Int32.Parse(item.fontsize));
                    //公司全名
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)gqbLabel[i]).b04, 260 + shiftX, 164 + shiftY, 0);
                    cb.SetFontAndSize(bfChinese, 13);
                    //金額
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)gqbLabel[i]).b05, 255 + shiftX, 120 + shiftY, 0);

                    cb.SetFontAndSize(bfChinese, 13);
                    //金額(大寫)
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)gqbLabel[i]).b06, 260 + shiftX, 140 + shiftY, 0);
                   
                    cb.EndText();
                }
            }
            doc1.Close();
            Response.ContentType = "application/octec-stream;";
            Response.AddHeader("Content-transfer-encoding", "binary");
            Response.AddHeader("Content-Disposition", "attachment;filename=check.pdf");
            Response.BinaryWrite(stream.ToArray());
            Response.End();
        }
    </script>

