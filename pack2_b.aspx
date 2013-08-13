<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src="../script/qj2.js" type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src="../script/qj_mess.js" type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
    	<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
    
    var q_name = 'pack2s', t_bbsTag = 'tbbs', t_content = " field=noa,packway,pack,inmount,outmount,inweight,outweight,weight,gweight,lengthb,width,height,cuft", afilter = [], bbsKey = ['noa'],  as; //, t_where = '';
    var t_sqlname = 'pack2s_load'; t_postname = q_name; brwCount2 = 10;
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
    input[type="text"], input[type="button"] {
		font-size: medium;
    }
</style>
</head>
<body>
<div  id="dbbs"  >
        <table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
            <tr style='color:White; background:#003366;' >
                <td align="center">
					<input type="checkbox" id="checkAllCheckbox"/>
				</td>
                <td align="center"><a id='lblPackway'></a></td>
                <td align="center"><a id='lblPack'></a></td>
                <td align="center"><a id='lblInmount'></a></td>
                <td align="center"><a id='lblOutmount'></a></td>
                <td align="center"><a id='lblInweight'></a></td>
                <td align="center"><a id='lblOutweight'></a></td>
                <td align="center"><a id='lblWeight'></a></td>
                <td align="center"><a id='lblGweight'></a></td>
                <td align="center"><a id='lblLengthb'></a></td>
                <td align="center"><a id='lblWidth'></a></td>
                <td align="center"><a id='lblHeight'></a></td>
                <td align="center"><a id='lblCuft'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;" align="center"><input name="sel"  id="radSel.*" type="radio" /></td>
                <td style="width:4%;">
                	<input class="txt" id="txtPackway.*" type="text" style="width:99%;"/>
                	<input class="txt" id="txtNoa.*" type="hidden" style="width:99%;"/>
                </td>
                <td style="width:8%;"><input class="txt" id="txtPack.*" type="text" style="width:99%; text-align:left;"/></td>
                <td style="width:8%;"><input class="txt" id="txtInmount.*" type="text" style="width:99%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtOutmount.*" type="text" style="width:99%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtInweight.*" type="text" style="width:99%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtOutweight.*" type="text" style="width:99%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtWeight.*" type="text" style="width:99%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtGweight.*" type="text" style="width:99%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtLengthb.*" type="text" style="width:99%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtWidth.*" type="text" style="width:99%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtHeight.*" type="text" style="width:99%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtCuft.*" type="text" style="width:99%; text-align:right;"/><input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
  <!--#include file="../inc/brow_ctrl.inc"-->
 </div>
</body>
</html>
