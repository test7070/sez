<%@ Page Language="C#" Debug="true" responseEncoding=Big5 %>
    <script language="c#" runat="server">
        public void Page_Load()
        {
            try
            {
                string targetUrl = "http://127.0.0.1/htm/obtdta.txt";
                System.Net.HttpWebRequest request = System.Net.HttpWebRequest.Create(targetUrl) as System.Net.HttpWebRequest;
                request.Method = "GET";
                request.ContentType = "text/xml; charset=\"Big5\"";
                request.Timeout = 10000;
                // 取得回應資料
                string result = "";
                using (System.Net.HttpWebResponse response = request.GetResponse() as System.Net.HttpWebResponse)
                {
                    using (System.IO.StreamReader sr = new System.IO.StreamReader(response.GetResponseStream(), System.Text.Encoding.GetEncoding("Big5")))
                    {
                        result = sr.ReadToEnd();
                    }
                }
                Response.ContentType = "application/x-msdownload;";
                Response.AddHeader("Content-transfer-encoding", "binary");
                Response.AddHeader("Content-Disposition", "attachment;filename=obtdta.txt");
                Response.Write(result.ToString());
            }
            catch (Exception ex)
            {
                Response.ContentType = "application/x-msdownload;";
                Response.AddHeader("Content-transfer-encoding", "binary");
                Response.AddHeader("Content-Disposition", "attachment;filename=obtdta.txt");
                Response.Write(ex.Message);
            }
            finally
            {
            }          
        }
        
    </script>