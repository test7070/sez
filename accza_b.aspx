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
            var q_name = 'accza', t_bbsTag = 'tbbs', t_content = " field=noa,accno", afilter = [], bbsKey = ['noa'],  as; //, t_where = '';
    var t_sqlname = 'accza'; t_postname = q_name; brwCount2 = 12;
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
        mainBrow(6, t_content, t_sqlname, t_postname, r_accy + "_" + r_cno);
    }

    function bbsAssign() { 
    	 for (var j = 0; j < q_bbsCount; j++) {
			if (!$('#btnMinus_' + j).hasClass('isAssign')) {
				$('#txtAccno_' + j).click(function() {
					window.parent.OpenAccnoWindows($(this).val());
				});
		   	}
         }
        _bbsAssign();
    }

    function q_gtPost() {  

    }
    function refresh() {
        _refresh();
    }
		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<th align="center" style="display: none;"></th>
					<th align="center" style='color:Blue;display: none;' ><a id='lblNoa'></a></th>
					<th align="center" style='color:Blue;' ><a id='lblAccno'></a></th>
				</tr>
				<tr>
					<td style="width:2%;display: none;">
					<input name="sel"  id="radSel.*" type="radio" />
					</td>
					<td style="width:20%;display: none;">
					<input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
					<td style="width:75%;">
					<input class="txt" id="txtAccno.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/brow_ctrl.inc"-->
		</div>
	</body>
</html>
