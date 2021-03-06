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

			var q_name = "add4";
			var q_readonly = ['txtNoa','txtAvgoil'];
			var bbmNum = [];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 20;
			q_desc = 1;
			$(document).ready(function() {
				bbmKey = ['noa'];
				brwCount2 = 20;
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function sum(){
				var t_count = 0;
				var t_sum = 0;
				for(var k=1;k<6;k++){
					var oilPrice = dec($('#txtOil'+k).val());
					if(oilPrice>0){
						t_sum = q_add(t_sum,oilPrice);
						t_count++;
					}
				}
				$('#txtAvgoil').val(round(q_div(t_sum,t_count),3));
			}
			
			function mainPost() {
				bbmMask = [['txtMon', r_picm]];
				q_mask(bbmMask);
				bbmNum = [
					['txtOil1', 10, q_getPara('vcc.pricePrecision'), 1],['txtOil2', 10, q_getPara('vcc.pricePrecision'), 1],['txtOil3', 10, q_getPara('vcc.pricePrecision'), 1],
					['txtOil4', 10, q_getPara('vcc.pricePrecision'), 1],['txtOil5', 10, q_getPara('vcc.pricePrecision'), 1],['txtAvgoil', 10, q_getPara('vcc.pricePrecision'), 1],
				]
				
				$('input[id*="txtOil"]').change(function(){
					sum();
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
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('add4_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtMon').val(q_date().substring(0,6)).focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtMon').focus();
			}

			function btnPrint() {

			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();

			}

			function btnOk() {
				Lock();
				var t_date = $('#txtMon').val();
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO"){
					q_gtnoa(q_name, replaceAll((t_date.length == 0 ? q_date() : t_date), '/', ''));
				}
				else
					wrServer(s1);
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
				width: 750px;
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
				width: 450px;
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
				width: 10%;
			}
			.tbbm .tdZ {
				width: 1%;
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
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMon'> </a></td>
						<td align="center" style="width:140px; color:black;"><a id='vewOil1'> </a></td>
						<td align="center" style="width:140px; color:black;"><a id='vewOil2'> </a></td>
						<td align="center" style="width:140px; color:black;"><a id='vewOil3'> </a></td>
						<td align="center" style="width:140px; color:black;"><a id='vewOil4'> </a></td>
						<td align="center" style="width:140px; color:black;"><a id='vewOil5'> </a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewAvgoil'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='mon' style="text-align: center;">~mon</td>
						<td id='oil1' style="text-align: right;">~oil1</td>
						<td id='oil2' style="text-align: right;">~oil2</td>
						<td id='oil3' style="text-align: right;">~oil3</td>
						<td id='oil4' style="text-align: right;">~oil4</td>
						<td id='oil5' style="text-align: right;">~oil5</td>
						<td id='avgoil' style="text-align: right;">~avgoil</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOil1' class="lbl"> </a></td>
						<td><input id="txtOil1" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOil2' class="lbl"> </a></td>
						<td><input id="txtOil2" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOil3' class="lbl"> </a></td>
						<td><input id="txtOil3" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOil4' class="lbl"> </a></td>
						<td><input id="txtOil4" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOil5' class="lbl"> </a></td>
						<td><input id="txtOil5" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAvgoil' class="lbl"> </a></td>
						<td><input id="txtAvgoil" type="text" class="txt num c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>