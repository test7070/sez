<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        
        public class Para
        {
            public string barcode, bag, serial, nick, addr, tel, station;
        }
        
        System.IO.MemoryStream stream = new System.IO.MemoryStream();
        string connectionString="";
        public void Page_Load()
        {
        	string db = "dc";
        	if(Request.QueryString["db"] !=null && Request.QueryString["db"].Length>0)
        		db= Request.QueryString["db"];
        	connectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database="+db;
            //參數
            string bno = "", eno ="";
            if (Request.QueryString["bno"] != null && Request.QueryString["bno"].Length > 0)
            {
                bno = Request.QueryString["bno"];
            }
            if (Request.QueryString["eno"] != null && Request.QueryString["eno"].Length > 0)
            {
                eno = Request.QueryString["eno"];
            }
            //資料
            System.Data.DataTable dt = new System.Data.DataTable();
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(connectionString))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString = @"declare @list table(
		                barcode nvarchar(20)
	                )
	                declare @n int = 300
	                declare @str nvarchar(20) = @bno
	                while @str<=@eno
	                begin
		                insert into @list(barcode)values(@str)
		                set @str = '97'+right('00000000'+cast(cast(left(right(@str,8),7) as int)+1 as nvarchar(10)),7)
		                set @str = @str+cast(cast(@str as int )% 6 as nvarchar(10))
		                
		                set @n = @n-1
		                if(@n<0)
			                break
	                end
	                select c.barcode
		                ,a.deliveryno bag 
                        ,b.serial serial
                        ,b.nick nick
                        ,b.addr_comp addr
                        ,b.tel tel
                        ,b.addr_fact station
                    from view_tranorde a
	                left join cust b on a.custno=b.noa
	                left join @list c on c.barcode between a.docketno1 and a.docketno2
	                where c.barcode is not null
	                and len(ISNULL(a.docketno1,''))>0
	                order by c.barcode
	                
	                declare @accy nvarchar(20)=isnull((select top 1 b.accy from @list a left join view_transef b on a.barcode=b.boatname and isnull(b.accy,'')!='' order by accy desc),'')
	                if(@accy!='')
						EXEC('update transef'+@accy+' set io=''已列印'' where boatname between '''+@bno+''' and '''+@eno+'''')
	                
	                ";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.Parameters.AddWithValue("@bno", bno);
                cmd.Parameters.AddWithValue("@eno", eno);
                adapter.SelectCommand = cmd;
                adapter.Fill(dt);
                connSource.Close();
            }
            ArrayList barcode = new ArrayList();
            foreach (System.Data.DataRow r in dt.Rows)
            {
                Para pa = new Para();
                pa.barcode = System.DBNull.Value.Equals(r.ItemArray[0]) ? "" : (System.String)r.ItemArray[0];
                pa.bag = System.DBNull.Value.Equals(r.ItemArray[1]) ? "" : (System.String)r.ItemArray[1];
                pa.serial = System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2];
                pa.nick = System.DBNull.Value.Equals(r.ItemArray[3]) ? "" : (System.String)r.ItemArray[3];
                pa.addr = System.DBNull.Value.Equals(r.ItemArray[4]) ? "" : (System.String)r.ItemArray[4];
                pa.tel = System.DBNull.Value.Equals(r.ItemArray[5]) ? "" : (System.String)r.ItemArray[5];
                pa.station = System.DBNull.Value.Equals(r.ItemArray[6]) ? "" : (System.String)r.ItemArray[6];
                barcode.Add(pa);
            }
            //-----PDF--------------------------------------------------------------------------------------------------
            //10*15
            var doc1 = new iTextSharp.text.Document(new iTextSharp.text.Rectangle(283, 425), 5, 5, 0, 0);
            iTextSharp.text.pdf.PdfWriter pdfWriter = iTextSharp.text.pdf.PdfWriter.GetInstance(doc1, stream);
            //font
            iTextSharp.text.pdf.BaseFont bfChinese = iTextSharp.text.pdf.BaseFont.CreateFont(@"C:\windows\fonts\msjh.ttf", iTextSharp.text.pdf.BaseFont.IDENTITY_H, iTextSharp.text.pdf.BaseFont.NOT_EMBEDDED);
            iTextSharp.text.pdf.BaseFont bfNumber = iTextSharp.text.pdf.BaseFont.CreateFont(@"C:\windows\fonts\ariblk.ttf", iTextSharp.text.pdf.BaseFont.IDENTITY_H, iTextSharp.text.pdf.BaseFont.NOT_EMBEDDED);
            doc1.Open();
            iTextSharp.text.pdf.PdfContentByte cb = pdfWriter.DirectContent;
            if (barcode.Count == 0)
            {
                cb.SetColorFill(iTextSharp.text.BaseColor.RED);
                cb.BeginText();
                cb.SetFontAndSize(bfChinese, 50);
                cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, "無資料", 20, 300, 0);
                cb.EndText();
            }else
            {
                
                for (int i = 0; i < barcode.Count; i++)
                {
                    if (i != 0)
                    {
                        //Insert page
                        doc1.NewPage();
                    }
                    cb.SetColorStroke(iTextSharp.text.BaseColor.BLACK);

                    //TEXT
                    cb.SetColorFill(iTextSharp.text.BaseColor.BLACK);
                    cb.BeginText();
                    cb.SetFontAndSize(bfChinese, 20);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)barcode[i]).bag + " 號袋", 50, 396, 0);
                    cb.SetFontAndSize(bfChinese, 16);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)barcode[i]).station, 226, 245, 0);
                    cb.SetFontAndSize(bfChinese, 10);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)barcode[i]).serial, 57, 262, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)barcode[i]).nick, 117, 262, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)barcode[i]).addr, 57, 250, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)barcode[i]).tel, 57, 238, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)barcode[i]).barcode, 150, 170, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)barcode[i]).barcode, 28, 88, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)barcode[i]).serial, 155, 70, 0);
                    cb.EndText();

                    //圖片 97
                    System.IO.MemoryStream img_barcode = new System.IO.MemoryStream();
                    GetCode39(((Para)barcode[i]).barcode).Save(img_barcode, System.Drawing.Imaging.ImageFormat.Bmp);
                    iTextSharp.text.Image img = iTextSharp.text.Image.GetInstance(img_barcode.ToArray());
                    img.SetAbsolutePosition(113, 184);
                    doc1.Add(img);
                }
            }
            doc1.Close();
            Response.ContentType = "application/octec-stream;";
            Response.AddHeader("Content-transfer-encoding", "binary");
            Response.AddHeader("Content-Disposition", "attachment;filename=tranorde.pdf");
            Response.BinaryWrite(stream.ToArray());
            Response.End();
        }

        public System.Drawing.Bitmap GetCode39(string strSource)
        {
            int x = 0; //左邊界
            int y = 0; //上邊界
            int WidLength = 2; //粗BarCode長度
            int NarrowLength = 1; //細BarCode長度
            int BarCodeHeight = 25; //BarCode高度
            int intSourceLength = strSource.Length;
            string strEncode = "010010100"; //編碼字串 初值為 起始符號 *

            string AlphaBet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-. $/+%*"; //Code39的字母

            string[] Code39 = //Code39的各字母對應碼
          {
               /* 0 */ "000110100",
               /* 1 */ "100100001",
               /* 2 */ "001100001",
               /* 3 */ "101100000",
               /* 4 */ "000110001",
               /* 5 */ "100110000",
               /* 6 */ "001110000",
               /* 7 */ "000100101",
               /* 8 */ "100100100",
               /* 9 */ "001100100",
               /* A */ "100001001",
               /* B */ "001001001",
               /* C */ "101001000",
               /* D */ "000011001",
               /* E */ "100011000",
               /* F */ "001011000",
               /* G */ "000001101",
               /* H */ "100001100",
               /* I */ "001001100",
               /* J */ "000011100",
               /* K */ "100000011",
               /* L */ "001000011",
               /* M */ "101000010",
               /* N */ "000010011",
               /* O */ "100010010",
               /* P */ "001010010",
               /* Q */ "000000111",
               /* R */ "100000110",
               /* S */ "001000110",
               /* T */ "000010110",
               /* U */ "110000001",
               /* V */ "011000001",
               /* W */ "111000000",
               /* X */ "010010001",
               /* Y */ "110010000",
               /* Z */ "011010000",
               /* - */ "010000101",
               /* . */ "110000100",
               /*' '*/ "011000100",
               /* $ */ "010101000",
               /* / */ "010100010",
               /* + */ "010001010",
               /* % */ "000101010",
               /* * */ "010010100"
          };


            strSource = strSource.ToUpper();

            //實作圖片
            System.Drawing.Bitmap objBitmap = new System.Drawing.Bitmap(
              ((WidLength * 3 + NarrowLength * 7) * (intSourceLength + 2)) + (x * 2),
              BarCodeHeight + (y * 2));

            System.Drawing.Graphics objGraphics = System.Drawing.Graphics.FromImage(objBitmap); //宣告GDI+繪圖介面
            //填上底色
            objGraphics.FillRectangle(System.Drawing.Brushes.White, 0, 0, objBitmap.Width, objBitmap.Height);

            for (int i = 0; i < intSourceLength; i++)
            {
                if (AlphaBet.IndexOf(strSource[i]) == -1 || strSource[i] == '*') //檢查是否有非法字元
                {
                    objGraphics.DrawString("含有非法字元", System.Drawing.SystemFonts.DefaultFont, System.Drawing.Brushes.Red, x, y);
                    return objBitmap;
                }
                //查表編碼
                strEncode = string.Format("{0}0{1}", strEncode, Code39[AlphaBet.IndexOf(strSource[i])]);
            }

            strEncode = string.Format("{0}0010010100", strEncode); //補上結束符號 *

            int intEncodeLength = strEncode.Length; //編碼後長度
            int intBarWidth;

            for (int i = 0; i < intEncodeLength; i++) //依碼畫出Code39 BarCode
            {
                intBarWidth = strEncode[i] == '1' ? WidLength : NarrowLength;
                objGraphics.FillRectangle(i % 2 == 0 ? System.Drawing.Brushes.Black : System.Drawing.Brushes.White,
                  x, y, intBarWidth, BarCodeHeight);
                x += intBarWidth;
            }
            return objBitmap;
        }
        
    </script>
