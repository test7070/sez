<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<script src="../script/jquery.min.js" type="text/javascript"></script>
<script src='../script/qj2.js' type="text/javascript"></script>
        <script src='qset.js' type="text/javascript"></script>
<script src='../script/qj_mess.js' type="text/javascript"></script>
<script src='../script/mask.js' type="text/javascript"></script>
<script type="text/javascript">
    var q_name = 'chgcash', t_bbsTag = 'tbbs', t_content = " field=noa,money,chgitemno,chgitem,acc1,acc2  order=odate ", afilter = [], bbsKey = ['noa'],  as; //, t_where = '';
    var t_sqlname = 'chgcash_load'; t_postname = q_name; brwCount2 = 12;
    var isBott = false;  /// 是否已按過 最後一頁
    var txtfield = [], afield, t_data, t_htm;
    var i, s1;

    $(document).ready(function () {
    	//當沒有網址參數
    	if (location.href.indexOf('?') < 0)   // debug
        {
            location.href = location.href + "?;;;^^1=0^^";
            return;
        }
        
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
</style>
</head>
<body>
<div  id="dbbs"  >
        <table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
            <tr style='color:White; background:#003366;' >
                <td align="center">&nbsp;</td>
                <td align="center"><a id='lblNoa'></a></td>
                <td align="center"><a id='lblMoney'></a></td>
                <td align="center"><a id='lblChgitem'></a></td>
                <td align="center"><a id='lblAcc'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td><input class="chk"  id="chkSel.*" type="checkbox"/></td>
                <td><input class="txt"  id="txtNoa.*" type="text"  /></td>
                <td><input class="txt" id="txtMoney.*" type="text"  /></td>
                <td><input class="txt" id="txtChgitemno.*" type="text" /><input class="txt" id="txtChgitem.*" type="text" /></td>
                <td><input class="txt" id="txtAcc1.*" type="text" /><input class="txt" id="txtAcc2.*" type="text" /></td>
            </tr>
        </table>
  <!--#include file="../inc/pop_ctrl.inc"--> 
 </div>
</body>
</html>
