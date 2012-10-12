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

			q_desc = 1;
			q_tables = 's';
			var q_name = "fixout";
			var q_readonly = ['txtNoa', 'txtMoney', 'txtWorker'];
			var q_readonlys = ['txtStkmount'];
			var bbmNum = new Array(['txtMoney', 10, 0, 1]);
			var bbsNum = new Array(['txtPrice', 10, 0, 1], ['txtMount', 10, 0, 1], ['txtMoney', 10, 0, 1], ['txtStkmount', 10, 0, 1]);
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'], ['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx'], ['txtCarplateno', 'lblCarplateno', 'carplate', 'noa,carplate,driver', 'txtCarplateno', 'carplate_b.aspx'], ['txtProductno_', 'btnProductno_', 'fixucc', 'noa,namea,brand,unit', 'txtProductno_,txtProduct_,txtBrand_,txtUnit_', 'fixucc_b.aspx'], ['txtTireno_', 'btnTirestk_', 'tirestk', 'noa,productno,product,brandno,brand,price', 'txtTireno_,txtProductno_,txtProduct_,txtBrandno_,txtBrand_,txtPrice_', 'tirestk_b.aspx']);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1)

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
				bbmMask = [['txtDatea', r_picd], ['txtOutdate', r_picd], ['txtMon', r_picm]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('fixout.typea'));
				q_cmbParse("cmbPosition", q_getPara('tire.position'), 's');
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}/// end Switch
				b_pop = '';
			}

			var init_stkmount = 0;
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'fixouts':
						var as = _q_appendData("fixouts", "", true);
						if (as[0] != undefined) {
							alert('胎號已領用，請重新輸入');
							btnMinus('btnMinus_' + b_seq);
						}
						break;
					case 'fixucc':
						var as = _q_appendData("fixucc", "", true);
						if (as[0] != undefined) {
							if (as[0].stkmount == '')
								q_tr('txtStkmount_' + bbs_id, 0);
							else
								init_stkmount = as[0].stkmount;
							q_tr('txtStkmount_' + bbs_id, as[0].stkmount);
						} else {
							q_tr('txtStkmount_' + bbs_id, 0);
						}

						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}  /// end switch
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				for (var i = 0; i < q_bbsCount; i++) {
					for (var j = 0; j < q_bbsCount; j++) {
						if (i != j && $('#txtTireno_' + i).val() == $('#txtTireno_' + j).val() && $('#txtTireno_' + i).val() != '' && $('#txtTireno_' + j).val()) {
							alert('胎號重複，請修改');
							return;
						}
					}
				}

				$('#txtWorker').val(r_name)
				sum();

				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_fixout') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('fixout_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
			}

			function combPay_chg() {
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtTireno_':
						q_tr('txtMount_' + b_seq, 1);
						q_tr('txtMoney_' + b_seq, q_float('txtPrice_' + b_seq) * 1);

						if (!emp($('#txtTireno_' + b_seq).val())) {
							var t_where = "where=^^ tireno='" + $('#txtTireno_' + b_seq).val() + "' ^^";
							q_gt('fixouts', t_where, 0, 0, 0, "", r_accy);
						}

						break;
				}
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#txtTireno_' + i).change(function(e) {
							t_IdSeq = -1;
							/// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							for (var j = 0; j < q_bbsCount; j++) {
								if ($('#txtTireno_' + b_seq).val() == $('#txtTireno_' + j).val() && !emp($('#txtTireno_' + j).val()) && b_seq != j) {
									alert('胎號重複!!');
									$('#txtTireno_' + b_seq).val('');
								}
							}
							if (!emp($('#txtTireno_' + b_seq).val())) {
								var t_where = "where=^^ tireno='" + $('#txtTireno_' + b_seq).val() + "' ^^";
								q_gt('fixouts', t_where, 0, 0, 0, "", r_accy);
							}
						});

						$('#txtMount_' + i).change(function(e) {
							t_IdSeq = -1;
							/// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_tr('txtStkmount_' + b_seq, init_stkmount - q_float('txtMount_' + b_seq));
							sum();
						});
						$('#txtPrice_' + i).change(function(e) {
							sum();
						});
						$('#txtMoney_' + i).change(function(e) {
							sum();
						});
						//$('#txtMemo_' + i).data('info', { index: i });
						$('#txtMemo_' + i).change(function(e) {
							if ($.trim($(this).val()).substring(0, 1) == '.')
								$('#txtMoney_' + i).removeAttr('readonly');
							else
								$('#txtMoney_' + i).attr('readonly', 'readonly');
							sum();
						});
						$('#txtMemo_' + i).change();
					}
				}
				_bbsAssign();
			}

			function btnIns() {
				_btnIns();

				$('#txtNoa').val('AUTO');
				$('#cmbTypea').val('01');
				$('#txtDatea').val(q_date());
				$('#txtMon').val(q_date().substring(0, 6));
				$('#txtOutdate').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtOutdate').focus();
				sum();
			}

			function btnPrint() {
				q_box('z_fixout.aspx', '', "800px", "600px", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				return true;
			}

			function sum() {
				var t_mount, t_price, t_money = 0, t_tax, t_discount;
				for (var j = 0; j < q_bbsCount; j++) {
					if ($.trim($('#txtMemo_' + j).val()).substring(0, 1) != '.') {
						t_mount = q_float('txtMount_' + j);
						t_price = q_float('txtPrice_' + j);
						$('#txtMoney_' + j).val(Math.round(t_mount * t_price, 0));
						t_money = t_money + Math.round(t_mount * t_price, 0);
					} else {
						t_money = t_money + q_float('txtMoney_' + j);
					}
				}
				t_tax = q_float('txtTax');
				t_discount = q_float('txtDiscount');
				$('#txtMoney').val(t_money);
			}

			function refresh(recno) {
				_refresh(recno);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				for (var i = 0; i < q_bbsCount; i++) {
					if ($.trim($('#txtMemo_' + i).val()).substring(0, 1) == '.')
						$('#txtMoney_' + i).removeAttr('readonly');
					else
						$('#txtMoney_' + i).attr('readonly', 'readonly');
				}
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
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

			var bbs_id = '';
			function show_stkmount(id) {
				bbs_id = id.substring(9);
				if ((q_cur == 1 || q_cur == 2) && $('#txtProductno_' + bbs_id).val() != '') {
					var t_where = "where=^^ noa='" + $('#txtProductno_' + bbs_id).val() + "' ^^";
					q_gt('fixucc', t_where, 0, 0, 0, "", r_accy);
				}
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 40%;
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
				width: 55%;
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
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 100%;
				float: left;
			}
			.txt.c2 {
				width: 40%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
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
				font-size: medium;
				padding: 0px;
				margin: -1px;
			}
			.tbbs input[type="text"] {
				width: 95%;
			}
			.tbbs a {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			.bbs {
				float: left;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.tbbs .td1 {
				width: 9%;
			}
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:20%"><a id='vewOutdate'> </a></td>
						<td align="center" style="width:20%"><a id='vewCarno'> </a></td>
						<td align="center" style="width:20%"><a id='vewDriver'> </a></td>
						<td align="center" style="width:20%"><a id='vewCarplate'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='outdate'>~outdate</td>
						<td align="center" id='carno'>~carno</td>
						<td align="center" id='driver'>~driver</td>
						<td align="center" id='carplateno'>~carplateno</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="trZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOutdate" class="lbl"> </a></td>
						<td>
						<input id="txtOutdate"type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDatea" class="lbl" > </a></td>
						<td>
						<input id="txtDatea"type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblMon" class="lbl" > </a></td>
						<td>
						<input id="txtMon"type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td class='td1'><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td2" colspan="2">
						<input id="txtNoa"  type="text" class="txt c1"/>
						</td>

						<td class='td5'><span> </span><a id="lblTypea" class="lbl"> </a></td>
						<td class="td6"><select id="cmbTypea" class="txt c1"></select></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblCarno" class="lbl btn"> </a></td>
						<td class="td2">
						<input id="txtCarno" type="text" class="txt c1"/>
						</td>
						<td class="td1"><span> </span><a id="lblDriver" class="lbl btn"> </a></td>
						<td class="td2" colspan="2">
						<input id="txtDriverno" type="text" class="txt c2"/>
						<input id="txtDriver" type="text" class="txt c3"/>
						</td>

					</tr>
					<tr class="tr3">

						<td class="td3"><span> </span><a id="lblCarplate" class="lbl btn"> </a></td>
						<td class="td4">
						<input id="txtCarplateno" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtMoney" type="text" class="txt num c1" />
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="td2" colspan="5">
						<input id="txtMemo" type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtWorker" type="text" class="txt c1" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'>
				<tr style='color:White; background:#003366;' >
					<td align="center">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" class="td1"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width: 20%;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width: 12%;"><a id='lblBrand_s'> </a></td>
					<td align="center" style="width: 3%;"><a id='lblUnit_s'> </a></td>
					<td align="center" class="td1" style="width: 5%;"><a id='lblMount_s'> </a></td>
					<td align="center" class="td1"><a id='lblPrice_s'> </a></td>
					<td align="center" class="td1"><a id='lblMoney_s'> </a></td>
					<td align="center" class="td1"><a id='lblTireno_s'> </a></td>
					<td align="center" ><a id='lblMemo_s'> </a></td>
					<td align="center" class="td1"><a id='lblPosition_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:1%;">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" style="display: none;" />
					</td>
					<td >
					<input id="txtProductno.*" type="text" style="width: 75%;" />
					<input id="btnProductno.*" type="button" value=".." style="width: 15%;font-size: medium;"/>
					</td>
					<td >
					<input class="txt c1" id="txtProduct.*" type="text" />
					</td>
					<td >
					<input  id="txtBrandno.*" type="text" style="width: 25%;"/>
					<input  id="txtBrand.*" type="text" style="width: 65%;"/>
					</td>
					<td >
					<input class="txt c1" id="txtUnit.*" type="text" />
					</td>
					<td >
					<input class="txt num c1" id="txtMount.*" type="text" onfocus='show_stkmount(id);'/>
					</td>
					<td >
					<input class="txt num c1" id="txtPrice.*" type="text" />
					</td>
					<td >
					<input class="txt num c1" id="txtMoney.*" type="text" />
					<input class="txt num c1" id="txtStkmount.*" type="text" />
					</td>
					<td >
					<input class="txt" id="txtTireno.*" type="text" style="width:80%" />
					<input id="btnTirestk.*" type="button" value=".." style="width: 15%;font-size: medium;"/>
					</td>
					<td >
					<input class="txt c1" id="txtMemo.*" type="text" />
					</td>
					<td ><select id="cmbPosition.*" class="txt c1"></select></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
