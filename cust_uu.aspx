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
			var q_name = "cust";
			var q_readonly = ['txtWorker','txtKdate','txtSales', 'txtGrpname', 'txtUacc1', 'txtUacc2', 'txtUacc3'];
			var bbmNum = [['txtCredit', 10, 0, 1]];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 20;
			//ajaxPath = ""; // execute in Root
			aPop = new Array(['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
			, ['txtAddr_fact', '', 'view_road', 'memo,zipcode', '0txtAddr_fact,txtZip_fact', 'road_b.aspx']
			, ['txtAddr_comp', '', 'view_road', 'memo,zipcode', '0txtAddr_comp,txtZip_comp', 'road_b.aspx']
			, ['txtAddr_invo', '', 'view_road', 'memo,zipcode', '0txtAddr_invo,txtZip_invo', 'road_b.aspx']
			, ['txtAddr_home', '', 'view_road', 'memo,zipcode', '0txtAddr_home,txtZip_home', 'road_b.aspx']
			, ['txtInvestdate', 'lblInvest', 'invest', 'datea,investmemo', 'txtInvestdate,txtInvestmemo', 'invest_b.aspx']
			, ['txtGrpno', 'lblGrp', 'cust', 'noa,comp', 'txtGrpno,txtGrpname', 'cust_b.aspx']);
			$(document).ready(function() {
				bbmKey = ['noa'];
				xmlTable = 'conn';
				xmlKey = [['noa', 'noq']];
				xmlDec = [];
				q_popSave(xmlTable);
				// for conn_b.aspx
				q_brwCount();
				var t_where = "where=^^ noa='"+r_userno+"' ^^";
				q_gt('sss',t_where,0,0,0,"",r_accy);
				$('#txtNoa').focus();
			});
			function currentData() {
			}
			currentData.prototype = {
				data : [],
				/*排除的欄位,新增時不複製*/
				exclude : [],
				/*記錄當前的資料*/
				copy : function() {
					curData.data = new Array();
					for (var i in fbbm) {
						var isExclude = false;
						for (var j in curData.exclude) {
							if (fbbm[i] == curData.exclude[j]) {
								isExclude = true;
								break;
							}
						}
						if (!isExclude) {
							curData.data.push({
								field : fbbm[i],
								value : $('#' + fbbm[i]).val()
							});
						}
					}
				},
				/*貼上資料*/
				paste : function() {
					for (var i in curData.data) {
						$('#' + curData.data[i].field).val(curData.data[i].value);
					}
				}
			};
			var curData = new currentData();

			//////////////////end Ready
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
				// 1=Last 0=Top
			}/// end Main()

			function mainPost() {
				bbmMask = [['txtDuedate', r_picd]];
				q_mask(bbmMask);
				//q_cmbParse("cmbTypea", q_getPara('cust.typea_uu'));
				q_gt('custtype', '', 0, 0, 0, "custtype");
				q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbTask",'0@否,1@是');
				
				 $('#btnConn').click(function() {
				 	if(q_cur==1){
				 		return;
				 	}else{
						t_where = "noa='" + $('#txtNoa').val() + "'";
						q_box("conn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'conn', "95%", "650px", q_getMsg('btnConn'));
					}
				});
				$('#txtNoa').change(function(e){
					$(this).val($.trim($(this).val()).toUpperCase());		
					if($(this).val().length>0){
						if((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())){
							//t_where="where=^^ noa='"+$(this).val()+"'^^";
							//q_gt('cust', t_where, 0, 0, 0, "checkCustno_change", r_accy);
							$('#cmbTypea').val($('#txtNoa').val().substring(0,1));
						}else{
							Lock();
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
							Unlock();
						}
					}
				});
				
				$('#txtComp').change(function(e){
					if(emp($('#txtComp').val()))
						$('#txtInvoicetitle').val($('#txtComp').val());
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
					case 'custtype':
						var as = _q_appendData("custtype", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].namea);
							}
							q_cmbParse("cmbTypea", t_item);
							if(abbm[q_recno])
								$("#cmbTypea").val(abbm[q_recno].typea);
						}
						break;
 					case 'checkCustno_change':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined){
							alert('已存在 '+as[0].noa+' '+as[0].comp);
						}
						break;
					case 'AutoCustno_btnOk_1'://新客戶
						var as = _q_appendData("cust", "", true);
						var maxnumber=0;//目前最大值
						var autonumber='0000';//流水編號
						if (as[0] != undefined){
							for ( var i = 0; i < as.length; i++) {
							if(maxnumber<parseInt(as[i].noa.substring(as[i].noa.length-autonumber.length,as[i].noa.length)))
								maxnumber=as[i].noa.substring(as[i].noa.length-autonumber.length,as[i].noa.length)
							}
						}
						maxnumber=autonumber+(parseInt(maxnumber)+1);
						maxnumber=maxnumber.substring(maxnumber.length-autonumber.length,maxnumber.length);
						
						$('#txtNoa').val($('#txtNoa').val()+maxnumber);
						
						wrServer($('#txtNoa').val());
						break;
					case 'AutoCustno_btnOk_2'://新分店
						var as = _q_appendData("cust", "", true);
						var maxnumber=0;//目前最大值
						var autonumber='000';//流水編號
						if (as[0] != undefined){
							for ( var i = 0; i < as.length; i++) {
							if(maxnumber<parseInt(as[i].noa.substring(as[i].noa.length-autonumber.length,as[i].noa.length)))
								maxnumber=as[i].noa.substring(as[i].noa.length-autonumber.length,as[i].noa.length)
							}
						}
						maxnumber=autonumber+(parseInt(maxnumber)+1);
						maxnumber=maxnumber.substring(maxnumber.length-autonumber.length,maxnumber.length);
						
						$('#txtNoa').val($('#txtNoa').val()+maxnumber);
						
						wrServer($('#txtNoa').val());
						break;
					case 'sss':
						var as = _q_appendData("sss", "", true);
						if (as[0] == undefined || (as[0].issales=='false') || (as[0].issales==false) ){
							q_gt(q_name, q_content, q_sqlCount, 1);
						}else{
							q_content = "where=^^ salesno='" +r_userno+ "'^^";
							q_gt(q_name, q_content, q_sqlCount, 1);							
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
				 		break;
				} /// end switch
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('cust_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function combPaytype_chg() {
				var cmb = document.getElementById("combPaytype");
				if (!q_cur)
					cmb.value = '';
				else
					$('#txtPaytype').val(cmb.value);
				cmb.value = '';
			}

			function btnIns() {
				if($('#Copy').is(':checked')){
					curData.copy();
				}
				_btnIns();
				if($('#Copy').is(':checked')){
					curData.paste();
				}
				refreshBbm();
				$('#txtNoa').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;

				_btnModi();
				refreshBbm();
				$('#txtComp').focus();
			}

			function btnPrint() {
				q_box("z_custp_uu.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa=" + $('#txtNoa').val() + ";" + r_accy, 'cust', "95%", "95%", q_getMsg('popCust'));
			}
			 function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();
			}
			function btnOk() {
				Lock(); 
				$('#txtNoa').val($.trim($('#txtNoa').val())); 	
				if((/^(\w+|\w+\u002D\w+)$/g).test($('#txtNoa').val())){
				}else{
					alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
					Unlock();
					return;
				}
				var t_err='';
				if (dec($('#txtCredit').val()) > 9999999999)
					t_err = t_err + q_getMsg('msgCreditErr ') + '\r';

				if (dec($('#txtGetdate').val()) > 31)
					t_err = t_err + q_getMsg("lblGetdate") + q_getMsg("msgErr") + '\r';
					
				if(t_err.length>0){
					alert(t_err);
					Unlock();
					return;
				}
				
				if(q_cur==1){
					$('#txtKdate').val(q_date());
					$('#txtWorker').val(r_name);
				}
				
				if(q_cur==1){
					//分辨產生新客戶或分店
					if($('#txtNoa').val().length==2){
						t_where="where=^^ noa like '"+$('#txtNoa').val()+"%' and len(noa)=6 ^^";
						q_gt('cust', t_where, 0, 0, 0, "AutoCustno_btnOk_1", r_accy);//新客戶
					}else if($('#txtNoa').val().length==6){
						t_where="where=^^ noa like '"+$('#txtNoa').val()+"%' and len(noa)>6^^";
						q_gt('cust', t_where, 0, 0, 0, "AutoCustno_btnOk_2", r_accy);//新分店
					}else{
						var t_err="建立新客戶編號不正確\r"
						t_err=t_err+"1.新客戶請輸入兩碼：第一碼為客戶類別；第二碼為區域別\r";
						t_err=t_err+"2.新分店請輸入六碼：六碼為客戶(總店)編號"
						alert(t_err);
						Unlock();
						return;
					}					
				}else{
					wrServer($('#txtNoa').val());
				}
			}

			function wrServer(key_value) {
				var i;

				xmlSql = '';
				if (q_cur == 2)/// popSave
					xmlSql = q_preXml();

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);
				refreshBbm();
			}
			function refreshBbm(){
				if(q_cur==1){
					$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
				}else{
					$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
				}
			}
			
			var vccitopen=true;
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (vccitopen&&t_para&&window.parent.q_name == 'vcc' &&(q_getPara('sys.comp').indexOf('英特瑞')>-1 || q_getPara('sys.comp').indexOf('安美得')>-1)) {
						btnIns();
						vccitopen=false;
						$('#txtNoa').val(window.parent.post_custno);
				}
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
				width: 38%;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 60%;
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
				/*width: 9%;*/
			}
			.tbbm .tdZ {
				/*width: 2%;*/
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
			.tbbm select {
				font-size: medium;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
				float: left;
			}
			.txt.c4 {
				width: 18%;
				float: left;
			}
			.txt.c6 {
				width: 49%;
				float: left;
			}
			.txt.c7 {
				width: 99%;
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
		<div id='dmain' style="overflow:hidden;width:1250px;">
			<div class="dview" id="dview" style="float: left; width:300px;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:25%"><a id='vewNoa'></a></td>
						<td align="center" style="width:40%"><a id='vewComp'></a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 900px;float: left;">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='5'>
					<tr style="height:1px;">
						<td style="width: 150px;"> </td>
						<td style="width: 150px;"> </td>
						<td style="width: 150px;"> </td>
						<td style="width: 150px;"> </td>
						<td style="width: 150px;"> </td>
						<td style="width: 150px;"> </td>
					</tr>
					<tr class="tr1">
						<td class="td1"><span> </span><a id='lblNoa' class="lbl"></a></td>
						<td class="td2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblSerial' class="lbl"></a></td>
						<td class="td4"><input id="txtSerial" type="text" class="txt c1"/></td>
						<td class="td5">
							<div style="float:left;">	<input id="Copy" type="checkbox" />	<span> </span><a id="lblCopy"></a></div>
							<span> </span><a id='lblWorker' class="lbl"> </a>
						</td>
						<td class="td6">
							<input id="txtKdate" type="text" class="txt c6"/>
							<input id="txtWorker" type="text" class="txt c6"/>
						</td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id='lblComp' class="lbl"></a></td>
						<td class="td2" colspan='3'><input id="txtComp" type="text" class="txt c7"/></td>
						<td class="td5"><span> </span><a id='lblNick' class="lbl"></a></td>
						<td class="td6"><input id="txtNick" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id='lblBoss' class="lbl"></a></td>
						<td class="td2"><input id="txtboss" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblHead' class="lbl"></a></td>
						<td class="td4"><input id="txthead" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id='lblStatus' class="lbl"></a></td>
						<td class="td6"><input id="txtStatus" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblType' class="lbl"></a></td>
						<td class="td2"><select id="cmbTypea" class="txt c1"></select></td>
						<td class="td3"><span> </span><a id='lblTeam' class="lbl"></a></td>
						<td class="td4"><input id="txtTeam" type="text" class="txt c1"/></td>
						<td class="td5" style="text-align:right;"><input id="btnConn" type="button" /></td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id='lblTel' class="lbl"></a></td>
						<td class="td2" colspan='3' ><input id="txtTel" type="text" class="txt c7"/></td>
						<td class="td5"><span> </span><a id='lblMobile' class="lbl"></a></td>
						<td class="td6"><input id="txtMobile" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id='lblFax' class="lbl"></a></td>
						<td class="td2" colspan='3'><input id="txtFax" type="text" class="txt c7"/></td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id='lblInvoicetitle' class="lbl"> </a></td>
						<td class="td2" colspan='3'><input id="txtInvoicetitle" type="text" class="txt c7"/></td>
						<td class="td5"><span> </span><a id='lblTask' class="lbl"></a></td>
						<td class="td6"><select id="cmbTask" class="txt c1"></select></td>
					</tr>
					<tr class="tr8">
						<td class="td1"><span> </span><a id='lblAddr_fact' class="lbl"></a></td>
						<td class="td2"><input id="txtZip_fact" type="text" class="txt c1"></td>
						<td class="td3" colspan='4'><input id="txtAddr_fact" type="text" class="txt c7"/></td>
					</tr>
					<tr class="tr9">
						<td class="td1"><span> </span><a id='lblAddr_comp' class="lbl"></a></td>
						<td class="td2"><input id="txtZip_comp" type="text" class="txt c1"/></td>
						<td class="td3" colspan='4'><input id="txtAddr_comp" type="text" class="txt c7"/></td>
					</tr>
					<tr class="tr10">
						<td class="td1"><span> </span><a id='lblAddr_invo' class="lbl"></a></td>
						<td class="td2"><input id="txtZip_invo" type="text" class="txt c1"/></td>
						<td class="td3" colspan='4'><input id="txtAddr_invo" type="text" class="txt c7"/></td>
					</tr>
					<tr class="tr11">
						<td class="td1"><span> </span><a id='lblAddr_home' class="lbl"></a></td>
						<td class="td2"><input id="txtZip_home" type="text" class="txt c1"/></td>
						<td class="td3" colspan='4'><input id="txtAddr_home" type="text" class="txt c7"/></td>
					</tr>
					<tr class="tr12">
						<td class="td1"><span> </span><a id='lblEmail' class="lbl"></a></td>
						<td class="td2" colspan='3'><input id="txtEmail" type="text" class="txt c7"/></td>
					</tr>
					<tr class="tr13">
						<td class="td1"><span> </span><a id="lblSales" class="lbl btn"></a></td>
						<td class="td2">
							<input id="txtSalesno" type="text" class="txt c6"/>
							<input id="txtSales"	type="text" class="txt c6"/>
						</td>
						<td class="td3"><span> </span><a id="lblCredit" class="lbl" ></a></td>
						<td class="td4"><input id="txtCredit" type="text" class="txt c1 num"/></td>
						<td class="td5"><span> </span><a id='lblStartdate' class="lbl"> </a></td>
						<td class="td6"><input id="txtStartdate" type="text" class="txt c1" />	</td>
					</tr>
					<tr class="tr14">
						<td class="td1"><span> </span><a id='lblChkstatus' class="lbl"></a></td>
						<td class="td2"><input id="txtChkstatus" type="text" class="txt c1" /></td>
						<td class="td3"><span> </span><a id='lblChkdate' class="lbl"></a></td>
						<td class="td4"><input id="txtChkdate" type="text" class="txt c1" /></td>
						<td class="td5"><span> </span><a id='lblTrantype' class="lbl"></a></td>
						<td class="td6"><select id="cmbTrantype" class="txt c1"></select></td>
					</tr>
					<tr class="tr15">
						<td class="td1"><span> </span><a id='lblPaytype' class="lbl"></a></td>
						<td class="td2">
							<input id="txtPaytype" type="text" class="txt" style="width: 129px;"/>
							<select id="combPaytype" class="txt" style="width: 20px;" onchange='combPaytype_chg()'></select>
						</td>
						<td class="td3"><span> </span><a id='lblGetdate' class="lbl"></a></td>
						<td class="td4"><input id="txtGetdate" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id='lblDueday' class="lbl"> </a></td>
						<td class="td6"><input id="txtDueday" type="text" class="txt num c1"/></td>
					</tr>
					<tr class="tr16">
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
						<td class="td2" colspan='5'>
							<textarea id="txtMemo" rows='5' cols='10' style="width:99%; height: 50px;"></textarea>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>