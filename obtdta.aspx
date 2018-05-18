<%@ Page Language="C#" Debug="true" responseEncoding=Big5 %>
    <script language="c#" runat="server">
        public void Page_Load()
        {
            try
            {
                string filename = "obtdta";
                if (Request.QueryString["file"] != null && Request.QueryString["file"].Length > 0)
                {
                    filename = Request.QueryString["file"];
                }
                string filePath = @"C:\inetpub\wwwroot\htm\" + filename + ".txt";
                System.IO.StreamReader streamReader = new System.IO.StreamReader(filePath, System.Text.Encoding.GetEncoding("Big5"));
                string text = streamReader.ReadToEnd();
                streamReader.Close();
                Response.ContentType = "application/x-msdownload;";
                Response.AddHeader("Content-transfer-encoding", "binary");
                Response.AddHeader("Content-Disposition", "attachment;filename="+filename+".txt");
                Response.Write(text);
            }
            catch (Exception ex)
            {
                Response.ContentType = "application/x-msdownload;";
                Response.AddHeader("Content-transfer-encoding", "binary");
                Response.AddHeader("Content-Disposition", "attachment;filename=error.txt");
                Response.Write(ex.Message );
            }
            finally
            {
            }          
        }
        
    </script>