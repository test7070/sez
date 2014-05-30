<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			var q_name = "uccc";
			var q_readonly = [];
			var bbmNum = [];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'uno';
			aPop = new Array(
				['txtProductno', 'lblProductno', 'ucc', 'noa,product,unit', 'txtProductno,txtProduct,txtUnit', 'ucc_b.aspx'],
				['txtStoreno', 'lblStoreno', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
				['txtUseno', 'lblUseno', 'cust', 'noa,comp', 'txtUseno,txtUsea', 'cust_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = ['uno'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1)
				$('#txtUno').focus();
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}
			
			function mainPost() {
				q_getFormat();
				q_cmbParse("cmbItype", q_getPara('uccc.itype'));
				bbmMask = [['txtSdate', r_picd]];
				q_mask(bbmMask);
			}

			function txtCopy(dest, source) {
				var adest = dest.split(',');
				var asource = source.split(',');
				$('#' + adest[0]).focus(function() {
					if (trim($(this).val()).length == 0)
						$(this).val(q_getMsg('msgCopy'));
				});
				$('#' + adest[0]).focusout(function() {
					var t_copy = ($(this).val().substr(0, 1) == '=');
					var t_clear = ($(this).val().substr(0, 2) == ' =');
					for (var i = 0; i < adest.length; i++) { {
							if (t_copy)
								$('#' + adest[i]).val($('#' + asource[i]).val());

							if (t_clear)
								$('#' + adest[i]).val('');
						}
					}
				});
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('uccc_s.aspx', q_name + '_s', "500px", "550px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtUno').focus();
				$('#txtUno').val('AUTO');
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
			}

			function btnModi() {
				if (emp($('#txtUno').val()))
					return;

				_btnModi();
			}

			function btnPrint() {
				q_box('z_stk.aspx', '', "800px", "600px", q_getMsg("popPrint"));
			}

			function btnOk() {
				var t_err = '';
				t_err = q_chkEmpField(['txtUno', q_getMsg('lblUno')]);
				$('#txtNoa').val()
				var t_uno = trim($('#txtUno').val());
				$('#txtNoa').val(t_uno);
				var t_date = trim($('#txtDatea').val());
				if (t_uno.length == 0 || t_uno == "AUTO")
					q_gtnoa(q_name, replaceAll((t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_uno);
			}

			function wrServer(key_value) {
				var i;

				xmlSql = '';
				if (q_cur == 2)
					xmlSql = q_preXml();

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);

			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}

			function btnSeek() {
				_btnSeek();
			}

			function btnTop() {
				_btnTop();
			}

			function btnPrev() {
				_btnPrev();
			}

			function btnPrevPage() {
				_btnPrevPage();
			}

			function btnNext() {
				_btnNext();
			}

			function btnNextPage() {
				_btnNextPage();
			}

			function btnBott() {
				_btnBott();
			}

			function q_brwAssign(s1) {
				_q_brwAssign(s1);
			}

			function btnDele() {
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 98%;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 98%;
				margin: -1px;
				border: 1px black solid;
				border-radius: 5px;
			}
			.tbbm {
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.tbbm tr {
				height: 35px;
			}
			.tbbm tr td {
				width: 9%;
			}
			.tbbm tr td span {
				float: right;
				display: block;
				width: 5px;
				height: 10px;
			}
			.tbbm tr td .lbl {
				float: right;
				color: blue;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 95%;
				float: left;
			}
			.txt.num {
				text-align: right;
			}
			.tbbm td {
				margin: 0 -1px;
				padding: 0;
			}
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				float: left;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left; width:30%;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewUno'> </a></td>
						<td align="center" style="width:25%"><a id='vewProduct'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='uno'>~uno</td>
						<td align="center" id='product,4'>~product,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 65%;float: left;">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='5'>
					<tr class="tr1">
						<td class='td1'><span> </span><a id="lblUno" class="lbl"> </a></td>
						<td class="td2" colspan="3">
							<input id="txtUno" type="text" class="txt c7"/>
							<input id="txtNoa" type="text" style="display:none;"/>
						</td>
						<td class='td5'><span> </span><a id="lblItypea" class="lbl"> </a></td>
						<td class="td6"><select id="cmbItype" class="txt c1"></select></td>
						<td class='td7'><span> </span><a id="lblPrice" class="lbl"> </a></td>
						<td class="td8"><input id="txtPrice" type="text" class="txt num c1"/></td>
						<td class='td9'><span> </span><a id="lblSprice" class="lbl"> </a></td>
						<td class="tdA"><input id="txtSprice" type="text" class="txt num c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>