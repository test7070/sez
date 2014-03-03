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
			var q_name = 'ucab',t_bbsTag = 'tbbs', t_content = "", afilter = [], bbsKey = ['noa', 'noq'], t_count = 0, as;
			var t_sqlname = 'ucab';
			t_postname = q_name;
			brwCount2 = 12;
			var isBott = false;
			var txtfield = [], afield, t_data, t_htm;
			var bbsMask = [];
			var bbsNum = [['txtMount',10,0,1]];
			var q_readonlys = ['txtModel','txtStation','txtTgg'];
			var i, s1;
			aPop = new Array(
				['txtModelno_', 'btnModelno_', 'model', 'noa,model', 'txtModelno_,txtModel_', 'model_b.aspx'],
				['txtStationno_', 'btnStationno_', 'station', 'noa,station', 'txtStationno_,txtStation_', 'station_b.aspx'],
				['txtTggno_', 'btnTggno_', 'tgg', 'noa,comp', 'txtTggno_,txtTgg_', 'tgg_b.aspx']
			);
			$(document).ready(function() {
				main();
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
			}
			
			function mainPost(){
				bbsMask = [['txtBdate',r_picd],['txtEdate',r_picd]];
			}

			function bbsAssign() {
				_bbsAssign();
			}
			
			function btnOk() {
				t_key = q_getHref();
				_btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
			}
			
			function bbsSave(as) {
				if(!as['modelno']) {
					as[bbsKey[0]] = '';
					return;
				}
				q_getId2('', as);
				return true;
            }

			function q_gtPost() {

			}

			function refresh() {
				_refresh();
			}
			
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}
			
			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				bbsAssign();
			}
		</script>
		<style type="text/css">
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			#dbbs{
				width: 100%;			
			}
			.num {
				text-align: right;
			}
			.txt{
				float:left;
			}
			.c1{
				width:98%;
			}
		</style>
	</head>
	<body>
		<div id="dbbs" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1'>
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:30px;">
						<input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;"/>
					</td>
					<td align="center" style="width:180px;"><a id='lblModelno'></a></td>
					<td align="center" style="width:60px;"><a id='lblMount'></a></td>
					<td align="center" style="width:180px;"><a id='lblStationno'></a></td>
					<td align="center" style="width:180px;"><a id='lblTggno'></a></td>
					<td align="center" style="width:200px;"><a id='lblBdate'></a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn" id="btnMinus.*" type="button" value='-' style="font-weight: bold;"/>
					</td>
					<td>
						<input id="btnModelno.*" type="button" value="." class="txt btn" style="width:1%;"/>
						<input type="text" id="txtModelno.*" class="txt" style="width:30%;"/>
						<input type="text" id="txtModel.*" class="txt" style="width:50%;"/>
					</td>
					<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
					<td>
						<input id="btnStationno.*" type="button" value="." class="txt btn" style="width:1%;"/>
						<input type="text" id="txtStationno.*" class="txt" style="width:30%;"/>
						<input type="text" id="txtStation.*" class="txt" style="width:50%;"/>
					</td>
					<td>
						<input id="btnTggno.*" type="button" value="." class="txt btn" style="width:1%;"/>
						<input type="text" id="txtTggno.*" class="txt" style="width:30%;"/>
						<input type="text" id="txtTgg.*" class="txt" style="width:50%;"/>
					</td>
					<td>
						<input id="txtBdate.*"  type="text" style="float:left; width:45%;"/>
						<span style="float:left; width:5px;"> </span><span style="float:left; width:20px; font-weight: bold;font-size: 20px;">～</span><span style="float:left; width:5px;"> </span>
						<input id="txtEdate.*"  type="text" style="float:left; width:45%;"/>
					</td>
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
	</body>
</html>