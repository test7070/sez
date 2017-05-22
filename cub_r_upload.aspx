<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        string savepath = @"F:\doc\cub\";
        
        public void Page_Load()
        {
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                System.Text.Encoding encoding = System.Text.Encoding.UTF8;
                Response.ContentEncoding = encoding;
                int formSize = Request.TotalBytes;
                byte[] formData = Request.BinaryRead(formSize);

                if (System.IO.Directory.Exists(savepath))
                {
                    //資料夾存在
                }
                else
                {
                    //新增資料夾
                    System.IO.Directory.CreateDirectory(savepath);
                }
                
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
