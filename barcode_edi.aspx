<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        
        public class Para
        {
            public string date1, date2;
            public string s1;
            public float s2;//代收款
            public string s3;//到著站;
            public float weight, count;
            public string barcode96;
            public string addressee_line1, addressee_line2, addressee_line3;
            public string memo_line1, memo_line2, memo_line3;
            public string sender_line1, sender_line2, sender_line3;

            public string bag;
            public string barcode97;
        }

        System.IO.MemoryStream stream = new System.IO.MemoryStream();
        int width = 345, height = 345;//圖片大小
        string connectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=dc";
        public void Page_Load()
        {
            string noa = "";
            if (Request.QueryString["noa"] != null && Request.QueryString["noa"].Length > 0)
            {
                noa = Request.QueryString["noa"];
            }
            Type1(noa);
        }
   
        public void Type1(string noa)
        {
            System.Drawing.Bitmap bm = new System.Drawing.Bitmap(width, height);
            System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(bm);
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.None;
            g.TextRenderingHint = System.Drawing.Text.TextRenderingHint.ClearTypeGridFit;
            g.Clear(System.Drawing.Color.White);

            if (noa.Length == 0)
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
                string queryString = @"select top 1 datea,trandate,'' --指定配送
	                                    ,isnull(price,0),accno,[weight],mount,po barcode96
	                                    ,addressee,atel+'  '+boat,caseend+aaddr --zipcode+addr
	                                    ,endaddr memo,straddr,''
	                                    ,custno,comp,boatname barcode97,carno bag
                                    from view_transef
                                    where noa=@noa";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.Parameters.AddWithValue("@noa", noa);
                adapter.SelectCommand = cmd;
                adapter.Fill(dt);
                connSource.Close();
            }
            Para pa = new Para();
            foreach (System.Data.DataRow r in dt.Rows)
            {
                pa.date1 = System.DBNull.Value.Equals(r.ItemArray[0]) ? "" : (System.String)r.ItemArray[0];
                pa.date2 = System.DBNull.Value.Equals(r.ItemArray[1]) ? "" : (System.String)r.ItemArray[1];
                pa.s1 = System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2];
                pa.s2 = System.DBNull.Value.Equals(r.ItemArray[3]) ? 0 : (float)(System.Decimal)r.ItemArray[3];
                pa.s3 = System.DBNull.Value.Equals(r.ItemArray[4]) ? "" : (System.String)r.ItemArray[4];

                pa.weight = System.DBNull.Value.Equals(r.ItemArray[5]) ? 0 : (float)(System.Decimal)r.ItemArray[5];
                pa.count = System.DBNull.Value.Equals(r.ItemArray[6]) ? 0 : (float)(System.Decimal)r.ItemArray[6];

                pa.barcode96 = System.DBNull.Value.Equals(r.ItemArray[7]) ? "" : (System.String)r.ItemArray[7];

                pa.addressee_line1 = System.DBNull.Value.Equals(r.ItemArray[8]) ? "" : (System.String)r.ItemArray[8];
                pa.addressee_line2 = System.DBNull.Value.Equals(r.ItemArray[9]) ? "" : (System.String)r.ItemArray[9];
                pa.addressee_line3 = System.DBNull.Value.Equals(r.ItemArray[10]) ? "" : (System.String)r.ItemArray[10];

                pa.memo_line1 = System.DBNull.Value.Equals(r.ItemArray[11]) ? "" : (System.String)r.ItemArray[11];
                pa.memo_line2 = System.DBNull.Value.Equals(r.ItemArray[12]) ? "" : (System.String)r.ItemArray[12];
                pa.memo_line3 = System.DBNull.Value.Equals(r.ItemArray[13]) ? "" : (System.String)r.ItemArray[13];

                pa.sender_line1 = System.DBNull.Value.Equals(r.ItemArray[14]) ? "" : (System.String)r.ItemArray[14];
                pa.sender_line2 = System.DBNull.Value.Equals(r.ItemArray[15]) ? "" : (System.String)r.ItemArray[15];
                pa.barcode97 = System.DBNull.Value.Equals(r.ItemArray[16]) ? "" : (System.String)r.ItemArray[16];
                pa.bag = System.DBNull.Value.Equals(r.ItemArray[17]) ? "" : (System.String)r.ItemArray[17];
            }
            //置中
            System.Drawing.StringFormat stringFormat = new System.Drawing.StringFormat();
            stringFormat.Alignment = System.Drawing.StringAlignment.Center;
            stringFormat.LineAlignment = System.Drawing.StringAlignment.Center;

            //外框
            //---橫線
            g.DrawLine(System.Drawing.Pens.Black, 0, 0, 344, 0);
            g.DrawLine(System.Drawing.Pens.Black, 0, 295, 344, 295);
            //---直線
            g.DrawLine(System.Drawing.Pens.Black, 0, 0, 0, 295);
            g.DrawLine(System.Drawing.Pens.Black, 344, 0, 344, 80);
            g.DrawLine(System.Drawing.Pens.Black, 344, 125, 344, 295);
            //內框
            //---橫線
            g.DrawLine(System.Drawing.Pens.Black, 0, 35, 130, 35);
            g.DrawLine(System.Drawing.Pens.Black, 0, 57, 130, 57);
            g.DrawLine(System.Drawing.Pens.Black, 0, 80, 344, 80);

            g.DrawLine(System.Drawing.Pens.Black, 0, 125, 344, 125);

            g.DrawLine(System.Drawing.Pens.Black, 0, 185, 344, 185);
            g.DrawLine(System.Drawing.Pens.Black, 0, 245, 344, 245);
            g.DrawLine(System.Drawing.Pens.Black, 0, 295, 344, 295);
            //---直線
            g.DrawLine(System.Drawing.Pens.Black, 25, 125, 25, 295);
            g.DrawLine(System.Drawing.Pens.Black, 65, 0, 65, 125);
            g.DrawLine(System.Drawing.Pens.Black, 130, 0, 130, 80);
            //value
            g.DrawString("指  定", new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Black, new System.Drawing.PointF(30, 14), stringFormat);
            g.DrawString("配  送", new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Black, new System.Drawing.PointF(30, 28), stringFormat);
            g.DrawString("代收款", new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Black, new System.Drawing.PointF(30, 50), stringFormat);
            g.DrawString("重  量", new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Black, new System.Drawing.PointF(30, 72), stringFormat);
            g.DrawString("總件數", new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Black, new System.Drawing.PointF(100, 72), stringFormat);
            g.DrawString("收", new System.Drawing.Font("新細明體", 10), System.Drawing.Brushes.Black, new System.Drawing.PointF(14, 140), stringFormat);
            g.DrawString("貨", new System.Drawing.Font("新細明體", 10), System.Drawing.Brushes.Black, new System.Drawing.PointF(14, 157), stringFormat);
            g.DrawString("人", new System.Drawing.Font("新細明體", 10), System.Drawing.Brushes.Black, new System.Drawing.PointF(14, 174), stringFormat);
            
            g.DrawString("備", new System.Drawing.Font("新細明體", 10), System.Drawing.Brushes.Black, new System.Drawing.PointF(14, 205), stringFormat);
            g.DrawString("註", new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Black, new System.Drawing.PointF(14, 230), stringFormat);
            
            g.DrawString("寄", new System.Drawing.Font("新細明體", 10), System.Drawing.Brushes.Black, new System.Drawing.PointF(14, 260), stringFormat);
            g.DrawString("貨", new System.Drawing.Font("新細明體", 10), System.Drawing.Brushes.Black, new System.Drawing.PointF(14, 275), stringFormat);
            g.DrawString("人", new System.Drawing.Font("新細明體", 10), System.Drawing.Brushes.Black, new System.Drawing.PointF(14, 290), stringFormat);
            
            //value 
            g.DrawString(pa.s2.ToString(), new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Blue, new System.Drawing.PointF(100, 48), stringFormat);
            g.DrawString(pa.s3, new System.Drawing.Font("新細明體", 50, System.Drawing.FontStyle.Bold), System.Drawing.Brushes.Blue, new System.Drawing.PointF(250, 50), stringFormat);

            g.DrawString(pa.weight.ToString()+" KG", new System.Drawing.Font("新細明體", 14), System.Drawing.Brushes.Blue, new System.Drawing.PointF(35, 105), stringFormat);
            g.DrawString(pa.count.ToString(), new System.Drawing.Font("新細明體", 14), System.Drawing.Brushes.Blue, new System.Drawing.PointF(100,105), stringFormat);

            g.DrawString(pa.addressee_line1, new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Blue, new System.Drawing.PointF(30, 132));
            g.DrawString(pa.addressee_line2, new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Blue, new System.Drawing.PointF(30, 150));
            g.DrawString(pa.addressee_line3, new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Blue, new System.Drawing.PointF(30, 168));

            g.DrawString(pa.memo_line1, new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Blue, new System.Drawing.PointF(30, 190));
            g.DrawString(pa.memo_line2, new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Blue, new System.Drawing.PointF(30, 208));
            g.DrawString(pa.memo_line3, new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Blue, new System.Drawing.PointF(30, 226));
  
            g.DrawString(pa.sender_line1, new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Blue, new System.Drawing.PointF(30, 250));
            g.DrawString(pa.sender_line2, new System.Drawing.Font("新細明體", 11), System.Drawing.Brushes.Blue, new System.Drawing.PointF(30, 268));

            g.DrawString(pa.bag + " 號袋", new System.Drawing.Font("新細明體", 20), System.Drawing.Brushes.Blue, new System.Drawing.PointF(65, 320), stringFormat);
            //barcode
            GetCode(pa.barcode96,ref g, 130, 85);
            //g.DrawImage(barcodeImage, 130, 85, barcodeImage.Width, barcodeImage.Height);
            g.DrawString(pa.barcode96, new System.Drawing.Font("新細明體", 8), System.Drawing.Brushes.Blue, new System.Drawing.PointF(220, 121), stringFormat);

            GetCode(pa.barcode97, ref g, 130, 300);
            //g.DrawImage(barcodeImage97, 130, 300, barcodeImage.Width, barcodeImage.Height);
            g.DrawString(pa.barcode97, new System.Drawing.Font("新細明體", 8), System.Drawing.Brushes.Blue, new System.Drawing.PointF(220, 337), stringFormat);
            //bitmap to stream
            bm.Save(stream, System.Drawing.Imaging.ImageFormat.Bmp);
          
            Response.ContentType = "application/x-msdownload;";
            Response.AddHeader("Content-transfer-encoding", "binary");
            Response.AddHeader("Content-Disposition", "attachment;filename="+noa+".bmp");
            Response.BinaryWrite(stream.ToArray());
            Response.End();
        }
        
        public System.Drawing.Bitmap getBarcode(string text, string code)
        {
            System.Drawing.Bitmap barcode = null;

            switch (code)
            {
                case "code39":
                    barcode = GetCode39(text);
                    break;
                case "code128a":
                    text = text.ToUpper();
                    barcode = (new Code128()).GetCodeImage(text, Code128.Encode.Code128A);
                    break;
                case "code128b":
                    text = text.ToUpper();
                    barcode = (new Code128()).GetCodeImage(text, Code128.Encode.Code128B);
                    break;
                case "code128c":
                    text = text.ToUpper();
                    barcode = (new Code128()).GetCodeImage(text, Code128.Encode.Code128C);
                    break;
                case "pdf417":
                    Pdf417lib pd = new Pdf417lib();
                    pd.setText(text);
                    pd.Options = Pdf417lib.PDF417_INVERT_BITMAP;
                    pd.paintCode();
                    barcode = DrawBarcodeImage(pd, 1, 1);
                    break;

            }
            return barcode;
        }
        
        /*public void parseFile(string filename,string data)
        {
            byte[] formData = Convert.FromBase64String(data.Substring(data.IndexOf("base64") + 7));
 
            System.IO.FileStream aax = new System.IO.FileStream(savepath + filename, System.IO.FileMode.OpenOrCreate);
            System.IO.BinaryWriter aay = new System.IO.BinaryWriter(aax);
            aay.Write(formData);
            aax.Close();
        }*/
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
        
        public System.Drawing.Bitmap GetCode39(string strSource)
        {
          int x = 0; //左邊界
          int y = 0; //上邊界
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
              x, y, intBarWidth , BarCodeHeight);
            x += intBarWidth;
          }
          return objBitmap; 
        }

        public class Code128
        {
            private System.Data.DataTable m_Code128 = new System.Data.DataTable();


            private uint m_Height = 40;
            /// <summary>
            /// 高度
            /// </summary>
            public uint Height { get { return m_Height; } set { m_Height = value; } }


            private System.Drawing.Font m_ValueFont = null;
            /// <summary>
            /// 是否顯示可見號碼 如果為Null不顯示號碼
            /// </summary>
            public System.Drawing.Font ValueFont { get { return m_ValueFont; } set { m_ValueFont = value; } }


            private byte m_Magnify = 0;
            /// <summary>
            /// 放大倍數
            /// </summary>
            public byte Magnify { get { return m_Magnify; } set { m_Magnify = value; } }
            /// <summary>
            /// 條碼類別
            /// </summary>
            public enum Encode
            {
                Code128A,
                Code128B,
                Code128C,
                EAN128
            }


            public Code128()
            {
                m_Code128.Columns.Add("ID");
                m_Code128.Columns.Add("Code128A");
                m_Code128.Columns.Add("Code128B");
                m_Code128.Columns.Add("Code128C");
                m_Code128.Columns.Add("BandCode");


                m_Code128.CaseSensitive = true;



                #region 資料表
                m_Code128.Rows.Add("0", " ", " ", "00", "212222");
                m_Code128.Rows.Add("1", "!", "!", "01", "222122");
                m_Code128.Rows.Add("2", "\"", "\"", "02", "222221"); 
                m_Code128.Rows.Add("3", "#", "#", "03", "121223");
                m_Code128.Rows.Add("4", "$", "$", "04", "121322");
                m_Code128.Rows.Add("5", "%", "%", "05", "131222");
                m_Code128.Rows.Add("6", "&", "&", "06", "122213");
                m_Code128.Rows.Add("7", "'", "'", "07", "122312");
                m_Code128.Rows.Add("8", "(", "(", "08", "132212");
                m_Code128.Rows.Add("9", ")", ")", "09", "221213");
                m_Code128.Rows.Add("10", "*", "*", "10", "221312");
                m_Code128.Rows.Add("11", "+", "+", "11", "231212");
                m_Code128.Rows.Add("12", ",", ",", "12", "112232");
                m_Code128.Rows.Add("13", "-", "-", "13", "122132");
                m_Code128.Rows.Add("14", ".", ".", "14", "122231");
                m_Code128.Rows.Add("15", "/", "/", "15", "113222");
                m_Code128.Rows.Add("16", "0", "0", "16", "123122");
                m_Code128.Rows.Add("17", "1", "1", "17", "123221");
                m_Code128.Rows.Add("18", "2", "2", "18", "223211");
                m_Code128.Rows.Add("19", "3", "3", "19", "221132");
                m_Code128.Rows.Add("20", "4", "4", "20", "221231");
                m_Code128.Rows.Add("21", "5", "5", "21", "213212");
                m_Code128.Rows.Add("22", "6", "6", "22", "223112");
                m_Code128.Rows.Add("23", "7", "7", "23", "312131");
                m_Code128.Rows.Add("24", "8", "8", "24", "311222");
                m_Code128.Rows.Add("25", "9", "9", "25", "321122");
                m_Code128.Rows.Add("26", ":", ":", "26", "321221");
                m_Code128.Rows.Add("27", ";", ";", "27", "312212");
                m_Code128.Rows.Add("28", "<", "<", "28", "322112");
                m_Code128.Rows.Add("29", "=", "=", "29", "322211");
                m_Code128.Rows.Add("30", ">", ">", "30", "212123");
                m_Code128.Rows.Add("31", "?", "?", "31", "212321");
                m_Code128.Rows.Add("32", "@", "@", "32", "232121");
                m_Code128.Rows.Add("33", "A", "A", "33", "111323");
                m_Code128.Rows.Add("34", "B", "B", "34", "131123");
                m_Code128.Rows.Add("35", "C", "C", "35", "131321");
                m_Code128.Rows.Add("36", "D", "D", "36", "112313");
                m_Code128.Rows.Add("37", "E", "E", "37", "132113");
                m_Code128.Rows.Add("38", "F", "F", "38", "132311");
                m_Code128.Rows.Add("39", "G", "G", "39", "211313");
                m_Code128.Rows.Add("40", "H", "H", "40", "231113");
                m_Code128.Rows.Add("41", "I", "I", "41", "231311");
                m_Code128.Rows.Add("42", "J", "J", "42", "112133");
                m_Code128.Rows.Add("43", "K", "K", "43", "112331");
                m_Code128.Rows.Add("44", "L", "L", "44", "132131");
                m_Code128.Rows.Add("45", "M", "M", "45", "113123");
                m_Code128.Rows.Add("46", "N", "N", "46", "113321");
                m_Code128.Rows.Add("47", "O", "O", "47", "133121");
                m_Code128.Rows.Add("48", "P", "P", "48", "313121");
                m_Code128.Rows.Add("49", "Q", "Q", "49", "211331");
                m_Code128.Rows.Add("50", "R", "R", "50", "231131");
                m_Code128.Rows.Add("51", "S", "S", "51", "213113");
                m_Code128.Rows.Add("52", "T", "T", "52", "213311");
                m_Code128.Rows.Add("53", "U", "U", "53", "213131");
                m_Code128.Rows.Add("54", "V", "V", "54", "311123");
                m_Code128.Rows.Add("55", "W", "W", "55", "311321");
                m_Code128.Rows.Add("56", "X", "X", "56", "331121");
                m_Code128.Rows.Add("57", "Y", "Y", "57", "312113");
                m_Code128.Rows.Add("58", "Z", "Z", "58", "312311");
                m_Code128.Rows.Add("59", "[", "[", "59", "332111");
                m_Code128.Rows.Add("60", "//", "//", "60", "314111");
                m_Code128.Rows.Add("61", "]", "]", "61", "221411");
                m_Code128.Rows.Add("62", "^", "^", "62", "431111");
                m_Code128.Rows.Add("63", "_", "_", "63", "111224");
                m_Code128.Rows.Add("64", "NUL", "`", "64", "111422");
                m_Code128.Rows.Add("65", "SOH", "a", "65", "121124");
                m_Code128.Rows.Add("66", "STX", "b", "66", "121421");
                m_Code128.Rows.Add("67", "ETX", "c", "67", "141122");
                m_Code128.Rows.Add("68", "EOT", "d", "68", "141221");
                m_Code128.Rows.Add("69", "ENQ", "e", "69", "112214");
                m_Code128.Rows.Add("70", "ACK", "f", "70", "112412");
                m_Code128.Rows.Add("71", "BEL", "g", "71", "122114");
                m_Code128.Rows.Add("72", "BS", "h", "72", "122411");
                m_Code128.Rows.Add("73", "HT", "i", "73", "142112");
                m_Code128.Rows.Add("74", "LF", "j", "74", "142211");
                m_Code128.Rows.Add("75", "VT", "k", "75", "241211");
                m_Code128.Rows.Add("76", "FF", "I", "76", "221114");
                m_Code128.Rows.Add("77", "CR", "m", "77", "413111");
                m_Code128.Rows.Add("78", "SO", "n", "78", "241112");
                m_Code128.Rows.Add("79", "SI", "o", "79", "134111");
                m_Code128.Rows.Add("80", "DLE", "p", "80", "111242");
                m_Code128.Rows.Add("81", "DC1", "q", "81", "121142");
                m_Code128.Rows.Add("82", "DC2", "r", "82", "121241");
                m_Code128.Rows.Add("83", "DC3", "s", "83", "114212");
                m_Code128.Rows.Add("84", "DC4", "t", "84", "124112");
                m_Code128.Rows.Add("85", "NAK", "u", "85", "124211");
                m_Code128.Rows.Add("86", "SYN", "v", "86", "411212");
                m_Code128.Rows.Add("87", "ETB", "w", "87", "421112");
                m_Code128.Rows.Add("88", "CAN", "x", "88", "421211");
                m_Code128.Rows.Add("89", "EM", "y", "89", "212141");
                m_Code128.Rows.Add("90", "SUB", "z", "90", "214121");
                m_Code128.Rows.Add("91", "ESC", "{", "91", "412121");
                m_Code128.Rows.Add("92", "FS", "|", "92", "111143");
                m_Code128.Rows.Add("93", "GS", "}", "93", "111341");
                m_Code128.Rows.Add("94", "RS", "~", "94", "131141");
                m_Code128.Rows.Add("95", "US", "DEL", "95", "114113");
                m_Code128.Rows.Add("96", "FNC3", "FNC3", "96", "114311");
                m_Code128.Rows.Add("97", "FNC2", "FNC2", "97", "411113");
                m_Code128.Rows.Add("98", "SHIFT", "SHIFT", "98", "411311");
                m_Code128.Rows.Add("99", "CODEC", "CODEC", "99", "113141");
                m_Code128.Rows.Add("100", "CODEB", "FNC4", "CODEB", "114131");
                m_Code128.Rows.Add("101", "FNC4", "CODEA", "CODEA", "311141");
                m_Code128.Rows.Add("102", "FNC1", "FNC1", "FNC1", "411131");
                m_Code128.Rows.Add("103", "StartA", "StartA", "StartA", "211412");
                m_Code128.Rows.Add("104", "StartB", "StartB", "StartB", "211214");
                m_Code128.Rows.Add("105", "StartC", "StartC", "StartC", "211232");
                m_Code128.Rows.Add("106", "Stop", "Stop", "Stop", "2331112");
                #endregion
            }
            /// <summary>
            /// 獲取128圖形
            /// </summary>
            /// <param name="p_Text">文字</param>
            /// <param name="p_Code">編碼</param>
            /// <returns>圖形</returns>
            public System.Drawing.Bitmap GetCodeImage(string p_Text, Encode p_Code)
            {
                string _ViewText = p_Text;
                string _Text = "";
                IList<int> _TextNumb = new List<int>();
                int _Examine = 0; //首位
                switch (p_Code)
                {
                    case Encode.Code128C:
                        _Examine = 105;
                        if (!((p_Text.Length & 1) == 0)) throw new Exception("128C長度必須是偶數");
                        while (p_Text.Length != 0)
                        {
                            int _Temp = 0;
                            try
                            {
                                int _CodeNumb128 = Int32.Parse(p_Text.Substring(0, 2));
                            }
                            catch
                            {
                                throw new Exception("128C必須是數位！");
                            }
                            _Text += GetValue(p_Code, p_Text.Substring(0, 2), ref _Temp);
                            _TextNumb.Add(_Temp);
                            p_Text = p_Text.Remove(0, 2);
                        }
                        break;
                    case Encode.EAN128:
                        _Examine = 105;
                        if (!((p_Text.Length & 1) == 0)) throw new Exception("EAN128長度必須是偶數");
                        _TextNumb.Add(102);
                        _Text += "411131";
                        while (p_Text.Length != 0)
                        {
                            int _Temp = 0;
                            try
                            {
                                int _CodeNumb128 = Int32.Parse(p_Text.Substring(0, 2));
                            }
                            catch
                            {
                                throw new Exception("128C必須是數位！");
                            }
                            _Text += GetValue(Encode.Code128C, p_Text.Substring(0, 2), ref _Temp);
                            _TextNumb.Add(_Temp);
                            p_Text = p_Text.Remove(0, 2);
                        }
                        break;
                    default:
                        if (p_Code == Encode.Code128A)
                        {
                            _Examine = 103;
                        }
                        else
                        {
                            _Examine = 104;
                        }

                        while (p_Text.Length != 0)
                        {
                            int _Temp = 0;
                            string _ValueCode = GetValue(p_Code, p_Text.Substring(0, 1), ref _Temp);
                            if (_ValueCode.Length == 0) throw new Exception("不正確字元集!" + p_Text.Substring(0, 1).ToString());
                            _Text += _ValueCode;
                            _TextNumb.Add(_Temp);
                            p_Text = p_Text.Remove(0, 1);
                        }
                        break;
                }

                if (_TextNumb.Count == 0) throw new Exception("錯誤的編碼,無資料");
                _Text = _Text.Insert(0, GetValue(_Examine)); //獲取開始位

                for (int i = 0; i != _TextNumb.Count; i++)
                {
                    _Examine += _TextNumb[i] * (i + 1);
                }
                _Examine = _Examine % 103; //獲得嚴效位
                _Text += GetValue(_Examine); //獲取嚴效位

                _Text += "2331112"; //結束位

                System.Drawing.Bitmap _CodeImage = GetImage(_Text);
                GetViewText(_CodeImage, _ViewText);
                return _CodeImage;
            }

            /// <summary>
            /// 獲取目標對應的資料
            /// </summary>
            /// <param name="p_Code">編碼</param>
            /// <param name="p_Value">數值 A b 30</param>
            /// <param name="p_SetID">返回編號</param>
            /// <returns>編碼</returns>
            private string GetValue(Encode p_Code, string p_Value, ref int p_SetID)
            {
                if (m_Code128 == null) return "";
                System.Data.DataRow[] _Row = m_Code128.Select(p_Code.ToString() + "='" + p_Value + "'");
                if (_Row.Length != 1) throw new Exception("錯誤的編碼" + p_Value.ToString());
                p_SetID = Int32.Parse(_Row[0]["ID"].ToString());
                return _Row[0]["BandCode"].ToString();
            }
            /// <summary>
            /// 根據編號獲得條紋
            /// </summary>
            /// <param name="p_CodeId"></param>
            /// <returns></returns>
            private string GetValue(int p_CodeId)
            {
                System.Data.DataRow[] _Row = m_Code128.Select("ID='" + p_CodeId.ToString() + "'");
                if (_Row.Length != 1) throw new Exception("驗效位的編碼錯誤" + p_CodeId.ToString());
                return _Row[0]["BandCode"].ToString();
            }

            /// <summary>
            /// 獲得條碼圖形
            /// </summary>
            /// <param name="p_Text">文字</param>
            /// <returns>圖形</returns>
            private System.Drawing.Bitmap GetImage(string p_Text)
            {
                char[] _Value = p_Text.ToCharArray();
                int _Width = 0;
                for (int i = 0; i != _Value.Length; i++)
                {
                    _Width += Int32.Parse(_Value[i].ToString()) * (m_Magnify + 1);
                }

                System.Drawing.Bitmap _CodeImage = new System.Drawing.Bitmap(_Width, (int)m_Height);
                System.Drawing.Graphics _Garphics = System.Drawing.Graphics.FromImage(_CodeImage);
                //Pen _Pen;
                int _LenEx = 0;
                for (int i = 0; i != _Value.Length; i++)
                {
                    int _ValueNumb = Int32.Parse(_Value[i].ToString()) * (m_Magnify + 1); //獲取寬和放大係數

                    if (!((i & 1) == 0))
                    {
                        //_Pen = new Pen(Brushes.White, _ValueNumb);
                        _Garphics.FillRectangle(System.Drawing.Brushes.White, new System.Drawing.Rectangle(_LenEx, 0, _ValueNumb, (int)m_Height));
                    }
                    else
                    {
                        //_Pen = new Pen(Brushes.Black, _ValueNumb);
                        _Garphics.FillRectangle(System.Drawing.Brushes.Black, new System.Drawing.Rectangle(_LenEx, 0, _ValueNumb, (int)m_Height));
                    }
                    //_Garphics.(_Pen, new Point(_LenEx, 0), new Point(_LenEx, m_Height));
                    _LenEx += _ValueNumb;

                }

                _Garphics.Dispose();
                return _CodeImage;
            }
            /// <summary>
            /// 顯示可見條碼文字 如果小於40 不顯示文字
            /// </summary>
            /// <param name="p_Bitmap">圖形</param>
            private void GetViewText(System.Drawing.Bitmap p_Bitmap, string p_ViewText)
            {
                if (m_ValueFont == null) return;

                System.Drawing.Graphics _Graphics = System.Drawing.Graphics.FromImage(p_Bitmap);
                System.Drawing.SizeF _DrawSize = _Graphics.MeasureString(p_ViewText, m_ValueFont);
                if (_DrawSize.Height > p_Bitmap.Height - 10 || _DrawSize.Width > p_Bitmap.Width)
                {
                    _Graphics.Dispose();
                    return;
                }

                int _StarY = p_Bitmap.Height - (int)_DrawSize.Height;

                _Graphics.FillRectangle(System.Drawing.Brushes.White, new System.Drawing.Rectangle(0, _StarY, p_Bitmap.Width, (int)_DrawSize.Height));
                _Graphics.DrawString(p_ViewText, m_ValueFont, System.Drawing.Brushes.Black, 0, _StarY);
            }
        }

        public class Pdf417lib
        {
            private void InitBlock()
            {
                codewords = new int[MAX_DATA_CODEWORDS + 2];
            }
            virtual protected internal int MaxSquare
            {
                get
                {
                    if (codeColumns > 21)
                    {
                        codeColumns = 29;
                        codeRows = 32;
                    }
                    else
                    {
                        codeColumns = 16;
                        codeRows = 58;
                    }
                    return MAX_DATA_CODEWORDS + 2;
                }

            }
            /// <summary>Gets the raw image bits of the barcode. The image will have to
            /// be scaled in the Y direction by <CODE>yHeight</CODE>.
            /// </summary>
            /// <returns> The raw barcode image
            /// </returns>
            virtual public sbyte[] OutBits
            {
                get
                {
                    return this.outBits;
                }

            }
            /// <summary>Gets the number of X pixels of <CODE>outBits</CODE>.</summary>
            /// <returns> the number of X pixels of <CODE>outBits</CODE>
            /// </returns>
            virtual public int BitColumns
            {
                get
                {
                    return this.bitColumns;
                }

            }
            //UPGRADE_NOTE: Respective javadoc comments were merged.  It should be changed in order to comply with .NET documentation conventions.
            /// <summary>Gets the number of Y pixels of <CODE>outBits</CODE>.
            /// It is also the number of rows in the barcode.
            /// </summary>
            /// <returns> the number of Y pixels of <CODE>outBits</CODE>
            /// </returns>
            /// <summary>Sets the number of barcode rows. This number may be changed
            /// to keep the barcode valid.
            /// </summary>
            /// <param name="codeRows">the number of barcode rows
            /// </param>
            virtual public int CodeRows
            {
                get
                {
                    return this.codeRows;
                }

                set
                {
                    this.codeRows = value;
                }

            }
            //UPGRADE_NOTE: Respective javadoc comments were merged.  It should be changed in order to comply with .NET documentation conventions.
            /// <summary>Gets the number of barcode data columns.</summary>
            /// <returns> he number of barcode data columns
            /// </returns>
            /// <summary>Sets the number of barcode data columns.
            /// This number may be changed to keep the barcode valid.
            /// </summary>
            /// <param name="codeColumns">the number of barcode data columns
            /// </param>
            virtual public int CodeColumns
            {
                get
                {
                    return this.codeColumns;
                }

                set
                {
                    this.codeColumns = value;
                }

            }
            /// <summary>Gets the codeword array. This array is always 928 elements long.
            /// It can be writen to if the option <CODE>PDF417_USE_RAW_CODEWORDS</CODE>
            /// is set.
            /// </summary>
            /// <returns> the codeword array
            /// </returns>
            virtual public int[] Codewords
            {
                get
                {
                    return this.codewords;
                }

            }
            //UPGRADE_NOTE: Respective javadoc comments were merged.  It should be changed in order to comply with .NET documentation conventions.
            /// <summary>Gets the length of the codewords.</summary>
            /// <returns> the length of the codewords
            /// </returns>
            /// <summary>Sets the length of the codewords.</summary>
            /// <param name="lenCodewords">the length of the codewords
            /// </param>
            virtual public int LenCodewords
            {
                get
                {
                    return this.lenCodewords;
                }

                set
                {
                    this.lenCodewords = value;
                }
            }

            //UPGRADE_NOTE: Respective javadoc comments were merged.  It should be changed in order to comply with .NET documentation conventions.
            /// <summary>Gets the error level correction used for the barcode. It may different
            /// from the previously set value.
            /// </summary>
            /// <returns> the error level correction used for the barcode
            /// </returns>
            /// <summary>Sets the error level correction for the barcode.</summary>
            /// <param name="errorLevel">the error level correction for the barcode
            /// </param>
            virtual public int ErrorLevel
            {
                get
                {
                    return this.errorLevel;
                }

                set
                {
                    this.errorLevel = value;
                }

            }
            //UPGRADE_NOTE: Respective javadoc comments were merged.  It should be changed in order to comply with .NET documentation conventions.
            /// <summary>Gets the options to generate the barcode.</summary>
            /// <returns> the options to generate the barcode
            /// </returns>
            /// <summary>Sets the options to generate the barcode. This can be all
            /// the <CODE>PDF417_*</CODE> constants.
            /// </summary>
            /// <param name="options">the options to generate the barcode
            /// </param>
            virtual public int Options
            {
                get
                {
                    return this.options;
                }

                set
                {
                    this.options = value;
                }

            }
            //UPGRADE_NOTE: Respective javadoc comments were merged.  It should be changed in order to comply with .NET documentation conventions.
            /// <summary>Gets the barcode aspect ratio.</summary>
            /// <returns> the barcode aspect ratio
            /// </returns>
            /// <summary>Sets the barcode aspect ratio. A ratio or 0.5 will make the
            /// barcode width twice as large as the height.
            /// </summary>
            /// <param name="aspectRatio">the barcode aspect ratio
            /// </param>
            virtual public float AspectRatio
            {
                get
                {
                    return this.aspectRatio;
                }

                set
                {
                    this.aspectRatio = value;
                }

            }
            //UPGRADE_NOTE: Respective javadoc comments were merged.  It should be changed in order to comply with .NET documentation conventions.
            /// <summary>Gets the Y pixel height relative to X.</summary>
            /// <returns> the Y pixel height relative to X
            /// </returns>
            /// <summary>Sets the Y pixel height relative to X. It is usually 3.</summary>
            /// <param name="yHeight">the Y pixel height relative to X
            /// </param>
            virtual public float YHeight
            {
                get
                {
                    return this.yHeight;
                }

                set
                {
                    this.yHeight = value;
                }

            }

            /// <summary>Auto-size is made based on <CODE>aspectRatio</CODE> and <CODE>yHeight</CODE>. </summary>
            public const int PDF417_USE_ASPECT_RATIO = 0;
            /// <summary>The size of the barcode will be at least <CODE>codeColumns*codeRows</CODE>. </summary>
            public const int PDF417_FIXED_RECTANGLE = 1;
            /// <summary>The size will be at least <CODE>codeColumns</CODE>
            /// with a variable number of <CODE>codeRows</CODE>.
            /// </summary>
            public const int PDF417_FIXED_COLUMNS = 2;
            /// <summary>The size will be at least <CODE>codeRows</CODE>
            /// with a variable number of <CODE>codeColumns</CODE>.
            /// </summary>
            public const int PDF417_FIXED_ROWS = 4;
            /// <summary>The error level correction is set automatically according
            /// to ISO 15438 recomendations.
            /// </summary>
            public const int PDF417_AUTO_ERROR_LEVEL = 0;
            /// <summary>The error level correction is set by the user. It can be 0 to 8. </summary>
            public const int PDF417_USE_ERROR_LEVEL = 16;
            /// <summary>No <CODE>text</CODE> interpretation is done and the content of <CODE>codewords</CODE>
            /// is used directly.
            /// </summary>
            public const int PDF417_USE_RAW_CODEWORDS = 64;
            /// <summary>Inverts the output bits of the raw bitmap that is normally
            /// bit one for black. It has only effect for the raw bitmap.
            /// </summary>
            public const int PDF417_INVERT_BITMAP = 128;


            protected internal int bitPtr;
            protected internal int cwPtr;
            protected internal SegmentList segmentList;

            /// <summary>Creates a new <CODE>BarcodePDF417</CODE> with the default settings. </summary>
            public Pdf417lib()
            {
                InitBlock();
                setDefaultParameters();
            }

            protected internal virtual bool checkSegmentType(Segment segment, char type)
            {
                if (segment == null)
                    return false;
                return segment.type == type;
            }

            protected internal virtual int getSegmentLength(Segment segment)
            {
                if (segment == null)
                    return 0;
                return segment.end - segment.start;
            }

            /// <summary>Set the default settings that correspond to <CODE>PDF417_USE_ASPECT_RATIO</CODE>
            /// and <CODE>PDF417_AUTO_ERROR_LEVEL</CODE>.
            /// </summary>
            public virtual void setDefaultParameters()
            {
                options = 0;
                outBits = null;
                text = new sbyte[0];
                yHeight = 3;
                aspectRatio = 0.5f;
            }

            protected internal virtual void outCodeword17(int codeword)
            {
                int bytePtr = bitPtr / 8;
                int bit = bitPtr - bytePtr * 8;
                outBits[bytePtr++] |= (sbyte)(codeword >> (9 + bit));
                outBits[bytePtr++] |= (sbyte)(codeword >> (1 + bit));
                codeword <<= 8;
                outBits[bytePtr] |= (sbyte)(codeword >> (1 + bit));
                bitPtr += 17;
            }

            protected internal virtual void outCodeword18(int codeword)
            {
                int bytePtr = bitPtr / 8;
                int bit = bitPtr - bytePtr * 8;
                outBits[bytePtr++] |= (sbyte)(codeword >> (10 + bit));
                outBits[bytePtr++] |= (sbyte)(codeword >> (2 + bit));
                codeword <<= 8;
                outBits[bytePtr] |= (sbyte)(codeword >> (2 + bit));
                if (bit == 7)
                    outBits[++bytePtr] |= unchecked((sbyte)0x80);
                bitPtr += 18;
            }

            protected internal virtual void outCodeword(int codeword)
            {
                outCodeword17(codeword);
            }

            protected internal virtual void outStopPattern()
            {
                outCodeword18(STOP_PATTERN);
            }

            protected internal virtual void outStartPattern()
            {
                outCodeword17(START_PATTERN);
            }

            protected internal virtual void outPaintCode()
            {
                int codePtr = 0;
                bitColumns = START_CODE_SIZE * (codeColumns + 3) + STOP_SIZE;
                int lenBits = ((bitColumns - 1) / 8 + 1) * codeRows;
                outBits = new sbyte[lenBits];
                for (int row = 0; row < codeRows; ++row)
                {
                    bitPtr = ((bitColumns - 1) / 8 + 1) * 8 * row;
                    int rowMod = row % 3;
                    int[] cluster = CLUSTERS[rowMod];
                    outStartPattern();
                    int edge = 0;
                    switch (rowMod)
                    {

                        case 0:
                            edge = 30 * (row / 3) + ((codeRows - 1) / 3);
                            break;

                        case 1:
                            edge = 30 * (row / 3) + errorLevel * 3 + ((codeRows - 1) % 3);
                            break;

                        default:
                            edge = 30 * (row / 3) + codeColumns - 1;
                            break;

                    }
                    outCodeword(cluster[edge]);

                    for (int column = 0; column < codeColumns; ++column)
                    {
                        outCodeword(cluster[codewords[codePtr++]]);
                    }

                    switch (rowMod)
                    {

                        case 0:
                            edge = 30 * (row / 3) + codeColumns - 1;
                            break;

                        case 1:
                            edge = 30 * (row / 3) + ((codeRows - 1) / 3);
                            break;

                        default:
                            edge = 30 * (row / 3) + errorLevel * 3 + ((codeRows - 1) % 3);
                            break;

                    }
                    outCodeword(cluster[edge]);
                    outStopPattern();
                }
                if ((options & PDF417_INVERT_BITMAP) != 0)
                {
                    for (int k = 0; k < outBits.Length; ++k)
                        //outBits[k] ^= 0xff;
                        outBits[k] ^= unchecked((sbyte)0xff);
                }
            }

            protected internal virtual void calculateErrorCorrection(int dest)
            {
                if (errorLevel < 0 || errorLevel > 8)
                    errorLevel = 0;
                int[] A = ERROR_LEVEL[errorLevel];
                int Alength = 2 << errorLevel;
                for (int k = 0; k < Alength; ++k)
                    codewords[dest + k] = 0;
                int lastE = Alength - 1;
                for (int k = 0; k < lenCodewords; ++k)
                {
                    int t1 = codewords[k] + codewords[dest];
                    for (int e = 0; e <= lastE; ++e)
                    {
                        int t2 = (t1 * A[lastE - e]) % MOD;
                        int t3 = MOD - t2;
                        codewords[dest + e] = ((e == lastE ? 0 : codewords[dest + e + 1]) + t3) % MOD;
                    }
                }
                for (int k = 0; k < Alength; ++k)
                    codewords[dest + k] = (MOD - codewords[dest + k]) % MOD;
            }

            protected internal virtual int getTextTypeAndValue(int maxLength, int idx)
            {
                if (idx >= maxLength)
                    return 0;
                char c = (char)(text[idx] & 0xff);
                if (c >= 'A' && c <= 'Z')
                    return (ALPHA + c - 'A');
                if (c >= 'a' && c <= 'z')
                    return (LOWER + c - 'a');
                if (c == ' ')
                    return (ALPHA + LOWER + MIXED + SPACE);
                int ms = MIXED_SET.IndexOf((System.Char)c);
                int ps = PUNCTUATION_SET.IndexOf((System.Char)c);
                if (ms < 0 && ps < 0)
                    return (ISBYTE + c);
                if (ms == ps)
                    return (MIXED + PUNCTUATION + ms);
                if (ms >= 0)
                    return (MIXED + ms);
                return (PUNCTUATION + ps);
            }

            protected internal virtual void textCompaction(int start, int length)
            {
                int[] dest = new int[ABSOLUTE_MAX_TEXT_SIZE * 2];
                int mode = ALPHA;
                int ptr = 0;
                int fullBytes = 0;
                int v = 0;
                int k;
                int size;
                length += start;
                for (k = start; k < length; ++k)
                {
                    v = getTextTypeAndValue(length, k);
                    if ((v & mode) != 0)
                    {
                        dest[ptr++] = v & 0xff;
                        continue;
                    }
                    if ((v & ISBYTE) != 0)
                    {
                        if ((ptr & 1) != 0)
                        {
                            dest[ptr++] = (mode & PUNCTUATION) != 0 ? PAL : PS;
                            mode = (mode & PUNCTUATION) != 0 ? ALPHA : mode;
                        }
                        dest[ptr++] = BYTESHIFT;
                        dest[ptr++] = v & 0xff;
                        fullBytes += 2;
                        continue;
                    }
                    switch (mode)
                    {

                        case ALPHA:
                            if ((v & LOWER) != 0)
                            {
                                dest[ptr++] = LL;
                                dest[ptr++] = v & 0xff;
                                mode = LOWER;
                            }
                            else if ((v & MIXED) != 0)
                            {
                                dest[ptr++] = ML;
                                dest[ptr++] = v & 0xff;
                                mode = MIXED;
                            }
                            else if ((getTextTypeAndValue(length, k + 1) & getTextTypeAndValue(length, k + 2) & PUNCTUATION) != 0)
                            {
                                dest[ptr++] = ML;
                                dest[ptr++] = PL;
                                dest[ptr++] = v & 0xff;
                                mode = PUNCTUATION;
                            }
                            else
                            {
                                dest[ptr++] = PS;
                                dest[ptr++] = v & 0xff;
                            }
                            break;

                        case LOWER:
                            if ((v & ALPHA) != 0)
                            {
                                if ((getTextTypeAndValue(length, k + 1) & getTextTypeAndValue(length, k + 2) & ALPHA) != 0)
                                {
                                    dest[ptr++] = ML;
                                    dest[ptr++] = AL;
                                    mode = ALPHA;
                                }
                                else
                                {
                                    dest[ptr++] = AS;
                                }
                                dest[ptr++] = v & 0xff;
                            }
                            else if ((v & MIXED) != 0)
                            {
                                dest[ptr++] = ML;
                                dest[ptr++] = v & 0xff;
                                mode = MIXED;
                            }
                            else if ((getTextTypeAndValue(length, k + 1) & getTextTypeAndValue(length, k + 2) & PUNCTUATION) != 0)
                            {
                                dest[ptr++] = ML;
                                dest[ptr++] = PL;
                                dest[ptr++] = v & 0xff;
                                mode = PUNCTUATION;
                            }
                            else
                            {
                                dest[ptr++] = PS;
                                dest[ptr++] = v & 0xff;
                            }
                            break;

                        case MIXED:
                            if ((v & LOWER) != 0)
                            {
                                dest[ptr++] = LL;
                                dest[ptr++] = v & 0xff;
                                mode = LOWER;
                            }
                            else if ((v & ALPHA) != 0)
                            {
                                dest[ptr++] = AL;
                                dest[ptr++] = v & 0xff;
                                mode = ALPHA;
                            }
                            else if ((getTextTypeAndValue(length, k + 1) & getTextTypeAndValue(length, k + 2) & PUNCTUATION) != 0)
                            {
                                dest[ptr++] = PL;
                                dest[ptr++] = v & 0xff;
                                mode = PUNCTUATION;
                            }
                            else
                            {
                                dest[ptr++] = PS;
                                dest[ptr++] = v & 0xff;
                            }
                            break;

                        case PUNCTUATION:
                            dest[ptr++] = PAL;
                            mode = ALPHA;
                            --k;
                            break;
                    }
                }
                if ((ptr & 1) != 0)
                    dest[ptr++] = PS;
                size = (ptr + fullBytes) / 2;
                if (size + cwPtr > MAX_DATA_CODEWORDS)
                {
                    throw new System.IndexOutOfRangeException("The text is too big.");
                }
                length = ptr;
                ptr = 0;
                while (ptr < length)
                {
                    v = dest[ptr++];
                    if (v >= 30)
                    {
                        codewords[cwPtr++] = v;
                        codewords[cwPtr++] = dest[ptr++];
                    }
                    else
                        codewords[cwPtr++] = v * 30 + dest[ptr++];
                }
            }

            protected internal virtual void basicNumberCompaction(int start, int length)
            {
                int ret = cwPtr;
                int retLast = length / 3;
                int ni, k;
                cwPtr += retLast + 1;
                for (k = 0; k <= retLast; ++k)
                    codewords[ret + k] = 0;
                codewords[ret + retLast] = 1;
                length += start;
                for (ni = start; ni < length; ++ni)
                {
                    // multiply by 10
                    for (k = retLast; k >= 0; --k)
                        codewords[ret + k] *= 10;
                    // add the digit
                    codewords[ret + retLast] += text[ni] - '0';
                    // propagate carry
                    for (k = retLast; k > 0; --k)
                    {
                        codewords[ret + k - 1] += codewords[ret + k] / 900;
                        codewords[ret + k] %= 900;
                    }
                }
            }

            protected internal virtual void numberCompaction(int start, int length)
            {
                int full = (length / 44) * 15;
                int size = length % 44;
                int k;
                if (size == 0)
                    size = full;
                else
                    size = full + size / 3 + 1;
                if (size + cwPtr > MAX_DATA_CODEWORDS)
                {
                    throw new System.IndexOutOfRangeException("The text is too big.");
                }
                length += start;
                for (k = start; k < length; k += 44)
                {
                    size = length - k < 44 ? length - k : 44;
                    basicNumberCompaction(k, size);
                }
            }

            protected internal virtual void byteCompaction6(int start)
            {
                int length = 6;
                int ret = cwPtr;
                int retLast = 4;
                int ni, k;
                cwPtr += retLast + 1;
                for (k = 0; k <= retLast; ++k)
                    codewords[ret + k] = 0;
                length += start;
                for (ni = start; ni < length; ++ni)
                {
                    // multiply by 256
                    for (k = retLast; k >= 0; --k)
                        codewords[ret + k] *= 256;
                    // add the digit
                    codewords[ret + retLast] += ((int)text[ni] & 0xff);
                    // propagate carry
                    for (k = retLast; k > 0; --k)
                    {
                        codewords[ret + k - 1] += codewords[ret + k] / 900;
                        codewords[ret + k] %= 900;
                    }
                }
            }

            internal virtual void byteCompaction(int start, int length)
            {
                int k, j;
                int size = (length / 6) * 5 + (length % 6);
                if (size + cwPtr > MAX_DATA_CODEWORDS)
                {
                    throw new System.IndexOutOfRangeException("The text is too big.");
                }
                length += start;
                for (k = start; k < length; k += 6)
                {
                    size = length - k < 44 ? length - k : 6;
                    if (size < 6)
                    {
                        for (j = 0; j < size; ++j)
                            codewords[cwPtr++] = (int)text[k + j] & 0xff;
                    }
                    else
                    {
                        byteCompaction6(k);
                    }
                }
            }

            internal virtual void breakString()
            {
                int textLength = text.Length;
                int lastP = 0;
                int startN = 0;
                int nd = 0;
                char c = (char)(0);
                int k, ptrS, j;
                bool lastTxt, txt;
                Segment v;
                Segment vp;
                Segment vn;
                for (k = 0; k < textLength; ++k)
                {
                    c = (char)(text[k] & 0xff);
                    if (c >= '0' && c <= '9')
                    {
                        if (nd == 0)
                            startN = k;
                        ++nd;
                        continue;
                    }
                    if (nd >= 13)
                    {
                        if (lastP != startN)
                        {
                            c = (char)(text[lastP] & 0xff);
                            ptrS = lastP;
                            lastTxt = (c >= ' ' && c < 127) || c == '\r' || c == '\n' || c == '\t';
                            for (j = lastP; j < startN; ++j)
                            {
                                c = (char)(text[j] & 0xff);
                                txt = (c >= ' ' && c < 127) || c == '\r' || c == '\n' || c == '\t';
                                if (txt != lastTxt)
                                {
                                    segmentList.add(lastTxt ? 'T' : 'B', lastP, j);
                                    lastP = j;
                                    lastTxt = txt;
                                }
                            }
                            segmentList.add(lastTxt ? 'T' : 'B', lastP, startN);
                        }
                        segmentList.add('N', startN, k);
                        lastP = k;
                    }
                    nd = 0;
                }
                if (nd < 13)
                    startN = textLength;
                if (lastP != startN)
                {
                    c = (char)(text[lastP] & 0xff);
                    ptrS = lastP;
                    lastTxt = (c >= ' ' && c < 127) || c == '\r' || c == '\n' || c == '\t';
                    for (j = lastP; j < startN; ++j)
                    {
                        c = (char)(text[j] & 0xff);
                        txt = (c >= ' ' && c < 127) || c == '\r' || c == '\n' || c == '\t';
                        if (txt != lastTxt)
                        {
                            segmentList.add(lastTxt ? 'T' : 'B', lastP, j);
                            lastP = j;
                            lastTxt = txt;
                        }
                    }
                    segmentList.add(lastTxt ? 'T' : 'B', lastP, startN);
                }
                if (nd >= 13)
                    segmentList.add('N', startN, textLength);
                //optimize
                //merge short binary
                for (k = 0; k < segmentList.size(); ++k)
                {
                    v = segmentList.get_Renamed(k);
                    vp = segmentList.get_Renamed(k - 1);
                    vn = segmentList.get_Renamed(k + 1); ;
                    if (checkSegmentType(v, 'B') && getSegmentLength(v) == 1)
                    {
                        if (checkSegmentType(vp, 'T') && checkSegmentType(vn, 'T') && getSegmentLength(vp) + getSegmentLength(vn) >= 3)
                        {
                            vp.end = vn.end;
                            segmentList.remove(k);
                            segmentList.remove(k);
                            k = -1;
                            continue;
                        }
                    }
                }
                //merge text sections
                for (k = 0; k < segmentList.size(); ++k)
                {
                    v = segmentList.get_Renamed(k);
                    vp = segmentList.get_Renamed(k - 1);
                    vn = segmentList.get_Renamed(k + 1); ;
                    if (checkSegmentType(v, 'T') && getSegmentLength(v) >= 5)
                    {
                        bool redo = false;
                        if ((checkSegmentType(vp, 'B') && getSegmentLength(vp) == 1) || checkSegmentType(vp, 'T'))
                        {
                            redo = true;
                            v.start = vp.start;
                            segmentList.remove(k - 1);
                            --k;
                        }
                        if ((checkSegmentType(vn, 'B') && getSegmentLength(vn) == 1) || checkSegmentType(vn, 'T'))
                        {
                            redo = true;
                            v.end = vn.end;
                            segmentList.remove(k + 1);
                        }
                        if (redo)
                        {
                            k = -1;
                            continue;
                        }
                    }
                }
                //merge binary sections
                for (k = 0; k < segmentList.size(); ++k)
                {
                    v = segmentList.get_Renamed(k);
                    vp = segmentList.get_Renamed(k - 1);
                    vn = segmentList.get_Renamed(k + 1); ;
                    if (checkSegmentType(v, 'B'))
                    {
                        bool redo = false;
                        if ((checkSegmentType(vp, 'T') && getSegmentLength(vp) < 5) || checkSegmentType(vp, 'B'))
                        {
                            redo = true;
                            v.start = vp.start;
                            segmentList.remove(k - 1);
                            --k;
                        }
                        if ((checkSegmentType(vn, 'T') && getSegmentLength(vn) < 5) || checkSegmentType(vn, 'B'))
                        {
                            redo = true;
                            v.end = vn.end;
                            segmentList.remove(k + 1);
                        }
                        if (redo)
                        {
                            k = -1;
                            continue;
                        }
                    }
                }
                // check if all numbers
                if (segmentList.size() == 1 && (v = segmentList.get_Renamed(0)).type == 'T' && getSegmentLength(v) >= 8)
                {
                    for (k = v.start; k < v.end; ++k)
                    {
                        c = (char)(text[k] & 0xff);
                        if (c < '0' || c > '9')
                            break;
                    }
                    if (k == v.end)
                        v.type = 'N';
                }
            }

            protected internal virtual void assemble()
            {
                int k;
                if (segmentList.size() == 0)
                    return;
                cwPtr = 1;
                for (k = 0; k < segmentList.size(); ++k)
                {
                    Segment v = segmentList.get_Renamed(k);
                    switch (v.type)
                    {

                        case 'T':
                            if (k != 0)
                                codewords[cwPtr++] = TEXT_MODE;
                            textCompaction(v.start, getSegmentLength(v));
                            break;

                        case 'N':
                            codewords[cwPtr++] = NUMERIC_MODE;
                            numberCompaction(v.start, getSegmentLength(v));
                            break;

                        case 'B':
                            codewords[cwPtr++] = (getSegmentLength(v) % 6) != 0 ? BYTE_MODE : BYTE_MODE_6;
                            byteCompaction(v.start, getSegmentLength(v));
                            break;
                    }
                }
            }

            protected internal static int maxPossibleErrorLevel(int remain)
            {
                int level = 8;
                int size = 512;
                while (level > 0)
                {
                    if (remain >= size)
                        return level;
                    --level;
                    size >>= 1;
                }
                return 0;
            }

            protected internal virtual void dumpList()
            {
                if (segmentList.size() == 0)
                    return;
                for (int k = 0; k < segmentList.size(); ++k)
                {
                    Segment v = segmentList.get_Renamed(k);
                    int len = getSegmentLength(v);
                    char[] c = new char[len];
                    for (int j = 0; j < len; ++j)
                    {
                        c[j] = (char)(text[v.start + j] & 0xff);
                        if (c[j] == '\r')
                            c[j] = '\n';
                    }
                    System.Console.Out.WriteLine("" + v.type + new System.String(c));
                }
            }

            /// <summary>Paints the barcode. If no exception was thrown a valid barcode is available. </summary>
            public virtual void paintCode()
            {
                int maxErr, lenErr, tot, pad;
                if ((options & PDF417_USE_RAW_CODEWORDS) != 0)
                {
                    if (lenCodewords > MAX_DATA_CODEWORDS || lenCodewords < 1 || lenCodewords != codewords[0])
                    {
                        throw new System.ArgumentException("Invalid codeword size.");
                    }
                }
                else
                {
                    if (text == null)
                        throw new System.NullReferenceException("Text cannot be null.");
                    if (text.Length > ABSOLUTE_MAX_TEXT_SIZE)
                    {
                        throw new System.IndexOutOfRangeException("The text is too big.");
                    }
                    segmentList = new SegmentList(this);
                    breakString();
                    //dumpList();
                    assemble();
                    segmentList = null;
                    codewords[0] = lenCodewords = cwPtr;
                }
                maxErr = maxPossibleErrorLevel(MAX_DATA_CODEWORDS + 2 - lenCodewords);
                if ((options & PDF417_USE_ERROR_LEVEL) == 0)
                {
                    if (lenCodewords < 41)
                        errorLevel = 2;
                    else if (lenCodewords < 161)
                        errorLevel = 3;
                    else if (lenCodewords < 321)
                        errorLevel = 4;
                    else
                        errorLevel = 5;
                }
                if (errorLevel < 0)
                    errorLevel = 0;
                else if (errorLevel > maxErr)
                    errorLevel = maxErr;
                if (codeColumns < 1)
                    codeColumns = 1;
                else if (codeColumns > 30)
                    codeColumns = 30;
                if (codeRows < 3)
                    codeRows = 3;
                else if (codeRows > 90)
                    codeRows = 90;
                lenErr = 2 << errorLevel;
                bool fixedColumn = (options & PDF417_FIXED_ROWS) == 0;
                bool skipRowColAdjust = false;
                tot = lenCodewords + lenErr;
                if ((options & PDF417_FIXED_RECTANGLE) != 0)
                {
                    tot = codeColumns * codeRows;
                    if (tot > MAX_DATA_CODEWORDS + 2)
                    {
                        tot = MaxSquare;
                    }
                    if (tot < lenCodewords + lenErr)
                        tot = lenCodewords + lenErr;
                    else
                        skipRowColAdjust = true;
                }
                else if ((options & (PDF417_FIXED_COLUMNS | PDF417_FIXED_ROWS)) == 0)
                {
                    double c, b;
                    fixedColumn = true;
                    if (aspectRatio < 0.001)
                        aspectRatio = 0.001f;
                    else if (aspectRatio > 1000)
                        aspectRatio = 1000;
                    b = 73 * aspectRatio - 4;
                    c = (-b + System.Math.Sqrt(b * b + 4 * 17 * aspectRatio * (lenCodewords + lenErr) * yHeight)) / (2 * 17 * aspectRatio);
                    //UPGRADE_WARNING: Narrowing conversions may produce unexpected results in C#. 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="jlca1042"'
                    codeColumns = (int)(c + 0.5);
                    if (codeColumns < 1)
                        codeColumns = 1;
                    else if (codeColumns > 30)
                        codeColumns = 30;
                }
                if (!skipRowColAdjust)
                {
                    if (fixedColumn)
                    {
                        codeRows = (tot - 1) / codeColumns + 1;
                        if (codeRows < 3)
                            codeRows = 3;
                        else if (codeRows > 90)
                        {
                            codeRows = 90;
                            codeColumns = (tot - 1) / 90 + 1;
                        }
                    }
                    else
                    {
                        codeColumns = (tot - 1) / codeRows + 1;
                        if (codeColumns > 30)
                        {
                            codeColumns = 30;
                            codeRows = (tot - 1) / 30 + 1;
                        }
                    }
                    tot = codeRows * codeColumns;
                }
                if (tot > MAX_DATA_CODEWORDS + 2)
                {
                    tot = MaxSquare;
                }
                errorLevel = maxPossibleErrorLevel(tot - lenCodewords);
                lenErr = 2 << errorLevel;
                pad = tot - lenErr - lenCodewords;
                cwPtr = lenCodewords;
                while (pad-- != 0)
                    codewords[cwPtr++] = TEXT_MODE;
                codewords[0] = lenCodewords = cwPtr;
                calculateErrorCorrection(lenCodewords);
                lenCodewords = tot;
                outPaintCode();
            }

            /// <summary>Gets the bytes that form the barcode. This bytes should
            /// be interpreted in the codepage Cp437.
            /// </summary>
            /// <returns> the bytes that form the barcode
            /// </returns>
            public virtual sbyte[] getText()
            {
                return this.text;
            }

            /// <summary>Sets the bytes that form the barcode. This bytes should
            /// be interpreted in the codepage Cp437.
            /// </summary>
            /// <param name="text">the bytes that form the barcode
            /// </param>
            public virtual void setText(sbyte[] text)
            {
                this.text = text;
            }

            /// <summary>Sets the text that will form the barcode. This text is converted
            /// to bytes using the encoding Cp437.
            /// </summary>
            /// <param name="s">the text that will form the barcode
            /// @throws UnsupportedEncodingException if the encoding Cp437 is not supported
            /// </param>
            public virtual void setText(System.String s)
            {
                sbyte bValue;
                //UPGRADE_ISSUE: Method 'java.lang.String.getBytes' was not converted. 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="jlca1000_javalangStringgetBytes_javalangString"'
                //TypeDescriptor.GetConverter(mySByte).ConvertFrom(mySByteStr);
                //this.text = (sbyte[])TypeDescriptor.GetConverter(this.text).ConvertFrom("Cp437");

                //sbyte []sValue = new sbyte[300];


                //		sValue[0] = Convert.ToSByte('t');
                //		sValue[1] = Convert.ToSByte('e');
                //		sValue[2] = Convert.ToSByte('s');
                //		sValue[3] = Convert.ToSByte('t');
                this.text = Filter(s);
                //this.text = Convert.ToSByte("Cp437");
                //this.text = 
                //this.text = (sbyte)("Cp437");

            }

            internal protected sbyte[] Filter(string sValue)
            {
                sbyte[] sArray = new sbyte[300];

                try
                {
                    Char[] cArray = sValue.ToCharArray();

                    for (int k = 0; k < cArray.Length; k++)
                    {
                        sArray[k] = Convert.ToSByte(cArray[k]);
                    }

                    return sArray;
                }
                catch (Exception e)
                {
                    //MessageBox.Show(e.Message, "Error",
                    //	MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                    return null;
                }
            }

            protected internal const int START_PATTERN = 0x1fea8;
            protected internal const int STOP_PATTERN = 0x3fa29;
            protected internal const int START_CODE_SIZE = 17;
            protected internal const int STOP_SIZE = 18;
            protected internal const int MOD = 929;
            protected internal const int ALPHA = 0x10000;
            protected internal const int LOWER = 0x20000;
            protected internal const int MIXED = 0x40000;
            protected internal const int PUNCTUATION = 0x80000;
            protected internal const int ISBYTE = 0x100000;
            protected internal const int BYTESHIFT = 913;
            protected internal const int PL = 25;
            protected internal const int LL = 27;
            protected internal const int AS = 27;
            protected internal const int ML = 28;
            protected internal const int AL = 28;
            protected internal const int PS = 29;
            protected internal const int PAL = 29;
            protected internal const int SPACE = 26;
            protected internal const int TEXT_MODE = 900;
            protected internal const int BYTE_MODE_6 = 924;
            protected internal const int BYTE_MODE = 901;
            protected internal const int NUMERIC_MODE = 902;
            protected internal const int ABSOLUTE_MAX_TEXT_SIZE = 5420;
            protected internal const int MAX_DATA_CODEWORDS = 926;

            internal static System.String MIXED_SET = "0123456789&\r\t,:#-.$/+%*=^";
            internal static System.String PUNCTUATION_SET = ";<>@[\\]_`~!\r\t,:\n-.$/\"|*()?{}'";

            internal static int[][] CLUSTERS = {new int[]{0x1d5c0, 0x1eaf0, 0x1f57c, 0x1d4e0, 0x1ea78, 0x1f53e, 0x1a8c0, 0x1d470, 0x1a860, 0x15040, 0x1a830, 0x15020, 0x1adc0, 0x1d6f0, 0x1eb7c, 0x1ace0, 0x1d678, 0x1eb3e, 0x158c0, 0x1ac70, 0x15860, 0x15dc0, 0x1aef0, 0x1d77c, 0x15ce0, 0x1ae78, 0x1d73e, 0x15c70, 0x1ae3c, 0x15ef0, 0x1af7c, 0x15e78, 0x1af3e, 0x15f7c, 0x1f5fa, 0x1d2e0, 0x1e978, 0x1f4be, 0x1a4c0, 0x1d270, 0x1e93c, 0x1a460, 0x1d238, 0x14840, 0x1a430, 0x1d21c, 0x14820, 0x1a418, 0x14810, 0x1a6e0, 0x1d378, 0x1e9be, 0x14cc0, 0x1a670, 0x1d33c, 0x14c60, 0x1a638, 0x1d31e, 0x14c30, 0x1a61c, 0x14ee0, 0x1a778, 0x1d3be, 0x14e70, 0x1a73c, 0x14e38, 0x1a71e, 0x14f78, 0x1a7be, 0x14f3c, 0x14f1e, 0x1a2c0, 0x1d170, 0x1e8bc, 0x1a260, 0x1d138, 0x1e89e, 0x14440, 0x1a230, 0x1d11c, 0x14420, 0x1a218, 0x14410, 0x14408, 0x146c0, 0x1a370, 0x1d1bc, 0x14660, 0x1a338, 0x1d19e, 0x14630, 0x1a31c, 0x14618, 0x1460c, 0x14770, 0x1a3bc, 0x14738, 0x1a39e, 0x1471c, 0x147bc, 0x1a160, 0x1d0b8, 0x1e85e, 0x14240, 0x1a130, 0x1d09c, 0x14220, 0x1a118, 0x1d08e, 0x14210, 0x1a10c, 0x14208, 0x1a106, 0x14360, 0x1a1b8, 0x1d0de, 0x14330, 0x1a19c, 0x14318, 0x1a18e, 0x1430c, 0x14306, 0x1a1de, 0x1438e, 0x14140, 0x1a0b0, 0x1d05c, 0x14120, 0x1a098, 0x1d04e, 0x14110, 0x1a08c, 0x14108, 0x1a086, 0x14104, 0x141b0, 0x14198, 0x1418c, 0x140a0, 0x1d02e, 0x1a04c, 0x1a046, 0x14082, 0x1cae0, 0x1e578, 0x1f2be, 0x194c0, 0x1ca70, 0x1e53c, 0x19460, 0x1ca38, 0x1e51e, 0x12840, 0x19430, 0x12820, 0x196e0, 0x1cb78, 0x1e5be, 0x12cc0, 0x19670, 0x1cb3c, 0x12c60, 0x19638, 0x12c30, 0x12c18, 0x12ee0, 0x19778, 0x1cbbe, 0x12e70, 0x1973c, 0x12e38, 0x12e1c, 0x12f78, 0x197be, 0x12f3c, 0x12fbe, 0x1dac0, 0x1ed70, 0x1f6bc, 0x1da60, 0x1ed38, 0x1f69e, 0x1b440, 0x1da30, 0x1ed1c, 0x1b420, 0x1da18, 0x1ed0e, 0x1b410, 0x1da0c, 0x192c0, 0x1c970, 0x1e4bc, 0x1b6c0, 0x19260, 0x1c938, 0x1e49e, 0x1b660, 0x1db38, 0x1ed9e, 0x16c40, 0x12420, 0x19218, 0x1c90e, 0x16c20, 0x1b618, 0x16c10, 0x126c0, 0x19370, 0x1c9bc, 0x16ec0, 0x12660, 0x19338, 0x1c99e, 0x16e60, 0x1b738, 0x1db9e, 0x16e30, 0x12618, 0x16e18, 0x12770, 
		0x193bc, 0x16f70, 0x12738, 0x1939e, 0x16f38, 0x1b79e, 0x16f1c, 0x127bc, 0x16fbc, 0x1279e, 0x16f9e, 0x1d960, 0x1ecb8, 0x1f65e, 0x1b240, 0x1d930, 0x1ec9c, 0x1b220, 0x1d918, 0x1ec8e, 0x1b210, 0x1d90c, 0x1b208, 0x1b204, 0x19160, 0x1c8b8, 0x1e45e, 0x1b360, 0x19130, 0x1c89c, 0x16640, 0x12220, 0x1d99c, 0x1c88e, 0x16620, 0x12210, 0x1910c, 0x16610, 0x1b30c, 0x19106, 0x12204, 0x12360, 0x191b8, 0x1c8de, 0x16760, 0x12330, 0x1919c, 0x16730, 0x1b39c, 0x1918e, 0x16718, 0x1230c, 0x12306, 0x123b8, 0x191de, 0x167b8, 0x1239c, 0x1679c, 0x1238e, 0x1678e, 0x167de, 0x1b140, 0x1d8b0, 0x1ec5c, 0x1b120, 0x1d898, 0x1ec4e, 0x1b110, 0x1d88c, 0x1b108, 0x1d886, 0x1b104, 0x1b102, 0x12140, 0x190b0, 0x1c85c, 0x16340, 0x12120, 0x19098, 0x1c84e, 0x16320, 0x1b198, 0x1d8ce, 0x16310, 0x12108, 0x19086, 0x16308, 0x1b186, 0x16304, 0x121b0, 0x190dc, 0x163b0, 0x12198, 0x190ce, 0x16398, 0x1b1ce, 0x1638c, 0x12186, 0x16386, 0x163dc, 0x163ce, 0x1b0a0, 0x1d858, 0x1ec2e, 0x1b090, 0x1d84c, 0x1b088, 0x1d846, 0x1b084, 0x1b082, 0x120a0, 0x19058, 0x1c82e, 0x161a0, 0x12090, 0x1904c, 0x16190, 0x1b0cc, 0x19046, 0x16188, 0x12084, 0x16184, 0x12082, 0x120d8, 0x161d8, 0x161cc, 0x161c6, 0x1d82c, 0x1d826, 0x1b042, 0x1902c, 0x12048, 0x160c8, 0x160c4, 0x160c2, 0x18ac0, 0x1c570, 0x1e2bc, 0x18a60, 0x1c538, 0x11440, 0x18a30, 0x1c51c, 0x11420, 0x18a18, 0x11410, 0x11408, 0x116c0, 0x18b70, 0x1c5bc, 0x11660, 0x18b38, 0x1c59e, 0x11630, 0x18b1c, 0x11618, 0x1160c, 0x11770, 0x18bbc, 0x11738, 0x18b9e, 0x1171c, 0x117bc, 0x1179e, 0x1cd60, 0x1e6b8, 0x1f35e, 0x19a40, 0x1cd30, 0x1e69c, 0x19a20, 0x1cd18, 0x1e68e, 0x19a10, 0x1cd0c, 0x19a08, 0x1cd06, 0x18960, 0x1c4b8, 0x1e25e, 0x19b60, 0x18930, 0x1c49c, 0x13640, 0x11220, 0x1cd9c, 0x1c48e, 0x13620, 0x19b18, 0x1890c, 0x13610, 0x11208, 0x13608, 0x11360, 0x189b8, 0x1c4de, 0x13760, 0x11330, 0x1cdde, 0x13730, 0x19b9c, 0x1898e, 0x13718, 0x1130c, 0x1370c, 0x113b8, 0x189de, 0x137b8, 0x1139c, 0x1379c, 0x1138e, 0x113de, 0x137de, 0x1dd40, 0x1eeb0, 0x1f75c, 0x1dd20, 0x1ee98, 0x1f74e, 0x1dd10, 0x1ee8c, 0x1dd08, 0x1ee86, 0x1dd04, 0x19940, 0x1ccb0, 
		0x1e65c, 0x1bb40, 0x19920, 0x1eedc, 0x1e64e, 0x1bb20, 0x1dd98, 0x1eece, 0x1bb10, 0x19908, 0x1cc86, 0x1bb08, 0x1dd86, 0x19902, 0x11140, 0x188b0, 0x1c45c, 0x13340, 0x11120, 0x18898, 0x1c44e, 0x17740, 0x13320, 0x19998, 0x1ccce, 0x17720, 0x1bb98, 0x1ddce, 0x18886, 0x17710, 0x13308, 0x19986, 0x17708, 0x11102, 0x111b0, 0x188dc, 0x133b0, 0x11198, 0x188ce, 0x177b0, 0x13398, 0x199ce, 0x17798, 0x1bbce, 0x11186, 0x13386, 0x111dc, 0x133dc, 0x111ce, 0x177dc, 0x133ce, 0x1dca0, 0x1ee58, 0x1f72e, 0x1dc90, 0x1ee4c, 0x1dc88, 0x1ee46, 0x1dc84, 0x1dc82, 0x198a0, 0x1cc58, 0x1e62e, 0x1b9a0, 0x19890, 0x1ee6e, 0x1b990, 0x1dccc, 0x1cc46, 0x1b988, 0x19884, 0x1b984, 0x19882, 0x1b982, 0x110a0, 0x18858, 0x1c42e, 0x131a0, 0x11090, 0x1884c, 0x173a0, 0x13190, 0x198cc, 0x18846, 0x17390, 0x1b9cc, 0x11084, 0x17388, 0x13184, 0x11082, 0x13182, 0x110d8, 0x1886e, 0x131d8, 0x110cc, 0x173d8, 0x131cc, 0x110c6, 0x173cc, 0x131c6, 0x110ee, 0x173ee, 0x1dc50, 0x1ee2c, 0x1dc48, 0x1ee26, 0x1dc44, 0x1dc42, 0x19850, 0x1cc2c, 0x1b8d0, 0x19848, 0x1cc26, 0x1b8c8, 0x1dc66, 0x1b8c4, 0x19842, 0x1b8c2, 0x11050, 0x1882c, 0x130d0, 0x11048, 0x18826, 0x171d0, 0x130c8, 0x19866, 0x171c8, 0x1b8e6, 0x11042, 0x171c4, 0x130c2, 0x171c2, 0x130ec, 0x171ec, 0x171e6, 0x1ee16, 0x1dc22, 0x1cc16, 0x19824, 0x19822, 0x11028, 0x13068, 0x170e8, 0x11022, 0x13062, 0x18560, 0x10a40, 0x18530, 0x10a20, 0x18518, 0x1c28e, 0x10a10, 0x1850c, 0x10a08, 0x18506, 0x10b60, 0x185b8, 0x1c2de, 0x10b30, 0x1859c, 0x10b18, 0x1858e, 0x10b0c, 0x10b06, 0x10bb8, 0x185de, 0x10b9c, 0x10b8e, 0x10bde, 0x18d40, 0x1c6b0, 0x1e35c, 0x18d20, 0x1c698, 0x18d10, 0x1c68c, 0x18d08, 0x1c686, 0x18d04, 0x10940, 0x184b0, 0x1c25c, 0x11b40, 0x10920, 0x1c6dc, 0x1c24e, 0x11b20, 0x18d98, 0x1c6ce, 0x11b10, 0x10908, 0x18486, 0x11b08, 0x18d86, 0x10902, 0x109b0, 0x184dc, 0x11bb0, 0x10998, 0x184ce, 0x11b98, 0x18dce, 0x11b8c, 0x10986, 0x109dc, 0x11bdc, 0x109ce, 0x11bce, 0x1cea0, 0x1e758, 0x1f3ae, 0x1ce90, 0x1e74c, 0x1ce88, 0x1e746, 0x1ce84, 0x1ce82, 0x18ca0, 0x1c658, 0x19da0, 0x18c90, 0x1c64c, 0x19d90, 0x1cecc, 0x1c646, 0x19d88, 
		0x18c84, 0x19d84, 0x18c82, 0x19d82, 0x108a0, 0x18458, 0x119a0, 0x10890, 0x1c66e, 0x13ba0, 0x11990, 0x18ccc, 0x18446, 0x13b90, 0x19dcc, 0x10884, 0x13b88, 0x11984, 0x10882, 0x11982, 0x108d8, 0x1846e, 0x119d8, 0x108cc, 0x13bd8, 0x119cc, 0x108c6, 0x13bcc, 0x119c6, 0x108ee, 0x119ee, 0x13bee, 0x1ef50, 0x1f7ac, 0x1ef48, 0x1f7a6, 0x1ef44, 0x1ef42, 0x1ce50, 0x1e72c, 0x1ded0, 0x1ef6c, 0x1e726, 0x1dec8, 0x1ef66, 0x1dec4, 0x1ce42, 0x1dec2, 0x18c50, 0x1c62c, 0x19cd0, 0x18c48, 0x1c626, 0x1bdd0, 0x19cc8, 0x1ce66, 0x1bdc8, 0x1dee6, 0x18c42, 0x1bdc4, 0x19cc2, 0x1bdc2, 0x10850, 0x1842c, 0x118d0, 0x10848, 0x18426, 0x139d0, 0x118c8, 0x18c66, 0x17bd0, 0x139c8, 0x19ce6, 0x10842, 0x17bc8, 0x1bde6, 0x118c2, 0x17bc4, 0x1086c, 0x118ec, 0x10866, 0x139ec, 0x118e6, 0x17bec, 0x139e6, 0x17be6, 0x1ef28, 0x1f796, 0x1ef24, 0x1ef22, 0x1ce28, 0x1e716, 0x1de68, 0x1ef36, 0x1de64, 0x1ce22, 0x1de62, 0x18c28, 0x1c616, 0x19c68, 0x18c24, 0x1bce8, 0x19c64, 0x18c22, 0x1bce4, 0x19c62, 0x1bce2, 0x10828, 0x18416, 0x11868, 0x18c36, 0x138e8, 0x11864, 0x10822, 0x179e8, 0x138e4, 0x11862, 0x179e4, 0x138e2, 0x179e2, 0x11876, 0x179f6, 0x1ef12, 0x1de34, 0x1de32, 0x19c34, 0x1bc74, 0x1bc72, 0x11834, 0x13874, 0x178f4, 0x178f2, 0x10540, 0x10520, 0x18298, 0x10510, 0x10508, 0x10504, 0x105b0, 0x10598, 0x1058c, 0x10586, 0x105dc, 0x105ce, 0x186a0, 0x18690, 0x1c34c, 0x18688, 0x1c346, 0x18684, 0x18682, 0x104a0, 0x18258, 0x10da0, 0x186d8, 0x1824c, 0x10d90, 0x186cc, 0x10d88, 0x186c6, 0x10d84, 0x10482, 0x10d82, 0x104d8, 0x1826e, 0x10dd8, 0x186ee, 0x10dcc, 0x104c6, 0x10dc6, 0x104ee, 0x10dee, 0x1c750, 0x1c748, 0x1c744, 0x1c742, 0x18650, 0x18ed0, 0x1c76c, 0x1c326, 0x18ec8, 0x1c766, 0x18ec4, 0x18642, 0x18ec2, 0x10450, 0x10cd0, 0x10448, 0x18226, 0x11dd0, 0x10cc8, 0x10444, 0x11dc8, 0x10cc4, 0x10442, 0x11dc4, 0x10cc2, 0x1046c, 0x10cec, 0x10466, 0x11dec, 0x10ce6, 0x11de6, 0x1e7a8, 0x1e7a4, 0x1e7a2, 0x1c728, 0x1cf68, 0x1e7b6, 0x1cf64, 0x1c722, 0x1cf62, 0x18628, 0x1c316, 0x18e68, 0x1c736, 0x19ee8, 0x18e64, 0x18622, 0x19ee4, 0x18e62, 0x19ee2, 0x10428, 0x18216, 0x10c68, 0x18636, 
		0x11ce8, 0x10c64, 0x10422, 0x13de8, 0x11ce4, 0x10c62, 0x13de4, 0x11ce2, 0x10436, 0x10c76, 0x11cf6, 0x13df6, 0x1f7d4, 0x1f7d2, 0x1e794, 0x1efb4, 0x1e792, 0x1efb2, 0x1c714, 0x1cf34, 0x1c712, 0x1df74, 0x1cf32, 0x1df72, 0x18614, 0x18e34, 0x18612, 0x19e74, 0x18e32, 0x1bef4}, new int[]{0x1f560, 0x1fab8, 0x1ea40, 0x1f530, 0x1fa9c, 0x1ea20, 0x1f518, 0x1fa8e, 0x1ea10, 0x1f50c, 0x1ea08, 0x1f506, 0x1ea04, 0x1eb60, 0x1f5b8, 0x1fade, 0x1d640, 0x1eb30, 0x1f59c, 0x1d620, 0x1eb18, 0x1f58e, 0x1d610, 0x1eb0c, 0x1d608, 0x1eb06, 0x1d604, 0x1d760, 0x1ebb8, 0x1f5de, 0x1ae40, 0x1d730, 0x1eb9c, 0x1ae20, 0x1d718, 0x1eb8e, 0x1ae10, 0x1d70c, 0x1ae08, 0x1d706, 0x1ae04, 0x1af60, 0x1d7b8, 0x1ebde, 0x15e40, 0x1af30, 0x1d79c, 0x15e20, 0x1af18, 0x1d78e, 0x15e10, 0x1af0c, 0x15e08, 0x1af06, 0x15f60, 0x1afb8, 0x1d7de, 0x15f30, 0x1af9c, 0x15f18, 0x1af8e, 0x15f0c, 0x15fb8, 0x1afde, 0x15f9c, 0x15f8e, 0x1e940, 0x1f4b0, 0x1fa5c, 0x1e920, 0x1f498, 0x1fa4e, 0x1e910, 0x1f48c, 0x1e908, 0x1f486, 0x1e904, 0x1e902, 0x1d340, 0x1e9b0, 0x1f4dc, 0x1d320, 0x1e998, 0x1f4ce, 0x1d310, 0x1e98c, 0x1d308, 0x1e986, 0x1d304, 0x1d302, 0x1a740, 0x1d3b0, 0x1e9dc, 0x1a720, 0x1d398, 0x1e9ce, 0x1a710, 0x1d38c, 0x1a708, 0x1d386, 0x1a704, 0x1a702, 0x14f40, 0x1a7b0, 0x1d3dc, 0x14f20, 0x1a798, 0x1d3ce, 0x14f10, 0x1a78c, 0x14f08, 0x1a786, 0x14f04, 0x14fb0, 0x1a7dc, 0x14f98, 0x1a7ce, 0x14f8c, 0x14f86, 0x14fdc, 0x14fce, 0x1e8a0, 0x1f458, 0x1fa2e, 0x1e890, 0x1f44c, 0x1e888, 0x1f446, 0x1e884, 0x1e882, 0x1d1a0, 0x1e8d8, 0x1f46e, 0x1d190, 0x1e8cc, 0x1d188, 0x1e8c6, 0x1d184, 0x1d182, 0x1a3a0, 0x1d1d8, 0x1e8ee, 0x1a390, 0x1d1cc, 0x1a388, 0x1d1c6, 0x1a384, 0x1a382, 0x147a0, 0x1a3d8, 0x1d1ee, 0x14790, 0x1a3cc, 0x14788, 0x1a3c6, 0x14784, 0x14782, 0x147d8, 0x1a3ee, 0x147cc, 0x147c6, 0x147ee, 0x1e850, 0x1f42c, 0x1e848, 0x1f426, 0x1e844, 0x1e842, 0x1d0d0, 0x1e86c, 0x1d0c8, 0x1e866, 0x1d0c4, 0x1d0c2, 0x1a1d0, 0x1d0ec, 0x1a1c8, 0x1d0e6, 0x1a1c4, 0x1a1c2, 0x143d0, 0x1a1ec, 0x143c8, 0x1a1e6, 0x143c4, 0x143c2, 0x143ec, 0x143e6, 0x1e828, 0x1f416, 0x1e824, 0x1e822, 0x1d068, 0x1e836, 0x1d064, 
		0x1d062, 0x1a0e8, 0x1d076, 0x1a0e4, 0x1a0e2, 0x141e8, 0x1a0f6, 0x141e4, 0x141e2, 0x1e814, 0x1e812, 0x1d034, 0x1d032, 0x1a074, 0x1a072, 0x1e540, 0x1f2b0, 0x1f95c, 0x1e520, 0x1f298, 0x1f94e, 0x1e510, 0x1f28c, 0x1e508, 0x1f286, 0x1e504, 0x1e502, 0x1cb40, 0x1e5b0, 0x1f2dc, 0x1cb20, 0x1e598, 0x1f2ce, 0x1cb10, 0x1e58c, 0x1cb08, 0x1e586, 0x1cb04, 0x1cb02, 0x19740, 0x1cbb0, 0x1e5dc, 0x19720, 0x1cb98, 0x1e5ce, 0x19710, 0x1cb8c, 0x19708, 0x1cb86, 0x19704, 0x19702, 0x12f40, 0x197b0, 0x1cbdc, 0x12f20, 0x19798, 0x1cbce, 0x12f10, 0x1978c, 0x12f08, 0x19786, 0x12f04, 0x12fb0, 0x197dc, 0x12f98, 0x197ce, 0x12f8c, 0x12f86, 0x12fdc, 0x12fce, 0x1f6a0, 0x1fb58, 0x16bf0, 0x1f690, 0x1fb4c, 0x169f8, 0x1f688, 0x1fb46, 0x168fc, 0x1f684, 0x1f682, 0x1e4a0, 0x1f258, 0x1f92e, 0x1eda0, 0x1e490, 0x1fb6e, 0x1ed90, 0x1f6cc, 0x1f246, 0x1ed88, 0x1e484, 0x1ed84, 0x1e482, 0x1ed82, 0x1c9a0, 0x1e4d8, 0x1f26e, 0x1dba0, 0x1c990, 0x1e4cc, 0x1db90, 0x1edcc, 0x1e4c6, 0x1db88, 0x1c984, 0x1db84, 0x1c982, 0x1db82, 0x193a0, 0x1c9d8, 0x1e4ee, 0x1b7a0, 0x19390, 0x1c9cc, 0x1b790, 0x1dbcc, 0x1c9c6, 0x1b788, 0x19384, 0x1b784, 0x19382, 0x1b782, 0x127a0, 0x193d8, 0x1c9ee, 0x16fa0, 0x12790, 0x193cc, 0x16f90, 0x1b7cc, 0x193c6, 0x16f88, 0x12784, 0x16f84, 0x12782, 0x127d8, 0x193ee, 0x16fd8, 0x127cc, 0x16fcc, 0x127c6, 0x16fc6, 0x127ee, 0x1f650, 0x1fb2c, 0x165f8, 0x1f648, 0x1fb26, 0x164fc, 0x1f644, 0x1647e, 0x1f642, 0x1e450, 0x1f22c, 0x1ecd0, 0x1e448, 0x1f226, 0x1ecc8, 0x1f666, 0x1ecc4, 0x1e442, 0x1ecc2, 0x1c8d0, 0x1e46c, 0x1d9d0, 0x1c8c8, 0x1e466, 0x1d9c8, 0x1ece6, 0x1d9c4, 0x1c8c2, 0x1d9c2, 0x191d0, 0x1c8ec, 0x1b3d0, 0x191c8, 0x1c8e6, 0x1b3c8, 0x1d9e6, 0x1b3c4, 0x191c2, 0x1b3c2, 0x123d0, 0x191ec, 0x167d0, 0x123c8, 0x191e6, 0x167c8, 0x1b3e6, 0x167c4, 0x123c2, 0x167c2, 0x123ec, 0x167ec, 0x123e6, 0x167e6, 0x1f628, 0x1fb16, 0x162fc, 0x1f624, 0x1627e, 0x1f622, 0x1e428, 0x1f216, 0x1ec68, 0x1f636, 0x1ec64, 0x1e422, 0x1ec62, 0x1c868, 0x1e436, 0x1d8e8, 0x1c864, 0x1d8e4, 0x1c862, 0x1d8e2, 0x190e8, 0x1c876, 0x1b1e8, 0x1d8f6, 0x1b1e4, 0x190e2, 0x1b1e2, 0x121e8, 0x190f6, 
		0x163e8, 0x121e4, 0x163e4, 0x121e2, 0x163e2, 0x121f6, 0x163f6, 0x1f614, 0x1617e, 0x1f612, 0x1e414, 0x1ec34, 0x1e412, 0x1ec32, 0x1c834, 0x1d874, 0x1c832, 0x1d872, 0x19074, 0x1b0f4, 0x19072, 0x1b0f2, 0x120f4, 0x161f4, 0x120f2, 0x161f2, 0x1f60a, 0x1e40a, 0x1ec1a, 0x1c81a, 0x1d83a, 0x1903a, 0x1b07a, 0x1e2a0, 0x1f158, 0x1f8ae, 0x1e290, 0x1f14c, 0x1e288, 0x1f146, 0x1e284, 0x1e282, 0x1c5a0, 0x1e2d8, 0x1f16e, 0x1c590, 0x1e2cc, 0x1c588, 0x1e2c6, 0x1c584, 0x1c582, 0x18ba0, 0x1c5d8, 0x1e2ee, 0x18b90, 0x1c5cc, 0x18b88, 0x1c5c6, 0x18b84, 0x18b82, 0x117a0, 0x18bd8, 0x1c5ee, 0x11790, 0x18bcc, 0x11788, 0x18bc6, 0x11784, 0x11782, 0x117d8, 0x18bee, 0x117cc, 0x117c6, 0x117ee, 0x1f350, 0x1f9ac, 0x135f8, 0x1f348, 0x1f9a6, 0x134fc, 0x1f344, 0x1347e, 0x1f342, 0x1e250, 0x1f12c, 0x1e6d0, 0x1e248, 0x1f126, 0x1e6c8, 0x1f366, 0x1e6c4, 0x1e242, 0x1e6c2, 0x1c4d0, 0x1e26c, 0x1cdd0, 0x1c4c8, 0x1e266, 0x1cdc8, 0x1e6e6, 0x1cdc4, 0x1c4c2, 0x1cdc2, 0x189d0, 0x1c4ec, 0x19bd0, 0x189c8, 0x1c4e6, 0x19bc8, 0x1cde6, 0x19bc4, 0x189c2, 0x19bc2, 0x113d0, 0x189ec, 0x137d0, 0x113c8, 0x189e6, 0x137c8, 0x19be6, 0x137c4, 0x113c2, 0x137c2, 0x113ec, 0x137ec, 0x113e6, 0x137e6, 0x1fba8, 0x175f0, 0x1bafc, 0x1fba4, 0x174f8, 0x1ba7e, 0x1fba2, 0x1747c, 0x1743e, 0x1f328, 0x1f996, 0x132fc, 0x1f768, 0x1fbb6, 0x176fc, 0x1327e, 0x1f764, 0x1f322, 0x1767e, 0x1f762, 0x1e228, 0x1f116, 0x1e668, 0x1e224, 0x1eee8, 0x1f776, 0x1e222, 0x1eee4, 0x1e662, 0x1eee2, 0x1c468, 0x1e236, 0x1cce8, 0x1c464, 0x1dde8, 0x1cce4, 0x1c462, 0x1dde4, 0x1cce2, 0x1dde2, 0x188e8, 0x1c476, 0x199e8, 0x188e4, 0x1bbe8, 0x199e4, 0x188e2, 0x1bbe4, 0x199e2, 0x1bbe2, 0x111e8, 0x188f6, 0x133e8, 0x111e4, 0x177e8, 0x133e4, 0x111e2, 0x177e4, 0x133e2, 0x177e2, 0x111f6, 0x133f6, 0x1fb94, 0x172f8, 0x1b97e, 0x1fb92, 0x1727c, 0x1723e, 0x1f314, 0x1317e, 0x1f734, 0x1f312, 0x1737e, 0x1f732, 0x1e214, 0x1e634, 0x1e212, 0x1ee74, 0x1e632, 0x1ee72, 0x1c434, 0x1cc74, 0x1c432, 0x1dcf4, 0x1cc72, 0x1dcf2, 0x18874, 0x198f4, 0x18872, 0x1b9f4, 0x198f2, 0x1b9f2, 0x110f4, 0x131f4, 0x110f2, 0x173f4, 0x131f2, 0x173f2, 0x1fb8a, 
		0x1717c, 0x1713e, 0x1f30a, 0x1f71a, 0x1e20a, 0x1e61a, 0x1ee3a, 0x1c41a, 0x1cc3a, 0x1dc7a, 0x1883a, 0x1987a, 0x1b8fa, 0x1107a, 0x130fa, 0x171fa, 0x170be, 0x1e150, 0x1f0ac, 0x1e148, 0x1f0a6, 0x1e144, 0x1e142, 0x1c2d0, 0x1e16c, 0x1c2c8, 0x1e166, 0x1c2c4, 0x1c2c2, 0x185d0, 0x1c2ec, 0x185c8, 0x1c2e6, 0x185c4, 0x185c2, 0x10bd0, 0x185ec, 0x10bc8, 0x185e6, 0x10bc4, 0x10bc2, 0x10bec, 0x10be6, 0x1f1a8, 0x1f8d6, 0x11afc, 0x1f1a4, 0x11a7e, 0x1f1a2, 0x1e128, 0x1f096, 0x1e368, 0x1e124, 0x1e364, 0x1e122, 0x1e362, 0x1c268, 0x1e136, 0x1c6e8, 0x1c264, 0x1c6e4, 0x1c262, 0x1c6e2, 0x184e8, 0x1c276, 0x18de8, 0x184e4, 0x18de4, 0x184e2, 0x18de2, 0x109e8, 0x184f6, 0x11be8, 0x109e4, 0x11be4, 0x109e2, 0x11be2, 0x109f6, 0x11bf6, 0x1f9d4, 0x13af8, 0x19d7e, 0x1f9d2, 0x13a7c, 0x13a3e, 0x1f194, 0x1197e, 0x1f3b4, 0x1f192, 0x13b7e, 0x1f3b2, 0x1e114, 0x1e334, 0x1e112, 0x1e774, 0x1e332, 0x1e772, 0x1c234, 0x1c674, 0x1c232, 0x1cef4, 0x1c672, 0x1cef2, 0x18474, 0x18cf4, 0x18472, 0x19df4, 0x18cf2, 0x19df2, 0x108f4, 0x119f4, 0x108f2, 0x13bf4, 0x119f2, 0x13bf2, 0x17af0, 0x1bd7c, 0x17a78, 0x1bd3e, 0x17a3c, 0x17a1e, 0x1f9ca, 0x1397c, 0x1fbda, 0x17b7c, 0x1393e, 0x17b3e, 0x1f18a, 0x1f39a, 0x1f7ba, 0x1e10a, 0x1e31a, 0x1e73a, 0x1ef7a, 0x1c21a, 0x1c63a, 0x1ce7a, 0x1defa, 0x1843a, 0x18c7a, 0x19cfa, 0x1bdfa, 0x1087a, 0x118fa, 0x139fa, 0x17978, 0x1bcbe, 0x1793c, 0x1791e, 0x138be, 0x179be, 0x178bc, 0x1789e, 0x1785e, 0x1e0a8, 0x1e0a4, 0x1e0a2, 0x1c168, 0x1e0b6, 0x1c164, 0x1c162, 0x182e8, 0x1c176, 0x182e4, 0x182e2, 0x105e8, 0x182f6, 0x105e4, 0x105e2, 0x105f6, 0x1f0d4, 0x10d7e, 0x1f0d2, 0x1e094, 0x1e1b4, 0x1e092, 0x1e1b2, 0x1c134, 0x1c374, 0x1c132, 0x1c372, 0x18274, 0x186f4, 0x18272, 0x186f2, 0x104f4, 0x10df4, 0x104f2, 0x10df2, 0x1f8ea, 0x11d7c, 0x11d3e, 0x1f0ca, 0x1f1da, 0x1e08a, 0x1e19a, 0x1e3ba, 0x1c11a, 0x1c33a, 0x1c77a, 0x1823a, 0x1867a, 0x18efa, 0x1047a, 0x10cfa, 0x11dfa, 0x13d78, 0x19ebe, 0x13d3c, 0x13d1e, 0x11cbe, 0x13dbe, 0x17d70, 0x1bebc, 0x17d38, 0x1be9e, 0x17d1c, 0x17d0e, 0x13cbc, 0x17dbc, 0x13c9e, 0x17d9e, 0x17cb8, 0x1be5e, 0x17c9c, 0x17c8e, 
		0x13c5e, 0x17cde, 0x17c5c, 0x17c4e, 0x17c2e, 0x1c0b4, 0x1c0b2, 0x18174, 0x18172, 0x102f4, 0x102f2, 0x1e0da, 0x1c09a, 0x1c1ba, 0x1813a, 0x1837a, 0x1027a, 0x106fa, 0x10ebe, 0x11ebc, 0x11e9e, 0x13eb8, 0x19f5e, 0x13e9c, 0x13e8e, 0x11e5e, 0x13ede, 0x17eb0, 0x1bf5c, 0x17e98, 0x1bf4e, 0x17e8c, 0x17e86, 0x13e5c, 0x17edc, 0x13e4e, 0x17ece, 0x17e58, 0x1bf2e, 0x17e4c, 0x17e46, 0x13e2e, 0x17e6e, 0x17e2c, 0x17e26, 0x10f5e, 0x11f5c, 0x11f4e, 0x13f58, 0x19fae, 0x13f4c, 0x13f46, 0x11f2e, 0x13f6e, 0x13f2c, 0x13f26}, new int[]{0x1abe0, 0x1d5f8, 0x153c0, 0x1a9f0, 0x1d4fc, 0x151e0, 0x1a8f8, 0x1d47e, 0x150f0, 0x1a87c, 0x15078, 0x1fad0, 0x15be0, 0x1adf8, 0x1fac8, 0x159f0, 0x1acfc, 0x1fac4, 0x158f8, 0x1ac7e, 0x1fac2, 0x1587c, 0x1f5d0, 0x1faec, 0x15df8, 0x1f5c8, 0x1fae6, 0x15cfc, 0x1f5c4, 0x15c7e, 0x1f5c2, 0x1ebd0, 0x1f5ec, 0x1ebc8, 0x1f5e6, 0x1ebc4, 0x1ebc2, 0x1d7d0, 0x1ebec, 0x1d7c8, 0x1ebe6, 0x1d7c4, 0x1d7c2, 0x1afd0, 0x1d7ec, 0x1afc8, 0x1d7e6, 0x1afc4, 0x14bc0, 0x1a5f0, 0x1d2fc, 0x149e0, 0x1a4f8, 0x1d27e, 0x148f0, 0x1a47c, 0x14878, 0x1a43e, 0x1483c, 0x1fa68, 0x14df0, 0x1a6fc, 0x1fa64, 0x14cf8, 0x1a67e, 0x1fa62, 0x14c7c, 0x14c3e, 0x1f4e8, 0x1fa76, 0x14efc, 0x1f4e4, 0x14e7e, 0x1f4e2, 0x1e9e8, 0x1f4f6, 0x1e9e4, 0x1e9e2, 0x1d3e8, 0x1e9f6, 0x1d3e4, 0x1d3e2, 0x1a7e8, 0x1d3f6, 0x1a7e4, 0x1a7e2, 0x145e0, 0x1a2f8, 0x1d17e, 0x144f0, 0x1a27c, 0x14478, 0x1a23e, 0x1443c, 0x1441e, 0x1fa34, 0x146f8, 0x1a37e, 0x1fa32, 0x1467c, 0x1463e, 0x1f474, 0x1477e, 0x1f472, 0x1e8f4, 0x1e8f2, 0x1d1f4, 0x1d1f2, 0x1a3f4, 0x1a3f2, 0x142f0, 0x1a17c, 0x14278, 0x1a13e, 0x1423c, 0x1421e, 0x1fa1a, 0x1437c, 0x1433e, 0x1f43a, 0x1e87a, 0x1d0fa, 0x14178, 0x1a0be, 0x1413c, 0x1411e, 0x141be, 0x140bc, 0x1409e, 0x12bc0, 0x195f0, 0x1cafc, 0x129e0, 0x194f8, 0x1ca7e, 0x128f0, 0x1947c, 0x12878, 0x1943e, 0x1283c, 0x1f968, 0x12df0, 0x196fc, 0x1f964, 0x12cf8, 0x1967e, 0x1f962, 0x12c7c, 0x12c3e, 0x1f2e8, 0x1f976, 0x12efc, 0x1f2e4, 0x12e7e, 0x1f2e2, 0x1e5e8, 0x1f2f6, 0x1e5e4, 0x1e5e2, 0x1cbe8, 0x1e5f6, 0x1cbe4, 0x1cbe2, 0x197e8, 0x1cbf6, 0x197e4, 0x197e2, 0x1b5e0, 0x1daf8, 
		0x1ed7e, 0x169c0, 0x1b4f0, 0x1da7c, 0x168e0, 0x1b478, 0x1da3e, 0x16870, 0x1b43c, 0x16838, 0x1b41e, 0x1681c, 0x125e0, 0x192f8, 0x1c97e, 0x16de0, 0x124f0, 0x1927c, 0x16cf0, 0x1b67c, 0x1923e, 0x16c78, 0x1243c, 0x16c3c, 0x1241e, 0x16c1e, 0x1f934, 0x126f8, 0x1937e, 0x1fb74, 0x1f932, 0x16ef8, 0x1267c, 0x1fb72, 0x16e7c, 0x1263e, 0x16e3e, 0x1f274, 0x1277e, 0x1f6f4, 0x1f272, 0x16f7e, 0x1f6f2, 0x1e4f4, 0x1edf4, 0x1e4f2, 0x1edf2, 0x1c9f4, 0x1dbf4, 0x1c9f2, 0x1dbf2, 0x193f4, 0x193f2, 0x165c0, 0x1b2f0, 0x1d97c, 0x164e0, 0x1b278, 0x1d93e, 0x16470, 0x1b23c, 0x16438, 0x1b21e, 0x1641c, 0x1640e, 0x122f0, 0x1917c, 0x166f0, 0x12278, 0x1913e, 0x16678, 0x1b33e, 0x1663c, 0x1221e, 0x1661e, 0x1f91a, 0x1237c, 0x1fb3a, 0x1677c, 0x1233e, 0x1673e, 0x1f23a, 0x1f67a, 0x1e47a, 0x1ecfa, 0x1c8fa, 0x1d9fa, 0x191fa, 0x162e0, 0x1b178, 0x1d8be, 0x16270, 0x1b13c, 0x16238, 0x1b11e, 0x1621c, 0x1620e, 0x12178, 0x190be, 0x16378, 0x1213c, 0x1633c, 0x1211e, 0x1631e, 0x121be, 0x163be, 0x16170, 0x1b0bc, 0x16138, 0x1b09e, 0x1611c, 0x1610e, 0x120bc, 0x161bc, 0x1209e, 0x1619e, 0x160b8, 0x1b05e, 0x1609c, 0x1608e, 0x1205e, 0x160de, 0x1605c, 0x1604e, 0x115e0, 0x18af8, 0x1c57e, 0x114f0, 0x18a7c, 0x11478, 0x18a3e, 0x1143c, 0x1141e, 0x1f8b4, 0x116f8, 0x18b7e, 0x1f8b2, 0x1167c, 0x1163e, 0x1f174, 0x1177e, 0x1f172, 0x1e2f4, 0x1e2f2, 0x1c5f4, 0x1c5f2, 0x18bf4, 0x18bf2, 0x135c0, 0x19af0, 0x1cd7c, 0x134e0, 0x19a78, 0x1cd3e, 0x13470, 0x19a3c, 0x13438, 0x19a1e, 0x1341c, 0x1340e, 0x112f0, 0x1897c, 0x136f0, 0x11278, 0x1893e, 0x13678, 0x19b3e, 0x1363c, 0x1121e, 0x1361e, 0x1f89a, 0x1137c, 0x1f9ba, 0x1377c, 0x1133e, 0x1373e, 0x1f13a, 0x1f37a, 0x1e27a, 0x1e6fa, 0x1c4fa, 0x1cdfa, 0x189fa, 0x1bae0, 0x1dd78, 0x1eebe, 0x174c0, 0x1ba70, 0x1dd3c, 0x17460, 0x1ba38, 0x1dd1e, 0x17430, 0x1ba1c, 0x17418, 0x1ba0e, 0x1740c, 0x132e0, 0x19978, 0x1ccbe, 0x176e0, 0x13270, 0x1993c, 0x17670, 0x1bb3c, 0x1991e, 0x17638, 0x1321c, 0x1761c, 0x1320e, 0x1760e, 0x11178, 0x188be, 0x13378, 0x1113c, 0x17778, 0x1333c, 0x1111e, 0x1773c, 0x1331e, 0x1771e, 0x111be, 0x133be, 0x177be, 0x172c0, 0x1b970, 
		0x1dcbc, 0x17260, 0x1b938, 0x1dc9e, 0x17230, 0x1b91c, 0x17218, 0x1b90e, 0x1720c, 0x17206, 0x13170, 0x198bc, 0x17370, 0x13138, 0x1989e, 0x17338, 0x1b99e, 0x1731c, 0x1310e, 0x1730e, 0x110bc, 0x131bc, 0x1109e, 0x173bc, 0x1319e, 0x1739e, 0x17160, 0x1b8b8, 0x1dc5e, 0x17130, 0x1b89c, 0x17118, 0x1b88e, 0x1710c, 0x17106, 0x130b8, 0x1985e, 0x171b8, 0x1309c, 0x1719c, 0x1308e, 0x1718e, 0x1105e, 0x130de, 0x171de, 0x170b0, 0x1b85c, 0x17098, 0x1b84e, 0x1708c, 0x17086, 0x1305c, 0x170dc, 0x1304e, 0x170ce, 0x17058, 0x1b82e, 0x1704c, 0x17046, 0x1302e, 0x1706e, 0x1702c, 0x17026, 0x10af0, 0x1857c, 0x10a78, 0x1853e, 0x10a3c, 0x10a1e, 0x10b7c, 0x10b3e, 0x1f0ba, 0x1e17a, 0x1c2fa, 0x185fa, 0x11ae0, 0x18d78, 0x1c6be, 0x11a70, 0x18d3c, 0x11a38, 0x18d1e, 0x11a1c, 0x11a0e, 0x10978, 0x184be, 0x11b78, 0x1093c, 0x11b3c, 0x1091e, 0x11b1e, 0x109be, 0x11bbe, 0x13ac0, 0x19d70, 0x1cebc, 0x13a60, 0x19d38, 0x1ce9e, 0x13a30, 0x19d1c, 0x13a18, 0x19d0e, 0x13a0c, 0x13a06, 0x11970, 0x18cbc, 0x13b70, 0x11938, 0x18c9e, 0x13b38, 0x1191c, 0x13b1c, 0x1190e, 0x13b0e, 0x108bc, 0x119bc, 0x1089e, 0x13bbc, 0x1199e, 0x13b9e, 0x1bd60, 0x1deb8, 0x1ef5e, 0x17a40, 0x1bd30, 0x1de9c, 0x17a20, 0x1bd18, 0x1de8e, 0x17a10, 0x1bd0c, 0x17a08, 0x1bd06, 0x17a04, 0x13960, 0x19cb8, 0x1ce5e, 0x17b60, 0x13930, 0x19c9c, 0x17b30, 0x1bd9c, 0x19c8e, 0x17b18, 0x1390c, 0x17b0c, 0x13906, 0x17b06, 0x118b8, 0x18c5e, 0x139b8, 0x1189c, 0x17bb8, 0x1399c, 0x1188e, 0x17b9c, 0x1398e, 0x17b8e, 0x1085e, 0x118de, 0x139de, 0x17bde, 0x17940, 0x1bcb0, 0x1de5c, 0x17920, 0x1bc98, 0x1de4e, 0x17910, 0x1bc8c, 0x17908, 0x1bc86, 0x17904, 0x17902, 0x138b0, 0x19c5c, 0x179b0, 0x13898, 0x19c4e, 0x17998, 0x1bcce, 0x1798c, 0x13886, 0x17986, 0x1185c, 0x138dc, 0x1184e, 0x179dc, 0x138ce, 0x179ce, 0x178a0, 0x1bc58, 0x1de2e, 0x17890, 0x1bc4c, 0x17888, 0x1bc46, 0x17884, 0x17882, 0x13858, 0x19c2e, 0x178d8, 0x1384c, 0x178cc, 0x13846, 0x178c6, 0x1182e, 0x1386e, 0x178ee, 0x17850, 0x1bc2c, 0x17848, 0x1bc26, 0x17844, 0x17842, 0x1382c, 0x1786c, 0x13826, 0x17866, 0x17828, 0x1bc16, 0x17824, 0x17822, 0x13816, 0x17836, 
		0x10578, 0x182be, 0x1053c, 0x1051e, 0x105be, 0x10d70, 0x186bc, 0x10d38, 0x1869e, 0x10d1c, 0x10d0e, 0x104bc, 0x10dbc, 0x1049e, 0x10d9e, 0x11d60, 0x18eb8, 0x1c75e, 0x11d30, 0x18e9c, 0x11d18, 0x18e8e, 0x11d0c, 0x11d06, 0x10cb8, 0x1865e, 0x11db8, 0x10c9c, 0x11d9c, 0x10c8e, 0x11d8e, 0x1045e, 0x10cde, 0x11dde, 0x13d40, 0x19eb0, 0x1cf5c, 0x13d20, 0x19e98, 0x1cf4e, 0x13d10, 0x19e8c, 0x13d08, 0x19e86, 0x13d04, 0x13d02, 0x11cb0, 0x18e5c, 0x13db0, 0x11c98, 0x18e4e, 0x13d98, 0x19ece, 0x13d8c, 0x11c86, 0x13d86, 0x10c5c, 0x11cdc, 0x10c4e, 0x13ddc, 0x11cce, 0x13dce, 0x1bea0, 0x1df58, 0x1efae, 0x1be90, 0x1df4c, 0x1be88, 0x1df46, 0x1be84, 0x1be82, 0x13ca0, 0x19e58, 0x1cf2e, 0x17da0, 0x13c90, 0x19e4c, 0x17d90, 0x1becc, 0x19e46, 0x17d88, 0x13c84, 0x17d84, 0x13c82, 0x17d82, 0x11c58, 0x18e2e, 0x13cd8, 0x11c4c, 0x17dd8, 0x13ccc, 0x11c46, 0x17dcc, 0x13cc6, 0x17dc6, 0x10c2e, 0x11c6e, 0x13cee, 0x17dee, 0x1be50, 0x1df2c, 0x1be48, 0x1df26, 0x1be44, 0x1be42, 0x13c50, 0x19e2c, 0x17cd0, 0x13c48, 0x19e26, 0x17cc8, 0x1be66, 0x17cc4, 0x13c42, 0x17cc2, 0x11c2c, 0x13c6c, 0x11c26, 0x17cec, 0x13c66, 0x17ce6, 0x1be28, 0x1df16, 0x1be24, 0x1be22, 0x13c28, 0x19e16, 0x17c68, 0x13c24, 0x17c64, 0x13c22, 0x17c62, 0x11c16, 0x13c36, 0x17c76, 0x1be14, 0x1be12, 0x13c14, 0x17c34, 0x13c12, 0x17c32, 0x102bc, 0x1029e, 0x106b8, 0x1835e, 0x1069c, 0x1068e, 0x1025e, 0x106de, 0x10eb0, 0x1875c, 0x10e98, 0x1874e, 0x10e8c, 0x10e86, 0x1065c, 0x10edc, 0x1064e, 0x10ece, 0x11ea0, 0x18f58, 0x1c7ae, 0x11e90, 0x18f4c, 0x11e88, 0x18f46, 0x11e84, 0x11e82, 0x10e58, 0x1872e, 0x11ed8, 0x18f6e, 0x11ecc, 0x10e46, 0x11ec6, 0x1062e, 0x10e6e, 0x11eee, 0x19f50, 0x1cfac, 0x19f48, 0x1cfa6, 0x19f44, 0x19f42, 0x11e50, 0x18f2c, 0x13ed0, 0x19f6c, 0x18f26, 0x13ec8, 0x11e44, 0x13ec4, 0x11e42, 0x13ec2, 0x10e2c, 0x11e6c, 0x10e26, 0x13eec, 0x11e66, 0x13ee6, 0x1dfa8, 0x1efd6, 0x1dfa4, 0x1dfa2, 0x19f28, 0x1cf96, 0x1bf68, 0x19f24, 0x1bf64, 0x19f22, 0x1bf62, 0x11e28, 0x18f16, 0x13e68, 0x11e24, 0x17ee8, 0x13e64, 0x11e22, 0x17ee4, 0x13e62, 0x17ee2, 0x10e16, 0x11e36, 0x13e76, 0x17ef6, 0x1df94, 
		0x1df92, 0x19f14, 0x1bf34, 0x19f12, 0x1bf32, 0x11e14, 0x13e34, 0x11e12, 0x17e74, 0x13e32, 0x17e72, 0x1df8a, 0x19f0a, 0x1bf1a, 0x11e0a, 0x13e1a, 0x17e3a, 0x1035c, 0x1034e, 0x10758, 0x183ae, 0x1074c, 0x10746, 0x1032e, 0x1076e, 0x10f50, 0x187ac, 0x10f48, 0x187a6, 0x10f44, 0x10f42, 0x1072c, 0x10f6c, 0x10726, 0x10f66, 0x18fa8, 0x1c7d6, 0x18fa4, 0x18fa2, 0x10f28, 0x18796, 0x11f68, 0x18fb6, 0x11f64, 0x10f22, 0x11f62, 0x10716, 0x10f36, 0x11f76, 0x1cfd4, 0x1cfd2, 0x18f94, 0x19fb4, 0x18f92, 0x19fb2, 0x10f14, 0x11f34, 0x10f12, 0x13f74, 0x11f32, 0x13f72, 0x1cfca, 0x18f8a, 0x19f9a, 0x10f0a, 0x11f1a, 0x13f3a, 0x103ac, 0x103a6, 0x107a8, 0x183d6, 0x107a4, 0x107a2, 0x10396, 0x107b6, 0x187d4, 0x187d2, 0x10794, 0x10fb4, 0x10792, 0x10fb2, 0x1c7ea}};

            internal static int[][] ERROR_LEVEL = {new int[]{27, 917}, new int[]{522, 568, 723, 809}, new int[]{237, 308, 436, 284, 646, 653, 428, 379}, new int[]{274, 562, 232, 755, 599, 524, 801, 132, 295, 116, 442, 428, 295, 42, 176, 65}, new int[]{361, 575, 922, 525, 176, 586, 640, 321, 536, 742, 677, 742, 687, 284, 193, 517, 273, 494, 263, 147, 593, 800, 571, 320, 803, 133, 231, 390, 685, 330, 63, 410}, new int[]{539, 422, 6, 93, 862, 771, 453, 106, 610, 287, 107, 505, 733, 877, 381, 612, 723, 476, 462, 172, 430, 609, 858, 822, 543, 376, 511, 400, 672, 762, 283, 184, 440, 35, 519, 31, 460, 594, 225, 535, 517, 352, 605, 158, 651, 201, 488, 502, 648, 733, 717, 83, 404, 97, 280, 771, 840, 629, 4, 381, 843, 623, 264, 543}, new int[]{521, 310, 864, 547, 858, 580, 296, 379, 53, 779, 897, 444, 400, 925, 749, 415, 822, 93, 217, 208, 928, 244, 583, 620, 246, 148, 447, 631, 292, 908, 490, 704, 516, 258, 457, 907, 594, 723, 674, 292, 272, 96, 684, 432, 686, 606, 860, 569, 193, 219, 129, 186, 236, 287, 192, 775, 278, 173, 40, 379, 712, 463, 646, 776, 171, 491, 297, 763, 156, 732, 95, 270, 447, 90, 507, 48, 228, 821, 808, 898, 784, 663, 627, 378, 382, 262, 380, 602, 754, 336, 89, 614, 87, 432, 670, 616, 157, 374, 242, 726, 600, 269, 375, 898, 845, 454, 354, 130, 814, 587, 804, 34, 211, 330, 539, 297, 827, 865, 37, 517, 834, 315, 550, 86, 801, 4, 108, 539}, new int[]{524, 894, 75, 766, 882, 857, 74, 204, 82, 586, 708, 250, 905, 786, 138, 720, 858, 194, 311, 913, 275, 190, 375, 850, 438, 733, 194, 280, 201, 280, 828, 757, 710, 814, 919, 89, 68, 569, 11, 204, 796, 605, 540, 913, 801, 700, 799, 137, 439, 418, 592, 668, 353, 859, 370, 694, 325, 240, 216, 257, 284, 549, 209, 884, 315, 70, 329, 793, 490, 274, 877, 162, 749, 812, 684, 461, 334, 376, 849, 521, 307, 291, 803, 712, 19, 358, 399, 908, 103, 511, 51, 8, 517, 225, 289, 470, 637, 731, 66, 255, 917, 269, 463, 830, 730, 433, 848, 585, 136, 538, 906, 90, 2, 290, 743, 199, 655, 903, 329, 49, 802, 580, 355, 588, 188, 462, 10, 134, 628, 320, 479, 130, 739, 71, 263, 318, 374, 601, 
		192, 605, 142, 673, 687, 234, 722, 384, 177, 752, 607, 640, 455, 193, 689, 707, 805, 641, 48, 60, 732, 621, 895, 544, 261, 852, 655, 309, 697, 755, 756, 60, 231, 773, 434, 421, 726, 528, 503, 118, 49, 795, 32, 144, 500, 238, 836, 394, 280, 566, 319, 9, 647, 550, 73, 914, 342, 126, 32, 681, 331, 792, 620, 60, 609, 441, 180, 791, 893, 754, 605, 383, 228, 749, 760, 213, 54, 297, 134, 54, 834, 299, 922, 191, 910, 532, 609, 829, 189, 20, 167, 29, 872, 449, 83, 402, 41, 656, 505, 579, 481, 173, 404, 251, 688, 95, 497, 555, 642, 543, 307, 159, 924, 558, 648, 55, 497, 10}, new int[]{352, 77, 373, 504, 35, 599, 428, 207, 409, 574, 118, 498, 285, 380, 350, 492, 197, 265, 920, 155, 914, 299, 229, 643, 294, 871, 306, 88, 87, 193, 352, 781, 846, 75, 327, 520, 435, 543, 203, 666, 249, 346, 781, 621, 640, 268, 794, 534, 539, 781, 408, 390, 644, 102, 476, 499, 290, 632, 545, 37, 858, 916, 552, 41, 542, 289, 122, 272, 383, 800, 485, 98, 752, 472, 761, 107, 784, 860, 658, 741, 290, 204, 681, 407, 855, 85, 99, 62, 482, 180, 20, 297, 451, 593, 913, 142, 808, 684, 287, 536, 561, 76, 653, 899, 729, 567, 744, 390, 513, 192, 516, 258, 240, 518, 794, 395, 768, 848, 51, 610, 384, 168, 190, 826, 328, 596, 786, 303, 570, 381, 415, 641, 156, 237, 151, 429, 531, 207, 676, 710, 89, 168, 304, 402, 40, 708, 575, 162, 864, 229, 65, 861, 841, 512, 164, 477, 221, 92, 358, 785, 288, 357, 850, 836, 827, 736, 707, 94, 8, 494, 114, 521, 2, 499, 851, 543, 152, 729, 771, 95, 248, 361, 578, 323, 856, 797, 289, 51, 684, 466, 533, 820, 669, 45, 902, 452, 167, 342, 244, 173, 35, 463, 651, 51, 699, 591, 452, 578, 37, 124, 298, 332, 552, 43, 427, 119, 662, 777, 475, 850, 764, 364, 578, 911, 283, 711, 472, 420, 245, 288, 594, 394, 511, 327, 589, 777, 699, 688, 43, 408, 842, 383, 721, 521, 560, 644, 714, 559, 62, 145, 873, 663, 713, 159, 672, 729, 624, 59, 193, 417, 158, 209, 563, 564, 343, 693, 109, 608, 563, 365, 181, 772, 677, 310, 248, 353, 708, 410, 579, 870, 617, 841, 632, 860, 289, 536, 35, 777, 618, 586, 424, 833, 77, 597, 346, 269, 757, 632
		, 695, 751, 331, 247, 184, 45, 787, 680, 18, 66, 407, 369, 54, 492, 228, 613, 830, 922, 437, 519, 644, 905, 789, 420, 305, 441, 207, 300, 892, 827, 141, 537, 381, 662, 513, 56, 252, 341, 242, 797, 838, 837, 720, 224, 307, 631, 61, 87, 560, 310, 756, 665, 397, 808, 851, 309, 473, 795, 378, 31, 647, 915, 459, 806, 590, 731, 425, 216, 548, 249, 321, 881, 699, 535, 673, 782, 210, 815, 905, 303, 843, 922, 281, 73, 469, 791, 660, 162, 498, 308, 155, 422, 907, 817, 187, 62, 16, 425, 535, 336, 286, 437, 375, 273, 610, 296, 183, 923, 116, 667, 751, 353, 62, 366, 691, 379, 687, 842, 37, 357, 720, 742, 330, 5, 39, 923, 311, 424, 242, 749, 321, 54, 669, 316, 342, 299, 534, 105, 667, 488, 640, 672, 576, 540, 316, 486, 721, 610, 46, 656, 447, 171, 616, 464, 190, 531, 297, 321, 762, 752, 533, 175, 134, 14, 381, 433, 717, 45, 111, 20, 596, 284, 736, 138, 646, 411, 877, 669, 141, 919, 45, 780, 407, 164, 332, 899, 165, 726, 600, 325, 498, 655, 357, 752, 768, 223, 849, 647, 63, 310, 863, 251, 366, 304, 282, 738, 675, 410, 389, 244, 31, 121, 303, 263}};

            /// <summary>Holds value of property outBits. </summary>
            private sbyte[] outBits;

            /// <summary>Holds value of property bitColumns. </summary>
            private int bitColumns;

            /// <summary>Holds value of property codeRows. </summary>
            private int codeRows;

            /// <summary>Holds value of property codeColumns. </summary>
            private int codeColumns;

            /// <summary>Holds value of property codewords. </summary>
            //UPGRADE_NOTE: The initialization of  'codewords' was moved to method 'InitBlock'. 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="jlca1005"'
            private int[] codewords;

            /// <summary>Holds value of property lenCodewords. </summary>
            private int lenCodewords;

            /// <summary>Holds value of property errorLevel. </summary>
            private int errorLevel;

            /// <summary>Holds value of property text. </summary>
            private sbyte[] text;

            /// <summary>Holds value of property options. </summary>
            private int options;

            /// <summary>Holds value of property aspectRatio. </summary>
            private float aspectRatio;

            /// <summary>Holds value of property yHeight. </summary>
            private float yHeight;

            //UPGRADE_NOTE: Field 'EnclosingInstance' was added to class 'Segment' to access its enclosing instance. 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="jlca1019"'
            protected internal class Segment
            {
                private void InitBlock(Pdf417lib enclosingInstance)
                {
                    this.enclosingInstance = enclosingInstance;
                }
                private Pdf417lib enclosingInstance;
                public Pdf417lib Enclosing_Instance
                {
                    get
                    {
                        return enclosingInstance;
                    }

                }
                public char type;
                public int start;
                public int end;

                public Segment(Pdf417lib enclosingInstance, char type, int start, int end)
                {
                    InitBlock(enclosingInstance);
                    this.type = type;
                    this.start = start;
                    this.end = end;
                }
            }

            //UPGRADE_NOTE: Field 'EnclosingInstance' was added to class 'SegmentList' to access its enclosing instance. 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="jlca1019"'
            protected internal class SegmentList
            {
                public SegmentList(Pdf417lib enclosingInstance)
                {
                    InitBlock(enclosingInstance);
                }
                private void InitBlock(Pdf417lib enclosingInstance)
                {
                    this.enclosingInstance = enclosingInstance;
                    //UPGRADE_ISSUE: Class hierarchy differences between 'java.util.ArrayList' and 'System.Collections.ArrayList' may cause compilation errors. 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="jlca1186"'
                    list = new System.Collections.ArrayList();
                }
                private Pdf417lib enclosingInstance;
                public Pdf417lib Enclosing_Instance
                {
                    get
                    {
                        return enclosingInstance;
                    }

                }
                //UPGRADE_ISSUE: Class hierarchy differences between 'java.util.ArrayList' and 'System.Collections.ArrayList' may cause compilation errors. 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="jlca1186"'
                //UPGRADE_NOTE: The initialization of  'list' was moved to method 'InitBlock'. 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="jlca1005"'
                protected internal System.Collections.ArrayList list;

                public virtual void add(char type, int start, int end)
                {
                    //UPGRADE_TODO: The equivalent in .NET for method 'java.util.ArrayList.add' may return a different value. 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="jlca1043"'
                    list.Add(new Segment(enclosingInstance, type, start, end));
                }

                public virtual Segment get_Renamed(int idx)
                {
                    //UPGRADE_TODO: The equivalent in .NET for method 'java.util.ArrayList.size' may return a different value. 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="jlca1043"'
                    if (idx < 0 || idx >= list.Count)
                        return null;
                    return (Segment)list[idx];
                }

                public virtual void remove(int idx)
                {
                    //UPGRADE_TODO: The equivalent in .NET for method 'java.util.ArrayList.size' may return a different value. 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="jlca1043"'
                    if (idx < 0 || idx >= list.Count)
                        return;
                    //UPGRADE_TODO: The equivalent in .NET for method 'java.util.ArrayList.remove' may return a different value. 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="jlca1043"'
                    list.RemoveAt(idx);
                }

                public virtual int size()
                {
                    //UPGRADE_TODO: The equivalent in .NET for method 'java.util.ArrayList.size' may return a different value. 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="jlca1043"'
                    return list.Count;
                }
            }

            /*[STAThread]
            public static void  Main(System.String[] args)
            {
                if (args.Length < 2)
                {
                    System.Console.Out.WriteLine("PDF417 barcode postscript generator");
                    System.Console.Out.WriteLine("Usage: java Pdf417lib postscript_file_name barcode_text");
                    return ;
                }
                try
                {
                    Pdf417lib pd = new Pdf417lib();
                    pd.setText(args[1]);
                    pd.Options = Pdf417lib.PDF417_INVERT_BITMAP;
                    pd.paintCode();
                    System.IO.StreamWriter pr = new System.IO.StreamWriter(new System.IO.FileStream(args[0], System.IO.FileMode.Create));
                    int cols = (pd.BitColumns - 1) / 8 + 1;
                    pr.WriteLine("/Times findfont\n12 scalefont setfont\n100 80 moveto\n(A PDF417 example.)show");
                    pr.WriteLine("stroke\n100 100 translate\n" + pd.BitColumns / 2.0 + " " + pd.CodeRows * 3 / 2.0 + " scale");
                    pr.Write(pd.BitColumns + " " + pd.CodeRows + " 1 [" + pd.BitColumns + " 0 0 " + (- pd.CodeRows) + " 0 " + pd.CodeRows + "]{<");
                    sbyte[] out_Renamed = pd.OutBits;
                    for (int k = 0; k < out_Renamed.Length; ++k)
                    {
                        if ((k % cols) == 0)
                            pr.WriteLine();
                        pr.Write(System.Convert.ToString((out_Renamed[k] & 0xff) | 0x100, 16).Substring(1).ToUpper());
                    }
                    pr.WriteLine("\n>}image\nshowpage");
                    //UPGRADE_NOTE: Exceptions thrown by the equivalent in .NET of method 'java.io.PrintWriter.close' may be different. 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="jlca1099"'
                    pr.Close();
                }
                catch (System.Exception e)
                {
                    SupportClass.WriteStackTrace(e, Console.Error);
                }
            }*/
        }
        public System.Drawing.Bitmap DrawBarcodeImage(Pdf417lib pd, int scale_x, int scale_y)
        {
            System.Drawing.Bitmap bmp;
            sbyte[] out_Renamed;
            int cols;
            int tmp;
            int x = 0, y = -1;
            System.Drawing.Color c;
            out_Renamed = pd.OutBits;
            cols = (pd.BitColumns - 1) / 8 + 1;
            bmp = new System.Drawing.Bitmap(pd.BitColumns * scale_x, (pd.OutBits.Length / cols) * scale_y);
            for (int k = 0; k < out_Renamed.Length; ++k)
            {
                if ((k % cols) == 0)
                {
                    y++;
                    x = 0;
                }
                tmp = (out_Renamed[k] & 0xff) | 0x100;
                for (int j = 0; j < 8; j++)
                {
                    if ((tmp & (0x80 >> j)) == 0)
                    {
                        c = System.Drawing.Color.Black;
                    }
                    else
                    {
                        c = System.Drawing.Color.White;
                    }
                    for (int xx = 0; xx < scale_x; xx++)
                    {
                        for (int yy = 0; yy < scale_y; yy++)
                        {
                            bmp.SetPixel(x * scale_x + xx, y * scale_y + yy, c);
                        }
                    }
                    x++;
                    if (x == pd.BitColumns)
                        break;
                }
            }
            return bmp;
        }
    </script>