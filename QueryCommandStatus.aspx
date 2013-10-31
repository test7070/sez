<%@ Page Language="C#" Debug="true" %>
    <script language="c#" runat="server">
        public class QueryCommandStatus
        {
            public string GroupName;
            public string CommandId;
            public int StatusCode;
        }

        public void Page_Load()
        {
            Encoding encoding = System.Text.Encoding.UTF8;
            Response.ContentEncoding = encoding;     
            int formSize = Request.TotalBytes;
            byte[] formData = Request.BinaryRead(formSize);
            
            //string test = "{\"GroupName\":\"CHITC377\",\"CommandId\":\"230055\",\"StatusCode\":0}";
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            var item = serializer.Deserialize<QueryCommandStatus>(System.Text.Encoding.Default.GetString(formData));
                
            string targetUrl = "http://115.85.145.34/Service/Service.asmx?op=QueryCommandStatus";
            string parame = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"+
                     " <soap:Body>"+
                      "  <QueryCommandStatus xmlns=\"http://tempuri.org/\">"+
                      "    <GroupName>"+item.GroupName+"</GroupName>" +
                      "    <CommandId>"+item.CommandId+"</CommandId>"+
                      "    <StatusCode>"+item.StatusCode.ToString()+"</StatusCode>"+
                     "   </QueryCommandStatus>"+
                    "  </soap:Body>"+
                   " </soap:Envelope>";
                  
            
            byte[] postData = Encoding.UTF8.GetBytes(parame);
            System.Net.HttpWebRequest request = System.Net.HttpWebRequest.Create(targetUrl) as System.Net.HttpWebRequest;
            request.Method = "POST";
            request.ContentType = "text/xml; charset=\"utf-8\"";
            request.Timeout = 10000;
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
    
            string t_para = "{\"action\":\"QueryCommandStatus\"";
            foreach (System.Xml.XmlElement g in doc.GetElementsByTagName("QueryCommandStatusResponse"))
            {
                foreach (System.Xml.XmlElement c in g.GetElementsByTagName("QueryCommandStatusResult"))
                {
                    t_para += ",\"QueryCommandStatusResult\":\"" + c.FirstChild.OuterXml+"\"";
                    
                }
                foreach (System.Xml.XmlElement c in g.GetElementsByTagName("StatusCode"))
                {
                    t_para += ",\"StatusCode\":\"" + c.FirstChild.OuterXml + "\"";
                   
                }
            }
            t_para += "}";

            Response.Clear();
            Response.ContentType = "application/json; charset=utf-8";
            Response.Write(t_para); 
        }       
    </script>
