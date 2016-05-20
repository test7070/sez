<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">
        public void Page_Load()
        {
         //   try
         //   {
                string path = @"D:\t\DOC\";
                string filename = HttpUtility.UrlDecode(Request.QueryString["FileName"]);
                string tempname = HttpUtility.UrlDecode(Request.QueryString["TempName"]);

                if (filename != null && filename.Length > 0 && tempname!=null  && tempname.Length > 0)
                {
                    Response.ContentType = "application/x-msdownload;";
                    Response.AddHeader("Content-transfer-encoding", "binary");
                    Response.AddHeader("Content-Disposition", "attachment;filename=" + System.IO.Path.GetFileName(path + filename));
                    Response.BinaryWrite(GetFileBits(path + tempname));
                    Response.End();              
                }       
         /*   }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            finally
            {
            }     */     
        }

        private byte[] GetFileBits(string filename)
        {
             byte[] bytes;
             using (System.IO.FileStream file = new System.IO.FileStream(filename, System.IO.FileMode.Open, System.IO.FileAccess.Read))
             {
                  bytes = new byte[file.Length];
                  file.Read(bytes, 0, (int)file.Length);
             }
             return bytes;
        }
        
    </script>