<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        public void Page_Load()
        {
            string barcode = "";
            int x = 0; //左邊界
            int y = 0; //上邊界
            int WidLength = 3; //粗BarCode長度
            int NarrowLength = 1; //細BarCode長度
            int BarCodeHeight = 25; //BarCode高度
            
            if (Request.QueryString["barcode"] != null && Request.QueryString["barcode"].Length > 0)
            {
                barcode = Request.QueryString["barcode"];
            }
            if (Request.QueryString["x"] != null && Request.QueryString["x"].Length > 0)
            {
                x = Convert.ToInt32(Request.QueryString["x"]);
            }
            if (Request.QueryString["y"] != null && Request.QueryString["x"].Length > 0)
            {
                y = Convert.ToInt32(Request.QueryString["y"]);
            }
            if (Request.QueryString["WidLength"] != null && Request.QueryString["WidLength"].Length > 0)
            {
                WidLength = Convert.ToInt32(Request.QueryString["WidLength"]);
            }
            if (Request.QueryString["NarrowLength"] != null && Request.QueryString["NarrowLength"].Length > 0)
            {
                NarrowLength = Convert.ToInt32(Request.QueryString["NarrowLength"]);
            }
            if (Request.QueryString["BarCodeHeight"] != null && Request.QueryString["BarCodeHeight"].Length > 0)
            {
                BarCodeHeight = Convert.ToInt32(Request.QueryString["BarCodeHeight"]);
            }
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            GetCode39(barcode,x,y,WidLength,NarrowLength,BarCodeHeight).Save(stream, System.Drawing.Imaging.ImageFormat.Bmp);

            Response.ContentType = "application/x-msdownload;";
            Response.AddHeader("Content-transfer-encoding", "binary");
            Response.AddHeader("Content-Disposition", "attachment;filename=" + (barcode.Length==0?"code39":barcode) + ".bmp");
            Response.BinaryWrite(stream.ToArray());
            Response.End();
        }

        public System.Drawing.Bitmap GetCode39(string strSource, int x, int y, int WidLength, int NarrowLength, int BarCodeHeight)
        {
          /*int x = 0; //左邊界
          int y = 0; //上邊界
          int WidLength = 3; //粗BarCode長度
          int NarrowLength = 1; //細BarCode長度
          int BarCodeHeight = 30; //BarCode高度*/
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

    </script>
