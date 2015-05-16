<%@ Page Language="C#" Debug="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title>4.1 EDI上傳作業</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../script/jquery.min.js" type="text/javascript"></script>
    <script src='../script/qj2.js' type="text/javascript"></script>
        <script src='qset.js' type="text/javascript"></script>
    <script src='../script/qj_mess.js' type="text/javascript"></script>
    <script src="../script/qbox.js" type="text/javascript"></script>
    <script src='../script/mask.js' type="text/javascript"></script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />

        <script type="text/javascript">
            var q_name = 'uploaddc';
            $(document).ready(function () {
                _q_boxClose();
                q_getId();
                q_gf('', 'uploaddc');
                $('#btnUpload').click(function () {
                    $('#txtAddr').val(location.href);
                });
                $('#btnFile1').click(function () {
                    $('#txtAddr').val(location.href);
                    $('#TextBox1').val(location.href);
                });
                $('#btnAuthority').click(function () {
                    btnAuthority(q_name);
                });

                $('#examplecsv').click(function () {
                    var s1 = location.href;
		    var j = s1.indexOf('.aspx');
                    var k = s1.lastIndexOf('/', j);

                    $('#examplecsv')[0].href = s1.substr(0, k) + '/edifsd_example.csv'; 
                });
                

            });

            function q_gfPost() {
                q_langShow();
                $('#txtUserno').val(r_userno);
            }

            function getAddr() {
                document.getElementsByName('TextBox1').value = location.href;
            }
        </script>

    <script language="c#" runat="server">
        public void Page_Load()
        {
            Encoding encoding = System.Text.Encoding.UTF8;
            Response.ContentEncoding = encoding;
            int formSize = Request.TotalBytes,i;
            byte[] formData = Request.BinaryRead(formSize);
            byte[] bCrLf = { 0xd, 0xa };// \r\n

            string savepath = "D:\\t\\";


            string[] s2 = HttpContext.Current.Request.Path.Split('/');
            if (s2.Length < 2)
            {
                Response.Write("<br>Path Error=" + HttpContext.Current.Request.Path + "</br>");
                return;
            }

            string t_userno = Request.Form["txtUserno"]; 
            
            var tmp = Request.Form["btnAuthority"];

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
            byte[] signEnd = new byte[nSign + 2];
            Array.ConstrainedCopy(sign, 0, signEnd, 0, nSign);
            Array.ConstrainedCopy((new byte[] { 0x2d, 0x2d }), 0, signEnd, nSign, 2);//add --
            string cSignEnd = encoding.GetString(signEnd);

            Array[] item = new Array[2];
            ArrayList items = new ArrayList();

            byte[] temp = new byte[formData.Length];
            byte[] temp2 = null;
            byte[] temp3 = null;
            int str, end;
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
                        Array.ConstrainedCopy(temp, str + signStr.Length, temp2, 0, temp2.Length);
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
                        item[1] = new byte[temp3.Length - (str + 4)-2];
                        Array.ConstrainedCopy(temp3, str + 4, item[1], 0, item[1].Length);
                        items.Add(item);

                        temp = new byte[temp2.Length - end];
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
                                end = filename.LastIndexOf(".");
                                if (end < 0)
                                {
                                    Response.Write("<br>" + filename + " Error </br>");
                                    return;
                                }

                                System.IO.FileStream fs = new System.IO.FileStream(savepath +"EDIFSD_"+ filename.Substring(0, end) + "^$__" + t_userno + filename.Substring(end), System.IO.FileMode.OpenOrCreate);

                                System.IO.BinaryWriter w = new System.IO.BinaryWriter(fs);
                                w.Write((byte[])obj[1]);
                                w.Close();
                                fs.Close();

                                Response.Write("<br>" + filename + "  upload finish!" + "</br>");
                                string url = Request.UrlReferrer.ToString();
                                i = url.IndexOf("?");
                                Response.Redirect("uploadBV_post.aspx"+ ( i > 0 ?  url.Substring( i) : ""));   /// 
                                
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
    <style type="text/css">
        .style1
        {
            font-family: 標楷體;
            color: #0066FF;
            font-size: x-large;
        }
    </style>
</head>
<body>
<div id='q_menu'></div>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' id='btnAuthority' name='btnAuthority' style='font-size:16px;' value='權限'/>

<p>&nbsp;</p>
<div>
<form id="Form1" name='form1' method='post' action='uploadBV.aspx' runat="server" 
    enctype='multipart/form-data' style='width:725px'>  
<input type='file' name='btnFile1' style='font-size:16px;' onclick='getAddr()'/>
<input type='hidden' name='txtAddr' style='font-size:16px;'/>
<asp:TextBox ID="TextBox1"  name="TextBox1" runat="server" Visible="false"></asp:TextBox>
<input type='submit' name='btnUpload' value='上傳' style='font-size:16px;'/>
    <p class='style1'>EDI資料上傳 </p>
<input id="txtUserno"  name="txtUserno" type="hidden"  />
<a id='examplecsv' href="" target="_blank" style="text-decoration:none;color:red;">下載範例CSV檔</a>
</form>
</div>

</body>
</html>
