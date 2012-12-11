<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
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

			isEditTotal = false;
			q_tables = 's';
			var q_name = "carsal";
			var q_readonly = ['txtNoa','txtWorker','txtTranmoney','txtDrivermoney','txtBonus','txtPlus','txtMoney',
							  'txtTicket','txtLabor','txtHealth','txtMinus','txtCarborr','txtTotal','txtUnpay','txtEo'];
			var q_readonlys = ['txtMoney','txtTotal'];
			var bbmNum = [['txtTranmoney', 10, 0],['txtDrivermoney', 10, 0],['txtBonus', 10, 0],['txtPlus', 10, 0],['txtMoney', 10, 0],['txtTicket', 10, 0],
						  ['txtLabor', 10, 0],['txtHealth', 10, 0],['txtMinus', 10, 0],['txtCarborr', 10, 0],['txtTotal', 10, 0]];
			var bbsNum = [['txtTranmoney', 10, 0],['txtDrivermoney', 10, 0],['txtBonus', 10, 0],['txtPlus', 10, 0],['txtMoney', 10, 0],['txtTicket', 10, 0],
						  ['txtLabor', 10, 0],['txtHealth', 10, 0],['txtMinus', 10, 0],['txtCarborr', 10, 0],['txtTotal', 10, 0]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			q_desc = 1;
			aPop = new Array(['txtDriverno_', '', 'driver', 'noa,namea', 'txtDriverno_,txtDriver_', 'driver_b.aspx'],
							 ['txtBdriverno', '', 'driver', 'noa,namea', 'txtBdriverno,txtBdriver', 'driver_b.aspx'],
							 ['txtEdriverno', '', 'driver', 'noa,namea', 'txtEdriverno,txtEdriver', 'driver_b.aspx']);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtNoa', r_picm], ['txtMon', r_picm]];
				q_mask(bbmMask);
				 $('#btnCarsal').click(function(e) {
                	q_func('carsal.import',r_accy+','+$('#txtMon').val()+','+$('#txtBdriverno').val()+','+$('#txtEdriverno').val()+','+r_name);
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
			function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'carsal.import':
						location.reload();
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

			function btnOk() {
				$('#txtWorker').val(r_name);
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				sum();
				wrServer($('#txtNoa').val());
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;

				q_box('carsal_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				_bbsAssign();
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_'+i).text(i+1);
					
					if(!$('#txtDrivermoney_'+i).hasClass('isAssign')){
						$('#txtDrivermoney_'+i).addClass('isAssign');
						$('#txtDrivermoney_'+i).change(function(){
							sum();
						});
					}
					if(!$('#txtBonus_'+i).hasClass('isAssign')){
						$('#txtBonus_'+i).addClass('isAssign');
						$('#txtBonus_'+i).change(function(){
							sum();
						});
					}
					if(!$('#txtPlus_'+i).hasClass('isAssign')){
						$('#txtPlus_'+i).addClass('isAssign');
						$('#txtPlus_'+i).change(function(){
							sum();
						});
					}
					
					if(!$('#txtTicket_'+i).hasClass('isAssign')){
						$('#txtTicket_'+i).addClass('isAssign');
						$('#txtTicket_'+i).change(function(){
							sum();
						});
					}
					if(!$('#txtLabor_'+i).hasClass('isAssign')){
						$('#txtLabor_'+i).addClass('isAssign');
						$('#txtLabor_'+i).change(function(){
							sum();
						});
					}
					if(!$('#txtHealth_'+i).hasClass('isAssign')){
						$('#txtHealth_'+i).addClass('isAssign');
						$('#txtHealth_'+i).change(function(){
							sum();
						});
					}
					if(!$('#txtMinus_'+i).hasClass('isAssign')){
						$('#txtMinus_'+i).addClass('isAssign');
						$('#txtMinus_'+i).change(function(){
							sum();
						});
					}
					if(!$('#txtCarborr_'+i).hasClass('isAssign')){
						$('#txtCarborr_'+i).addClass('isAssign');
						$('#txtCarborr_'+i).change(function(){
							sum();
						});
					}
				}
			}

			function btnIns() {
				_btnIns();
				$('#txtDatea').val(q_date());
				$('#txtNoa').focus();
				$('#txtNoa').removeAttr('readonly');
				
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
				sum();
			}

			function btnPrint() {
				q_box('z_carsal.aspx' + "?;;;;" + r_accy, '', "90%", "600px", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['driverno']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['noa'] = abbm2['noa'];
				return true;
			}

			function sum() {
				var t_tranmoney=0,t_drivermoney=0,t_bonus=0,t_plus=0,t_money=0;
				var t_eo=0,t_ticket=0,t_labor=0,t_health=0,t_minus=0,t_carborr=0,t_total=0;		
		
				 for( i = 0; i < q_bbsCount; i++) {
					 t_tranmoney += q_float('txtTranmoney_'+i);					 
					 t_drivermoney += q_float('txtDrivermoney_'+i);
					 t_bonus += q_float('txtBonus_'+i);
					 t_plus += q_float('txtPlus_'+i);					 
					 t_money += q_float('txtDrivermoney_'+i)+q_float('txtBonus_'+i)+q_float('txtPlus_'+i);
					 $('#txtMoney_' + i).val(q_float('txtDrivermoney_'+i)+q_float('txtBonus_'+i)+q_float('txtPlus_'+i));
					 t_eo += q_float('txtEo_'+i);
					 t_ticket += q_float('txtTicket_'+i);
					 t_labor += q_float('txtLabor_'+i);
					 t_health += q_float('txtHealth_'+i);
					 t_minus += q_float('txtMinus_'+i);
					 t_carborr += q_float('txtCarborr_'+i);
				     t_total +=  q_float('txtMoney_'+i)-q_float('txtEo_'+i)-q_float('txtTicket_'+i)-q_float('txtLabor_'+i)-q_float('txtHealth_'+i)-q_float('txtMinus_'+i)-q_float('txtCarborr_'+i);
					 $('#txtTotal_' + i).val(q_float('txtMoney_'+i)-q_float('txtEo_'+i)-q_float('txtTicket_'+i)-q_float('txtLabor_'+i)-q_float('txtHealth_'+i)-q_float('txtMinus_'+i)-q_float('txtCarborr_'+i));
					// t_total += parseInt($.trim($('#txtTotal_' + i).val()).length == 0 ? '0' : $('#txtTotal_' + i).val().replace(/,/g,''), 10);				
				 }
				 

				 $('#txtTranmoney').val(t_tranmoney);
				 $('#txtDrivermoney').val(t_drivermoney);
				 $('#txtBonus').val(t_bonus);
				 $('#txtPlus').val(t_plus);
				 $('#txtMoney').val(t_money);
				 $('#txtEo').val(t_eo);
				 $('#txtTicket').val(t_ticket);
				 $('#txtLabor').val(t_labor);
				 $('#txtHealth').val(t_health);
				 $('#txtMinus').val(t_minus);
				 $('#txtCarborr').val(t_carborr);
				 $('#txtTotal').val(t_total);
			}

			function refresh(recno) {
				_refresh(recno);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(q_cur == 1 || q_cur == 2) {
                	$('.tr1').hide();
                }else{
                	$('#txtBdriverno').removeAttr('readonly').removeAttr('disabled').css('background-color','white');
                	$('#txtEdriverno').removeAttr('readonly').removeAttr('disabled').css('background-color','white');
                	$('#txtMon').removeAttr('readonly').removeAttr('disabled').css('background-color','white');
                	$('.tr1').show();
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
		</script>
		<style type="text/css">
			#dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 150px; 
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
			.tbbm .tr1{
				background-color: #FFEC8B;
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
			.dbbs {
				width: 1400px;
			}
			.tbbs a {
				font-size: medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			select {
				font-size: medium;
			}

		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'></a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNoa'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td align="center" id='noa'>~noa</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr1">
						<td class="td1"><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtMon" type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblDriver" class="lbl btn"> </a></td>
						<td class="td4">
						<input id="txtBdriverno" type="text"  class="txt c2"/>
						<input id="txtBdriver" type="text"  class="txt c3"/>
						</td>
						<td id="tdSign" style="width:1%; text-align: center;">~</td>
						<td class="td5">
						<input id="txtEdriverno" type="text"  class="txt c2"/>
						<input id="txtEdriver" type="text"  class="txt c3"/>
						</td>
						<td class="td8"> <input type="button"  id="btnCarsal" class="txt  c1"/></td>
						<td class="tdZ"> </td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtDatea" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblTranmoney" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtTranmoney" type="text" class="txt c1  num"/>
						</td>
						<td class="td3"><span> </span><a id="lblDrivermoney" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtDrivermoney" type="text" class="txt c1  num"/>
						</td>
						<td class="td5"><span> </span><a id="lblBonus" class="lbl"> </a></td>
						<td class="td6">
						<input id="txtBonus" type="text" class="txt c1  num"/>
						</td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblPlus" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtPlus" type="text" class="txt c1  num"/>
						</td>
						<td class="td3"> </td>
						<td class="td4"> </td>
						<td class="td5"><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td class="td6">
						<input id="txtMoney" type="text" class="txt c1  num"/>
						</td>
					</tr>
					<tr class="tr5">
						<td><span> </span><a id="lblEo" class="lbl"> </a></td>
						<td><input id="txtEo" type="text" class="txt c1  num"/></td>
						<td class="td1"><span> </span><a id="lblTicket" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtTicket" type="text" class="txt c1  num"/>
						</td>
						<td class="td3"><span> </span><a id="lblLabor" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtLabor" type="text" class="txt c1  num"/>
						</td>
					</tr>
					<tr class="tr6">
						<td><span> </span><a id="lblHealth" class="lbl"> </a></td>
						<td><input id="txtHealth" type="text" class="txt c1  num"/>	</td>
						<td><span> </span><a id="lblMinus" class="lbl"> </a></td>
						<td><input id="txtMinus" type="text" class="txt c1  num"/></td>
						<td><span> </span><a id="lblCarborr" class="lbl"> </a></td>
						<td><input id="txtCarborr" type="text" class="txt c1  num"/></td>
					</tr>
					<tr>
						<td>  </td>
						<td>  </td>
						<td>  </td>
						<td>  </td>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt c1  num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/>	</td>
						<td><span> </span><a id="lblLock" class="lbl"> </a></td>
						<td><input id="chkLock" type="checkbox" style="float:left;"/>	</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:120px;"><a id='lblDriver_s'></a></td>
					<td align="center" style="width:30px;"><a id='lblDay_s'></a></td>
					<td align="center" style="width:80px;"><a id='lblTranmoney_s'></a></td>
					<td align="center" style="width:80px;"><a id='lblDrivermoney_s'></a></td>
					<td align="center" style="width:80px;"><a id='lblBonus_s'></a></td>
					<td align="center" style="width:80px;"><a id='lblPlus_s'></a></td>
					<td align="center" style="width:80px;"><a id='lblMoney_s'></a></td>
					<td align="center" style="width:80px;"><a id='lblEo_s'></a></td>
					<td align="center" style="width:60px;"><a id='lblTicket_s'></a></td>
					<td align="center" style="width:60px;"><a id='lblLabor_s'></a></td>
					<td align="center" style="width:60px;"><a id='lblHealth_s'></a></td>
					<td align="center" style="width:80px;"><a id='lblMinus_s'></a></td>
					<td align="center" style="width:60px;"><a id='lblCarborr_s'></a></td>
					<td align="center" style="width:80px;"><a id='lblTotal_s'></a></td>
					<td align="center" style="width:80px;"><a id='lblUnpay_s'></a></td>
					<td align="center" style="width:150px;"><a id='lblMemo_s'></a></td>
					
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td  align="center"><input type="text" id="txtDriverno.*" style="width:40%; float:left;" />
						<input type="text" id="txtDriver.*" style="width:50%; float:left;" />
					</td>
					<td ><input type="text" id="txtDay.*" style="width:95%; text-align: right;" /></td>
					<td ><input type="text" id="txtTranmoney.*" style="width:95%; text-align: right;" /></td>
					<td ><input type="text" id="txtDrivermoney.*" style="width:95%; text-align: right;" /></td>
					<td ><input type="text" id="txtBonus.*" style="width:95%; text-align: right;" /></td>
					<td ><input type="text" id="txtPlus.*" style="width:95%; text-align: right;" /></td>
					<td ><input type="text" id="txtMoney.*" style="width:95%; text-align: right;" /></td>
					<td ><input type="text" id="txtEo.*" style="width:95%; text-align: right;" /></td>
					<td ><input type="text" id="txtTicket.*" style="width:95%; text-align: right;" /></td>
					<td ><input type="text" id="txtLabor.*" style="width:95%; text-align: right;" /></td>
					<td ><input type="text" id="txtHealth.*" style="width:95%; text-align: right;" /></td>
					<td ><input type="text" id="txtMinus.*" style="width:95%; text-align: right;" /></td>
					<td ><input type="text" id="txtCarborr.*" style="width:95%; text-align: right;" /></td>
					<td ><input type="text" id="txtTotal.*" style="width:95%; text-align: right;" /></td>
					<td ><input type="text" id="txtUnpay.*" style="width:95%; text-align: right;" /></td>
					<td ><input type="text" id="txtMemo.*" style="width:95%; text-align: right;" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
