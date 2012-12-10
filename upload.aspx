<%@ Page Language="C#" Debug="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title>upload</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script language="c#" runat="server">
        public void Page_Load()
        {
            Encoding encoding = System.Text.Encoding.UTF8;
            Response.ContentEncoding = encoding;
            int formSize = Request.TotalBytes;
            byte[] formData = Request.BinaryRead(formSize);
            byte[] bCrLf = { 0xd, 0xa };// \r\n
   
            string savepath = "D:\\D\\web\\upload\\";

            Response.Write("<form name=\"form1\" method=\"post\" action=\"upload.aspx\" enctype=\"multipart/form-data\">");
            Response.Write("<input type=\"file\" name=\"btnFile1\"/>");
            Response.Write("<input type=\"file\" name=\"btnFile2\"/>");
            Response.Write("<input type=\"submit\" name=\"btnUpload\" value=\"upload\"/>");
            Response.Write("</form>");
            

            if (formSize == 0)
            {
                return;
            }
            
            //origin
            string origin = encoding.GetString(formData);
            // sign
            int nSign = IndexOf(formData, bCrLf);
            if (nSign == -1)
            {
                Response.Write("<br>" + "Error_1: token sign error!" + "</br>");
                return;
            }
            byte[] sign = new byte[nSign];
            Array.ConstrainedCopy(formData, 0, sign, 0, nSign);
            string cSign = encoding.GetString(sign);
            byte[] signStr = new byte[nSign + 2];
            Array.ConstrainedCopy(sign, 0, signStr, 0, nSign);
            Array.ConstrainedCopy(bCrLf, 0, signStr, nSign, 2);
            string cSignStr = encoding.GetString(signStr);
            byte[] signEnd = new byte[nSign+2];
            Array.ConstrainedCopy(sign, 0, signEnd, 0, nSign);
            Array.ConstrainedCopy((new byte[] {0x2d, 0x2d}), 0, signEnd, nSign, 2);//add --
            string cSignEnd = encoding.GetString(signEnd);
            
            Array[] item = new Array[2];
            ArrayList items = new ArrayList();
            
            byte[] temp = new byte[formData.Length];
            byte[] temp2 = null;
            byte[] temp3 = null;
            int str,end;
            Array.ConstrainedCopy(formData, 0, temp, 0, temp.Length);
            try
            {
                while (true)
                {
                    if (IndexOf(temp, sign) == -1)
                        break;
                    else
                    {
                        str = IndexOf(temp, signStr);
                        if (str == -1)
                        {
                            //Response.Write("<br>end</br>");     
                            break;
                        }
                        
                        temp2 = new byte[temp.Length - (str + signStr.Length)];
                        Array.ConstrainedCopy(temp, str + signStr.Length,temp2, 0, temp2.Length);
                        end = IndexOf(temp2, signStr);
                        end = (end == -1 ? IndexOf(temp2, signEnd) : end);
                        if (end == -1)
                        {
                            Response.Write("<br>Struct error!</br>");
                            break;
                        }
                        item = new Array[2];
                        temp3 = new byte[end];
                        Array.ConstrainedCopy(temp2, 0, temp3, 0, temp3.Length);
                        str = IndexOf(temp3, (new byte[] { 0xd, 0xa, 0xd, 0xa }));
                        item[0] = new byte[str];
                        Array.ConstrainedCopy(temp3, 0, item[0], 0, item[0].Length);
                        item[1] = new byte[temp3.Length - (str + 4)];
                        Array.ConstrainedCopy(temp3, str + 4, item[1], 0, item[1].Length);
                        items.Add(item);
                        
                        temp = new byte[temp2.Length-end];
                        Array.ConstrainedCopy(temp2, end, temp, 0, temp.Length);                  
                    }
                }
                
                IEnumerator e = items.GetEnumerator();
                while (e.MoveNext())
                {
                    Array[] obj = (Array[])e.Current;
                    string header = encoding.GetString((byte[])obj[0]);
                    int nFileNameStr = header.IndexOf("filename=\"") + 10;
                    if (nFileNameStr >= 10)
                    {
                        string path = header.Substring(nFileNameStr, header.IndexOf("\"", nFileNameStr) - nFileNameStr);
                        string filename = System.IO.Path.GetFileName(path);
                        if (filename.Length != 0)
                        {
                            try
                            {
                                System.IO.FileStream fs = new System.IO.FileStream(savepath + filename, System.IO.FileMode.OpenOrCreate);
                                System.IO.BinaryWriter w = new System.IO.BinaryWriter(fs);
                                w.Write((byte[])obj[1]);
                                w.Close();
                                fs.Close();

                                Response.Write("<br>" + filename + "  upload finish!" + "</br>");
                            }
                            catch (System.Exception se)
                            {
                                Response.Write("<br>" + se.Message + "</br>");
                            }
                        }
                    }
                }
            }
            catch (System.Exception e)
            {
                Response.Write("<br>" + e.Message + "</br>");
            }  
        }

        public int IndexOf(byte[] ByteArrayToSearch, byte[] ByteArrayToFind)
        {
            Encoding encoding = Encoding.ASCII;
            string toSearch = encoding.GetString(ByteArrayToSearch, 0, ByteArrayToSearch.Length);
            string toFind = encoding.GetString(ByteArrayToFind, 0, ByteArrayToFind.Length);
            int result = toSearch.IndexOf(toFind, StringComparison.Ordinal);
            return result;
        }
    </script>
</head>
<body>
</body>
</html>
