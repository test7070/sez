<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
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

			q_tables = 's';
			var q_name = "station";
			var q_readonly = ['txtGen'];
			var q_readonlys = [];
			var bbmNum = [['txtMount',10,0,1],['txtHours',10,2,1],['txtWages',10,2,1],['txtGen',10,2,1]
			,['txtMaxgen',10,2,1],['txtMovmount',10,2,1],['txtMovtime',10,2,1],['txtMovmin',10,2,1],['txtMechcost',10,2,1]];
			var bbsNum = [['txtGen',10,2,1],['txtLoadrate',10,2,1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 15;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
			});
			aPop = new Array(
				['txtFactoryno', 'lblFactory', 'factory', 'noa,factory', 'txtFactoryno,txtFactory', 'factory_b.aspx'],
				['txtMechno_', 'btnMechno_', 'mech', 'noa,mech,gen', 'txtMechno_,txtMech_,txtGen_', 'mech_b.aspx'],
				['txtStoreno', 'lblStoreno', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
				['txtStoreinno', 'lblStoreinno', 'store', 'noa,store', 'txtStoreinno,txtStorein', 'store_b.aspx'],
				['txtStationgno', 'lblStationgno', 'stationg', 'noa,namea', 'txtStationgno,txtStationg', 'stationg_b.aspx'],
				['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx']
			);
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}
			
			function mainPost() {
				q_getFormat();
				
				q_cmbParse("cmbGensel", '1@'+q_getMsg('lblMachinehour')+','+'2@'+q_getMsg('lblManhour'));
				ChangeMUnit();
				
				$('#txtNoa').change(function(e) {
					$(this).val($.trim($(this).val()).toUpperCase());
					if ($(this).val().length > 0) {
						if ((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())) {
							t_where = "where=^^ noa='" + $(this).val() + "'^^";
							q_gt('station', t_where, 0, 0, 0, "checkStationno_change", r_accy);
						} else {
							Lock();
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。' + String.fromCharCode(13) + 'EX: A01、A01-001');
							Unlock();
						}
					}
				});
				$('#txtHours').change(function(){
					sum();
				});
				$('#txtMount').change(function(){
					sum();
				});
				
				$('#cmbGensel').change(function(){
					ChangeMUnit();
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
					case 'checkStationno_change':
						var as = _q_appendData("station", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].station);
						}
						break;
					case 'checkStationno_btnOk':
						var as = _q_appendData("station", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].station);
							Unlock();
							return;
						} else {
							wrServer($('#txtNoa').val());
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();

			}

			function btnOk() {
				Lock();
				$('#txtNoa').val($.trim($('#txtNoa').val()));
				sum();
				if (q_cur == 1) {
					t_where = "where=^^ noa='" + $('#txtNoa').val() + "'^^";
					q_gt('station', t_where, 0, 0, 0, "checkStationno_btnOk", r_accy);
				} else {
					wrServer($('#txtNoa').val());
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('station_s.aspx', q_name + '_s', "500px", "350px", q_getMsg("popSeek"));
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
				$('#txtStation').focus();
				ChangeMUnit();
			}

			function btnPrint() {
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
					}
				}
				_bbsAssign();
				ChangeMUnit();
			}

			function bbsSave(as) {
				t_err = '';
				if (!as['mechno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
				var t_hours = 0,t_mount=0;
				var t_gen = 0;
				t_hours = dec($('#txtHours').val());
				t_mount = dec($('#txtMount').val());
				if(t_hours==0){
					$('#txtHours').val('8');
				}
				if(t_mount==0){
					$('#txtMount').val('1');
				}
				t_gen = q_mul(t_hours,t_mount);
				$('#txtGen').val(t_gen);
			}

			function refresh(recno) {
				_refresh(recno);
				refreshBbm();
				ChangeMUnit();
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
			
			function ChangeMUnit() {
				if($('#cmbGensel').val()=='1'){
					$('#lblManunit').text(q_getMsg('lblMachinehour'));
					$('#lblMachunit').text(q_getMsg('lblMachinehour'));
				}else{
					$('#lblManunit').text(q_getMsg('lblManhour'));
					$('#lblMachunit').text(q_getMsg('lblManhour'));
				}
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 400px;
				border-width: 0px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
				width: 100%;
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
				width: 650px;
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
				width: 25%;
			}
			.tbbm .tdZ {
				width: 1%;
			}
			td .schema {
				display: block;
				width: 95%;
				height: 0px;
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
				width: 95%;
				float: left;
			}
			.txt.c2 {
				width: 30%;
				float: left;
			}
			.txt.c3 {
				width: 69%;
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
				width: 100%;
			}
			.dbbs {
				width: 950px;
			}
			.tbbs a {
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
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:1%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:74%"><a id='vewStation'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='station'>~station</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td2"><input id="txtNoa" type="text" class="txt c1" /></td>
						<td class="td3"> </td>
						<td class="td4"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblStation' class="lbl"> </a></td>
						<td class="td2"><input id="txtStation" type="text" class="txt c1"/></td>
						<td class="td3"> </td>
						<td class="td4"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblStationgno' class="lbl btn"> </a></td>
						<td class="td2" colspan="2">
							<input id="txtStationgno" type="text" class="txt c2"/>
							<input id="txtStationg" type="text" class="txt c3"/>
						</td>
						<td class="td3"> </td>
						<td class="td4"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblFactory' class="lbl btn"> </a></td>
						<td class="td2" colspan="2">
							<input id="txtFactoryno" type="text" class="txt c2"/>
							<input id="txtFactory" type="text" class="txt c3"/>
						</td>
						<td class="td3"> </td>
						<td class="td4"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblPart' class="lbl btn"> </a></td>
						<td class="td2" colspan="2">
							<input id="txtPartno" type="text" class="txt c2"/>
							<input id="txtPart" type="text" class="txt c3"/>
						</td>
						<td class="td3"> </td>
						<td class="td4"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblStoreno' class="lbl btn"> </a></td>
						<td class="td2" colspan="2">
							<input id="txtStoreno" type="text" class="txt c2"/>
							<input id="txtStore" type="text" class="txt c3"/>
						</td>
						<td class="td3"> </td>
						<td class="td4"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblStoreinno' class="lbl btn"> </a></td>
						<td class="td2" colspan="2">
							<input id="txtStoreinno" type="text" class="txt c2"/>
							<input id="txtStorein" type="text" class="txt c3"/>
						</td>
						<td class="td3"> </td>
						<td class="td4"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblGensel' class="lbl"> </a></td>
						<td class="td2"><select id="cmbGensel" style="font-size: medium;" > </select></td>
						<td class="td3"> </td>
						<td class="td4"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblHours' class="lbl"> </a></td>
						<td class="td2"><input id="txtHours" type="text" class="txt c1 num"/></td>
						<td class="td3">HR</td>
						<td class="td4"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblWages' class="lbl"> </a></td>
						<td class="td2"><input id="txtWages" type="text" class="txt c1 num"/></td>
						<td class="td3"><a id='lblManunit' class="lbl" style="float: left;"> </a></td>
						<td class="td4"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMount' class="lbl"> </a></td>
						<td class="td2"><input id="txtMount" type="text" class="txt c1 num"/></td>
						<td class="td3"><a id='lblMechunit' class="lbl" style="float: left;"> </a></td>
						<td class="td4"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblGen' class="lbl"> </a></td>
						<td class="td2"><input id="txtGen" type="text" class="txt c1 num"/></td>
						<td class="td3"><a id='lblMachunit' class="lbl" style="float: left;"> </a></td>
						<td class="td4"> </td>
						
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMaxgen' class="lbl"> </a></td>
						<td class="td2"><input id="txtMaxgen" type="text" class="txt c1 num"/></td>
						<td class="td3">Pcs</td>
						<td class="td4"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMovmount' class="lbl"> </a></td>
						<td class="td2"><input id="txtMovmount" type="text" class="txt c1 num"/></td>
						<td class="td3">Pcs</td>
						<td class="td4"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMovtime' class="lbl"> </a></td>
						<td class="td2"><input id="txtMovtime" type="text" class="txt c1 num"/></td>
						<td class="td3">HR</td>
						<td class="td4"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMovmin' class="lbl"> </a></td>
						<td class="td2"><input id="txtMovmin" type="text" class="txt c1 num"/></td>
						<td class="td3">Min.</td>
						<td class="td4"> </td>
					</tr>
					<tr style="display: none;">
						<td class="td1"><span> </span><a id='lblMechcost' class="lbl"> </a></td>
						<td class="td2"><input id="txtMechcost" type="text" class="txt c1 num"/></td>
						<td class="td3"> </td>
						<td class="td4"> </td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width: 2%;">
						<input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;" />
					</td>
					<td align="center" style="width:10%;"><a id='lblMechno_s'> </a></td>
					<td align="center" style="width:20%;"><a id='lblMech_s'> </a></td>
					<td align="center" style="width:8%;"><a id='lblGen_s'> </a></td>
					<td align="center" style="width:8%;"><a id='lblLoadrate_s'> </a></td>
					<td align="center" style="width:15%;"><a id='lblWeekno_s'> </a></td>
					<td align="center" style="width:15%;"><a id='lblDayno_s'> </a></td>
					<td align="center" ><a id='lblMemo_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td>
						<input class="btn" id="btnMechno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
						<input id="txtMechno.*" type="text" style="width: 75%;"/>
					</td>
					<td><input type="text" id="txtMech.*" class="txt c1"/></td>
					<td><input id="txtGen.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLoadrate.*" type="text" class="txt num c1"/></td>
					<td><input id="txtWeekno.*" type="text" class="txt c1"/></td>
					<td><input id="txtDayno.*" type="text" class="txt c1"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>