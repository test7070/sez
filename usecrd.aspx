<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery-1.6.1.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'usecrd', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 10;
			var t_sqlname = 'usecrd_load';
			t_postname = q_name;
			var isBott = false;
			var afield, t_htm;
			var i, s1;
			var q_readonly = [];
			var q_readonlys = ['txtCreditno','txtNamea','txtCredit','txtWorker','txtBasev','txtMul'];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];

			$(document).ready(function() {
				bbmKey = [];
				bbsKey = ['noa', 'noq'];
				if (!q_paraChk())
					return;
				main();
			});
			
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6, t_content, t_sqlname, t_postname);
				q_mask(bbmMask);
			}

			function q_gtPost(t_name) {
				switch(t_name){
					case 'GetCredit':
						var as = _q_appendData('credit', "", true);
						console.log(as);
						break;
				}
			}

			function bbsAssign() {
				_bbsAssign();
			}

			function btnOk() {
				sum();
				t_key = q_getHref();
				_btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['creditno']) {
					as[bbsKey[0]] = '';
					return;
				}
				q_getId2('', as);
				return true;
			}

			function refresh() {
				_refresh();
				q_gt('credit', '', 0, 0, 0, "GetCredit", r_accy);
			}

			function sum() {
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
			}
		</script>
		<style type="text/css">
			.num{
				text-align:right;
			}
			.c1{
				float:left;
				width:95%;
			}
		</style>
	</head>
	<body>
		<div id="dbbs" >
			<!--#include file="../inc/pop_modi.inc"-->
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%' >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:36px;">
						<input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;" />
					</td>
					<td align="center" style="width:80px;"><a id='lblCreditno'></a></td>
					<td align="center" style="width:200px;"><a id='lblNamea'></a></td>
					<td align="center" style="width:120px;"><a id='lblRefv'></a></td>
					<td align="center" style="width:120px;"><a id='lblCredit'></a></td>
					<td align="center" style="width:120px;"><a id='lblWorker'></a></td>
					<td align="center" style="width:120px;"><a id='lblBasev'></a></td>
					<td align="center" style="width:120px;"><a id='lblMul'></a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn" id="btnMinus.*" type="button" value='-' style="font-weight: bold; " />
						<input class="txt c1" id="txtNoa.*" type="hidden" />
						<input id="txtNoq.*" type="hidden" />
					</td>
					<td><input id="txtCreditno.*" type="text" class="c1" /></td>
					<td><input id="txtNamea.*" type="text" class="c1" /></td>
					<td><input id="txtRefv.*" type="text" class="c1 num" /></td>
					<td><input id="txtCredit.*" type="text" class="c1 num" /></td>
					<td><input id="txtWorker.*" type="text" class="c1" /></td>
					<td><input id="txtBasev.*" type="text" class="c1 num" /></td>
					<td><input id="txtMul.*" type="text" class="c1 num" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
