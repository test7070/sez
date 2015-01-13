<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        string savepath = "D:\\t\\";
        public void Page_Load()
        {
            try
            {
                //參數
                System.Text.Encoding encoding = System.Text.Encoding.UTF8;
                Response.ContentEncoding = encoding;
                int formSize = Request.TotalBytes;
                byte[] formData = Request.BinaryRead(formSize);
                parseFile(HttpUtility.UrlDecode(Request.Headers["FileName"]),encoding.GetString(formData));
                
            }
            catch (Exception e) {
                Response.Write(e.Message);
            }
        }
        public void parseFile(string filename,string data)
        {
            byte[] formData = Convert.FromBase64String(data.Substring(data.IndexOf("base64") + 7));
 
            System.IO.FileStream aax = new System.IO.FileStream(savepath + filename, System.IO.FileMode.OpenOrCreate);
            System.IO.BinaryWriter aay = new System.IO.BinaryWriter(aax);
            aay.Write(formData);
            aax.Close();
        }
    </script>
