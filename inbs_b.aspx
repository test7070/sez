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
    var q_name = 'inbs', t_bbsTag = 'tbbs', t_content = " field=noa,noq,productno,product,unit,dime,width,lengthb,spec,ordeno,no2,bweight,mount,theory", afilter = [], bbsKey = ['noa'],  as; //, t_where = '';
    var t_sqlname = 'inbs_load'; t_postname = q_name; brwCount2 = 12;
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
        $('#checkAllCheckbox').click(function(){
			$('input[type=checkbox][id^=chkSel]').each(function(){
				var t_id = $(this).attr('id').split('_')[1];
				if(!emp($('#txtProductno_' + t_id).val()))
					$(this).attr('checked',$('#checkAllCheckbox').is(':checked'));
			});
		});
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
                <td align="center" style="width:1%;">
                	<input type="checkbox" id="checkAllCheckbox"/>
                </td>
                <td align="center" style="width:20%;"><a id='lblProductno'></a></td>
                <td align="center" style="width:40%;"><a id='lblProduct'></a></td>
                <td align="center" style="width:4%;"><a id='lblUnit'></a></td>
                <td align="center" style="width:35%;"><a id='lblOrdeno'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td><input class="chk"  id="chkSel.*" type="checkbox"/></td>
                <td><input class="txt"  id="txtProductno.*" type="text" style="width:98%;" /></td>
                <td><input class="txt" id="txtProduct.*" type="text" style="width:98%;" /></td>
                <td><input class="txt" id="txtUnit.*" type="text" style="width:94%;"/></td>
                <td><input class="txt" id="txtOrdeno.*" type="text" style="width:70%;"/><input class="txt" id="txtno2.*" type="text"  style="width:20%;"/></td>
             </tr>
        </table>
  <!--#include file="../inc/pop_ctrl.inc"--> 
 </div>
</body>
</html>
