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
			var q_name = "workchg";
			var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
			var q_readonlys = [];
			var bbmNum = [];
			var bbmMask = [];
			var bbsNum = [['txtMount', 15, 0, 1],['txtGmount', 15, 0, 1],['txtEmount', 15, 0, 1]];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			aPop = new Array(
	        	['txtBproductno', 'lblBproductno', 'ucaucc', 'noa,product', 'txtBproductno,txtBproduct', 'ucaucc_b.aspx'],
	        	['txtEproductno', 'lblEproductno', 'ucaucc', 'noa,product', 'txtEproductno,txtEproduct', 'ucaucc_b.aspx'],
	        	['txtOrgproductno_', 'btnOrgproductno_', 'works', 'productno,product,processno,process,unit,cuadate,mount,processno,process,memo',
	        	 'txtOrgproductno_,txtOrgproduct_,txtOrgprocessno_,txtOrgprocess_,txtUnit_,txtMount_,txtCuadate_,txtProcessno_,txtProcess_,txtMemo_', 'works_b.aspx','95%','95%'],
	        	['txtOrgprocessno_', 'btnOrgprocessno_', 'process', 'noa,process', 'txtOrgprocessno_,txtOrgprocess_', 'process_b.aspx'],
	        	['txtProcessno_', 'btnProcessno_', 'process', 'noa,process', 'txtProcessno_,txtProcess_', 'process_b.aspx'],
	        	['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx']
			);
			$(document).ready(function () {
				bbmKey = ['noa'];
				bbsKey = ['noa','noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
			});

			//////////////////   end Ready
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0); // 1=Last  0=Top
			}  ///  end Main()
	
			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea',r_picd]];
				bbsMask = [['txtCuadate',r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbMtype", q_getPara('uca.mtype'),'s');
				$('#btnWorkchgDo').click(function(){
                	var t_noa = trim($('#txtNoa').val());
					//q_func('qtxt.query.workchg','workchg.txt,workchg,'+r_accy + ';' + t_noa + ';'+ r_name);
				});
			}
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.workchg':
						alert('作業完畢');
					break;
				}
			}
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {   
					case q_name + '_s':
						  q_boxClose2(s2); ///   q_boxClose 3/4
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
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date()).focus();
			}
	
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
			}
	
			function btnPrint() {
	
			}

			function btnOk() {
				var t_err = '';
				t_err = q_chkEmpField(['txtNoa', q_getMsg('lblNoa')]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				if(q_cur==1)
						$('#txtWorker').val(r_name);
					else
						$('#txtWorker2').val(r_name);
				var t_noa = trim($('#txtNoa').val());
				var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")   
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workchg') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}
			
			function bbsAssign() {  /// 表身運算式
				_bbsAssign();
			}

			function bbsSave(as) {
				if(!as['productno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
			}
	
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(q_cur == 0 && !emp($('#txtNoa').val()))
					$('#btnWorkchgDo').removeAttr('disabled');
				else
					$('#btnWorkchgDo').attr('disabled','disabled');
			}
	
			function btnMinus(id) {
				_btnMinus(id);
			}
	
			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign(); 
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
			#dmain{
				/*overflow:hidden;*/
			}
			.dview{
				float:left;
				width:25%;
			}
			.tview{
				margin:0;
				padding:2px;
				border:1px black double;
				border-spacing:0;
				font-size:16px;
				background-color:#FFFF66;
				color:blue;
			}
			.tview td{
				padding:2px;
				text-align:center;
				border:1px black solid;
			}
			.dbbm{
				float:left;
				width:70%;
				margin:-1px;
				border:1px black solid;
				border-radius:5px;
			}
			.tbbm{
				padding:0px;
				border:1px white double;
				border-spacing:0;
				border-collapse:collapse;
				font-size: medium;
				color:blue;
				background:#cad3ff;
				width:100%;
			}
			.tbbm tr{
				height:35px;
			}
			.tbbm tr td {
				margin:0px -1px;
				padding:0;
				width: 10%;
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
			.tbbm tr td .lbl.btn{
				color:#4297D7;
				font-weight:bolder;
			}
			.tbbm tr td .lbl.btn:hover{
				color:#FF8F19;
			}
			.txt {
				float:left;
			}
			.txt.c1{
				width:95%;
			}
			.txt.c5 {
				width: 71%;
				float: left;
			}
			.num{
				text-align:right;
			}
			.tbbm tr td input[type="text"]{
				border-width:1px;
				padding:0px;
				margin:-1px;
			}
			.dbbs {
				float:left;
				width: 100%;
			}
			.tbbs {
				width:100%;
			}
			.tbbs a {
				font-size: medium;
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
			<div class="dview" id="dview" style="float: left;  width:25%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk' class="lbl"> </a></td>
						<td align="center" style="width:40%"><a id='vewNoa' class="lbl"> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea' class="lbl"> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='datea'>~datea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing=''>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBproductno' class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtBproductno"  type="text" class="txt" style="width:30%;"/>
							<input id="txtBproduct"  type="text" class="txt" style="width:65%;"/>
						</td>
					</tr>  
					<tr>
						<td><span> </span><a id='lblEproductno' class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtEproductno"  type="text" class="txt" style="width:30%;"/>
							<input id="txtEproduct"  type="text" class="txt" style="width:65%;"/>
						</td>
					</tr>  
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="2"><input id="txtMemo"  type="text" class="txt" style="width: 98%;" /></td>
						<td><input id="btnWorkchgDo"  type="button"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1" /></td>
					</tr>
				</table>
	        </div>
			<div class='dbbs' >
				<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1'>
					<tr style='color:White; background:#003366;' >
						<td align="center" style="width:1%;">
							<input class="txt btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;"  />
						</td>
						<td align="center" style="width:15%;"><a id='lblOrgproduct_s'> </a></td>
						<td align="center" style="width:10%;"><a id='lblOrgprocesss'> </a></td>
						<td align="center" style="width:15%;"><a id='lblProduct_s'> </a></td>
						<td align="center" style="width:10%;"><a id='lblProcesss'> </a></td>
						<td align="center" style="width:4%;"><a id='lblUnit_s'> </a></td>
						<td align="center" style="width:8%;"><a id='lblCuadates'> </a></td>
						<td align="center" style="width:8%;"><a id='lblMounts'> </a></td>
						<td align="center"><a id='lblMemos'> </a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
						<td>
							<input id="txtOrgproductno.*" type="text" class="txt" style="width: 75%;"/>
							<input class="btn"  id="btnOrgproductno.*" type="button" value='...' style=" font-weight: bold;" />
							<input id="txtOrgproduct.*" type="text" class="txt c1"/>
						</td>
						<td>
							<input id="txtOrgprocessno.*" type="text" class="txt c5"/>
							<input class="btn"  id="btnOrgprocessno.*" type="button" value='.' style=" font-weight: bold;" />
							<input id="txtOrgprocess.*" type="text" class="txt c1"/>
						</td>
						<td>
							<input id="txtProductno.*" type="text" class="txt" style="width: 75%;"/>
							<input class="btn"  id="btnProductno.*" type="button" value='...' style=" font-weight: bold;" />
							<input id="txtProduct.*" type="text" class="txt c1"/>
						</td>
						<td>
							<input id="txtProcessno.*" type="text" class="txt c5"/>
							<input class="btn"  id="btnProcessno.*" type="button" value='.' style=" font-weight: bold;" />
							<input id="txtProcess.*" type="text" class="txt c1"/>
						</td>
						<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
						<td><input id="txtCuadate.*" type="text" class="txt c1"/></td>
						<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
						<td>
							<input id="txtMemo.*" type="text" class="txt c1"/>
							<input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>