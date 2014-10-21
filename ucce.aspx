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

			q_tables = 's';
			var q_name = "ucce";
			var q_readonly = ['txtNoa','txtStore'];
			var q_readonlys = ['txtStore'];
			var bbmNum = [];
			var bbsNum = [['txtMount', 10, 2, 1], ['txtPrice', 10, 2, 1], ['txtTotal', 10, 0, 1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(
				['txtStoreno', 'lblStoreno', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
				['txtStoreno2', 'lblStore2', 'store', 'noa,store', 'txtStoreno2,txtStore2', 'store_b.aspx'],
				['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucaucc_b.aspx'],
				['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				brwCount2 = 5;
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);

			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbKind", q_getPara('ucce.kind'));
				$('#cmbKind').change(function() {
					for (var j = 0; j < q_bbsCount; j++) {
						btnMinus('btnMinus_' + j);
					}
					product_change();
				});
			}

			function q_boxClose(s2) {
				var
				ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				var t_storeno = $.trim($('#txtStoreno').val());
				var t_store = $.trim($('#txtStore').val());
				for(var k=0;k<q_bbsCount;k++){
					var bbsStoreno = $.trim($('#txtStoreno_'+k).val());
					if(bbsStoreno.length == 0){
						$('#txtStoreno_'+k).val(t_storeno);
						$('#txtStore_'+k).val(t_store);
					}
				}
				$('#txtWorker').val(r_name);
				//sum();

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ucce') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;

				q_box('ucce_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
			}

			function combPay_chg() {
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtMount_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_tr('txtTotal_' + b_seq, round(q_mul(q_float('txtPrice_' + b_seq), q_float('txtMount_' + b_seq)), 0));
						});
						$('#txtPrice_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_tr('txtTotal_' + b_seq, round(q_mul(q_float('txtPrice_' + b_seq), q_float('txtMount_' + b_seq)), 0));
						});
					}
				}
				_bbsAssign();
				product_change();
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
				if (q_getPara('sys.comp').indexOf('永勝') > -1|| q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1 || q_getPara('sys.comp').indexOf('德芳') > -1) {
					$('#cmbKind').val(1);
				}
				product_change();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtProduct').focus();
				product_change();
			}

			function btnPrint() {
				q_box('z_uccep.aspx?;;;', '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] ) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['datea'] = abbm2['datea'];
				return true;
			}

			function sum() {
				var t1 = 0, t_unit, t_mount, t_weight = 0;
				for (var j = 0; j < q_bbsCount; j++) {
					q_tr('txtTotal_' + j, q_float('txtPrice_' + j) * q_float('txtMount_' + j));
				}

			}

			function refresh(recno) {
				_refresh(recno);
				product_change();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (q_getPara('sys.comp').indexOf('永勝') > -1|| q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1 || q_getPara('sys.comp').indexOf('德芳') > -1) {
					$('#cmbKind').attr('disabled', 'disabled');
				}
			}

			function btnMinus(id) {
				_btnMinus(id);
				//sum();
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

			function product_change() {
				if ($('#cmbKind').val() == '1') {
					aPop = new Array(
						['txtStoreno', 'lblStoreno', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
						['txtStoreno2', 'lblStore2', 'store', 'noa,store', 'txtStoreno2,txtStore2', 'store_b.aspx'],
						['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucaucc_b.aspx'],
						['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx']
					);
				} else if ($('#cmbKind').val() == '2') {
					aPop = new Array(
						['txtStoreno', 'lblStoreno', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
						['txtStoreno2', 'lblStore2', 'store', 'noa,store', 'txtStoreno2,txtStore2', 'store_b.aspx'],
						['txtProductno_', 'btnProduct_', 'bcc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'bcc_b.aspx'],
						['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx']
					);
				} else {
					aPop = new Array(
						['txtStoreno', 'lblStoreno', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
						['txtStoreno2', 'lblStore2', 'store', 'noa,store', 'txtStoreno2,txtStore2', 'store_b.aspx'],
						['txtProductno_', 'btnProduct_', 'fixucc', 'noa,namea,unit', 'txtProductno_,txtProduct_,txtUnit_', 'fixucc_b.aspx'],
						['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx']
					);
				}
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
			.tbbm .tdZ {
				width: 2%;
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
				width: 98%;
				float: left;
			}
			.txt.c3 {
				width: 80%;
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
			.tbbm textarea {
				font-size: medium;
			}

			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1px;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.dbbs .tbbs tr {
				height: 35px;
			}
			.dbbs .tbbs tr td {
				text-align: center;
				border: 2px lightgrey double;
			}
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="width: 1260px;">
			<div class="dview" id="dview" style="float: left; width:32%;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>

					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='datea'>~datea</td>

					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 68%;float:left">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='0'>
					<tr class="tr1">
						<td class='td1'><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class='td2'><input id="txtNoa" type="text" class="txt c1"/></td>
						<td class='td3'><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class='td4'><input id="txtDatea" type="text" class="txt c1"/></td>
						<td class='td5'><span> </span><a id="lblKind" class="lbl"> </a></td>
						<td class='td6'><select id="cmbKind" class="txt c1"></select></td>
					</tr>
					<tr>
						<td class='td1'><span> </span><a id="lblStoreno" class="lbl btn"> </a></td>
						<td class='td2' colspan="2">
							<input id="txtStoreno" type="text" class="txt" style="width:30%"/>
							<input id="txtStore" type="text" class="txt" style="width:65%"/>
						</td>
					</tr>
				</table>
			</div>
			<div class='dbbs' style="width: 1260px;">
				<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1' >
					<tr style='color:White; background:#003366;' >
						<td align="center" style="width:1%;">
							<input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;" />
						</td>
						<td align="center" style="width:15%;"><a id='lblStoreno_s'> </a></td>
						<td align="center" style="width:20%;"><a id='lblProductno_s'> </a></td>
						<td align="center" style="width:5%;"><a id='lblUnit_s'> </a></td>
						<td align="center" style="width:9%;"><a id='lblMount_s'> </a></td>
						<td align="center" style="width:9%;"><a id='lblEmount2_s'> </a></td>
						<td align="center" style="width:9%;"><a id='lblPrice_s'> </a></td>
						<td align="center" style="width:9%;"><a id='lblTotal_s'> </a></td>
						<td align="center"><a id='lblMemo_s'> </a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td>
							<input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						</td>
						<td>
							<input class="txt c3" id="txtStoreno.*" type="text" style="width:85%;"/>
							<input class="btn" id="btnStoreno.*" type="button" value='.' style="width:1%;" />
							<BR>
							<input class="txt c1" id="txtStore.*" type="text" />
						</td>
						<td>
							<input id="btnProduct.*" type="button" value='.' style="float:left;width:1%;" />
							<input id="txtProductno.*" type="text" style="float:left;width:80%;"/>
							<BR>
							<input class="txt c1" id="txtProduct.*" type="text" />
						</td>
						<td><input class="txt c1" id="txtUnit.*" type="text"/></td>
						<td><input class="txt num c1" id="txtMount.*" type="text"/></td>
						<td><input class="txt num c1" id="txtEmount2.*" type="text"/></td>
						<td><input class="txt num c1" id="txtPrice.*" type="text" /></td>
						<td><input class="txt num c1" id="txtTotal.*" type="text" /></td>
						<td>
							<input class="txt c1" id="txtMemo.*"type="text" />
							<input id="txtNoq.*" type="hidden" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
