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

			var q_name = "ucc";
			var q_readonly = ['txtWorker'];
			var bbmNum = [];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 20;
			q_xchg = 1;
			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
				$('#txtNoa').focus();
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				q_mask(bbmMask);
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_af_s':
						q_boxClose2(s2);
						break;
				}
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}  /// end switch
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box(q_name + '_af_s.aspx', q_name + '_af_s', "500px", "300px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				refreshBbm();
				$('#txtNoa').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				refreshBbm();
				$('#txtNoa').attr('readonly', 'readonly');
			}

			function btnPrint() {
				q_box('z_ucc_af.aspx', '', "95%", "95%", q_getMsg("popPrint"));
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();
			}

			function btnOk() {
				Lock();
				$('#txtNoa').val($.trim($('#txtNoa').val()));
				$('#txtWorker').val(r_name);

				if (q_cur == 1) {
					wrServer($('#txtNoa').val());
				} else {
					wrServer($('#txtNoa').val());
				}
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
				refreshBbm();
			}

			function refreshBbm() {
				if (q_cur == 1) {
					$('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
				} else {
					$('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
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
				width: 100%;
				border-width: 0px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
			}
			.tview tr {
				height: 30px;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border-width: 0px;
				background-color: #FFFF66;
				color: blue;
			}
			.dbbm {
				float: left;
				width: 550px;
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
			.tbbs input[type="text"] {
				width: 98%;
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
			select {
				font-size: medium;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewBarcode'> </a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:400px; color:black;"><a id='vewProduct_af'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewHeight'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewWidth'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewLengthb'> </a></td>
						<td align="center" style="width:150px; color:black;"><a id='vewSize'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewUnit'> </a></td>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='barcode' style="text-align: left;">~barcode</td>
						<td id='noa' style="text-align: left;">~noa</td>
						<td id='product' style="text-align:left;">~product</td>
						<td id='height' style="text-align:right;">~height</td>
						<td id='width' style="text-align:right;">~width</td>
						<td id='lengthb' style="text-align:right;">~lengthb</td>
						<td id='size' style="text-align:left;">~size</td>
						<td id='unit' style="text-align:center;">~unit</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBarcode' class="lbl"> </a></td>
						<td><input id="txtBarcode"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblProduct' class="lbl"> </a></td>
						<td colspan="3"><input id="txtProduct" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblHeight' class="lbl"> </a></td>
						<td><input id="txtHeight" type="text"  class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWidth' class="lbl"> </a></td>
						<td><input id="txtWidth" type="text"  class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblLengthb' class="lbl"> </a></td>
						<td><input id="txtLengthb" type="text"  class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSize' class="lbl"> </a></td>
						<td colspan="3"><input id="txtSize" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblUnit' class="lbl"> </a></td>
						<td><input id="txtUnit" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3">
						<input id="txtMemo"  type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td>
						<input id="txtWorker" type="text" class="txt c1" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
