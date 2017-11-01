<%@ Page Language="C#" Debug="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title>資料上傳作業</title>
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
            });

            function q_gfPost() {
                q_langShow();
                $('#txtUserno').val(r_userno);
            }

            function getAddr() {
                document.getElementsByName('TextBox1').value = location.href;
            }
        </script>
        <script type="text/javascript">
            window.history.forward(1); //防止使用者回到上一頁
		</script>

    <script language="c#" runat="server">
        public void Page_Load()
        {
            if (Request.Files.Count == 0)
                return;
            string savepath = @"D:\t\";
            HttpFileCollection MyFileCollection = Request.Files;
            for(int x=0;x<MyFileCollection.Count;x++){
                HttpPostedFile MyPostedFile = MyFileCollection.Get(x);
                MyFileCollection[x].SaveAs(savepath+MyPostedFile.FileName);
            }
            string url = Request.UrlReferrer.ToString();
            int i = url.IndexOf("?");
            Response.Redirect("uploadDC_post.aspx" + (i > 0 ? url.Substring(i) : ""));
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
<form id="Form1" name='form1' method='post' action='uploadWJ.aspx' runat="server" 
    enctype='multipart/form-data' style='width:725px'>  
<input type='file' name='btnFile1' style='font-size:16px;' onclick='getAddr()' multiple />
<input type='hidden' name='txtAddr' style='font-size:16px;'/>
<asp:TextBox ID="TextBox1"  name="TextBox1" runat="server" Visible="false"></asp:TextBox>
<input type='submit' name='btnUpload' value='上傳' style='font-size:16px;'/>
<p class='style1'>台拜訂單 資料上傳 檔名格式 = ORDEWJ*.xls</p>
<p class='style1'>統一精工加油站    檔名格式 = SMILE*.XLS</p>
<p class='style1'>山隆加油站        檔名格式 = SLOIL*.XLS</p>
<p class='style1'>ETAG 資料上傳 檔名格式=ETAG*.xls</p>
<p class='style1'>中鋼租車 資料上傳&nbsp; 檔名格式=CSA </p>
<p class='style1'>中鋼外銷 資料上傳&nbsp; 檔名格式=CSC</p>
<p class='style1'>中鋼內銷 資料上傳&nbsp; 檔名格式=CSIA053.txt</p>
<p class='style1'>指紋打卡機&nbsp;資料上傳&nbsp; 檔名格式=SALWJ.TXT</p>
<p class='style1'>健保級距&nbsp;資料上傳&nbsp; 檔名格式=HEALTH.xls</p> <a href="http://www.nhi.gov.tw/webdata/webdata.aspx?menu=19&menu_id=706&WD_ID=800&webdata_id=3615">健保級距 XLS 下載 ， 請另存新檔後，再上傳</a>
<p class='style1'>勞保級距&nbsp;資料上傳&nbsp; 檔名格式=LABOR.xls</p> <a href="http://www.bli.gov.tw/sub.aspx?a=iCZS3R5M6%2fI%3d">勞保級距 XLS 下載 ， 請另存新檔後，再上傳</a>
<p class='style1'>勞退級距&nbsp;資料上傳&nbsp; 檔名格式=RETIRE.xls</p> <a href="http://www.bli.gov.tw/sub.aspx?a=y3lcfnmUOPU%3d">勞退級距 XLS 下載 ， 請另存新檔後，再上傳</a>

<input id="txtUserno"  name="txtUserno" type="hidden"  />
</form>
</div>

</body>
</html>

