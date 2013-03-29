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
            var q_name = 'car2', t_bbsTag = 'tbbs', t_content = ' field=noa,driverno,driver order=odate', afilter = [], bbsKey = ['noa'], as;//, t_where = '';
            var t_sqlname = 'car2_load'; t_postname = q_name; brwCount2 = 0;
            	brwCount = -1;
            var isBott = false;
            /// 是否已按過 最後一頁
            var txtfield = [], afield, t_data, t_htm;
            var i, s1;
            q_alias='a';
            
            $(document).ready(function() {
            	if (!q_paraChk())
            		return;
                main();
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
            }

            function q_gtPost() {
            }
            function refresh(){
            	_refresh();
            }
            function bbsAssign() { 
        		_bbsAssign();
	   	
    		}
		</script>
		
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs"  class='tbbs' border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
				<tr style='color:White; background:#003366;'>
					<th align="center" ></th>
					<th align="center"><a id='lblNoa'></a></th>
					<th align="center"><a id='lblDriver'></a></th>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:2%;">	<input class="chk"  id="chkSel.*" type="checkbox" name="chkSel"/></td>
					<td style="width:20%;"><input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td style="width:75%;"><input class="txt" id="txtDriver.*" type="text" style="width:98%;"  readonly="readonly" />	</td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"--> 
		</div>
	</body>
</html>
