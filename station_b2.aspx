<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'station', t_content = ' ', bbsKey = ['noa'], as;
            var t_sqlname = 'station_load';
            t_postname = q_name;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
            var i, s1;
            
            $(document).ready(function() {
            	brwCount2 = 20;
                main();
            });
            /// end ready

            function main() {
                if (dataErr) {
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
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<th align="center" > </th>
					<th align="center" style='color:Blue;' ><a id='lblNoa'> </a></th>
					<th align="center" style='color:Blue;' ><a id='lblStation'> </a></th>
				</tr>
				<tr>
					<td style="width:2%;"><input name="chk"  id="chkSel.*" type="checkbox" name="chkSel"/></td>
					<td style="width:20%;"><input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td style="width:45%;"><input class="txt" id="txtStation.*" type="text" style="width:98%;"  readonly="readonly" /></td>
				</tr>
			</table>
			<!--#include file="../inc/brow_ctrl.inc"-->
		</div>
	</body>
</html>
