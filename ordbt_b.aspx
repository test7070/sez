<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'ordbt', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = ['noa'], t_count = 0, as, brwCount = -1;
			brwCount2 = 0;
			var t_sqlname = 'ordbt';
			t_postname = q_name;
			var isBott = false;
			var afield, t_htm;
			var i, s1;
			var q_readonly = [];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [['txtPrice', 10, 2, 1],['txtRprice', 10, 2, 1],['txtIprice', 10, 2, 1],['txtFprice', 10, 2, 1]];
			var bbmMask = [];
			var bbsMask = [];
			aPop = new Array(
				['txtTggno_', '', 'tgg', 'noa,nick', 'txtTggno_,txtTgg_', 'tgg_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = [];
				bbsKey = ['noa', 'no4'];
				if (!q_paraChk())
					return;
				main();
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
			}

			function mainPost() {
				bbmMask = [];
				bbsMask = [['txtEdate',r_picd],['txtRdate',r_picd],['txtFdate',r_picd]];
				q_mask(bbmMask);
				parent.$.fn.colorbox.resize({
					height : "750px"
				});
			}

			function bbsAssign() {
				_bbsAssign();
			}

			function btnOk() {
                t_key = q_getHref();
				var no3='';
				for(var j=0;j<t_key.length;j++){
					if(t_key[j]=='no3'){
						no3 = t_key[(j+1)];
					}
				}
				for(var k=0;k<q_bbsCount;k++){
					$('#txtNo3_'+k).val(no3);
				}
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['tggno']) {
					as[bbsKey[0]] = '';
					return;
				}
				q_getId2('', as);
				return true;
			}

			function btnModi() {
				var t_key = q_getHref();
				if (!t_key)
					return;
				_btnModi(1);
			}

			function refresh() {
				_refresh();
			}

			function q_gtPost(t_postname) {
				switch (t_postname) {
					case q_name:
						break;
				}
			}

			function q_popPost(s1) {
				switch (s1) {
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
			}
		</script>
		<style type="text/css">
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.txt {
				float: left;
			}
			.c1 {
				width: 90%;
			}
			.num {
				text-align: right;
			}
			#dbbs {
				width: 1140px;
			}
			.btn {
				font-weight: bold;
			}
			#lblNo {
				font-size: medium;
			}
		</style>
    </head>
    <body>
		<div id="dbbs">
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;font-size: medium;'>
				<tr style='color:White; background:#003366;' >
                    <td align="center" style="width:40px;">
						<input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"/>
					</td>
                    <td align="center" style='display:none;' ><a id='lblNoa'> </a></td>
					<td style="width:200px; text-align: center;">廠商</td>
					<td style="width:100px; text-align: center;">有效日期</td>
					<td style="width:200px; text-align: center;">包裝方式</td>
					<td style="width:100px; text-align: center;">期望單價</td>
					<td style="width:100px; text-align: center;">廠商回報價</td>
					<td style="width:100px; text-align: center;">回報日期</td>
					<td style="width:100px; text-align: center;">議價單價</td>
					<td style="width:100px; text-align: center;">成交日期</td>
					<td style="width:100px; text-align: center;">成交價</td>
                </tr>
				<tr style="background:#cad3ff;font-size: 14px;">
                    <td align="center" style="width:2%;">
						<input class="btn"  id="btnMinus.*" type="button" value="－" style="font-weight: bold;"/>
                    </td>
                    <td style="width:20%;display:none;">
						<input class="txt" id="txtNoa.*" type="text" style="width:98%;" />
						<input class="txt" id="txtNo3.*" type="text" style="width:98%;" />
						<input class="txt" id="txtNo4.*" type="text" style="width:98%;" />
                    </td>
					<td>
						<input id="txtTggno.*" type="text" style="width:45%;float:left;"/>
						<input id="txtTgg.*" type="text" style="width:45%;float:left;"/>
					</td>
					<td><input id="txtEdate.*" type="text" class="txt c1"/></td>
					<td><input id="txtPack.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtRprice.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtRdate.*" type="text" class="txt c1"/></td>
					<td><input id="txtIprice.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtFdate.*" type="text" class="txt c1"/></td>
					<td><input id="txtFprice.*" type="text" class="txt c1 num"/></td>
				</tr>
            </table>
            <!--#include file="../inc/pop_modi.inc"-->
        </div>
    </body>
</html>