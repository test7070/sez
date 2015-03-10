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

			var q_name = "tgg";
			var q_readonly = ['txtWorker', 'txtKdate', 'txtUacc1', 'txtUacc2', 'txtUacc3'];
			var bbmNum = [['txtDueday', 10, 0]];
			var bbmMask = [['txtChkdate', '999/99/99'], ['txtStartdate', '99'], ['txtGetdate', '99']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 21;
			aPop = new Array(
				['txtInvestdate', 'lblInvest', 'invest', 'datea,investmemo', 'txtInvestdate,txtInvestmemo', 'invest_b.aspx'], 
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'], 
				['txtBankno', 'lblBank', 'bank', 'noa,bank', 'txtBankno,txtBank', 'bank_b.aspx'], 
				['txtAddr_fact', '', 'view_road', 'memo,zipcode', '0txtAddr_fact,txtZip_fact', 'road_b.aspx'], 
				['txtAddr_comp', '', 'view_road', 'memo,zipcode', '0txtAddr_comp,txtZip_comp', 'road_b.aspx'], 
				['txtAddr_invo', '', 'view_road', 'memo,zipcode', '0txtAddr_invo,txtZip_invo', 'road_b.aspx'], 
				['txtAddr_home', '', 'view_road', 'memo,zipcode', '0txtAddr_home,txtZip_home', 'road_b.aspx'],
				['txtUacc4', 'lblUacc4', 'acc', 'acc1,acc2', 'txtUacc4', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
			);
			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
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

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				q_mask(bbmMask);
				mainForm(0);
			}

			function mainPost() {
				if(q_getPara('sys.project').toUpperCase()=='RA'){
					q_cmbParse("cmbTypea", q_getPara('tgg_ra.typea'));
				}else{
					q_cmbParse("cmbTypea", q_getPara('tgg.typea'));
				}
				q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				$('#txtNoa').change(function(e) {
					$(this).val($.trim($(this).val()).toUpperCase());
					if ($(this).val().length > 0) {
						if ((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())) {
							t_where = "where=^^ noa='" + $(this).val() + "'^^";
							q_gt('tgg', t_where, 0, 0, 0, "checkTggno_change", r_accy);
						} else {
							Lock();
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。' + String.fromCharCode(13) + 'EX: A01、A01-001');
							Unlock();
						}
					}
				});
				$("#cmbTypea").focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				});
				$("#cmbTrantype").focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				});
				$("#combPaytype").change(function(e) {
					if (q_cur == 1 || q_cur == 2)
						$('#txtPaytype').val($('#combPaytype').find(":selected").text());
				});
				$("#txtPaytype").focus(function(e) {
					var n = $(this).val().match(/[0-9]+/g);
					var input = document.getElementById("txtPaytype");
					if ( typeof (input.selectionStart) != 'undefined' && n != null) {
						input.selectionStart = $(this).val().indexOf(n);
						input.selectionEnd = $(this).val().indexOf(n) + n.length + 1;
					}
				});
				$('#btnConn').click(function() {
					if (q_cur == 1) {
						return;
					}
					t_where = "noa='" + $('#txtNoa').val() + "'";
					q_box("conn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'conn', "95%", "650px", q_getMsg('lblConn'));
				});
				
				$('#txtComp').change(function() {
					if (q_cur==1 && q_getPara('sys.project').toUpperCase()=='XY'){
						//讀羅馬拼音
						var t_where = "where=^^ ['"+$('#txtComp').val() +"')  ^^";
						q_gt('cust_xy', t_where, 0, 0, 0, "XY_getpy", r_accy);	
						return;
					}
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
					case 'checkTggno_change':
						var as = _q_appendData("tgg", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].comp);
						}
						break;
					case 'checkTggno_btnOk':
						var as = _q_appendData("tgg", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].comp);
							Unlock();
							return;
						} else {
							wrServer($('#txtNoa').val());
						}
						break;
					case 'XY_getpy':
						var as = _q_appendData("cust", "", true);
						if(as[0] != undefined){
							var tmp=as[0].Column1;
							//排除特殊字元
							tmp=replaceAll(as[0].Column1,"'","");
							tmp=replaceAll(as[0].Column1," ","");
							tmp=replaceAll(as[0].Column1,".","");
							tmp=replaceAll(as[0].Column1,"(","");
							tmp=replaceAll(as[0].Column1,"+","");
							tmp=replaceAll(as[0].Column1,"-","");
							tmp=replaceAll(as[0].Column1,"*","");
							tmp=replaceAll(as[0].Column1,"/","");
							tmp=replaceAll(as[0].Column1,"~","");
							tmp=replaceAll(as[0].Column1,"!","");
							tmp=replaceAll(as[0].Column1,"@","");
							tmp=replaceAll(as[0].Column1,"#","");
							tmp=replaceAll(as[0].Column1,"$","");
							tmp=replaceAll(as[0].Column1,"%","");
							tmp=replaceAll(as[0].Column1,"^","");
							tmp=replaceAll(as[0].Column1,"&","");
							
							tmp=tmp+'ZZ';
							
							$('#txtNoa').val(tmp.substr(0,2));
						}
						break;
					case 'btnOk_xy_checkNoa2':
						var as = _q_appendData("tgg", "", true);
						if (as[0] != undefined) {
							var t_seq=as[(as.length-1)].noa.substr(-2);
							t_seq=('00'+(dec(t_seq)+1)).substr(-2);
							
							$('#txtNoa').val(trim($('#txtNoa').val())+t_seq);
						}else{
							$('#txtNoa').val(trim($('#txtNoa').val())+'01');
						}
						wrServer($('#txtNoa').val());
						Unlock();
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
				q_box('tgg_s.aspx', q_name + '_s', "500px", "300px", q_getMsg("popSeek"));
			}

			function btnIns() {
				if ($('#Copy').is(':checked')) {
					curData.copy();
				}
				_btnIns();
				refreshBbm();
				if ($('#Copy').is(':checked')) {
					curData.paste();
				}
				$('#Copy').removeAttr('checked');
				$('#txtNoa').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				refreshBbm();
				$('#txtNoa').attr('readonly', 'readonly');
				$('#txtComp').focus();
			}

			function btnPrint() {
				if (q_getPara('sys.comp').indexOf('永勝') > -1) {
					q_box("z_tggp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa=" + $('#txtNoa').val() + ";" + r_accy, 'tgg', "95%", "95%", q_getMsg('popTgg'));
				} else {
					q_box("z_label.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";tgg=" + $('#txtNoa').val() + ";" + r_accy, 'z_label', "95%", "95%", q_getMsg('popZ_label'));
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();
			}

			function btnOk() {
				if ($('#txtChkdate').val().length > 0 && !q_cd($('#txtChkdate').val())){
					alert(q_getMsg('lblChkdate') + '錯誤。');
					return;
				}
				
				if($('#txtStartdate').val()>'31'){
					alert(q_getMsg("lblStartdate")+'最大天數為31日');
					return;
				}
				
				if($('#txtGetdate').val()>'31'){
					alert(q_getMsg("lblGetdate")+'最大天數為31日');
					return;
				}
					
				$('#txtKdate').val(q_date());
				$('#txtWorker').val(r_name);
				var t_noa = trim($('#txtNoa').val()).toUpperCase();
				if (t_noa.length == 0) {
					alert(q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]));
					return;
				}
				
				if (q_getPara('sys.project').toUpperCase()=='XY'){
					$('#txtConntel').val($('#textGqbtitle').val())
					$('#txtExt').val($('#textInvo').val())
					$('#txtPost').val($('#textPost').val())
				}
				
				if (q_cur==1 && q_getPara('sys.project').toUpperCase()=='XY'){
					//取得最新流水號
					var t_noa = trim($('#txtNoa').val());
					var t_where = "where=^^ left(noa,"+(t_noa.length)+")='" + t_noa + "' and len(noa)="+(t_noa.length+2)+" ^^";
					q_gt('tgg', t_where, 0, 0, 0, "btnOk_xy_checkNoa2", r_accy);
					Lock();
					return;
				}
						
				if (q_cur == 1) {
					t_where = "where=^^ noa='" + t_noa + "'^^";
					q_gt('tgg', t_where, 0, 0, 0, "checkTggno_btnOk", r_accy);
				} else {
					wrServer(t_noa);
				}
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);
				refreshBbm();
				if (q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1)
					$('.it').css('text-align', 'left');
					
				if (q_getPara('sys.project').toUpperCase()=='XY'){
					$('.isXY').show();
				}else{
					$('.isXY').hide();
				}
			}

			function refreshBbm() {
				if (q_cur == 1) {
					$('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
				} else {
					$('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
				}
				
				if (q_getPara('sys.project').toUpperCase()=='XY'){
					if (q_cur == 1 || q_cur==2) {
						$('#textGqbtitle').css('color', 'black').css('background', 'white').removeAttr('readonly').val($('#txtConntel').val());
						$('#textInvo').css('color', 'black').css('background', 'white').removeAttr('readonly').val($('#txtExt').val());
						$('#textPost').css('color', 'black').css('background', 'white').removeAttr('readonly').val($('#txtPost').val());
					}else{
						$('#textGqbtitle').css('color', 'black').css('background', 'RGB(237,237,238)').attr('readonly', 'readonly').val($('#txtConntel').val());
						$('#textInvo').css('color', 'black').css('background', 'RGB(237,237,238)').attr('readonly', 'readonly').val($('#txtExt').val());
						$('#textPost').css('color', 'black').css('background', 'RGB(237,237,238)').attr('readonly', 'readonly').val($('#txtPost').val());
					}
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
				width: 250px;
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
				width: 700px;
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
						<td align="center" style="width:80px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='nick' style="text-align: center;" class='it'>~nick</td>
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
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblSerial' class="lbl"> </a></td>
						<td><input id="txtSerial" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblKdate' class="lbl"> </a></td>
						<td><input id="txtKdate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblComp' class="lbl"> </a></td>
						<td colspan="3"><input id="txtComp" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblNick' class="lbl"> </a></td>
						<td><input id="txtNick" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBoss' class="lbl"> </a></td>
						<td><input id="txtboss" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblHead' class="lbl"> </a></td>
						<td><input id="txthead" type="text" class="txt c1"/></td>
						<!--
						<td><span> </span><a id='lblStatus' class="lbl"> </a></td>
						<td><input id="txtStatus" type="text" class="txt c1"/></td>
						-->
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan="2"><input id="txtTel" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td colspan="2"><input id="txtFax" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMobile' class="lbl"> </a></td>
						<td colspan="2"><input id="txtMobile" type="text" class="txt c1"/></td>
						<td><input id="btnConn" type="button"/></td>
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_fact' class="lbl"> </a></td>
						<td colspan="5">
							<input id="txtZip_fact" type="text" style="float:left; width:10%;"/>
							<input id="txtAddr_fact" type="text" style="float:left; width:90%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_comp' class="lbl"> </a></td>
						<td colspan="5">
							<input id="txtZip_comp" type="text" style="float:left; width:10%;"/>
							<input id="txtAddr_comp" type="text" style="float:left; width:90%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_invo' class="lbl"> </a></td>
						<td colspan="5">
							<input id="txtZip_invo" type="text" style="float:left; width:10%;"/>
							<input id="txtAddr_invo" type="text" style="float:left; width:90%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_home' class="lbl"> </a></td>
						<td colspan="5">
							<input id="txtZip_home" type="text" style="float:left; width:10%;"/>
							<input id="txtAddr_home" type="text" style="float:left; width:90%;"/>
						</td>
					</tr>
					<tr class="tr12">
						<td><span> </span><a id="lblEmail" class="lbl"></a></td>
						<td colspan="5"><input id="txtEmail" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBank" class="lbl btn" > </a></td>
						<td colspan="2">
							<input id="txtBankno" type="text" style="float:left; width:40%;"/>
							<input id="txtBank" type="text" style="float:left; width:60%;"/>
						</td>
						<td><span> </span><a id="lblAccount" class="lbl" > </a></td>
						<td colspan="2"><input id="txtAccount" type="text" class="txt c1"/></td>
					</tr>
					<tr class="isXY" style="display: none;">
						<td><span> </span><a class="lbl isXY" >支票抬頭</a></td>
						<td colspan="2"><input id="textGqbtitle" type="text" class="txt c1 isXY"/></td>
						<td><span> </span><a class="lbl isXY" >發票</a></td>
						<td>
							<input id="textInvo" type="text" class="txt c1 isXY" style="width:50px;"/>
							<span> </span><a class="lbl isXY" >回郵</a>
						</td>
						<td><input id="textPost" type="text" class="txt c1 isXY" style="width:50px;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSales" class="lbl btn" > </a></td>
						<td colspan="2">
							<input id="txtSalesno" type="text" style="float:left; width:40%;"/>
							<input id="txtSales" type="text" style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblService' class="lbl"> </a></td>
						<td colspan="3"><input id="txtService" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblUacc4' class="lbl btn"> </a></td>
						<td><input id="txtUacc4" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblChkdate' class="lbl"> </a></td>
						<td><input id="txtChkdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblStartdate' class="lbl"> </a></td>
						<td><input id="txtStartdate" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblUacc1' class="lbl"> </a></td>
						<td><input id="txtUacc1" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDueday' class="lbl"> </a></td>
						<td><input id="txtDueday" type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblGetdate' class="lbl"> </a></td>
						<td><input id="txtGetdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblUacc2' class="lbl"> </a></td>
						<td><input id="txtUacc2" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td><input id="txtPaytype" type="text" class="txt c1"/></td>
						<td>
							<select id="combPaytype" style="float:left; width:20px;"></select>
							<span> </span><a id='lblTrantype' class="lbl"> </a>
						</td>
						<td><select id="cmbTrantype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblUacc3' class="lbl"> </a></td>
						<td><input id="txtUacc3" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="5">
							<textarea id="txtMemo" style="width:100%; height:100px;"> </textarea>
							<input id="txtExt" type="hidden" />
							<input id="txtPost" type="hidden" />
							<input id="txtConntel" type="hidden" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td align="right">
							<input id="Copy" type="checkbox" />
							<span> </span><a id="lblCopy" class="lbl"> </a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>