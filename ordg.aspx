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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			q_desc = 1;
			q_tables = 's';
			var q_name = "ordg";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2', 'txtComp', 'txtAcomp', 'txtTgg', 'txtOrdeno', 'txtOrdcno'];
			var q_readonlys = ['txtProfit'];
			var bbmNum = [['txtTaxrate', 15, 2, 1], ['txtFloata', 15, 4, 1], ['txtBfloat', 15, 4, 1]];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'datea';
			brwCount2 = 6;
			aPop = new Array(
				['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,spec,unit,unit', 'txtProductno_,txtProduct_,txtSpec_,txtUnit_,txtBunit_,txtProduct_', 'ucc_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
				['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
				['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
			);
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
				$('#txtDatea').focus();
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function sum() {
				var t1 = 0, t_unit, t_mount, t_weight = 0;
				for (var j = 0; j < q_bbsCount; j++) {
					bbs_sum(j);
					bbs_bsum(j);	
				}
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', '9999/99/99']];
				q_mask(bbmMask);
				bbsNum = [['txtPrice', 15, q_getPara('vcc.pricePrecision'), 1], ['txtMount', 15, q_getPara('vcc.mountPrecision'), 1], ['txtWeight', 15, q_getPara('vcc.weightPrecision'), 1], ['txtTotal', 15, 0, 1]
								,['txtBprice', 15, q_getPara('vcc.pricePrecision'), 1], ['txtBmount', 15, q_getPara('vcc.mountPrecision'), 1], ['txtBweight', 15, q_getPara('vcc.weightPrecision'), 1], ['txtBtotal', 15, 0, 1]];
				q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_cmbParse("cmbBcoin", q_getPara('sys.coin'));
				q_cmbParse("cmbTypea", q_getPara('ordg.typea'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				
				$('#lblOrdeno').click(function() {
					if(!emp($('#txtOrdeno').val()))
						q_box('orde.aspx' + "?;;;noa='" + trim($('#txtOrdeno').val()) + "';" + (dec($('#txtDatea').val().substr(0,4))-1911), '', "95%", "95%", q_getMsg("popOrde"));
				});
				
				$('#lblOrdcno').click(function() {
					if(!emp($('#txtOrdcno').val()))
						q_box('ordc.aspx' + "?;;;noa='" + trim($('#txtOrdcno').val()) + "';" + (dec($('#txtDatea').val().substr(0,4))-1911), '', "95%", "95%", q_getMsg("popOrdc"));
				});
				
				$('#lblInvono').click(function() {
					if(!emp($('#txtInvono').val()) &&q_cur!=1 &&q_cur!=2)
						q_box('invo.aspx' + "?;;;noa='" + trim($('#txtInvono').val()) + "';" + (dec($('#txtDatea').val().substr(0,4))-1911), '', "95%", "95%", q_getMsg("popInvo"));
				});
				
				$('#lblInvoino').click(function() {
					if(!emp($('#txtInvoino').val()) &&q_cur!=1 &&q_cur!=2)
						q_box('invoi.aspx' + "?;;;noa='" + trim($('#txtInvoino').val()) + "';" + (dec($('#txtDatea').val().substr(0,4))-1911), '', "95%", "95%", q_getMsg("popInvoi"));
				});
				
				$('#cmbTaxtype').change(function() {
					if($('#cmbTaxtype').val()=='1' || $('#cmbTaxtype').val()=='3')
						$('#txtTaxrate').val(q_getPara('sys.taxrate'));
					else 
						$('#txtTaxrate').val(0);
					Taxtype_change();
				});
			}
			
			function Taxtype_change(){
				if(q_cur==1 || q_cur==2){
					if($('#cmbTaxtype').val()=='1' || $('#cmbTaxtype').val()=='3'){
		            	$('#txtTaxrate').css('color','black').css('background','white').removeAttr('readonly');
		            }else{
		            	$('#txtTaxrate').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
		            }
	           }
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

			var z_cno = r_cno, z_acomp = r_comp, z_nick = r_comp.substr(0, 2);
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'cno_acomp':
						var as = _q_appendData("acomp", "", true);
						if (as[0] != undefined) {
							z_cno = as[0].noa;
							z_acomp = as[0].acomp;
							z_nick = as[0].nick;
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function btnOk() {
				t_err = '';
				if($('#cmbTypea').val()=='1'){
					t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtDatea', q_getMsg('lblDatea')]]);
				}else{
					t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtDatea', q_getMsg('lblDatea')], ['txtInvono', q_getMsg('lblInvono')], ['txtInvoino', q_getMsg('lblInvoino')]]);
				}
				
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				sum();

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ordg') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}
			
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				if(q_cur != 2)
					q_func('qtxt.query.u2', 'ordg.txt,post,' + encodeURI($('#txtNoa').val()) + ';1;'+q_getPara('sys.key_orde')+';'+q_getPara('sys.key_ordc')+';'+r_userno+';'+r_name+';'+q_getPara('sys.dateformat')+';'+q_getPara('vcc.pricePrecision')+';'+q_getPara('rc2.pricePrecision'));//新增,修改
			}
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.u1':
						//呼叫workf.post
						q_func('qtxt.query.u2', 'ordg.txt,post,' + encodeURI($('#txtNoa').val()) + ';1;'+q_getPara('sys.key_orde')+';'+q_getPara('sys.key_ordc')+';'+r_userno+';'+r_name+';'+q_getPara('sys.dateformat')+';'+q_getPara('vcc.pricePrecision')+';'+q_getPara('rc2.pricePrecision'));//新增,修改
						break;
					case 'qtxt.query.u2':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							abbm[q_recno]['ordeno'] = as[0].ordeno;
							abbm[q_recno]['ordcno'] = as[0].ordcno;
							$('#txtOrdeno').val(as[0].ordeno);
							$('#txtOrdcno').val(as[0].ordcno);
						}
						break;
					case 'qtxt.query.u3':
						_btnOk($('#txtNoa').val(), bbmKey[0], ( bbsHtm ? bbsKey[1] : ''), '', 3)
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('ordg_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtMount_'+j).change(function() {
							var n = $(this).attr('id').split('_')[1];
							bbs_sum(n);
						});
						$('#txtWeight_'+j).change(function() {
							var n = $(this).attr('id').split('_')[1];
							bbs_sum(n);
						});
						$('#txtPrice_'+j).change(function() {
							var n = $(this).attr('id').split('_')[1];
							bbs_sum(n);
						});
						$('#txtTotal_'+j).change(function() {
							var n = $(this).attr('id').split('_')[1];
							bbs_sum(n);
						});
						
						$('#txtBmount_'+j).change(function() {
							var n = $(this).attr('id').split('_')[1];
							bbs_bsum(n);
						});
						$('#txtBweight_'+j).change(function() {
							var n = $(this).attr('id').split('_')[1];
							bbs_bsum(n);
						});
						$('#txtBprice_'+j).change(function() {
							var n = $(this).attr('id').split('_')[1];
							bbs_bsum(n);
						});
						$('#txtBtotal_'+j).change(function() {
							var n = $(this).attr('id').split('_')[1];
							bbs_bsum(n);
						});
					}
				}
				_bbsAssign();
				field_hide();
			}
			
			function bbs_sum(seq) {
				if(q_float('txtPrice_'+seq)!=0){
					var t_unit = $.trim($('#txtUnit_' + seq).val()).toUpperCase();
					if(t_unit=='KG' || t_unit=='M2' || t_unit=='M' || t_unit=='批' || t_unit=='公斤' || t_unit=='噸' || t_unit=='頓'){
						q_tr('txtTotal_'+seq,q_mul(q_float('txtWeight_'+seq),q_float('txtPrice_'+seq)));
					}else{
						q_tr('txtTotal_'+seq,q_mul(q_float('txtMount_'+seq),q_float('txtPrice_'+seq)));
					}
				}
				q_tr('txtProfit_'+seq,q_sub(q_float('txtTotal_'+seq),q_float('txtBtotal_'+seq)));
			}
			
			function bbs_bsum(seq) {
				if(q_float('txtBprice_'+seq)!=0){
					var t_unit = $.trim($('#txtBunit_' + seq).val()).toUpperCase();
					if(t_unit=='KG' || t_unit=='M2' || t_unit=='M' || t_unit=='批' || t_unit=='公斤' || t_unit=='噸' || t_unit=='頓'){
						q_tr('txtBtotal_'+seq,q_mul(q_float('txtBweight_'+seq),q_float('txtBprice_'+seq)));
					}else{
						q_tr('txtBtotal_'+seq,q_mul(q_float('txtBmount_'+seq),q_float('txtBprice_'+seq)));
					}
				}
				q_tr('txtProfit_'+seq,q_sub(q_float('txtTotal_'+seq),q_float('txtBtotal_'+seq)));
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);
				
				var t_date,t_year,t_month,t_day;
				t_date = new Date();
				t_year = t_date.getUTCFullYear();
				t_month = t_date.getUTCMonth()+1;
				t_month = t_month>9?t_month+'':'0'+t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day>9?t_day+'':'0'+t_day;
				$('#txtDatea').val(t_year+'/'+t_month+'/'+t_day);
				
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
			}

			function btnPrint() {
                /*var t_where = "noa='" + $.trim($('#txtNoa').val()) + "'";
                q_box("z_ordep.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));*/
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				xmlSql = '';
				if (q_cur == 2)
					xmlSql = q_preXml();
					
				if(q_cur == 2)
					q_func('qtxt.query.u1', 'ordg.txt,post,' + encodeURI($('#txtNoa').val()) + ';0;'+q_getPara('sys.key_orde')+';'+q_getPara('sys.key_ordc')+';'+r_userno+';'+r_name+';'+q_getPara('sys.dateformat')+';'+q_getPara('vcc.pricePrecision')+';'+q_getPara('rc2.pricePrecision'));

				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] && !as['product'] && !as['spec'] && !dec(as['total'])) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();

				if (!emp(abbm2['datea']))
					as['datea'] = abbm2['datea'];

				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				field_hide();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					
				} else {
					
				}	
				
				field_hide();
				Taxtype_change();
			}
			
			function field_hide() {
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
				var hasSpec = q_getPara('sys.isspec');
				var isSpec = (hasSpec.toString()=='1'?$('.isSpec').show():$('.isSpec').hide());
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
				//_btnDele();
				if (!confirm(mess_dele))
					return;
				q_cur = 3;
				q_func('qtxt.query.u3', 'ordg.txt,post,' + encodeURI($('#txtNoa').val()) + ';0;'+q_getPara('sys.key_orde')+';'+q_getPara('sys.key_ordc')+';'+r_userno+';'+r_name+';'+q_getPara('sys.dateformat')+';'+q_getPara('vcc.pricePrecision')+';'+q_getPara('rc2.pricePrecision'));//刪除
			}

			function btnCancel() {
				_btnCancel();
			}

			function q_popPost(s1) {
				switch (s1) {
					
				}
			}
			
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 30%;
				border-width: 0px;
			}
			.tview {
				width: 100%;
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
				width: 70%;
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
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 48%;
				float: left;
			}
			.txt.c3 {
				width: 50%;
				float: left;
			}
			.txt.c6 {
				width: 25%;
			}
			.txt.c7 {
				width: 95%;
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
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;width: 1260px;">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
						<!--<td align="center" style="width:25%"><a id='vewNoa'> </a></td>-->
						<td align="center" style="width:30%"><a id='vewComp'> </a></td>
						<td align="center" style="width:30%"><a id='vewTgg'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<!--<td align="center" id='noa'>~noa</td>-->
						<td align="center" id='comp,4'>~comp,4</td>
						<td align="center" id='tgg,4'>~tgg,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm" style="width: 872px;">
					<tr class="tr1" style="height: 0px">
						<td class="td1" style="width: 108px;"> </td>
						<td class="td2" style="width: 108px;"> </td>
						<td class="td3" style="width: 108px;"> </td>
						<td class="td4" style="width: 108px;"> </td>
						<td class="td5" style="width: 108px;"> </td>
						<td class="td6" style="width: 108px;"> </td>
						<td class="td7" style="width: 108px;"> </td>
						<td class="td8" style="width: 108px;"> </td>
					</tr>
					<tr class="tr1">
						<td class="td1"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td2"><input id="txtDatea" type="text" class="txt c1"/></td>
						<td class="td3" > </td>
						<td class="td4"> </td>
						<td class="td5"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td6" colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td class="td8" align="center"> </td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtCno" type="text" class="txt c1"/></td>
						<td class="td3" colspan="2"><input id="txtAcomp" type="text" class="txt c1"/></td>
						<td class="td5" ><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td class="td6"  colspan="2"><input id="txtContract" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtCustno" type="text" class="txt c1"/></td>
						<td class="td3" colspan="2"><input id="txtComp" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id="lblCoin" class="lbl btn"> </a></td>
						<td class="td6"><select id="cmbCoin" class="txt c1"> </select></td>
						<td class="td7"><input id="txtFloata" type="text" class="txt num c1" /></td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtTggno" type="text" class="txt c1"/></td>
						<td class="td3" colspan="2"><input id="txtTgg" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id="lblBcoin" class="lbl btn"> </a></td>
						<td class="td6"><select id="cmbBcoin" class="txt c1"> </select></td>
						<td class="td7"><input id="txtBfloat" type="text" class="txt num c1" /></td>
					</tr>
					<tr class="tr4">
						<td class="td1" ><span> </span><a id='lblManu' class="lbl"> </a></td>
						<td class="td2" colspan="3"><input id="txtManu" type="text" class="txt c1"/></td>
						<td class="td5" ><span> </span><a id='lblTaxtype' class="lbl"> </a></td>
						<td class="td6"><select id="cmbTaxtype" class="txt c1"> </select></td>
						<td class="td7" ><span> </span><a id='lblTaxrate' class="lbl"> </a></td>
						<td class="td8"><input id="txtTaxrate" type="text" class="txt c1 num" style="width: 80%;"/>%</td>
					</tr>
					<tr class="tr5">
						<td class="td1" ><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td class="td2"><select id="cmbTypea" class="txt c1"> </select></td>
						<td class="td3"> </td>
						<td class="td4"> </td>
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2"><input id="txtWorker" type="text" class="txt c1" /></td>
						<td class="td3"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td class="td4"><input id="txtWorker2" type="text" class="txt c1" /></td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id="lblOrdeno" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtOrdeno" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblOrdcno" class="lbl btn"> </a></td>
						<td class="td4"><input id="txtOrdcno" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id="lblInvono" class="lbl btn"> </a></td>
						<td class="td6"><input id="txtInvono" type="text" class="txt c1"/></td>
						<td class="td7"><span> </span><a id="lblInvoino" class="lbl btn"> </a></td>
						<td class="td8"><input id="txtInvoino" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id='lblMemo' class='lbl'> </a></td>
						<td class="td2" colspan='7'>
							<textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1860px;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1'>
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:25px;">
						<input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;" />
					</td>
					<td style="width:20px;"> </td>
					<td align="center" style="width:160px;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblProduct_s'> </a><a class="isSpec">/</a><a id='lblSpec_s' class="isSpec"> </a></td>
					<td align="center" style="width:95px;" class="isStyle"><a id='lblStyle_s'> </a></td>
					<td align="center" style="width:75px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblWeight_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblTotal_s'> </a></td>
					<td align="center" style="width:75px;"><a id='lblBunit_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblBmount_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblBweight_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblBprice_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblBtotal_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblProfit_s'> </a></td>
					<td align="center" style="width:175px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" class="btn" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="hidden" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input class="btn" id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width: 10px;" />
						<input id="txtProductno.*" type="text" class="txt c1" style="width:83%;" />
					</td>
					<td>
						<input id="txtProduct.*" type="text" class="txt c1"/>
						<input id="txtSpec.*" type="text" class="txt c1 isSpec"/>
					</td>
					<td class="isStyle"><input id="txtStyle.*" type="text" class="txt c1 isStyle"/></td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td><input id="txtMount.*" type="text" class="txt num c1" /></td>
					<td><input id="txtWeight.*" type="text" class="txt num c1" /></td>
					<td><input id="txtPrice.*" type="text" class="txt num c1" /></td>
					<td><input id="txtTotal.*" type="text" class="txt num c1" /></td>
					<td><input id="txtBunit.*" type="text" class="txt c1"/></td>
					<td><input id="txtBmount.*" type="text" class="txt num c1" /></td>
					<td><input id="txtBweight.*" type="text" class="txt num c1" /></td>
					<td><input id="txtBprice.*" type="text" class="txt num c1" /></td>
					<td><input id="txtBtotal.*" type="text" class="txt num c1" /></td>
					<td><input id="txtProfit.*" type="text" class="txt num c1" /></td>
					<td>
						<input id="txtMemo.*" type="text" class="txt c1"/>
						<input id="recno.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>