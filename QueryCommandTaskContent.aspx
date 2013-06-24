<%@ Page Language="C#" Debug="true" %>
    <script language="c#" runat="server">
        public class QueryCommandTaskContent
        {
            public string CarId;           
            public string CommandId;
        }   
        public void Page_Load()
        {
      
            Encoding encoding = System.Text.Encoding.UTF8;
            Response.ContentEncoding = encoding;     
            int formSize = Request.TotalBytes;
            byte[] formData = Request.BinaryRead(formSize);

            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            var item = serializer.Deserialize<QueryCommandTaskContent>(System.Text.Encoding.Default.GetString(formData)); 
			item.CarId = System.Web.HttpUtility.UrlDecode(item.CarId);
			item.CommandId = System.Web.HttpUtility.UrlDecode(item.CommandId);

            string targetUrl = "http://115.85.145.34/Service/Service.asmx?op=QueryCommandTaskContent";
            string parame = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">" +
                        " <soap:Body>" +
                        "   <QueryCommandTaskContent xmlns=\"http://tempuri.org/\">" +
                        "     <GroupName>CHITC195</GroupName>" +
                        "     <CarId>"+item.CarId+"</CarId>" +
                        "     <CommandId>"+item.CommandId+"</CommandId>" +
                        "     <TaskContent> </TaskContent>" +
                        "     <ErrMsg> </ErrMsg>" +
                        "   </QueryCommandTaskContent>" +
                    "   </soap:Body>" +
                    " </soap:Envelope>";
               
            byte[] postData = Encoding.UTF8.GetBytes(parame);
            System.Net.HttpWebRequest request = System.Net.HttpWebRequest.Create(targetUrl) as System.Net.HttpWebRequest;
            request.Method = "POST";
            request.ContentType = "text/xml; charset=\"utf-8\"";
            request.Timeout = 30000;
            request.ContentLength = postData.Length;
            // 寫入 Post Body Message 資料流
            using (System.IO.Stream st = request.GetRequestStream())
            {
                st.Write(postData, 0, postData.Length);
            }

            string result = "";
            // 取得回應資料
            using (System.Net.HttpWebResponse response = request.GetResponse() as System.Net.HttpWebResponse)
            {
                using (System.IO.StreamReader sr = new System.IO.StreamReader(response.GetResponseStream()))
                {
                    result = sr.ReadToEnd();
                }
            }

            //解析XML     
            System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
            doc.LoadXml(result);
            System.Xml.XmlNode root = doc.DocumentElement;

            string t_para = "{\"action\":\"QueryCommandTaskContent\"";
            foreach (System.Xml.XmlElement g in doc.GetElementsByTagName("QueryCommandTaskContentResponse"))
            {
                foreach (System.Xml.XmlElement c in g.GetElementsByTagName("QueryCommandTaskContentResult"))
                {
                    t_para += ",\"QueryCommandTaskContentResult\":\"" + c.FirstChild.OuterXml + "\"";
                }
                foreach (System.Xml.XmlElement c in g.GetElementsByTagName("TaskContent"))
                {
                    try
                    {
                        t_para += ",\"TaskContent\":\"" + c.FirstChild.OuterXml + "\"";
                    }
                    catch 
                    {
                        t_para += ",\"TaskContent\":\"\"";
                    }
                    
                }
                foreach (System.Xml.XmlElement c in g.GetElementsByTagName("ErrMsg"))
                {
                    try
                    {
                        t_para += ",\"ErrMsg\":\"" + c.FirstChild.OuterXml + "\"";
                    }
                    catch
                    {
                        t_para += ",\"ErrMsg\":\"\"";
                    } 
                }
            }
            t_para += "}";
            Response.Clear();
            Response.ContentType = "application/json; charset=utf-8";
            Response.Write(t_para); 
        }       
    </script>
