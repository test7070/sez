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
    var q_name = 'view_workqs', t_bbsTag = 'tbbs', t_content = " field=noa,noq,productno,product,unit,mount,qcresult,storeno,store,bkmount,wmount,workno,ordeno,no2,memo,workfno,workfnoq,wdmount", afilter = [], bbsKey = ['noa','noq'],  as; //, t_where = '';
    var t_sqlname = 'workqs_workds_load'; t_postname = q_name; brwCount2 = 12;
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
        for (var j = 0; j < q_bbsCount; j++) {
			if(!emp($('#txtNoa_'+j).val())){
				$('#txtBkmount2_'+j).val(q_float('txtBkmount_'+j)-q_float('txtWdmount_'+j));
			}
		}
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
    input[type="text"], input[type="button"] {
		font-size: medium;
	}
</style>
</head>
<body>
<div  id="dbbs"  >
        <table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:1280px;'  >
            <tr style='color:White; background:#003366;' >
                <td align="center">
					<input type="checkbox" id="checkAllCheckbox"/>
				</td>
				 <td align="center"><a id='lblNoa'></a></td>
                <td align="center"><a id='lblProductno'></a></td>
                <td align="center"><a id='lblProduct'></a></td>
                <td align="center"><a id='lblUnit'></a></td>
                <td align="center"><a id='lblMount'></a></td>
                <td align="center"><a id='lblBkmount'></a></td>
                <td align="center"><a id='lblWmount'></a></td>
                <td align="center"><a id='lblQcresult'></a></td>
                <td align="center"><a id='lblWorkno'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:26px;">
                	<input class="chk"  id="chkSel.*" type="checkbox"/><input id="txtWk_mount.*" type="hidden"/>
                	<input id="txtStoreno.*" type="hidden"/><input id="txtStore.*" type="hidden"/>
                	<input id="txtMemo.*" type="hidden"/><input id="txtOrdeno.*" type="hidden"/><input id="txtNo2.*" type="hidden"/>
                	<input id="txtBorn.*" type="hidden"/><input id="txtBkmount.*" type="hidden"/><input id="txtWdmount.*" type="hidden"/>
                </td>
                <td style="width:190px;">
                	<input class="txt" id="txtNoa.*" type="text" style="width:70%;"/>
                	<input class="txt" id="txtNoq.*" type="text" style="width:20%;"/>
                </td>
                <td style="width:170px;"><input class="txt"  id="txtProductno.*" type="text" style="width:98%;" /></td>
                <td style="width:230px;"><input class="txt" id="txtProduct.*" type="text" style="width:98%;" /></td>
                <td style="width:55px;"><input class="txt" id="txtUnit.*" type="text" style="width:94%;"/></td>
                <td style="width:80px;"><input class="txt" id="txtMount.*" type="text" style="width:94%;text-align: right;"/></td>
                <td style="width:80px;"><input class="txt" id="txtBkmount2.*" type="text" style="width:94%;text-align: right;"/></td>
                <td style="width:80px;"><input class="txt" id="txtWmount.*" type="text" style="width:94%;text-align: right;"/></td>
                <td><input class="txt" id="txtQcresult.*" type="text" style="width:94%;"/></td>
                <td style="width:170px;"><input class="txt" id="txtWorkno.*" type="text" style="width:98%;" /></td>
             </tr>
        </table>
  <!--#include file="../inc/pop_ctrl.inc"--> 
 </div>
</body>
</html>
