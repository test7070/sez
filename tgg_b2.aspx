<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'tgg', t_content = ' field=noa,comp,tel,zip_fact,addr_fact,trantype,zip_invo,addr_invo,paytype,nick,conn,conntel', bbsKey = ['noa'], as;
            var t_sqlname = 'tgg_load';
            t_postname = q_name;
            brwCount2 = 20;
            var isBott = false;
            /// 是否已按過 最後一頁
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
            var i, s1;
            $(document).ready(function() {
                main();
            });
            /// end ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                //mainBrow(0, t_content);
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
            }

            function q_gtPost() {
            }

            function refresh() {
                _refresh();
            }

            function bbsAssign() {
                _bbsAssign();
            }
            
            function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}
		</script>
		<style type="text/css">
		</style>
	</head>

	<body>
		<div  id="dbbs"  >
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<th align="center" ></th>
					<th align="center" style='color:Blue;' ><a id='lblNoa'> </a></th>
					<th align="center" style='color:Blue;' ><a id='lblComp'> </a></th>
				</tr>
				<tr>
					<td style="width:2%;">
					<input name="chk"  id="chkSel.*" type="checkbox" />
					</td>
					<td style="width:20%;">
					<input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
					<td style="width:75%;">
					<input class="txt" id="txtComp.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/brow_ctrl.inc"-->
		</div>

	</body>
</html>
