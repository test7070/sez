<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src="../script/qj2.js" type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src="../script/qj_mess.js" type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
    	<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
    var q_name = 'workbs', t_bbsTag = 'tbbs', t_content = " field=productno,product,unit,born,bweight,mount,weight,errmount,memo,ordeno ", afilter = [], bbsKey = ['noa','no2'],  as; //, t_where = '';
    var t_sqlname = 'workbs_load'; t_postname = q_name; brwCount2 = 12;
    var isBott = false;  /// 是否已按過 最後一頁
    var txtfield = [], afield, t_data, t_htm;
    var i, s1;

    $(document).ready(function () {
        if (!q_paraChk())
            return;

        main();
    });         /// end ready

    function main() {
        if (dataErr)  /// 載入資料錯誤
        {
            dataErr = false;
            return;
        }
        mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
    }

    function bbsAssign() { 
        _bbsAssign();
    }

    function q_gtPost() {  

    }
    function refresh() {
        _refresh();
    }

</script>
<style type="text/css">
    .seek_tr
    {color:white; text-align:center; font-weight:bold;BACKGROUND-COLOR: #76a2fe}
    .txt{
    	width:95%;
    	float:left;
    }
    .num{
    	text-align:right;
    }
</style>
</head>
<body>
<div  id="dbbs"  >
        <table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;">&nbsp;</td>
                <td align="center" style="width:10%;"><a id='lblProductno'></a></td>
                <td align="center" style="width:15%;"><a id='lblProduct'></a></td>
                <td align="center" style="width:5%;"><a id='lblUnit'></a></td>
                <td align="center" style="width:8%;"><a id='lblBorn'></a></td>
                <td align="center" style="width:8%;"><a id='lblBweight'></a></td>
                <td align="center" style="width:8%;"><a id='lblMount'></a></td>
                <td align="center" style="width:8%;"><a id='lblWeight'></a></td>
                <td align="center" style="width:8%;"><a id='lblErrmount'></a></td>
                <td align="center" style="width:15%;"><a id='lblOrdeno'></a></td>
                <td align="center"><a id='lblMemo'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td><input class="chk" id="chkSel.*" type="checkbox"/></td>
                <td><input class="txt" id="txtProductno.*" type="text" /></td>
                <td><input class="txt" id="txtProduct.*" type="text" /></td>
                <td><input class="txt" id="txtUnit.*" type="text" /></td>
                <td><input class="txt num" id="txtBorn.*" type="text" /></td>
                <td><input class="txt num" id="txtBweight.*" type="text" /></td>
                <td><input class="txt num" id="txtMount.*" type="text" /></td>
                <td><input class="txt num" id="txtWeight.*" type="text" /></td>
                <td><input class="txt num" id="txtErrmount.*" type="text" /></td>
                <td>
                	<input style="width:70%;" id="txtOrdeno.*" type="text" />
                	<input style="width:25%;" id="txtNo2.*" type="text" />
                </td>
                <td><input class="txt" id="txtMemo.*" type="text" /></td>
            </tr>
        </table>
  <!--#include file="../inc/pop_ctrl.inc"--> 
 </div>
</body>
</html>
