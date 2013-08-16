<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
	<title> </title>
	<script src="../script/jquery.min.js" type="text/javascript"> </script>
	<script src='../script/qj2.js' type="text/javascript"> </script>
	<script src='qset.js' type="text/javascript"> </script>
	<script src='../script/qj_mess.js' type="text/javascript"> </script>
	<script src="../script/qbox.js" type="text/javascript"> </script>
	<script src='../script/mask.js' type="text/javascript"> </script>
	<link href="../qbox.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript">
		this.errorHandler = null;
		function onPageError(error) {
			alert("An error occurred:\r\n" + error.Message);
		}
		q_desc = 1;
		q_tables = 's';
		var q_name = "vcce";
		var q_readonly = ['txtNoa','cmbStype'];
		var q_readonlys = [];
		var bbmNum = [['txtWeight', 15, 3, 1],['txtTotal', 10, 2, 1]];  
		var bbsNum = [['txtMount', 10, 0, 1],['txtEcount', 10, 0, 1],['txtAdjcount', 10, 0, 1]];
		var bbmMask = [];
		var bbsMask = [];
		q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
		aPop = new Array(
		['txtCustno', 'lblCustno', 'cust', 'noa,comp,tel,trantype,addr_comp', 'txtCustno,txtComp,txtTel,txtTrantype,txtAddr_post', 'cust_b.aspx']
		,['txtOrdeno', '', 'orde', 'noa,custno,comp,trantype,stype,tel,addr2', 'txtOrdeno,txtCustno,txtComp,cmbTrantype,cmbStype,txtTel,txtAddr_post', '']
		,['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx']
		);

		$(document).ready(function () {
			bbmKey = ['noa'];
			bbsKey = ['noa', 'noq'];
			q_brwCount();   
			q_gt(q_name, q_content, q_sqlCount, 1,0,'',r_accy);

		});

		//////////////////   end Ready
		function main() {
			if (dataErr)  
			{
				dataErr = false;
				return;
			}

			mainForm(1); 
		}  
		function mainPost() { 
			q_getFormat();
			bbmMask = [['txtDatea', r_picd],['txtCldate',r_picd]];
			q_mask(bbmMask);
			q_cmbParse("cmbTrantype", q_getPara('vcce.trantype'));
			q_cmbParse("cmbStype", q_getPara('orde.stype'));
			
			$('#btnVcct').click(function(){
				var t_noa = $('#txtNoa').val();
				var t_where = '';
				if(t_noa.length > 0)
					t_where = "noa='" + t_noa + "'";
					q_box("vcct.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vcct', "95%", "95%", q_getMsg('btnVcct'));
			});
			
			$('#btnInvoice').click(function(){
				var t_noa = $('#txtNoa').val();
				var t_where = '';
				if(t_noa.length > 0)
					t_where = "vcceno='" + t_noa + "'";
					q_box("invoice.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'invoice', "95%", "95%", q_getMsg('btnInvoice'));
			});
			
			$('#btnPack').click(function(){
				var t_noa = $('#txtNoa').val();
				var t_where = '';
				if(t_noa.length > 0)
					t_where = "noa='" + t_noa + "'";
					q_box("packing_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'invoice', "95%", "95%", q_getMsg('btnPack'));
			});
			
			$('#btnOrdeimport').click(function(){
				var ordeno = $('#txtOrdeno').val();
				var t_where = ' 1=1 ';
				if(ordeno.length > 0)
					t_where += " and noa='" + ordeno + "'";
				t_where += q_sqlPara2('custno',$('#txtCustno').val());
				q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'orde', "95%", "95%", q_getMsg('popOrde'));
			});
			$('#txtAddr_post').change(function(){
				var t_custno = trim($(this).val());
				if(!emp(t_custno)){
					focus_addr = $(this).attr('id');
					var t_where = "where=^^ noa='" + t_custno + "' ^^";
					q_gt('cust', t_where, 0, 0, 0, "");
				}  
			});
			$('#txtDeivery_addr').change(function(){
				var t_custno = trim($(this).val());
				if(!emp(t_custno)){
					focus_addr = $(this).attr('id');
					var t_where = "where=^^ noa='" + t_custno + "' ^^";
					q_gt('cust', t_where, 0, 0, 0, "");
				}  
			});
			
			$('#txtOrdeno').change(function(){
				var t_ordeno = trim($('#txtOrdeno').val());
				if(!emp(t_ordeno)){
					var t_where = "where=^^ noa='" + t_ordeno + "' ^^";
					q_gt('ordei', t_where, 0, 0, 0, "", r_accy);
				}  
			});
		}

		function q_boxClose(s2) { ///   q_boxClose 2/4 
			var ret;
			switch (b_pop) {
				case 'orde':
					if (q_cur > 0 && q_cur < 4) {
						if (!b_ret || b_ret.length == 0)
							return;
						ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtOrdeno,txtNo2,txtProductno,txtProduct,txtMount', b_ret.length, b_ret,
												 'noa,no2,productno,product,mount','txtProductno');   /// 最後 aEmpField 不可以有【數字欄位】
						if(b_ret[0].noa != undefined){
							var t_where = "noa='" + b_ret[0].noa + "'";
							q_gt('orde', t_where , 0, 0, 0, "", r_accy);
					   	}
					}
						break;
				case q_name + '_s':
					q_boxClose2(s2); ///   q_boxClose 3/4
					break;
			}   /// end Switch
			b_pop = '';
		}

		var focus_addr='';
		function q_gtPost(t_name) {  
			switch (t_name) {
				case 'ordei':
            		var as = _q_appendData("ordei", "", true);
            		var t_memo='';
            		if(as[0]!=undefined)
            			t_memo='INVOICE 備註:'+as[0].invoicememo+'\nPACKING LIST備註:'+as[0].packinglistmemo
            		
            		$('#txtMemo').val(t_memo);
            		break;
				case 'orde':
					var orde=_q_appendData("orde", "", true);
					if(orde[0]!=undefined)
						$('#txtCustno').val(orde[0].custno);
						$('#txtComp').val(orde[0].comp);
						$('#txtTel').val(orde[0].tel);
						$('#txtTrantype').val(orde[0].trantype);
						$('#txtAddr_post').val(orde[0].addr2);
						$('#txtOrdeno').val(orde[0].noa);
					break;
				case 'cust':
					var as = _q_appendData("cust", "", true);
					if(as[0]!=undefined && focus_addr !=''){
						$('#'+focus_addr).val(as[0].addr_fact);
						focus_addr = '';
					}
					break;
				case q_name: if (q_cur == 4)   
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

			$('#txtWorker').val(r_name)
			sum();

			var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
			if (s1.length == 0 || s1 == "AUTO")   
				q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vcce')+ $('#txtDatea').val(), '/', ''));
			else
				wrServer(s1);
		}

		function _btnSeek() {
			if (q_cur > 0 && q_cur < 4)  // 1-3
				return;

			q_box('vcce_s.aspx', q_name + '_s', "500px", "360px", q_getMsg("popSeek"));
		}

		function combPay_chg() {   
		}

		function bbsAssign() { 
			for(var j = 0; j < q_bbsCount; j++) {
				if (!$('#btnMinus_' + j).hasClass('isAssign')) {	
					$('#txtWeight_' + j).change(function () {
						sum()
					});	 
				}
			}
			_bbsAssign();
		}

		function btnIns() {
			_btnIns();
			$('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
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

		}

		function wrServer(key_value) {
			var i;

			$('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
			_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
		}

		function bbsSave(as) {
			if (!as['product'] ) {  
				as[bbsKey[1]] = '';   
				return;
			}

			q_nowf();
			as['datea'] = abbm2['datea'];
		 
			return true;
		}

		function sum() {
			/*
			var t1 = 0, t_unit, t_mount, t_weight = 0;
			for (var j = 0; j < q_bbsCount; j++) {
				t_weight+=q_float('txtWeight_'+j);
			}  // j
			q_tr('txtWeight',t_weight);
			*/
		}
		
		///////////////////////////////////////////////////  
		function refresh(recno) {
			_refresh(recno);
	   }

		function readonly(t_para, empty) {
			_readonly(t_para, empty);
			$('#cmbStype').attr('disabled',true);
			
			if(t_para){
            	$('#btnVcct').removeAttr('disabled');
            	$('#btnInvoice').removeAttr('disabled');
            	$('#btnPack').removeAttr('disabled');
            }else{
            	$('#btnVcct').attr('disabled','disabled');
            	$('#btnInvoice').attr('disabled','disabled');
            	$('#btnPack').attr('disabled','disabled');
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
		
		function q_popPost(s1) {
		    	switch (s1) {
			        case 'txtOrdeno':
		    			var t_ordeno = trim($('#txtOrdeno').val());
						if(!emp(t_ordeno)){
							var t_where = "where=^^ noa='" + t_ordeno + "' ^^";
							q_gt('ordei', t_where, 0, 0, 0, "", r_accy);
						}
			        break;
		    	}
			}
		
	</script>
	<style type="text/css">
			#dmain {
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
			.tbbm tr td{
				width: 9%;
			}
			.tbbm .tdZ {
				width: 3%;
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
				width: 97%;
				float: left;
			}
			.txt.c2 {
				width: 14%;
				float: left;
			}
			.txt.c3 {
				width: 26%;
				float: left;
			}
			.txt.c4 {
				width: 25%;
				float: left;
			}
			.txt.c5 {
				width: 60%;
				float: left;
			}
			.txt.c6 {
				width: 25%;
				
			}
			.txt.c7 {
				width: 98%;
				float: left;
			}
			.txt.c8 {
				float:left;
				width: 65px;
				
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
			.dbbs {
				width: 100%;
			}
			.tbbs a {
				font-size: medium;
			}

			.num {
				text-align: right;
			}
			.tbbs tr.error input[type="text"] {
				color: red;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
		.tbbs
		{
			FONT-SIZE: medium;
			COLOR: blue ;
			TEXT-ALIGN: left;
			 BORDER:1PX LIGHTGREY SOLID;
			 width:100% ; height:98% ;  
		}  
	  
	   .tbbs .td1
		{
			width: 4%;
		}
		.tbbs .td2
		{
			width: 6%;
		}
		.tbbs .td3
		{
			width: 8%;
		}
		.tbbs .td4
		{
			width: 2%;
		}
	</style>
</head>
<body ondragstart="return false" draggable="false"
		ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"  
		ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"  
		ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
<!--#include file="../inc/toolbar.inc"-->
	<div id='dmain' >
		<div class="dview" id="dview" style="float: left;  width:32%;"  >
		   <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
			<tr>
				<td align="center" style="width:5%"><a id='vewChk'> </a></td>
				<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
				<td align="center" style="width:25%"><a id='vewComp'> </a></td>
			</tr>
			 <tr>
				   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
				   <td align="center" id='datea'>~datea</td>
				   <td align="center" id='comp,4'>~comp,4</td>
			</tr>
		</table>
		</div>
		<div class='dbbm' style="width: 68%;float:left">
		<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
		<tr class="tr1">
			<td class='td1'><span> </span><a id="lblDatea" class="lbl"> </a></td>
			<td class="td2"><input id="txtDatea"  type="text" class="txt c1"/></td>
			<td class="td4"><span> </span><a id="lblNoa" class="lbl"> </a></td>
			<td class="td5"><input id="txtNoa"  type="text" class="txt c1"/> </td>
			<td class="td5"></td>
			<!--//在vcct已有
			<td class='td6'><span> </span><a id="lblCldate" class="lbl"> </a></td>
			<td class="td7"><input id="txtCldate"  type="text" class="txt c1"/></td>-->
			<td class='td3'><span> </span><a id="lblOrdeno" class="lbl"> </a> </td>
			<td class="td4"><input id="txtOrdeno"  type="text" class="txt c1"/> </td>
			<td class="td6"><input id="btnOrdeimport" type="button"/> </td>
		</tr>
		<tr class="tr2">
			<td class='td1'><span> </span><a id="lblCustno" class="lbl btn"> </a></td>
			<td class="td2"><input id="txtCustno"  type="text" class="txt c1"/></td>
			<td class='td3' colspan="3"><input id="txtComp"  type="text" class="txt c7"/></td>
			<!--//在vcct已有
			<td class="td6"><span> </span><a id="lblCaseno" class="lbl"> </a></td>
			<td class="td7"><input id="txtCaseno"  type="text" class="txt c1"/> </td>
			<td class="td8"><input id="txtCaseno2"  type="text" class="txt c1"/> </td>-->
			<td class='td3'><span> </span><a id="lblStype" class="lbl"> </a> </td>
			<td class="td4"><select id="cmbStype" class="txt c1"> </select></td>
			<td class="td6"><input id="btnVcct" type="button"/> </td>
		</tr>
		<tr class="tr3">
			<td class='td1'><span> </span><a id="lblTel" class="lbl"> </a></td>
			<td class="td2" colspan="4"><input id="txtTel"  type="text" class="txt c7"/></td>
			<td class="td3"><span> </span><a id="lblTrantype" class="lbl"> </a></td>
			<td class="td4"><select id="cmbTrantype" class="txt c1"> </select></td>
			<td class="td6"><input id="btnInvoice" type="button"/> </td>
		</tr>
		<tr class="tr4">
			<td class='td1'><span> </span><a id="lblAddr_post" class="lbl"> </a></td>
			<td class="td2" colspan="4"><input id="txtAddr_post"  type="text" class="txt c7"/> </td>
			<td class="td4"><span> </span><a id="lblCardeal" class="lbl"> </a></td>
			<td class="td5"><input id="txtCardeal"  type="text" class="txt c1"/> </td>
			<td class="td6"><input id="btnPack" type="button"/> </td>
		</tr>
		<tr class="tr5">
			<td class='td1'><span> </span><a id="lblDeivery_addr" class="lbl"> </a></td>
			<td class="td2" colspan="4"><input id="txtDeivery_addr"  type="text" class="txt c7"/> </td>
			<td class='td6'><span> </span><a id="lblCarno" class="lbl"> </a></td>
			<td class="td7"><input id="txtCarno"  type="text" class="txt c1"/></td>
		</tr>   
		<tr class="tr6">
			<td class='td1'><span> </span><a id="lblWeight" class="lbl"> </a></td>
			<td class="td2"><input id="txtWeight"  type="text" class="txt c1 num"/></td>
			<td class='td8'><span> </span><a id="lblTotal" class="lbl"> </a></td>
			<td class="td9"><input id="txtTotal"  type="text" class="txt c1 num"/></td>
		</tr> 
		<tr class="tr7">
			<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
			<td class="td2" colspan="8"><textarea id="txtMemo" cols="5" rows="10" style="width: 99%;height: 50px;"> </textarea></td>
		</tr>						  
		</table>
		</div>
		<div class='dbbs' > 
		<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
			<tr style='color:White; background:#003366;' >
				<td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
				<td align="center" style="width:10%;"><a id='lblOrdeno_s'> </a></td>
				<td align="center" style="width:4%;"><a id='lblNo2_s'> </a></td>
				<td align="center" style="width:20%;"><a id='lblProductno_s'> </a></td>
				<td align="center" style="width:7%;"><a id='lblMount_s'> </a></td>
				<td align="center" style="width:3%;"><a id='lblEnds_s'> </a></td>
				<td align="center" style="width:7%;"><a id='lblEcount_s'> </a></td>
				<td align="center" style="width:7%;"><a id='lblAdjcount_s'> </a></td>
				<td align="center"><a id='lblMemo_s'> </a></td>
			</tr>
			<tr  style='background:#cad3ff;'>
				<td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
				<td ><input class="txt c1" id="txtOrdeno.*" type="text" /></td>
				<td ><input class="txt c1" id="txtNo2.*" type="text" /></td>
				<td><input class="txt c4" id="txtProductno.*" type="text" />
					 <input class="txt c5" id="txtProduct.*" type="text" />
					 <input class="btn"  id="btnProduct.*" type="button" value='.' style=" font-weight: bold;" />
				</td>
				<td ><input class="txt num c1" id="txtMount.*" type="text"/></td>
				<td align="center"><input id="chkEnda.*" type="checkbox"/></td>
				<td ><input class="txt num c1" id="txtEcount.*" type="text" /></td>
				<td ><input class="txt num c1" id="txtAdjcount.*" type="text" /></td>
				<td ><input class="txt c1" id="txtMemo.*" type="text" /></td>
			</tr>
		</table>
		</div>
		</div>
		<input id="q_sys" type="hidden" />
</body>
</html>
 