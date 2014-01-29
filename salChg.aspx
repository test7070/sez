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

			var q_name = "salchg";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtAccno'];
			var bbmNum = [['txtBorrow', 15, 0, 1], ['txtMinus', 15, 0, 1], ['txtPlus', 15, 0, 1], ['txtDay_meal', 5, 0, 1]];
			var bbmMask = [];
			q_desc = 1;
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			//ajaxPath = ""; //  execute in Root
			aPop = new Array(['txtSssno', 'lblSss', 'sssall', 'noa,namea', 'txtSssno,txtNamea', 'sssall_b.aspx']);
			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				$('#txtNoa').focus();
				q_gt('authority', "where=^^a.noa='" + q_name + "' and a.sssno='" + r_userno + "'^^", q_sqlCount, 1);
			});

			//////////////////   end Ready
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
				// 1=Last  0=Top
			}///  end Main()

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
				q_mask(bbmMask);
				q_gt('salchgitem', '', 0, 0, 0, "");
				q_gt('part', '', 0, 0, 0, "");
				$('#lblAccno').click(function() {
					q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
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
					case 'authority':
						var as = _q_appendData('authority', '', true);
						if (q_getPara('sys.comp').indexOf('大昌') > -1) {
							if (as.length > 0 && as[0]["pr_dele"] == "true")
								q_content = "";
							else
								q_content = "where=^^sssno='" + r_userno + "'^^";
						} else {
							if (r_rank >= 9)
								q_content = "";
							else
								q_content = "where=^^sssno='" + r_userno + "'^^";
						}
						q_gt(q_name, q_content, q_sqlCount, 1);
						break;
					case 'salchgitem':
						var as = _q_appendData("salchgitem", "", true);
						var t_item = " @ ";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].item;
						}
						q_cmbParse("cmbPlusitem", t_item);
						if (abbm[q_recno] != undefined)
							$("#cmbPlusitem").val(abbm[q_recno].plusitem);
						q_cmbParse("cmbMinusitem", t_item);
						if (abbm[q_recno] != undefined)
							$("#cmbMinusitem").val(abbm[q_recno].minusitem);
						break;
					case 'part':
						var as = _q_appendData("part", "", true);
						var t_item = " @ ";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
						}
						q_cmbParse("cmbPartno", t_item);
						if (abbm[q_recno] != undefined)
							$("#cmbPartno").val(abbm[q_recno].partno);
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('salchg_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtMon').val(q_date().substr(0, 6));
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				if (q_chkClose())
					return;
				_btnModi();
				$('#txtDatea').focus();
			}

			function btnPrint() {

			}

			function btnOk() {
				$('#txtMon').val($.trim($('#txtMon').val()));
				if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())) {
					alert(q_getMsg('lblMon') + '錯誤。');
					return;
				}
				$('#txtWorker').val(r_name);
				var t_err = '';

				t_err = q_chkEmpField([['txtMon', q_getMsg('lblMon')], ['txtSssno', q_getMsg('lblSss')]]);

				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				var t_noa = trim($('#txtNoa').val());

				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll($('#txtMon').val(), '/', ''));
				else
					wrServer(t_noa);
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
				if (r_rank <= 7)
					q_gt('holiday', "where=^^ noa>='" + $('#txtDatea').val() + "'^^", 0, 0, 0, "", r_accy);
				else
					checkenda = false;
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
				if (q_chkClose())
					return;
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
				width: 28%;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
				width: 100%;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 70%;
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
				width: 99%;
				float: left;
			}
			.txt.c2 {
				width: 36%;
				float: right;
			}
			.txt.c3 {
				width: 63%;
				float: left;
			}
			.txt.c4 {
				width: 18%;
				float: left;
			}
			.txt.c5 {
				width: 80%;
				float: left;
			}
			.txt.c6 {
				width: 25%;
			}
			.txt.c7 {
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
			.tbbm td input[type="button"] {
				float: left;
				width: auto;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left;  width:25%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:25%"><a id='vewMon'></a></td>
						<td align="center" style="width:40%"><a id='vewNamea'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='mon'>~mon</td>
						<td align="center" id='namea'>~namea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 73%;float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr>
						<td class="td1"><span> </span><a id='lblNoa' class="lbl"></a></td>
						<td class="td2"><input id="txtNoa"  type="text" class="txt c1" /></td>
						<td class="td3"></td>
						<td class="td4"></td>
						<td class="td5"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblDatea' class="lbl"></a></td>
						<td class="td2"><input id="txtDatea"  type="text" class="txt c1" /></td>
						<td class="td3"></td>
						<td class="td4"></td>
						<td class="td5"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblPartno" class="lbl"> </a></td>
						<td class="td2" ><select id="cmbPartno" class="txt c1"></select></td>
						<td class="td3"></td>
						<td class="td4"></td>
						<td class="td5"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblSss" class="lbl btn" ></a></td>
						<td class="td2">
							<input id="txtSssno"  type="text"  class="txt c2"/>
							<input id="txtNamea" type="text"  class="txt c3"/>
						</td>
						<td class="td3"></td>
						<td class="td4"></td>
						<td class="td5"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblDay_meal' class="lbl"></a></td>
						<td class="td2"><input id="txtDay_meal"  type="text" class="txt num c1" /></td>
						<td class="td3"></td>
						<td class="td4"></td>
						<td class="td5"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMon' class="lbl"></a></td>
						<td class="td2"><input id="txtMon"  type="text" class="txt c1" /></td>
						<td class="td3"></td>
						<td class="td4"></td>
						<td class="td5"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblBorrow' class="lbl"></a></td>
						<td class="td2"><input id="txtBorrow"  type="text" class="txt num c1" /></td>
						<td class="td3"><span> </span><a id='lblAccno' class="lbl btn"></a></td>
						<td class="td4"><input id="txtAccno"  type="text" class="txt c1"/></td>
						<td class="td5"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblMinusitem" class="lbl"> </a></td>
						<td class="td2" >
							<select id="cmbMinusitem" class="txt c1"></select>
							<!--<input id="txtMinusitem"  type="text"  class="txt c1"/>-->
						</td>
						<td class="td3"><span> </span><a id="lblMinus" class="lbl"> </a></td>
						<td class="td4"><input id="txtMinus"  type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblPlusitem" class="lbl"> </a></td>
						<td class="td2">
							<select id="cmbPlusitem" class="txt c1"></select>
							<!--<input id="txtPlusitem"  type="text"  class="txt c1"/>-->
						</td>
						<td class="td3"><span> </span><a id="lblPlus" class="lbl"> </a></td>
						<td class="td4"><input id="txtPlus"  type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="td2" colspan='4'><input id="txtMemo"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2"><input id="txtWorker"  type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>