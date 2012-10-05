<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<script src='../script/qj2.js' type="text/javascript"></script>
        <script src='qset.js' type="text/javascript"></script>
<script src='../script/qj_mess.js' type="text/javascript"></script>
<script src="../script/jquery-1.6.1.min.js" type="text/javascript"></script>
<script src='../script/mask.js' type="text/javascript"></script>
<script type="text/javascript">
    var q_name = 'ordcs', t_bbsTag = 'tbbs', t_content = " field=productno,product,size,dime,width,lengthb,radius,mount,weight,noa,no2,price  order=odate ", afilter = [], bbsKey = ['noa', 'no2'], t_count = 0, as;
    var t_sqlname = 'ordcs_load2'; t_postname = q_name; brwCount2 = 12;
    var isBott = false;  /// 是否已按過 最後一頁
    var txtfield = [], afield, t_data, t_htm;
    var i, s1;

    $(document).ready(function () {
        main();
    });         /// end ready

    function main() {
        if (dataErr)  /// 載入資料錯誤
        {
            dataErr = false;
            return;
        }
        mainBrow(6, t_content, t_sqlname, t_postname);
        //q_gt('ordc', '' , 0, 0, 0, "", r_accy);
    }
    function bbsAssign() {  /// checked 
        _bbsAssign();
    }

    function q_gtPost() { 
        var ordc = _q_appendData("ordc", "", true);
        q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtRadius,txtWidth,txtDime,txtLengthb,txtMount,txtWeight,txtPrice,txtTotal,txtTheory,txtMemo,txtOrdbno,txtNo3', ordc.length, ordc, 'productno,product,spec,radius,width,dime,lengthb,mount,weight,price,total,theory,memo,noa,no3', '');
    }
    function refresh() {
        _refresh();
    }
</script>
<style type="text/css">
    .seek_tr
    {color:white; text-align:center; font-weight:bold;BACKGROUND-COLOR: #76a2fe}
</style>
</head>
<body>
<div  id="dbbs"  >
        <table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
            <tr style='color:White; background:#003366;' >
                <td align="center">&nbsp;</td>
                <td align="center"><a id='lblProductno_st'></a></td>
                <td align="center"><a id='lblProduct'></a></td>
                <td align="center"><a id='lblSpec'></a></td>
                <td align="center"><a id='lblSize'></a></td>
                <td align="center"><a id='lblMount'></a></td>
                <td align="center"><a id='lblWeight'></a></td>
                <td align="center"><a id='lblPrice'></a></td>
                <td align="center"><a id='lblNoa'></a></td>
                <td align="center"><a id='lblMemo'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="chkSel.*" type="checkbox"  /></td>
                <td style="width:10%;"><input class="txt"  id="txtProductno.*" type="text" style="width:98%;" /></td>
                <td style="width:15%;"><input class="txt" id="txtProduct.*" type="text" style="width:98%;" /></td>
                 <td style="width:15%;"><input class="txt" id="txtSpec.*" type="text"  style="width:98%;" /></td>
                <td style="width:18%;">
                       	<input class="txt num c8" id="txtSize1.*" type="text"/><div id="x1" style="float: left"> x</div>
                		<input class="txt num c8" id="txtSize2.*" type="text"/><div id="x2" style="float: left"> x</div>
                        <input class="txt num c8" id="txtSize3.*" type="text"/><div id="x3.*" style="float: left"> x</div>
                         <input class="txt num c8" id="txtSize4.*" type="text"/>
                         <!--上為虛擬下為實際-->
                         <input id="txtRadius.*" type="hidden"/>
                		<input  id="txtWidth.*" type="hidden"/>
                        <input  id="txtDime.*" type="hidden"/>
                         <input id="txtLengthb.*" type="hidden"/>
                </td>
                <td style="width:5%;"><input class="txt" id="txtMount.*" type="text" style="width:94%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtWeight.*" type="text" style="width:96%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtPrice.*" type="text" style="width:96%; text-align:right;"/></td>
                <td style="width:5%;"><input class="txt" id="txtNoa.*" type="text" style="width:96%;"/><input class="txt" id="txtno2.*" type="text" /></td>
                <td style="width:8%;"><input class="txt" id="txtMemo.*" type="text" style="width:98%;"/><input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
  <!--#include file="../inc/pop_ctrl.inc"--> 
 </div>
</body>
</html>
