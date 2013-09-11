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
            var q_name = 'view_acc', t_content = ' field=acc1,acc2', bbsKey = ['acc1'], as;
		    var isBott = false;  /// 是否已按過 最後一頁
		    var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
		    var i,s1;
		        $(document).ready(function () {
		            main();
		        });         /// end ready
		
		        function main() {
		            if (dataErr)  /// 載入資料錯誤
		            {
		                dataErr = false;
		                return;
		            }
		
		            var s2 = q_getId();
		            var s3 = (s2 && s2.length > 3 ? s2[3] : '');  //篩選科目
		            var s1 = (s2 && s2.length > 3 ? s2[4] : '');  //年度
		            mainBrow(0 , '', '', '', s1);
		         }
		         
		        function q_gtPost(){
		            
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
					<th align="center" > </th>
					<th align="center" style='color:blue;' ><a id='lblAcc1'> </a></th>
					<th align="center" style='color:blue;' ><a id='lblAcc2'> </a></th>
				</tr>
				<tr>
					<td style="width:2%;">
					<input name="sel"  id="radSel.*" type="radio" />
					</td>
					<td style="width:40%;">
					<input class="txt" id="txtAcc1.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
					<td style="width:50%;">
					<input class="txt" id="txtAcc2.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/brow_ctrl.inc"-->
		</div>
	</body>
</html>
