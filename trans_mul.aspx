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
			var q_name = "tran";
			var q_readonly = ['txtNoa','txtTotal','txtWeight','txtWorker', 'txtWorker2'];
			var q_readonlys = ['txtTotal'];
			var bbmNum = [['txtMount',10,3,1],['txtWeight',10,3,1],['txtTotal',10,0,1]];
			var bbsNum = [['txtMount',10,0,1],['txtWeight',10,3,1],['txtPrice',10,3,1],['txtTotal',10,0,1]];
			var bbmMask = [];
			var bbsMask = [['txtDtime','99:99'],['txtCaseno2','A']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			aPop = new Array(
				['txtDriverno', 'lblDriverno', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'],
				['txtCarno', 'lblCarno', 'car2', 'a.noa', 'txtCarno', 'car2_b.aspx'],
				['txtCustno_', 'btnCustno_', 'cust', 'noa,comp,nick', 'txtCustno_,txtComp_,txtNick_', 'cust_b.aspx'],
				['txtUccno_', 'btnUccno_', 'ucc', 'noa,product', 'txtUccno_,txtProduct_', 'ucc_b.aspx'],
				['txtStraddrno_', 'btnStraddrno_', 'addr', 'noa,addr', 'txtStraddrno_,txtStraddr_', 'addr_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);

			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function sum(){
				var t_mount=0,t_weight=0,t_total=0;
				var t_mounts=0,t_weights=0,t_prices=0,t_totals=0;
				for(var i=0;i<q_bbsCount;i++){
					t_mounts = dec($('#txtMount_'+i).val());
					t_weights = dec($('#txtWeight_'+i).val());
					t_prices = dec($('#txtPrice_'+i).val());
					t_totals = round(q_mul(t_mounts,t_prices),0);
					t_total = q_add(t_total,t_totals);
					t_weight = q_add(t_weight,t_weights);
					t_mount = q_add(t_mount,t_mounts);
					$('#txtTotal_'+i).val(t_totals);
				}
				$('#txtWeight').val(t_weight);
				$('#txtTotal').val(t_total);
			}
			
			function mainPost() {
				q_getFormat();
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
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function q_popPost(s1) {
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				for(var j=0;j<q_bbsCount;j++){
					$('#txtCarno_'+j).val($('#txtCarno').val());
					$('#txtDriverno_'+j).val($('#txtDriverno').val());
					$('#txtDriver_'+j).val($('#txtDriver').val());
				}
				sum();
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtOdate').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tran') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtMount_'+j).change(function(){
							sum();
						});
						$('#txtWeight_'+j).change(function(){
							sum();
						});
						$('#txtPrice_'+j).change(function(){
							sum();
						});
					}
				}
				_bbsAssign();
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtOdate').val(q_date());
				$('#txtDatea').val(q_date()).focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
			}

			function btnPrint() {
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}
			
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				//新增 trans 應付
				var t_accy = (!emp(r_accy)?r_accy:q_date().substring(0,3));
				var t_noa = $.trim($('#txtNoa').val());
				q_func('qtxt.query','tran.txt,transave,'+encodeURI(t_accy) + ';' + encodeURI(t_noa));
			}

			function bbsSave(as) {
				if (!as['straddr']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['date'] = abbm2['date'];
				return true;
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
			.tbbm td {
				margin: 0 -1px;
				padding: 0;
			}
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
			}
			.tbbm td input[type="button"] {
				float: left;
				width: auto;
			}
			.dbbs {
				width: 100%;
			}
			.tbbs {
				FONT-SIZE: medium;
				COLOR: blue;
				TEXT-ALIGN: left;
				BORDER: 1PX LIGHTGREY SOLID;
				width: 100%;
				height: 98%;
			}
			.tbbs a {
				font-size: medium;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 25%;
				float: left;
			}
			.txt.c3 {
				width: 75%;
				float: left;
			}
			.txt.c4 {
				width: 5%;
				margin-right:2px;
				float: left;
			}
			.txt.c5 {
				width: 80%;
				float: left;
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
		<div id="dmain" >
			<div class="dview" id="dview">
				<table class="tview" id="tview" border="1" cellpadding="2" cellspacing="0" style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id="vewChk"></a></td>
						<td align="center" style="width:20%"><a id="vewNoa"></a></td>
						<td align="center" style="width:20%"><a id="vewDatea"></a></td>
						<td align="center" style="width:20%"><a id="vewDriver"></a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='driver'>~driver</td>

					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm" border="0" cellpadding="2" cellspacing="0">
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl" > </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblOdate" class="lbl" > </a></td>
						<td><input id="txtOdate" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblDatea" class="lbl" > </a></td>
						<td><input id="txtDatea" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDriverno" class="lbl btn" > </a></td>
						<td colspan="3">
							<input id="txtDriverno" type="text" class="txt c2"/>
							<input id="txtDriver" type="text" class="txt c3"/>
						</td>
						<td><span> </span><a id="lblCarno" class="lbl btn" > </a></td>
						<td><input id="txtCarno" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMount" class="lbl" > </a></td>
						<td><input id="txtMount" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblTotal" class="lbl" > </a></td>
						<td><input id="txtTotal" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblWeight" class="lbl" > </a></td>
						<td><input id="txtWeight" type="text" class="txt c1 num" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl" > </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl" > </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>

			<div class="dbbs" >
				<table id="tbbs" class="tbbs" border="1" cellpadding="2" cellspacing="1" >
					<tr style="color:White; background:#003366;" >
						<td align="center" style="width: 1%;">
							<input class="btn" id="btnPlus" type="button" value="+" style="font-weight: bold;" />
						</td>
						<td align="center" style="width: 12%;"><a id='lblCustno_s'> </a></td>
						<td align="center" style="width: 12%;"><a id='lblUcc_s'> </a></td>
						<td align="center" style="width: 8%;"><a id='lblMount_s'> </a></td>
						<td align="center" style="width: 8%;"><a id='lblWeight_s'> </a></td>
						<td align="center" style="width: 12%;"><a id='lblStraddr_s'> </a></td>
						<td align="center" style="width: 8%;"><a id='lblPrice_s'> </a></td>
						<td align="center" style="width: 8%;"><a id='lblTotal_s'> </a></td>
						<td align="center" style="width: 8%;"><a id='lblMemo_s'> </a></td>
						<td align="center" style="width: 12%;"><a id='lblCaseno_s'> </a></td>
						<td align="center" style="width: 4%;"><a id='lblCaseno2_s'> </a></td>
						<td align="center" style="width: 6%;"><a id='lblDtime_s'> </a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td style="width:1%;">
							<input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						</td>
						<td>
							<input type="button" class="txt c4" id="btnCustno.*" />
							<input type="text" class="txt c5" id="txtCustno.*" />
							<input type="text" class="txt c1" id="txtComp.*" />
							<input type="text" class="txt c1" style="display:none;" id="txtNick.*" />
						</td>
						<td>
							<input type="button" class="txt c4" id="btnUccno.*" />
							<input type="text" class="txt c5" id="txtUccno.*" />
							<input type="text" class="txt c1" id="txtProduct.*" />
						</td>
						<td><input type="text" class="txt c1 num" id="txtMount.*" /></td>
						<td><input type="text" class="txt c1 num" id="txtWeight.*" /></td>
						<td>
							<input type="button" class="txt c4" id="btnStraddrno.*" />
							<input type="text" class="txt c5" id="txtStraddrno.*" />
							<input type="text" class="txt c1" id="txtStraddr.*" />
						</td>
						<td><input type="text" class="txt c1 num" id="txtPrice.*" /></td>
						<td><input type="text" class="txt c1 num" id="txtTotal.*" /></td>
						<td><input type="text" class="txt c1" id="txtMemo.*" /></td>
						<td><input type="text" class="txt c1" id="txtCaseno.*" /></td>
						<td><input type="text" class="txt c1" style="text-align:center;" id="txtCaseno2.*" /></td>
						<td><input type="text" class="txt c1" id="txtDtime.*" /></td>
						<td style="display:none">
							<input type="text" id="txtNoq.*" style="display:none"/>
							<input type="text" id="txtCarno.*" style="display:none"/>
							<input type="text" id="txtDriverno.*" style="display:none"/>
							<input type="text" id="txtDriver.*" style="display:none"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>