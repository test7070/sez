<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			isEditTotal = false;
			q_tables = 's';
			var q_name = "trando";
			var q_readonly = ['txtNoa', 'txtWorker'];
			var q_readonlys = ['txtTranno', 'txtTrannoq','txtTrandate','txtCustorde','txtMoney','txtAddr','txtProduct'];
			var bbmNum = [];
			var bbsNum = [['txtMoney', 10, 0]];
			var bbmMask = [];
			var bbsMask = [['txtTrandate','999/99/99']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			q_desc = 1;
			aPop = new Array();
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '')
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
				bbmMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
				$('#btnImport').click(function(e) {
					if (q_cur == 1 || q_cur == 2) {
						if ($.trim($('#txtPo').val()) == 0) {
							alert('Please enter the P/O.');
							return false;
						}
						var t_po = "'" + $.trim($('#txtPo').val()) + "'";
						t_where = " where=^^ (view_trans" + r_accy + ".po=" + t_po + ") ^^";						
						q_gt('view_trans', t_where, 0, 0, 0, "", r_accy);
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
				b_pop = '';
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'view_trans':
						var as = _q_appendData("view_trans", "", true);
						for(var i=0;i<as.length;i++){
							for(var j=0;j<q_bbsCount;j++){
								if(as[i].caseno==$('#txtCaseno_'+j).val()){
									$('#txtTranno_'+j).val(as[i].noa);
									$('#txtTrannoq_'+j).val(as[i].noq);
									$('#txtTrandate_'+j).val(as[i].trandate);
									$('#txtCustorde_'+j).val(as[i].custorde);
									$('#txtMoney_'+j).val(as[i].total);
									$('#txtAddr_'+j).val(as[i].straddr);
									$('#txtProduct_'+j).val(as[i].product);
								}
							}
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function btnOk() {
				$('#txtWorker').val(r_name);
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trando') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;

				q_box('trando_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				_bbsAssign();
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_'+i).text(i+1);
				}
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
			}

			function btnPrint() {
				//q_box('z_trando.aspx' + "?;;;;" +r_accy+";noa="+trim($('#txtNoa').val()), '', "90%", "600px", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['caseno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();

				return true;
			}

			function sum() {
			}

			function refresh(recno) {
				_refresh(recno);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (q_cur != 1 && q_cur != 2){
                    $('#btnImport').attr('disabled', 'disabled');
                }else{
                    $('#btnImport').removeAttr('disabled');
                }
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
				padding: 0px;
				margin: -1px;
			}
			.dbbs {
				width: 2000px;
			}
			.tbbs a {
				font-size: medium;
			}
			.tbbs input[type="text"] {
				font-family: "細明體",Arial, sans-serif;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			select {
				font-size: medium;
			}

		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:15%"><a id='vewDatea'></a></td>
						<td align="center" style="width:20%"><a id='vewPo'></a></td>
						<td align="center" style="width:20%"><a id='vewDelivery'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='po'>~po</td>
						<td align="center" id='deliveryno'>~deliveryno</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr class="tr1">
						<td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td2" colspan="2">
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td class="td4"><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td5">
						<input id="txtDatea" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblDeliveryno" class="lbl"> </a></td>
						<td class="td2" colspan="2">
						<input id="txtDeliveryno" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblBoatname" class="lbl"> </a></td>
						<td class="td2" colspan="2">
						<input id="txtBoatname" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblPo" class="lbl"> </a></td>
						<td class="td2" colspan="2">
						<input id="txtPo" type="text" class="txt c1"/>
						</td>
						<td> </td>
						<td> </td>
						<td> <input id="btnImport" type="button" class="txt c1"/></td>
						
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="td2" colspan="5">
						<input id="txtMemo" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtWorker" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr> </tr>
					<tr> </tr>
					<tr> </tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:150px;"><a id='lblCaseno_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblTranno_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblTrandate_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblCustorde_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width:120px;"><a id='lblAddr_s'> </a></td>
					<td align="center" style="width:120px;"><a id='lblProduct_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td ><input type="text" id="txtCaseno.*" style="width:95%;" /></td>
					<td ><input type="text" id="txtTranno.*" style="width:95%;" /><input type="text" id="txtTrannoq.*" style="display: none;" /></td>
					<td ><input type="text" id="txtTrandate.*" style="width:95%;" /></td>
					<td ><input type="text" id="txtCustorde.*" style="width:95%;" /></td>
					<td ><input type="text" id="txtMoney.*" style="width:95%;text-align: right;"/></td>
					<td ><input type="text" id="txtAddr.*" style="width:95%;" /></td>
					<td ><input type="text" id="txtProduct.*" style="width:95%;" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
