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
			var q_name = "cng";
			var q_readonly = ['txtNoa','txtTgg','txtCardeal','txtStorein','txtStore','txtNamea', 'txtWorker', 'txtWorker2', 'txtTranstart', 'txtAddr'];
			var q_readonlys = [];
			var bbmNum = [['txtPrice', 10, 0, 1], ['txtTranmoney', 15, 0, 1]];
			var bbsNum = [['txtMount', 15, 2, 1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(
				//['txtPost', 'lblPost', 'addr', 'post,addr', 'txtPost', 'addr_b.aspx'],
				['txtPost', 'lblPost', 'addr', 'noa,post', 'txtPost,txtAddr', 'addr2_b.aspx'],
				['txtTranstartno', 'lblTranstart', 'addr2', 'noa,post','txtTranstartno,txtTranstart', 'addr2_b.aspx'],
				['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
				['txtRackno', 'lblRackno', 'rack', 'noa,rack,storeno,store', 'txtRackno', 'rack_b.aspx'],
				['txtStoreinno', 'lblStorein', 'store', 'noa,store', 'txtStoreinno,txtStorein', 'store_b.aspx'],
				['txtRackinno', 'lblRackinno', 'rack', 'noa,rack,storeno,store', 'txtRackinno', 'rack_b.aspx'],
				['txtTggno', 'lblTgg', 'tgg', 'noa,nick', 'txtTggno,txtTgg', 'tgg_b.aspx'],
				['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product,unit,spec', 'txtProductno_,txtProduct_,txtUnit_,txtSpec_', 'ucaucc_b.aspx'],
				['txtMemo', '', 'qphr', 'noa,phr', '0,txtMemo', ''],
				['txtSssno', 'lblSssno', 'sss', 'noa,namea', 'txtSssno,txtNamea', 'sss_b.aspx']
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
				mainForm(1);
			}

			function mainPost() {
				if(q_getPara('sys.comp').indexOf('英特瑞')>-1 || q_getPara('sys.comp').indexOf('安美得')>-1|| q_getPara('sys.comp').indexOf('永勝')>-1) {
					bbsNum = [['txtMount', 15, 0, 1]];
				}
				q_getFormat();
				bbmMask = [['txtDatea', r_picd]];
				// bbsMask = [['txtClass', r_picd]]; //102/10/31 製造業(醫療 食品)當成有效日 12/10格式自己打
				q_mask(bbmMask);
				q_cmbParse("cmbTranstyle", q_getPara('sys.transtyle'));
				q_cmbParse("cmbTypea", q_getPara('cng.typea'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				$('#txtPrice').change(function() {
					sum();
				});
				$('#txtPost').change(function(){
					GetTranPrice();
				});
				$('#txtTranstartno').change(function(){
					GetTranPrice();
				});
				$('#txtCardealno').change(function(){
					GetTranPrice();
					//取得車號下拉式選單
					var thisVal = $(this).val();
					var t_where = "where=^^ noa=N'" + thisVal + "' ^^";
					q_gt('cardeal', t_where, 0, 0, 0, "getCardealCarno");
				});
				$('#cmbTranstyle').change(function(){
					GetTranPrice();
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
			
			function q_popPost(s1) {
				switch (s1) {
					case 'txtCardealno':
						//取得車號下拉式選單
						var thisVal = $('#txtCardealno').val();
						var t_where = "where=^^ noa=N'" + thisVal + "' ^^";
						q_gt('cardeal', t_where, 0, 0, 0, "getCardealCarno");
						GetTranPrice();
						break;
					case 'txtPost':
						GetTranPrice();
						break;
					case 'txtTranstartno':
						GetTranPrice();
						break;	
				}
			}

			function GetTranPrice(){
				var Post = $.trim($('#txtPost').val()); 
				var Cardealno = $.trim($('#txtCardealno').val()); 
				var TranStyle = $.trim($('#cmbTranstyle').val());
				var Transtartno = $.trim($('#txtTranstartno').val()); 
				var t_where = 'where=^^ 1=1 ';
				t_where += " and post=N'" + Post + "' ";
				t_where += " and transtartno=N'" + Transtartno + "' ";
				t_where += " and cardealno=N'" + Cardealno + "' ";
				t_where += " and transtyle=N'" + TranStyle + "' ";
				t_where += ' ^^';
				q_gt('addr', t_where, 0, 0, 0, "GetTranPrice");
			}
			
			
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'getCardealCarno' :
						var as = _q_appendData("cardeals", "", true);
						var t_item = " @ ";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].carno + '@' + as[i].carno;
							}
						}
						document.all.combCarno.options.length = 0;
						q_cmbParse("combCarno", t_item);
						$('#combCarno').unbind('change').change(function(){
							if (q_cur == 1 || q_cur == 2) {
								$('#txtCarno').val($('#combCarno').find("option:selected").text());
								
							}
						});
						break;
					case 'GetTranPrice' :
						var as = _q_appendData("addr", "", true);
						if (as[0] != undefined) {
							$('#txtPrice').val(as[0].driverprice2);
						}else{
							$('#txtPrice').val(0);
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtDatea', q_getMsg('lblDatea')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				if(showRack()){
					var thisRackno = $.trim($('#txtRackno').val());
					var thisStoreno = $.trim($('#txtStoreno').val());
					var thisRackinno = $.trim($('#txtRackinno').val());
					var thisStoreinno = $.trim($('#txtStoreinno').val());
					if(thisStoreno.length > 0 && thisRackno.length ==0){
						alert(q_chkEmpField([['txtRackno', q_getMsg('lblRackno')]]));
						return;
					}
					if(thisStoreinno.length > 0 && thisRackinno.length ==0){
						alert(q_chkEmpField([['txtRackinno', q_getMsg('lblRackinno')]]));
						return;
					}
				}
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cng') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('cng_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#txtMount_' + i).click(function() {
							sum();
						});
					}
				}
				_bbsAssign();
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
				if(q_getPara('sys.comp').indexOf('英特瑞')>-1 || q_getPara('sys.comp').indexOf('安美得')>-1) {
					$('.class_it').show();
				} else {
					$('.class_it').hide();
				}
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				//判斷是否由撥料作業轉來>>鎖定欄位
				if(!emp($('#txtWorkkno').val()) || !emp($('#txtWorklno').val())){
					$('#cmbTypea').attr('disabled', 'disabled');
					$('#txtDatea').attr('disabled', 'disabled');
					$('#txtStoreno').attr('disabled', 'disabled');
					$('#txtStoreinno').attr('disabled', 'disabled');
					$('#lblStorek').css('display', 'inline').text($('#lblStore').text());
					$('#lblStoreink').css('display', 'inline').text($('#lblStorein').text());
					$('#lblStore').css('display','none');
					$('#lblStorein').css('display','none');
					
					$('#btnPlus').attr('disabled', 'disabled');
					for (var j = 0; j < q_bbsCount; j++) {
						$('#btnMinus_'+j).attr('disabled', 'disabled');
						$('#txtProductno_'+j).attr('disabled', 'disabled');
						$('#btnProductno_'+j).attr('disabled', 'disabled');
						$('#txtProduct_'+j).attr('disabled', 'disabled');
						$('#txtUnit_'+j).attr('disabled', 'disabled');
						$('#txtSpec_'+j).attr('disabled', 'disabled');
						$('#txtMount_'+j).attr('disabled', 'disabled');
					}
				}
				
				$('#txtProduct').focus();
				//取得車號下拉式選單
				var thisVal = $('#txtCardealno').val();
				var t_where = "where=^^ noa=N'" + thisVal + "' ^^";
				q_gt('cardeal', t_where, 0, 0, 0, "getCardealCarno");
				if(q_getPara('sys.comp').indexOf('英特瑞')>-1 || q_getPara('sys.comp').indexOf('安美得')>-1) {
					$('.class_it').show();
				} else {
					$('.class_it').hide();
				}
			}

			function btnPrint() {
				var hasStyle = q_getPara('sys.isstyle');
				if(hasStyle=='1'){
					q_box('z_cng_ra.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
				}else{
					q_box('z_cngp.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
				}
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
				as['tggno'] = abbm2['tggno'];
				as['typea'] = abbm2['typea'];
				as['storeno'] = abbm2['storeno'];
				as['storeinno'] = abbm2['storeinno'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				$('#lblStore').css('display','inline');
				$('#lblStorein').css('display','inline');
				$('#lblStorek').css('display', 'none');
				$('#lblStoreink').css('display', 'none');
				
				if(q_getPara('sys.comp').indexOf('英特瑞')>-1 || q_getPara('sys.comp').indexOf('安美得')>-1) {
					$('.class_it').show();
					$('.it').css('text-align','left');
				} else {
					$('.class_it').hide();
				}
				showRack();
			}

			function showRack(){
				var hasRackComp = q_getPara('sys.rack');
				var isRack = (hasRackComp==1?true:false);
				if(isRack== true){
					$('.isRack').show();
				}else{
					$('.isRack').hide();
				}
				return isRack;
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
				var hasSpec = q_getPara('sys.isspec');
				var isSpec = (hasSpec.toString()=='1'?$('.isSpec').show():$('.isSpec').hide());
				showRack();
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
				if(!emp($('#txtWorkkno').val())){
					alert("該調撥單由撥料作業("+$('#txtWorkkno').val()+")轉來，請至撥料作業刪除!!!")
					return;
				}
				
				if(!emp($('#txtWorklno').val())){
					alert("該調撥單由委外撥料作業("+$('#txtWorklno').val()+")轉來，請至委外撥料作業刪除!!!")
					return;
				}
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}

			function sum() {
				var total = 0;
				for (var j = 0; j < q_bbsCount; j++) {
					total += dec($('#txtMount_' + j).val());
				}
				q_tr('txtTranmoney', total * dec($('#txtPrice').val()));
			}

		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 98%;
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
				width: 98%;
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
				width: 10%;
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
			.txt.c5 {
				width: 80%;
				float: left;
			}
			.txt.c6 {
				width: 49%;
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
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.dbbs {
				width: 100%;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1px;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: lightgrey;
				width: 100%;
			}
			.dbbs .tbbs tr {
				height: 35px;
			}
			.dbbs .tbbs tr td {
				text-align: center;
				border: 2px lightgrey double;
			}
			.dbbs .tbbs select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="width: 1260px;">
			<div class="dview" id="dview" style="float: left; width:500px;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:15%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewStore'> </a></td>
						<td align="center" style="width:25%"><a id='vewStorein'> </a></td>
						<td align="center" style="width:25%"><a id='vewTgg'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='store,8' class="it">~store,8</td>
						<td align="center" id='storein,8' class="it">~storein,8</td>
						<td align="center" id='tgg,8' class="it">~tgg,8</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 760px;float:left">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='0'>
					<tr class="tr1">
						<td class='td1'><span> </span><a id="lblType" class="lbl" > </a></td>
						<td class="td2"><select id="cmbTypea" class="txt c1"></select></td>
						<td class='td3'><span> </span><a id="lblDatea" class="lbl" > </a></td>
						<td class="td4"><input id="txtDatea" type="text" class="txt c1"/></td>
						<td class='td5'><span> </span><a id="lblNoa" class="lbl" > </a></td>
						<td class="td6"><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr2">
						<td class='td3'>
							<span> </span><a id="lblStore" class="lbl btn"> </a>
							<a id="lblStorek" class="lbl btn" style="display: none"> </a>
						</td>
						<td class="td4"><input id="txtStoreno" type="text" class="txt c1"/></td>
						<td class="td4" colspan="2"><input id="txtStore" type="text" class="txt c1"/></td>
						<td class='td3 isRack'><span> </span><a id="lblRackno" class="lbl btn"> </a></td>
						<td class="td4 isRack"><input id="txtRackno" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr3">
						<td class="td5"><span> </span><a id="lblStorein" class="lbl btn"> </a>
							<a id="lblStoreink" class="lbl btn" style="display: none"> </a>
						</td>
						<td class="td6"><input id="txtStoreinno" type="text" class="txt c1"/></td>
						<td class="td6" colspan="2"><input id="txtStorein" type="text" class="txt c1"/></td>
						<td class='td3 isRack'><span> </span><a id="lblRackinno" class="lbl btn"> </a></td>
						<td class="td4 isRack"><input id="txtRackinno" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr3">
						<td class='td1'><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtTggno" type="text" class="txt c1"/></td>
						<td class="td2" colspan="2"><input id="txtTgg" type="text" class="txt c1"/></td>
						<td class='td1'><span> </span><a id="lblTrantype" class="lbl" > </a></td>
						<td class="td2"><select id="cmbTrantype" class="txt c1"></select></td>
					</tr>
					<tr class="tr4">
						<td class='td1'><span> </span><a id="lblCardeal" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtCardealno" type="text" class="txt c1"/></td>
						<td class="td3" colspan="2"><input id="txtCardeal" type="text" class="txt c1"/></td>
						<td class='td5'><span> </span><a id="lblCarno" class="lbl" > </a></td>
						<td class="td6">
							<input id="txtCarno" type="text" class="txt" style="width:75%;"/>
							<select id="combCarno" style="width: 20%;"> </select>
						</td>
					</tr>
					<tr>
						<td class='td1'><span> </span><a id="lblTranstart" class="lbl btn" > </a></td>
						<td class="td2" ><input id="txtTranstartno" type="text" class="txt c1"/></td>
						<td class="td3" colspan="2"><input id="txtTranstart" type="text" class="txt c1"/></td>
						<td class='td5'><span> </span><a id="lblTranstyle" class="lbl" > </a></td>
						<td class="td6"><select id="cmbTranstyle" style="width: 100%;"> </select></td>
					</tr>
					<tr class="tr5">
						<td class='td1'><span> </span><a id="lblPost" class="lbl btn" > </a></td>
						<td class="td2" ><input id="txtPost" type="text" class="txt c1"/></td>
						<td class="td3" colspan="2"><input id="txtAddr" type="text" class="txt c1"/></td>
						<td class='td5'><span> </span><a id="lblPrice" class="lbl" > </a></td>
						<td class="td6"><input id="txtPrice" type="text" class="txt c1 num"/></td>
						
					</tr>
					<tr class="tr5">
						<td class='td1'><span> </span><a id="lblSssno" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtSssno" type="text" class="txt c1"/></td>
						<td class="td3" colspan="2"><input id="txtNamea" type="text" class="txt c1"/></td>
						<td class='td5'><span> </span><a id="lblTranmoney" class="lbl" > </a></td>
						<td class="td6"><input id="txtTranmoney" type="text" class="txt c1 num"/></td>
					</tr>
					<tr class="tr7">
						<td class='td1'><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="td2" colspan='5'><textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea>
							<input id="txtWorkkno" type="hidden" /><input id="txtWorklno" type="hidden" />
						</td>
					</tr>
					<tr class="tr5">
						<td class='td1'><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="td2"><input id="txtWorker" type="text" class="txt c1"/></td>
						<td class="td3"><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1260px;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
					<td style="width:40px;" align="center">
						<input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
					</td>
					<td style="width:200px;" align="center"><a id='lblProductnos'> </a></td>
					<td style="width:230px;" align="center"><a id='lblProducts'> </a></td>
					<td style="width:40px;" align="center"><a id='lblUnit'> </a></td>
					<td style="width:95px;" align="center" class="isStyle"><a id='lblStyle'> </a></td>
					<td style="width:100px;" align="center"><a id='lblMounts'> </a></td>
					<td style="width:100px;" align="center" class="class_it"><a id='lblClass'> </a></td>
					<td style="width:400px;"align="center"><a id='lblMemos'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td>
						<input id="txtProductno.*" type="text" style="width:80%;" />
						<input class="btn" id="btnProductno.*" type="button" value='.' style="width:15%;" />
					</td>
					<td>
						<input class="txt c1" id="txtProduct.*" type="text"/>
						<input class="txt c1 isSpec" id="txtSpec.*" type="text"/>
					</td>
					<td><input class="txt c1" id="txtUnit.*" type="text" /></td>
					<td class="isStyle"><input class="txt c1" id="txtStyle.*" type="text" /></td>
					<td><input class="txt num c1" id="txtMount.*" type="text"/></td>
					<td class="class_it"><input class="txt c1" id="txtClass.*" type="text"/></td>
					<td>
						<input class="txt c1" id="txtMemo.*" type="text"/>
						<input id="txtNoq.*" type="hidden" />
						<input id="recno.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>