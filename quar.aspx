<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
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
			q_copy=1;
			q_desc = 1;
			q_tables = 's';
			var q_name = "quar";
			var decbbs = ['price', 'weight', 'mount', 'total', 'dime', 'width', 'lengthb', 'c1', 'notv', 'theory'];
			var decbbm = ['money', 'tax', 'total', 'weight', 'floata', 'mount', 'price', 'totalus'];
			var q_readonly = ['txtNoa','txtWorker', 'txtComp', 'txtAcomp', 'txtSales', 'txtWorker2'];
			var q_readonlys = ['txtNo3'];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 15;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(
				['txtProductno_', 'btnProduct_', 'ucx', 'noa,product,unit,spec', 'txtProductno_,txtProduct_,txtUnit_,txtSpec_', 'ucx_b.aspx'],
				['txtCustno', 'lblCust', 'cust', 'noa,nick,paytype,trantype,tel,fax,zip_comp,addr_comp', 'txtCustno,txtComp,txtPaytype,cmbTrantype,txtTel,txtFax,txtPost,txtAddr', 'cust_b.aspx'],
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no3'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
				q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function sum() {
				var t1 = 0, t_unit, t_mount=0, t_weight = 0, t_total = 0;
				for (var j = 0; j < q_bbsCount; j++) {
					t_mount = q_add(t_mount, q_float('txtMount_' + j));
					t_weight = q_add(t_weight, q_float('txtWeight_' + j));
					t_total = q_add(t_total, q_float('txtTotal_' + j));
				}
				q_tr('txtMount', t_total);
				q_tr('txtWeight',t_weight);
				q_tr('txtTotal', t_total);
				q_tr('txtTotalus', q_mul(q_float('txtTotal'), q_float('txtFloata')));
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtOdate', r_picd]];
				q_mask(bbmMask);
				bbmNum = [['txtTotal', 15, 0, 1],['txtTotalus', 15, 2, 1], ['txtFloata', 11, 5, 1],['txtMount', 15, q_getPara('vcc.mountPrecision'), 1],['txtWeight', 15, q_getPara('vcc.weightPrecision'), 1]];
				bbsNum = [['txtMount', 10, q_getPara('vcc.mountPrecision'), 1],['txtMount', 10, q_getPara('vcc.weightPrecision'), 1]
				, ['txtPrice', 10, q_getPara('vcc.pricePrecision'), 1]	, ['txtTotal', 15, 0, 1]];
				
				q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbPayterms", q_getPara('sys.payterms'));
				q_cmbParse("combPayterms", q_getPara('sys.payterms'));
				var t_where = "where=^^ 1=0 ^^";
				q_gt('custaddr', t_where, 0, 0, 0, "");

				$('#txtFloata').change(function() {
					sum();
				});
				$('#txtTotal').change(function() {
					sum();
				});
				$('#txtAddr').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}
				});
				$('#txtAddr2').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}
				});

				$('#txtCustno').change(function() {
					if (!emp($('#txtCustno').val())) {
						var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
						q_gt('custaddr', t_where, 0, 0, 0, "");
					}
				});
				$('#chkCancel').click(function(){
					if($(this).prop('checked')){
						for(var k=0;k<q_bbsCount;k++){
							$('#chkCancel_'+k).prop('checked',true);
						}
					}
				});
				
			}

			function q_boxClose(s2) {
				var
				ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			var focus_addr = '';
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
					case 'flors_coin':
						var as = _q_appendData("flors", "", true);
						var z_coin='';
						for ( i = 0; i < as.length; i++) {
							z_coin+=','+as[i].coin;
						}
						if(z_coin.length==0) z_coin=' ';
						
						q_cmbParse("cmbCoin", z_coin);
						if(abbm[q_recno])
							$('#cmbCoin').val(abbm[q_recno].coin);
						
						break;
					case 'custaddr':
						var as = _q_appendData("custaddr", "", true);
						var t_item = " @ ";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].post + '@' + as[i].addr;
							}
						}
						document.all.combAddr.options.length = 0;
						q_cmbParse("combAddr", t_item);
						break;
					case 'cust':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined && focus_addr != '') {
							$('#' + focus_addr).val(as[0].addr_fact);
							focus_addr = '';
						}
						break;
					case 'flors':
						var as = _q_appendData("flors", "", true);
						if (as[0] != undefined) {
							q_tr('txtFloata',as[0].floata);
							sum();
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
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCust')], ['txtOdate', q_getMsg('lblOdate')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				//1030419 當專案沒有勾 BBM的取消和結案被打勾BBS也要寫入
				if(!$('#chkIsproj').prop('checked')){
					for (var j = 0; j < q_bbsCount; j++) {
						if($('#chkEnda').prop('checked'))
							$('#chkEnda_'+j).prop('checked','true');
					}
				}
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				if (q_cur == 2)
					$('#txtWorker2').val(r_name);
					
				sum();

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_quar') + (!emp($('#txtDatea').val())?$('#txtDatea').val():q_date()), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;

				q_box('quar_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
			}

			function combPay_chg() {
				var cmb = document.getElementById("combPay")
				if (!q_cur)
					cmb.value = '';
				else
					$('#txtPaytype').val(cmb.value);
				cmb.value = '';
			}
			
			function coin_chg() {
				var t_where = "where=^^ ('" + $('#txtOdate').val() + "' between bdate and edate) and coin='"+$('#cmbCoin').find("option:selected").text()+"' ^^";
				q_gt('flors', t_where, 0, 0, 0, "");
			}

			function combAddr_chg() {
				if (q_cur == 1 || q_cur == 2) {
					$('#txtAddr2').val($('#combAddr').find("option:selected").text());
					$('#txtPost2').val($('#combAddr').find("option:selected").val());
				}
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtUnit_' + j).change(function() {
							sum();
						});
						$('#txtMount_' + j).change(function() {
							sum();
						});
						$('#txtWeight_' + j).change(function () {
							sum();
						});
						$('#txtPrice_' + j).change(function() {
							sum();
						});
						$('#btnVccrecord_' + j).click(function() {
							t_IdSeq = -1;
							/// 要先給 才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							//t_where = "cust='" + $('#txtCustno').val() + "' and noq='" + $('#txtProductno_' + b_seq).val() + "'";
							t_where = "custno='" + $('#txtCustno').val() + "' and comp='" + $('#txtComp').val() + "' and productno='" + $('#txtProductno_' + b_seq).val() + "' and product='" + $('#txtProduct_' + b_seq).val() + "'";
							q_box("z_vccrecord.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vccrecord', "95%", "95%", q_getMsg('lblRecord_s'));
						});
						
						$('#btnGetprice_'+j).click(function() {
							$('#div_getprice').show();
						});
					}
				}
				_bbsAssign();
				HiddenField();
			}

			function btnIns() {
				_btnIns();
								
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtOdate').val(q_date());
				$('#txtDatea').val(q_cdn(q_date(), 3));
				
				$('#txtDatea').focus();

				$('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);

				if (!emp($('#txtCustno').val())) {
					var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
					q_gt('custaddr', t_where, 0, 0, 0, "");
				}
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtProduct').focus();

				if (!emp($('#txtCustno').val())) {
					var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
					q_gt('custaddr', t_where, 0, 0, 0, "");
				}
			}

			function btnPrint() {
					q_box('z_quarp.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['datea'] = abbm2['datea'];
				as['odate'] = abbm2['odate'];
				as['custno'] = abbm2['custno'];
				as['apv'] = abbm2['apv'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				HiddenField();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#combAddr').attr('disabled', 'disabled');
				} else {
					$('#combAddr').removeAttr('disabled');
				}
			}
			
			function HiddenField(){
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

			function q_popPost(s1) {
				switch (s1) {
					case 'txtCustno':
						if (!emp($('#txtCustno').val())) {
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}
						break;
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
				/*margin: -1px;
				 border: 1px black solid;*/
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
				/*width: 10%;*/
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
			.txt.c4 {
				width: 25%;
				float: left;
			}
			.txt.c5 {
				width: 72%;
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
				width: auto;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
			}
			.dbbs {
				width: 100%;
			}
			.tbbs a {
				font-size: medium;
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
			.tbbs tr.error input[type="text"] {
				color: red;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
		</style>
	</head>
	<body>
		<div id="div_getprice" style="position:absolute; top:300px; left:500px; display:none; width:600px; background-color: #FFE7CD; ">
			<table id="table_stkcost" class="table_row" style="width:100%;" cellpadding='1' cellspacing='0'>
				<tr style="height: 1px;">
					<td align="center" width="100px"> </td>
					<td align="center" width="100px"> </td>
					<td align="center" width="100px"> </td>
					<td align="center" width="100px"> </td>
					<td align="center" width="100px"> </td>
					<td align="center" width="100px"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">產品</a></td>
					<td align="center" colspan="2"><input id="textProductno" type="text" class="txt c1" disabled="disabled"/></td>
					<td align="center" colspan="3"><input id="textProduct" type="text" class="txt c1" disabled="disabled"/></td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">單位</a></td>
					<td align="center"><input id="textUnit" type="text" class="txt c1" disabled="disabled"/></td>
					<td align="center"><a class="lbl">產品成本</a></td>
					<td align="center"><input id="textCost" type="text" class="txt num c1"/></td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">單位重</a></td>
					<td align="center"><input id="textUweight" type="text" class="txt num c1"/></td>
					<td align="center"><a class="lbl">包裝方式</a></td>
					<td align="center"><input id="textPackwayno" type="text" class="txt c1"/></td>
					<td align="center" colspan="2"><input id="textPackwayname" type="text" class="txt c1"/></td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">Inner</a></td>
					<td align="center"><input id="textInner" type="text" class="txt num c1" disabled="disabled"/></td>
					<td align="center"><a class="lbl">Outer</a></td>
					<td align="center"><input id="textOuter" type="text" class="txt num c1" disabled="disabled"/></td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">CBM/CTN</a></td>
					<td align="center"><input id="textCbm" type="text" class="txt num c1" disabled="disabled"/></td>
					<td align="center"><a class="lbl">CUFT/CTN</a></td>
					<td align="center"><input id="textCuft" type="text" class="txt num c1" disabled="disabled"/></td>
				</tr>
				<tr style="background-color: #E7FFCD; " >
					<td align="center"><a class="lbl">運費選擇</a></td>
					<td align="center" colspan="5"> </td>
				</tr>
				<tr style="background-color: #E7FFCD; " >
					<td align="center">
						<input type="radio" name="trantype" value="cy" checked> 
						<a class="lbl">CY $</a>
					</td>
					<td align="center"><input id="textCyprice" type="text" class="txt num c1"/></td>
					<td align="center"><a class="lbl">CBM</a></td>
					<td align="center"><input id="textCycbm" type="text" class="txt num c1"/></td>
					<td align="center" colspan="2"> </td>
				</tr>
				<tr style="background-color: #E7FFCD; ">
					<td align="center">
						<input type="radio" name="trantype" value="kg">
						<a class="lbl">KG $</a>
					</td>
					<td align="center"><input id="textKgprice" type="text" class="txt num c1"/></td>
					<td align="center">
						<input type="radio" name="trantype" value="cuft">
						<a class="lbl">Cuft $</a>
					</td>
					<td align="center"><input id="textCuftprice" type="text" class="txt num c1"/></td>
					<td align="center" colspan="2"> </td>
				</tr>
				<tr style="background-color: #E7CDFF; ">
					<td align="center"><a class="lbl">運費成本</a></td>
					<td align="center"><input id="textTranPrice" type="text" class="txt num c1"/></td>
					<td align="center"><a class="lbl">其他支出</a></td>
					<td align="center"><input id="textFee" type="text" class="txt num c1"/></td>
					<td align="center"><a class="lbl">成本合計</a></td>
					<td align="center"><input id="textCost2" type="text" class="txt num c1"/></td>
				</tr>
				<tr style="background-color: #EC7DD2; ">
					<td align="center"><a class="lbl">Profit</a></td>
					<td align="center"><input id="textProfit" type="text" class="txt num c1" style="width: 70%"/>&nbsp; %</td>
					<td align="center"><input id="textProfitmoney" type="text" class="txt num c1"/></td>
					<td align="center" colspan="3"> </td>
				</tr>
				<tr style="background-color: #EC7DD2; ">
					<td align="center"><a class="lbl">Insurance</a></td>
					<td align="center"><input id="textInsurance" type="text" class="txt num c1" style="width: 70%"/>&nbsp; %</td>
					<td align="center"><input id="textInsurmoney" type="text" class="txt num c1"/></td>
					<td align="center"><a class="lbl">Commission</a></td>
					<td align="center"><input id="textCommission" type="text" class="txt num c1" style="width: 70%"/>&nbsp; %</td>
					<td align="center"><input id="textCommimoney" type="text" class="txt num c1"/></td>
				</tr>
				<tr style="background-color: #52EDFC;">
					<td align="center"><a class="lbl">價格條件</a></td>
					<td align="center"><select id="combPayterms" class="txt c1"> </select></td>
					<td align="center"><a class="lbl">試算單價</a></td>
					<td align="center"><input id="textCost3" type="text" class="txt num c1"/></td>
					<td align="center" colspan="2"> </td>
				</tr>
				<tr>
					<td align="center" colspan='6'>
						<input id="btnOk_div_getprice" type="button" value="回寫單價">
						<input id="btnClose_div_getprice" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;width: 1270px;">
			<div class="dview" id="dview">
				<table class="tview" id="tview"	>
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='custno comp,4'>~custno ~comp,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm" style="width: 872px;">
					<tr class="tr0" style="height: 1px;">
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
					</tr>
					<tr class="tr1">
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="3"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td><input id="txtOdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr2">
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td><input id="txtCno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtAcomp" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td colspan="3"><input id="txtContract" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr3">
						<td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td><input id="txtCustno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtComp" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblConn' class="lbl"> </a></td>
						<td colspan="3"><input id="txtConn" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr4">
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan='3'><input id="txtTel"	type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td colspan='3'><input id="txtFax" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr5">
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td><input id="txtPost" type="text" class="txt c1"></td>
						<td colspan='6' ><input id="txtAddr" type="text" class="txt c1" /></td>
					</tr>
					<tr class="tr6">
						<td><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td><input id="txtPost2" type="text" class="txt c1"/></td>
						<td colspan='6' >
							<input id="txtAddr2" type="text" class="txt c1" style="width: 625px;"/>
							<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'> </select>
						</td>
					</tr>
					<tr class="tr7">
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td><select id="cmbTrantype" class="txt c1" name="D1" > </select></td>
						<td><span> </span><a id='lblBdock' class="lbl"> </a></td>
						<td colspan="2"><input id="txtBdock" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblEdock' class="lbl"> </a></td>
						<td colspan="2"><input id="txtEdock" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr7">
						<td><span> </span><a id='lblPayterms' class="lbl"> </a></td>
						<td><select id="cmbPayterms" class="txt c1"> </select></td>
						<td><span> </span><a id='lblVia' class="lbl"> </a></td>
						<td colspan="2"><input id="txtVia" type="text" class="txt c1"/></td>
						<!--<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td colspan="2"><input id="txtPrice" type="text" class="txt c1 num"/></td>-->
					</tr>
					<tr class="tr7">
						<td><span> </span><a id='lblProfit' class="lbl"> </a></td>
						<td><input id="txtProfit" type="text" class="txt c5 num"/><a>&nbsp; %</a></td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtPaytype" type="text" class="txt c1" style="width: 190px;"/>
							<select id="combPaytype" class="txt c1" onchange='combPay_chg()' style="width: 25px;"> </select>
						</td>
						<td><span> </span><a id='lblSales' class="lbl btn"> </a></td>
						<td><input id="txtSalesno" type="text" class="txt c1"/></td>
						<td><input id="txtSales" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr7">
						<td><span> </span><a id='lblInsurance' class="lbl"> </a></td>
						<td><input id="txtInsurance" type="text" class="txt c5 num" /><a>&nbsp; %</a></td>
						<td><span> </span><a id='lblCommission' class="lbl"> </a></td>
						<td><input id="txtCommission" type="text" class="txt c5 num"/><a>&nbsp; %</a></td>
						<td> </td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><select id="cmbCoin" class="txt c1" onchange='coin_chg()'> </select></td>
						<td><input id="txtFloata" type="text" class="txt c1 num"/></td>
					</tr>
					<tr class="tr8">
						<td><span> </span><a id='lblMount' class="lbl"> </a></td>
						<td  colspan='2'><input id="txtMount" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td colspan='2'><input id="txtWeight" type="text" class="txt c1 num"/></td>
					</tr>
					<tr class="tr9">
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td colspan='2'><input id="txtTotal" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td colspan='2'><input id="txtTotalus"	type="text" class="txt c1 num"/></td>
					</tr>
					<tr class="tr10">
						<td align="right">
							<span> </span><a id='lblMemo' class="lbl"> </a>
						</td>
						<td colspan='7' >
							<textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea>
						</td>
					</tr>
					<tr class="tr11">
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1" /></td>
						<td> </td>
						<td> </td>
						<td colspan="2">
							<input id="chkEnda" type="checkbox"/>
							<span> </span><a id='lblEnda'> </a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1260px;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:40px;"><input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" /></td>
					<td align="center" style="width:40px;"><a id='lblNo3_s'> </a></td>
					<td align="center" style="width:180px;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblGetprice_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblPackway_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblWeight_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblTotal_s'> </a></td>
					<td align="center"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblEnda_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td><input id="txtNo3.*" type="text" class="txt c1" /></td>
					<td align="center">
						<input id="txtProductno.*" type="text" class="txt c1" style="width: 85%;" />
						<input class="btn" id="btnProduct.*" type="button" value='.' style=" font-weight: bold;" />
					</td>
					<td>
						<input id="txtProduct.*" type="text" class="txt c1"/>
						<input id="txtSpec.*" type="text" class="txt c1 isSpec"/>
					</td>
					<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td><input id="txtPrice.*" type="text" class="txt c1 num"/></td>
					<td align="center"><input class="btn" id="btnGetprice.*" type="button" value='.' style=" font-weight: bold;"/></td>
					<td><input id="txtPackway.*" type="text" class="txt c1"/></td>
					<td><input id="txtWeight.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtTotal.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
					<td align="center"><input id="chkEnda.*" type="checkbox"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
