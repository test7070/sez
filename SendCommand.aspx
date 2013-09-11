<%@ Page Language="C#" Debug="true" %>
    <script language="c#" runat="server">
        public class SendCommand
        {
            public string CarId;
            public string Message;
            public string CommandId;
        }   
        public void Page_Load()
        {
      
            Encoding encoding = System.Text.Encoding.UTF8;
            Response.ContentEncoding = encoding;     
            int formSize = Request.TotalBytes;
            byte[] formData = Request.BinaryRead(formSize);
                
            //string test = "{\"GroupName\":\"CHITC195\",\"CarId\":\"001-M9\",\"Message\":\"測試 2013/04/08\",\"CommandId\":\"0\"}";
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            var item = serializer.Deserialize<SendCommand>(System.Text.Encoding.Default.GetString(formData));
			item.CarId = System.Web.HttpUtility.UrlDecode(item.CarId);
			item.Message = System.Web.HttpUtility.UrlDecode(item.Message);
			
            string targetUrl = "http://115.85.145.34/Service/Service.asmx?op=SendCommand";
            string parame = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">" +
                        " <soap:Body>" +
                        "   <SendCommand xmlns=\"http://tempuri.org/\">" +
                        "     <GroupName>CHITC195</GroupName>" +
                        "     <CarId>"+item.CarId+"</CarId>" +
                        "     <Message>"+item.Message+"</Message>" +
                        "     <CommandId>"+item.CommandId+"</CommandId>" +
                        "   </SendCommand>" +
                    "   </soap:Body>" +
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

            string t_para = "{\"action\":\"SendCommand\"";
            foreach (System.Xml.XmlElement g in doc.GetElementsByTagName("SendCommandResponse"))
            {
                foreach (System.Xml.XmlElement c in g.GetElementsByTagName("SendCommandResult"))
                {
                    t_para += ",\"SendCommandResult\":\"" + c.FirstChild.OuterXml + "\"";
                }
                foreach (System.Xml.XmlElement c in g.GetElementsByTagName("CommandId"))
                {
                    t_para += ",\"CommandId\":\"" + c.FirstChild.OuterXml + "\"";
                }
            }
            t_para += "}";
            
            Response.Clear();
            Response.ContentType = "application/json; charset=utf-8";
            Response.Write(t_para); 

        }       
    </script>
