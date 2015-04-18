<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        
        public class Para
        {
            public string bag;
            public string barcode97;
            public string noa, nick, addr, tel, station;
        }

        System.IO.MemoryStream stream = new System.IO.MemoryStream();
        int width = 360, height = 470;//圖片大小
        string connectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=dc";
        public void Page_Load()
        {
            string barcode = "";
            if (Request.QueryString["barcode"] != null && Request.QueryString["barcode"].Length > 0)
            {
                barcode = Request.QueryString["barcode"];
            }
            Type1(barcode);
        }

        public void Type1(string barcode)
        {
            System.Drawing.Bitmap bm = new System.Drawing.Bitmap(width, height);
            System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(bm);
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.None;
            g.TextRenderingHint = System.Drawing.Text.TextRenderingHint.ClearTypeGridFit;
            g.Clear(System.Drawing.Color.White);

            if (barcode.Length == 0)
            {
                bm.Save(stream, System.Drawing.Imaging.ImageFormat.Bmp);

                Response.ContentType = "application/x-msdownload;";
                Response.AddHeader("Content-transfer-encoding", "binary");
                Response.AddHeader("Content-Disposition", "attachment;filename=barcode.bmp");
                Response.BinaryWrite(stream.ToArray());
                Response.End();
                return;
            }
            //資料
            System.Data.DataTable dt = new System.Data.DataTable();
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(connectionString))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString = @"select a.deliveryno bag 
	                    ,b.serial serial
	                    ,b.nick nick
	                    ,b.addr_comp addr
	                    ,b.tel tel
	                    ,b.addr_fact station
                    from view_tranorde a
                    left join cust b on a.custno=b.noa
                    where @barcode97 between docketno1 and docketno2
                    and len(ISNULL(docketno1,''))>0";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.Parameters.AddWithValue("@barcode97", barcode);
                adapter.SelectCommand = cmd;
                adapter.Fill(dt);
                connSource.Close();
            }
            Para pa = new Para();
            pa.barcode97 = barcode;
            foreach (System.Data.DataRow r in dt.Rows)
            {
                pa.bag = System.DBNull.Value.Equals(r.ItemArray[0]) ? "" : (System.String)r.ItemArray[0];
         
                pa.noa = System.DBNull.Value.Equals(r.ItemArray[1]) ? "" : (System.String)r.ItemArray[1];
                pa.nick = System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2];
                pa.addr = System.DBNull.Value.Equals(r.ItemArray[3]) ? "" : (System.String)r.ItemArray[3];
                pa.tel = System.DBNull.Value.Equals(r.ItemArray[4]) ? "" : (System.String)r.ItemArray[4];
                pa.station = System.DBNull.Value.Equals(r.ItemArray[5]) ? "" : (System.String)r.ItemArray[5];
            }
            //外框
            //---橫線
            //g.DrawLine(System.Drawing.Pens.Black, 0, 0, 359, 0);
            //g.DrawLine(System.Drawing.Pens.Black, 0, 559, 359, 559);
            //---直線
            //g.DrawLine(System.Drawing.Pens.Black, 0, 0, 0, 559);
            //g.DrawLine(System.Drawing.Pens.Black, 359, 0, 359, 559);
            
            //置中
            System.Drawing.StringFormat stringFormat = new System.Drawing.StringFormat();
            stringFormat.Alignment = System.Drawing.StringAlignment.Center;
            stringFormat.LineAlignment = System.Drawing.StringAlignment.Center;

            g.DrawString(pa.bag + " 號袋", new System.Drawing.Font("新細明體", 20), System.Drawing.Brushes.Blue, new System.Drawing.PointF(50, 30), stringFormat);

            g.DrawString(pa.noa, new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Black, new System.Drawing.PointF(70, 205));
            g.DrawString(pa.nick, new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Black, new System.Drawing.PointF(145, 205));
            g.DrawString(pa.addr, new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Black, new System.Drawing.PointF(70, 220));
            g.DrawString(pa.tel, new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Black, new System.Drawing.PointF(70, 235));

            g.DrawString(pa.station, new System.Drawing.Font("新細明體", 20), System.Drawing.Brushes.Black, new System.Drawing.PointF(320, 230), stringFormat);

            g.DrawString(pa.barcode97, new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Blue, new System.Drawing.PointF(60, 441), stringFormat);
            g.DrawString(pa.noa, new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Blue, new System.Drawing.PointF(230, 465), stringFormat);
            
            //barcode
            //GetCode(pa.barcode97, ref g, 150, 320);
            //g.DrawImage(barcodeImage97, 130, 300, barcodeImage.Width, barcodeImage.Height);
            //g.DrawString(pa.barcode97, new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Blue, new System.Drawing.PointF(250, 360), stringFormat);
            //bitmap to stream
            bm.Save(stream, System.Drawing.Imaging.ImageFormat.Bmp);
          
            Response.ContentType = "application/x-msdownload;";
            Response.AddHeader("Content-transfer-encoding", "binary");
            Response.AddHeader("Content-Disposition", "attachment;filename=" + pa.barcode97 + ".bmp");
            Response.BinaryWrite(stream.ToArray());
            Response.End();
        }
        public void GetCode(string strSource, ref System.Drawing.Graphics objGraphics, int x, int y)
        {
            //int x = 0; //左邊界
            //int y = 0; //上邊界
            int WidLength = 3; //粗BarCode長度
            int NarrowLength = 1; //細BarCode長度
            int BarCodeHeight = 30; //BarCode高度
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
            for (int i = 0; i < intSourceLength; i++)
            {
                if (AlphaBet.IndexOf(strSource[i]) == -1 || strSource[i] == '*') //檢查是否有非法字元
                {
                    objGraphics.DrawString("含有非法字元", System.Drawing.SystemFonts.DefaultFont, System.Drawing.Brushes.Red, x, y);
                    return;
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
            return;
        }
        
    </script>
