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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			var q_name = "custprices";
			var q_readonly = ['txtNoa', 'txtDatea','txtWorker','txtPrice2'];
			//var bbmNum = [['txtPrice', 10],['txtOprice', 10],['txtDiscount', 10],['txtNotaxprice', 10],['txtTaxrate', 10]];    
			var bbmNum = [];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_xchg = 1;
	q_modiDay=9999;
            brwCount2 = 20;
			aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,nick', 'txtCustno,txtComp', 'cust_b.aspx'],
            ['txtAgentno', 'lblAgent', 'agent', 'noa,agent', 'txtAgentno,txtAgent', 'agent_b.aspx'],
            ['txtProductno', 'lblProduct', 'view_ucaucc', 'noa,product,unit,saleprice', 'txtProductno,txtProduct,txtUnit,txtCost', 'ucaucc_b.aspx']);
			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
				q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
			});
			
			function sum(){
				if(!(q_cur==1 || q_cur==2))
					return;	
				var cost=q_float('txtCost');
				var tranprice=q_float('txtTranprice');
				var fee=0;
				var commission=q_float('txtCommission');
				var profit=q_float('txtProfit');
				var insurance=q_float('txtInsurance');
				var price=0;
				var precision=dec(q_getPara('vcc.pricePrecision'));	
				switch ($('#cmbPayterms').val()) {//P利潤 I保險 C佣金 F運費
					case 'C＆F'://(成本/(1-P)+F) //=CFR   
						price=round(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),precision);
						break;
					case 'C＆F＆C'://(成本/(1-P)+F)/(1-C)
						price=round(q_div(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),q_sub(1,q_div(commission,100))),precision);
						break;
					case 'C＆I': //成本/(1-P)/(1-I)
						price=round(q_div(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),q_sub(1,q_div(insurance,100))),precision);
						break;
					case 'C＆I＆C'://成本/(1-P)/(1-I)/(1-C)
						price=round(q_div(q_div(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),q_sub(1,q_div(insurance,100))),q_sub(1,q_div(commission,100))),precision);
						break;
					case 'CIF'://(成本/(1-P)+F)/(1-I)   
						price=round(q_div(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),q_sub(1,q_div(insurance,100))),precision);
						break;
					case 'CIF＆C'://(成本/(1-P)+F)/(1-I)/(1-C)
						price=round(q_div(q_div(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),q_sub(1,q_div(insurance,100))),q_sub(1,q_div(commission,100))),precision);
						break;
					case 'EXW'://成本/(1-P)
						price=round(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),precision);
						break;
					case 'FOB'://成本/(1-P)
						price=round(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),precision);
						break;
					case 'FOB＆C': //成本/(1-P)/(1-C)
						price=round(q_div(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),q_sub(1,q_div(commission,100))),precision);
						break;
					case 'FCA'://成本/(1-P)
						price=round(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),precision);
						break;
					default://(成本/(1-P)+F)/(1-I)/(1-C)
						price=round(q_div(q_div(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),q_sub(1,q_div(insurance,100))),q_sub(1,q_div(commission,100))),precision);
						break;
				}
				$('#txtPrice2').val(price);
			}
			
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				bbmMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbPayterms", q_getPara('sys.payterms'));
				
				$('#txtCost').change(function(e){sum();});
				$('#txtTranprice').change(function(e){sum();});
				$('#txtCommission').change(function(e){sum();});
				$('#txtProfit').change(function(e){sum();});
				$('#txtInsurance').change(function(e){sum();});
				$('#cmbPayterms').change(function(e){sum();});
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
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}
			function q_popPost(s1) {
				switch (s1) {
					case 'txtProductno':
                        sum();
                        break;
					default:
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('custprices_s.aspx', q_name + '_s', "500px", "500px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoq').val('001');
				$('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtBdate').val(q_date());
				refreshBbm();
				sum();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				refreshBbm();
				sum();
			}

			function btnPrint() {
				q_box("z_custprice.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa=" + $('#txtNoa').val() + ";" + r_accy, 'tgg', "95%", "95%", q_getMsg('popTgg'));
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();
			}

			function btnOk() {
				sum();
                $('#txtWorker').val(r_name);
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_custprice') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);
				refreshBbm();
			}

			function refreshBbm() {
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					//$('#txtBdate').datepicker('destroy');
				}else{
					//$('#txtBdate').datepicker();
				}
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
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 1500px;
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
				width: 850px;
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
				color: black;
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
		<div style="overflow: auto;display:block;width:1050px;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="display:none; color:black;"><a id='vewNoa'>編號</a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewBdate'>生效日期</a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewComp'>客戶</a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewAgent'>經銷商</a></td>
						<td align="center" style="width:150px; color:black;"><a id='vewProductno'>產品編號</a></td>
						<td align="center" style="width:150px; color:black;"><a id='vewProduct'>產品名稱</a></td>
						<td align="center" style="width:40px; color:black;"><a id='vewUnit'>單位</a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewCost'>銷售單價</a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewTranprice'>運費單價</a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewPayterms'>交易條件</a></td>
						<td align="center" style="width:50px; color:black;"><a id='vewCommission'>佣金%</a></td>
						<td align="center" style="width:50px; color:black;"><a id='vewProfit'>毛利%</a></td>
						<td align="center" style="width:50px; color:black;"><a id='vewInsurance'>保險%</a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewPrice2'>試算單價</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='noa' style="display:none;text-align: center;">~noa</td>
						<td id='bdate' style="text-align: center;">~bdate</td>
						<td id='comp' style="text-align: center;">~comp</td>
						<td id='agent' style="text-align: center;">~agent</td>
						<td id='productno' style="text-align: center;">~productno</td>
						<td id='product' style="text-align: center;">~product</td>
						<td id='unit' style="text-align: center;">~unit</td>
						<td id='cost,3' style="text-align: right;">~cost,3</td>
						<td id='tranprice,3' style="text-align: right;">~tranprice,3</td>
						<td id='payterms' style="text-align: center;">~payterms</td>
						<td id='commission' style="text-align: right;">~commission</td>
						<td id='profit' style="text-align: right;">~profit</td>
						<td id='insurance' style="text-align: right;">~insurance</td>
						<td id='price2,3' style="text-align: right;">~price2,3</td>
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
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl">編號</a></td>
						<td>
							<input id="txtNoa" type="text" class="txt c1"/>
							<input id="txtNoq" type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id='lblDatea' class="lbl">登錄日期</a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblBdate' class="lbl">生效日期</a></td>
						<td><input id="txtBdate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl btn">客戶</a></td>
						<td colspan="3">
							<input id="txtCustno" type="text" class="txt" style="float:left;width:40%;"/>
							<input id="txtComp" type="text" class="txt" style="float:left;width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAgent' class="lbl btn">經銷商</a></td>
						<td colspan="3">
							<input id="txtAgentno" type="text" class="txt" style="float:left;width:40%;"/>
							<input id="txtAgent" type="text" class="txt" style="float:left;width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblProduct' class="lbl btn">產品</a></td>
						<td colspan="3">
							<input id="txtProductno" type="text" class="txt" style="float:left;width:40%;"/>
							<input id="txtProduct" type="text" class="txt" style="float:left;width:60%;"/>
						</td>
						<td><span> </span><a id='lblUnit' class="lbl">單位</a></td>
						<td><input id="txtUnit" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCost' class="lbl">成本單價</a></td>
						<td><input id="txtCost" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblTranprice' class="lbl">運費單價</a></td>
						<td><input id="txtTranprice" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblNotaxprice' class="lbl">交易條件</a></td>
						<td><select id="cmbPayterms" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCommission' class="lbl">佣金%</a></td>
						<td><input id="txtCommission" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblProfit' class="lbl">毛利%</a></td>
						<td><input id="txtProfit" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblInsurance' class="lbl">保險%</a></td>
						<td><input id="txtInsurance" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPrice2' class="lbl">試算單價</a></td>
						<td><input id="txtPrice2" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblCoin' class="lbl">幣別</a></td>
						<td><select id="cmbCoin" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl">備註</a></td>
						<td colspan="5">
							<textarea id="txtMemo" style="width:100%; height:100px;"> </textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl">製單人</a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
