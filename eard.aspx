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
			var q_name = "eard";
			var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
			var q_readonlys = [];
			var bbmNum = [['txtEmpweight', 10, 0, 1],['txtMinusweight', 10, 0, 1],['txtPlusweight', 10, 0, 1],
						  ['txtWeight', 10, 0, 1],['txtFweight', 10, 0, 1],['txtGweight', 10, 0, 1],
						  ['txtSweight', 10, 0, 1],['txtDime1', 10, 0, 1],['txtDime2', 10, 0, 1],
						  ['txtDime3', 10, 0, 1]
						 ];
			var bbsNum = [['txtWeight', 10, 0, 1],['txtSweight', 10, 0, 1],['txtPweight', 10, 0, 1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			$(document).ready(function () {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1)
			});
			aPop = [['txtCustno', 'lblCustno', 'cust', 'noa,comp,nick', 'txtCustno,txtCust,txtNick', 'cust_b.aspx']];
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
                bbmMask = [['txtDatea',r_picd],['txtTimea','99:99']]
                q_mask(bbmMask);
                bbsMask = [['txtDatea',r_picd]]
                q_mask(bbsMask);
                q_gt('cardeal', '', 0, 0, 0, "");
                $('#txtEmpweight').change(function(){sum();});
                $('#txtMinusweight').change(function(){sum();});
                $('#txtPlusweight').change(function(){sum();});
                $('#txtWeight').change(function(){sum();});
                $('#txtGweight').change(function(){sum();});
                $('#btnImportVcc').click(function(){
                	if(q_cur == 1 || q_cur == 2){
	                	var t_custno = $('#txtCustno').val();
	                	var t_carno = $('#txtCarno').val();
	                	if(emp(t_custno) || emp(t_carno)){
	                		alert('請輸入 : 【' + q_getMsg('lblCustno') + '】、【' + q_getMsg('lblCarno') + '】');
	                	}else{
	                		t_where = "where=^^ custno='" +t_custno+ "' and carno2='" + t_carno + "' ^^";
	                		q_gt('vcc', t_where , 0, 0, 0, "", r_accy);
	                	}
                	}
                });
				if (q_getPara('sys.project').toUpperCase()==='FE'){
					q_cmbParse("cmbTypea", '1@進貨,2@出貨,3@借磅,4@進貨退回,5@出貨退回');
					$('.FEY').show();
					$('.FEN').hide();
					$('.FEYD').remove();
					if($('#cmbTypea').val()=='5'){
							$('.cmbType123').show();
							$('.cmbType23').show();
							$('.cmbType12').show();
							$('.cmbType1').hide();
							$('.cmbType2').show();
							$('.cmbType3').hide();
					}
					if($('#cmbTypea').val()=='4'){
							$('.cmbType123').show();
							$('.cmbType23').hide();
							$('.cmbType12').show();
							$('.cmbType1').show();
							$('.cmbType2').hide();
							$('.cmbType3').hide();
					}
					if($('#cmbTypea').val()=='3'){
							$('.cmbType123').show();
							$('.cmbType23').show();
							$('.cmbType12').hide();
							$('.cmbType1').hide();
							$('.cmbType2').hide();
							$('.cmbType3').show();
					}
					if($('#cmbTypea').val()=='2'){
							$('.cmbType123').show();
							$('.cmbType23').show();
							$('.cmbType12').show();
							$('.cmbType1').hide();
							$('.cmbType2').show();
							$('.cmbType3').hide();
					}
					if($('#cmbTypea').val()=='1'){
							$('.cmbType123').show();
							$('.cmbType23').hide();
							$('.cmbType12').show();
							$('.cmbType1').show();
							$('.cmbType2').hide();
							$('.cmbType3').hide();
					}
				}
				else {
					$('.FEND').remove();
					q_cmbParse("cmbTypea", q_getPara('eard.typea'));
				}
				$("#cmbTypea").focus(function() {
				}).change(function() {
				if (q_getPara('sys.project').toUpperCase()==='FE'){
					$('.FEYD').remove();
					$('.FEY').show();
					$('.FEN').hide();
					if($('#cmbTypea').val()=='5'){
							$('.cmbType123').show();
							$('.cmbType23').show();
							$('.cmbType12').show();
							$('.cmbType1').hide();
							$('.cmbType2').show();
							$('.cmbType3').hide();
					}
					if($('#cmbTypea').val()=='4'){
							$('.cmbType123').show();
							$('.cmbType23').hide();
							$('.cmbType12').show();
							$('.cmbType1').show();
							$('.cmbType2').hide();
							$('.cmbType3').hide();
					}
					if($('#cmbTypea').val()=='3'){
							$('.cmbType123').show();
							$('.cmbType23').show();
							$('.cmbType12').hide();
							$('.cmbType1').hide();
							$('.cmbType2').hide();
							$('.cmbType3').show();
					}
					if($('#cmbTypea').val()=='2'){
							$('.cmbType123').show();
							$('.cmbType23').show();
							$('.cmbType12').show();
							$('.cmbType1').hide();
							$('.cmbType2').show();
							$('.cmbType3').hide();
					}
					if($('#cmbTypea').val()=='1'){
							$('.cmbType123').show();
							$('.cmbType23').hide();
							$('.cmbType12').show();
							$('.cmbType1').show();
							$('.cmbType2').hide();
							$('.cmbType3').hide();
					}
				}
				else	{
					$('.FEND').remove();
				}
				});


			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {   
					case q_name + '_s':
						  q_boxClose2(s2); ///   q_boxClose 3/4
						  break;
				}
			}
			
			function sum(){
				//BBM
				var t_empweight = dec($('#txtEmpweight').val());
				var t_minusweight = dec($('#txtMinusweight').val());
				var t_plusweight = dec($('#txtPlusweight').val());
				var t_weight = dec($('#txtWeight').val());
				var t_gweight = dec($('#txtGweight').val());
				var t_sweight = 0;
				/*if(t_gweight != 0 && t_empweight != 0){
					t_weight = t_gweight - (t_empweight - t_minusweight + t_plusweight);
				}
				if(t_empweight != 0 && t_weight != 0 && t_gweight == 0){
					t_gweight = (t_empweight - t_minusweight + t_plusweight) + t_weight;
				}
				if(t_gweight != 0 && t_weight != 0 && t_empweight == 0){
					t_empweight = t_gweight - t_weight - (t_plusweight - t_minusweight);
				}*/
				
				t_gweight = t_empweight - t_minusweight + t_plusweight + t_weight;
				
				//BBS
				for (var j = 0; j < q_bbsCount; j++) {
					if(!emp($('#txtVccno_' + j).val()) && !($('#chkExclude_' + j).is(':checked'))){
						t_sweight += dec($('#txtSweight_' + j).val());
					}
				}
				//$('#txtWeight').val(t_weight);
				$('#txtGweight').val(t_gweight);
				//$('#txtEmpweight').val(t_empweight);
				$('#txtSweight').val(t_sweight);				
				
			}
			
			function q_gtPost(t_name) { 
				switch (t_name) {
					case 'cardeal':
						var as = _q_appendData("cardeal", "", true);
						var t_item = " @ ";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].nick;
						}
						q_cmbParse("cmbCardealno", t_item);
						if(abbm[q_recno])
							$("#cmbCardealno").val(abbm[q_recno].cardealno);
						break;
					case 'vcc':
						var as = _q_appendData("vcc", "", true);
						if(as[0]!=undefined){
	                		q_gridAddRow(bbsHtm, 'tbbs', 'txtVccno,txtDatea,txtWeight'
			            	, as.length, as, 'noa,datea,weight', 'txtVccno');
						}
						break;
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
				if (q_getPara('sys.project').toUpperCase()==='FE'){
				}
				else{
					_btnIns();
					$('#txtNoa').val('AUTO');
					$('#txtDatea').val(q_date());
					$('#txtDatea').focus();
				}
			}
	
			function btnModi() {
				if (q_getPara('sys.project').toUpperCase()==='FE'){
				}
				else{
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				}
			}
	
			function btnPrint() {
				if (q_getPara('sys.project').toUpperCase()==='FE'){
				}
				else{
					q_box('z_eard.aspx', '', "95%", "95%", q_getMsg("popPrint"));
				}
			}

			function btnOk() {
				var t_err = '';
	
				t_err = q_chkEmpField(['txtNoa', q_getMsg('lblNoa')]);

				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				$('#txtCardeal').val($('#cmbCardealno').find(":selected").text());
				if(q_cur==1)
	            	$('#txtWorker').val(r_name);
	            else
	            	$('#txtWorker2').val(r_name);
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
		    		q_gtnoa(q_name, replaceAll('S' + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
			}
	
			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}


			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
 					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
 						$('#txtSweight_' + j).change(function(){
 							sum();
 						});
 						$('#txtVccno_' + j).change(function(){
 							sum();
 						});
 						$('#chkExclude_' + j).change(function(){
 							sum();
 						});
					}
				}
				_bbsAssign();
			}
			
			function bbsSave(as) {
			if (q_getPara('sys.project').toUpperCase()==='FE'){
			}
			else {
				if (!as['vccno']) {
					as[bbsKey[1]] = '';
					return;
				}
			}
				q_nowf();
				return true;
			}
	
			function refresh(recno) {
				_refresh(recno);
				if (q_getPara('sys.project').toUpperCase()==='FE'){
					q_cmbParse("cmbTypea", '1@進貨,2@出貨,3@借磅,4@進貨退回,5@出貨退回');
					$('.FEYD').remove();
					$('.FEY').show();
					$('.FEN').hide();
					if($('#cmbTypea').val()=='5'){
							$('.cmbType123').show();
							$('.cmbType23').show();
							$('.cmbType12').show();
							$('.cmbType1').hide();
							$('.cmbType2').show();
							$('.cmbType3').hide();
					}
					if($('#cmbTypea').val()=='4'){
							$('.cmbType123').show();
							$('.cmbType23').hide();
							$('.cmbType12').show();
							$('.cmbType1').show();
							$('.cmbType2').hide();
							$('.cmbType3').hide();
					}
					if($('#cmbTypea').val()=='3'){
							$('.cmbType123').show();
							$('.cmbType23').show();
							$('.cmbType12').hide();
							$('.cmbType1').hide();
							$('.cmbType2').hide();
							$('.cmbType3').show();
					}
					if($('#cmbTypea').val()=='2'){
							$('.cmbType123').show();
							$('.cmbType23').show();
							$('.cmbType12').show();
							$('.cmbType1').hide();
							$('.cmbType2').show();
							$('.cmbType3').hide();
					}
					if($('#cmbTypea').val()=='1'){
							$('.cmbType123').show();
							$('.cmbType23').hide();
							$('.cmbType12').show();
							$('.cmbType1').show();
							$('.cmbType2').hide();
							$('.cmbType3').hide();
					}
				}
				else {
					$('.FEND').remove();
					q_cmbParse("cmbTypea", q_getPara('eard.typea'));
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
				if (q_getPara('sys.project').toUpperCase()==='FE'){
				}
				else{
					_btnDele();
				}
			}
	
			function btnCancel() {
				_btnCancel();
			}
	</script>
	<style type="text/css">
		#dmain{
			overflow:hidden;
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
			width:9%;
			margin:0px -1px;
			padding:0;
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
		.txt.c1{
			width:95%;
			float:left;
		}
		.num{
			text-align:right;
		}
		.tbbm tr td input[type="text"]{
			border-width:1px;
			padding:0px;
			margin:-1px;
		}
		input[type="text"], input[type="button"] {
			font-size: medium;
		}
		.dbbs {
			width: 750px;
		}
		.tbbs a {
			font-size: medium;
		}
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
	<div id='dmain' style="overflow:hidden;">
		<div class="dview" id="dview">
			<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
				<tr>
					<td align="center" style="width:5%"><a id='vewChk' class="lbl"> </a></td>
					<td align="center" style="width:30%"><a id='vewNoa' class="lbl"> </a></td>
					<td align="center" style="width:15%"><a id='vewDatea' class="lbl"> </a></td>
					<td align="center" style="width:30%"><a id='vewNick' class="lbl"> </a></td>
				</tr>
				<tr>
					<td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
					<td align="center" id='noa'>~noa</td>
					<td align="center" id='datea'>~datea</td>
					<td align="center" id='nick'>~nick</td>
				</tr>
			</table>
		</div>
		<div class='dbbm'>
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing=''>
				<tr class="tr1">
					<td class="td1"><span> </span><a id='lblTypea' class="lbl"> </a></td>
					<td class="td2"><select id="cmbTypea" class="txt c1"> </select></td>
					<td class="td3"><span> </span><a id="lblNoa" class="lbl"> </a></td>
					<td class="td4"><input id="txtNoa" type="text" class="txt c1" style="width:120px;"/></td>
					<td class="td5"><span> </span><a id="lblDatea" class="lbl"> </a></td>
					<td class="td6"><input id="txtDatea" type="text" class="txt c1" /></td>
					<td class="FEY" style="display:none;"><input id="chkEardweight" type="checkbox"/><a>日期手動</a></td>
					<td class="td7"><span> </span><a id="lblTimea" class="lbl"> </a></td>
					<td class="td8"><input id="txtTimea" type="text" class="txt c1" /></td>
				</tr>
				<tr class="tr2">
					<td class="td1 cmbType1" style="display:none;"><span> </span><a class="lbl btn">廠商名稱</a></td>
					<td class="td1 cmbType2" style="display:none;"><span> </span><a class="lbl btn">客戶名稱</a></td>
					<td class="td5 cmbType3" style="display:none;"><span> </span><a class="lbl">傳票編號</a></td>
					<td class="td6 cmbType3" style="display:none;"><input id="txtAccno" type="text" class="txt c1" /></td>
					<td class="td5 cmbType3" style="display:none;"><span> </span><a class="lbl">借磅費用</a></td>
					<td class="td6 cmbType3" style="display:none;"><input id="txtPrice" type="text" class="txt c1" /></td>
					<td class="td1 FEN"><span> </span><a id="lblCustno" class="lbl btn"> </a></td>
					<td class="td2 cmbType12" colspan="3">
						<input id="txtCustno" type="text" style="float:left;width:30%;"/>
						<input id="txtCust" type="text" style="float:left;width:70%;"/>
						<input id="txtNick" type="text" style="display:none;"/>
					</td>
					<td class="td3 cmbType123"><span> </span><a id="lblCardealno" class="lbl"> </a></td>
					<td class="td4 cmbType123">
						<select id="cmbCardealno" class="txt c1 FEN"> </select>
						<input class="cmbType123" id="txtCardeal" type="text"  style="display:none;width:100%;"/>
					</td>
					
					<td class="td5 cmbType123"><span> </span><a id="lblCarno" class="lbl"> </a></td>
					<td class="td6 cmbType123"><input id="txtCarno" type="text" class="txt c1" /></td>
					<td class="FEY" style="display:none;"><input id="chkEardsignal" type="checkbox"/><a>重量手動</a></td>
				</tr>  
				<tr class="tr3">
					<td class="td1 FEN"><span> </span><a id="lblCaseno" class="lbl"> </a></td>
					<td class="td2 FEN"><input id="txtCaseno" type="text" class="txt c1" /></td>
					<td class="td1"><span> </span><a id='lblEmpweight' class="lbl"> </a></td>
					<td class="td2"><input id="txtEmpweight"  type="text"  class="txt c1 num"/></td>
					<td class="td1 cmbType123" style="display:none;"><span> </span><a id="lblWeightt" class="lbl"> 淨重</a></td>
					<td class="td2 cmbType123" style="display:none;"><input id="txtWeight" type="text" class="txt c1 num FEND" /></td>
					<td class="td5 cmbType123" style="display:none;"><span> </span><a id="lblGweightt" class="lbl"> 總重</a></td>
					<td class="td6 cmbType123" style="display:none;"><input id="txtGweight" type="text" class="txt c1 num FEND" /></td>
					<td class="td3 cmbType12" style="display:none;"><span> </span><a class="lbl">夾帶物</a></td>
					<td class="td4 cmbType12" style="display:none;">
					<textarea id="txtItem" class="txt c1" style="height:75px;"> </textarea>
					</td>
					<td class="td3 FEN"><span> </span><a id="lblMinusweight" class="lbl"> </a></td>
					<td class="td4 FEN"><input id="txtMinusweight" type="text" class="txt c1 num" /></td>
					<td class="td5 FEN"><span> </span><a id="lblPlusweight" class="lbl"> </a></td>
					<td class="td6 FEN"><input type="text" id="txtPlusweight" class="txt c1 num" /></td>
				<tr class="FEN">
					<td class="td1"><span> </span><a id="lblWeight" class="lbl"> </a></td>
					<td class="td2"><input id="txtWeight" type="text" class="txt c1 num FEYD" /></td>
					<td class="td3 FEN"><span> </span><a id='lblFweight' class="lbl"> </a></td>
					<td class="td8 FEN"><input id="txtFweight" type="text" class="txt c1 num" /></td>
					<td class="td5"><span> </span><a id="lblGweight" class="lbl"> </a></td>		
					<td class="td6"><input id="txtGweight" type="text" class="txt c1 num FEYD" /></td>
					<td class="td7 FEN"><span> </span><a id="lblSweight" class="lbl"> </a></td>
					<td class="td8 FEN"><input id="txtSweight" type="text" class="txt c1 num" /></td>
				</tr>
				<tr class="FEN">
					<td class="td1"><span> </span><a id="lblSize" class="lbl"> </a></td>
					<td class="td2"><input id="txtSize" type="text" class="txt c1" /></td>
					<td class="td3"><span> </span><a id='lblDime1' class="lbl"> </a></td>
					<td class="td4"><input id="txtDime1"  type="text"  class="txt c1 num"/></td>
					<td class="td5"><span> </span><a id="lblDime2" class="lbl"> </a></td>
					<td class="td6"><input id="txtDime2" type="text" class="txt c1 num" /></td>
					<td class="td7"><span> </span><a id="lblDime3" class="lbl"> </a></td>
					<td class="td8"><input id="txtDime3" type="text" class="txt c1 num" /></td>
				</tr>
				<tr class="tr6">
					<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
					<td class="td2"><input id="txtWorker"  type="text"  class="txt c1"/></td>
					<td class="td3"><span> </span><a id="lblWorker2" class="lbl"> </a></td>
					<td class="td4"><input id="txtWorker2" type="text" class="txt c1" /></td>
					<td class="td5 FEN"><input id="btnImportVcc" type="button" /></td>
					<td class="td6"></td>
					<td class="td7"></td>
					<td class="td8"></td>
				</tr>                               
			</table>
        </div>
	</div>
	<div class='dbbs'>
		<table id="tbbs" class='tbbs' style=' text-align:center'>
			<tr style='color:white; background:#003366;' >
				<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
				</td>
				<td align="center" class="td1 cmbType1" style="width:20%;display:none;"><a>進貨類型</a></td>
				<td align="center" class="td1 cmbType23" style="width:20%"><a id='lblVccno_s'> </a></td>
				<td align="center" class="td1" style="width:10%"><a id='lblDatea_s'> </a></td>
				<td align="center" class="td1 FEN" style="width:8%"><a id='lblExclude_s'> </a></td>
				<td align="center" class="td1" style="width:10%"><a id='lblWeight_s'> </a></td>
				<td align="center" class="td1 FEN" style="width:10%"><a id='lblSweight_s'> </a></td>
				<td align="center" class="td1 FEN" style="width:10%"><a id='lblPweight_s'> </a></td>
			</tr>
			<tr id="trSel.*" style='background:#cad3ff;'>
				<td style="width:1%;">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
				</td>
				<td class="cmbType1" style="display:none;"><input id="txtTypea.*" type="text" class="txt c1"/></td>
				<td class="cmbType23"><input id="txtVccno.*" type="text" class="txt c1"/></td>
				<td><input id="txtDatea.*" type="text" class="txt c1"/></td>
				<td class="FEN"><input id="chkExclude.*" type="checkbox" /></td>
				<td><input id="txtWeight.*" type="text" class="txt c1 num"/></td>
				<td class="FEN"><input id="txtSweight.*" type="text" class="txt c1 num"/></td>
				<td class="FEN">
					<input id="txtPweight.*" type="text" class="txt c1 num"/>
					<input id="txtNoq.*" type="text" style="display:none;"/>
				</td>
			</tr>
		</table>
	</div>
	<input id="q_sys" type="hidden" />
</body>
</html>