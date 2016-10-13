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
			var q_name = "vcca";
			var q_readonly = ['txtMoney','txtTotal', 'txtChkno', 'txtTax', 'txtAccno', 'txtWorker','txtTrdno'];
			var bbmNum = [['txtMoney', 10, 0], ['txtTax', 10, 0], ['txtTotal', 10, 0], ['txtMount', 10, 3], ['txtPrice', 10, 1]];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Noa';
			q_desc=1;
			aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
			,['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', '0txtCustno,txtComp,txtNick', 'cust_b.aspx']
			,['txtBuyerno', 'lblBuyer', 'cust', 'noa,comp,serial', '0txtBuyerno,txtBuyer,txtSerial', 'cust_b.aspx']
			,['txtProductno', 'lblProduct', 'ucca', 'noa,product,unit', 'txtProductno,txtProduct,txtUnit', 'ucca_b.aspx']
			);
			brwCount2 = 10;
			function currentData() {
			}
			currentData.prototype = {
				origin : '',
				orgcustno : '',
				custno : '',
				cust : '',
				data : [],
				/*新增時複製的欄位*/
				include : ['txtDatea', 'txtCno', 'txtAcomp', 'txtCustno', 'txtComp', 'txtNick', 'txtSerial', 'txtAddress', 'txtMon','txtNoa','txtBuyerno','txtBuyer','txtProductno','txtProduct','txtUnit'],
				/*記錄當前的資料*/
				copy : function() {
					curData.data = new Array();
					for (var i in fbbm) {
						var isInclude = false;
						for (var j in curData.include) {
							if (fbbm[i] == curData.include[j]) {
								isInclude = true;
								break;
							}
						}
						if (isInclude) {
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

			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
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
				bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
				q_mask(bbmMask);
				if(q_getId()[5]!=undefined){
					var str=decodeURI(q_getId()[5]).split('&');
					for(var i in str){
						if(str[i].toUpperCase().substring(0,7)=='ORIGIN=')
							curData.origin = str[i].substring(7).toUpperCase();	
						else if(str[i].toUpperCase().substring(0,10)=='ORGCUSTNO=')
							curData.orgcustno = str[i].substring(10).toUpperCase();	
						else if(str[i].toUpperCase().substring(0,8)=='CUSTNO2=')
							curData.custno = str[i].substring(8).toUpperCase();	
						else if(str[i].toUpperCase().substring(0,6)=='CUST2=')
							curData.cust = str[i].substring(6).toUpperCase();	
					}
				}
				$('#txtSerial').change(function() {
					$(this).val($.trim($(this).val()).toUpperCase());
					if ($(this).val().length > 0 && checkId($(this).val())!=2){
						Lock();
						alert(q_getMsg('lblSerial')+'錯誤。');
						Unlock();
					}
				});
				q_cmbParse("cmbTaxtype",q_getPara('sys.taxtype'));
				$('#txtDatea').focusout(function () {
					q_cd( $(this).val() ,$(this));
				});
				$('#cmbTaxtype').focus(function() {
					var len = $("#cmbTaxtype").children().length > 0 ? $("#cmbTaxtype").children().length : 1;
					$("#cmbTaxtype").attr('size', len + "");
				}).blur(function() {
					$("#cmbTaxtype").attr('size', '1');
				}).change(function(e) {				
					sum();
				}).click(function(e) {			
					sum();
				});	
				$('#txtNoa').change(function(e) {
					$('#txtNoa').val($('#txtNoa').val().toUpperCase());
				});		
				$('#txtMount').change(function() {
					sum();
				});
				$('#txtPrice').change(function() {
					sum();
				});
				$('#txtTax').change(function() {
					sum();
				});
				$('#txtTotal').change(function() {
					sum();
				});			
				$('#lblAccno').click(function() {
					q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
				});
				$('#lblTrdno').click(function() {
					q_pop('txtTrdno', "trd.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtTrdno').val() + "';" + r_accy + '_' + r_cno, 'trd', 'noa', 'datea', "95%", "95%", q_getMsg('popTrd'), true);
				});
			}
			
			function q_boxClose(s2) {///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、報價視窗  關閉時執行
				var
				ret;
				switch (b_pop) {/// 重要：不可以直接 return ，最後需執行 originalClose();
					case q_name + '_s':
						q_boxClose2(s2);
						///   q_boxClose 3/4
						break;
				}/// end Switch
				b_pop = '';
			}

			function q_gtPost(t_name) {
				switch (t_name) { 
					
					case 'cust':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined) {
							$('#txtBuyerno').val(as[0].noa);
							$('#txtBuyer').val(as[0].comp);
							$('#txtSerial').val(as[0].serial);
						}
						break;
					case 'vccar':
						var as = _q_appendData("vccar", "", true);
						if (as[0] == undefined) {
							alert("請檢查發票日期及公司有無設定，或發票已輸入。");
						} else {
							//3聯須輸入統編
							if (as[0].rev=='3' && $('#cmbTaxtype').val()!='6' && checkId($('#txtSerial').val())!=2){										
								alert(q_getMsg('lblSerial')+'錯誤。');
								Unlock(1);
								return;
							}
							//2聯不須輸入統編
							if (as[0].rev=='2' && $('#txtSerial').val().length>0 && $('#cmbTaxtype').val()!='6' && checkId($('#txtSerial').val())!=2){										
								alert(q_getMsg('lblSerial')+'錯誤。');
								Unlock(1);
								return;
							}
							wrServer($('#txtNoa').val()); 
							return;			
						}
						break;
					case q_name:
						if (q_cur == 4)// 查詢
							q_Seek_gtPost();
						break;
				}
			}
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				abbm[q_recno]['accno'] = xmlString;
				$('#txtAccno').val(xmlString);
				Unlock(1);
			}
			function btnOk() {	
				Lock(1,{opacity:0});
				if(q_getPara('sys.project').toUpperCase()!='ES' && $('#cmbTaxtype').val() !=6 && emp($('#txtProductno').val())){
					alert(q_getMsg('lblProduct')+'未填寫。');
					Unlock(1);
					return;
				}
				if ($('#txtDatea').val().length==0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
					Unlock(1);
					return;
				}							   
				$('#txtNoa').val($.trim($('#txtNoa').val()));
				if ($('#txtNoa').val().length > 0 && !(/^[a-z,A-Z]{2}[0-9]{8}$/g).test($('#txtNoa').val())){
					alert(q_getMsg('lblNoa')+'錯誤。');
					Unlock(1);
					return;
				}
				if($.trim($('#txtMon').val()).length==0)
					$('#txtMon').val($('#txtDatea').val().substring(0,6));
				$('#txtMon').val($.trim($('#txtMon').val()));
				if (!(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
					alert(q_getMsg('lblMon')+'錯誤。');
					Unlock(1);
					return;
				}		
				$('#txtWorker' ).val(r_name);
				sum();
				var t_where = '';
				if(q_cur==1){
					t_where = "where=^^ cno='" + $('#txtCno').val() + "' and ('" + $('#txtDatea').val() + "' between bdate and edate) "+
					" and exists(select noa from vccars where vccars.noa=vccar.noa and ('" + $('#txtNoa').val() + "' between binvono and einvono))"+
					" and not exists(select noa from vcca where noa='" + $('#txtNoa').val() + "') ^^";				  
				}else{
					t_where = "where=^^ cno='" + $('#txtCno').val() + "' and ('" + $('#txtDatea').val() + "' between bdate and edate) "+
					" and exists(select noa from vccars where vccars.noa=vccar.noa and ('" + $('#txtNoa').val() + "' between binvono and einvono)) ^^";
				}
				q_gt('vccar', t_where, 0, 0, 0, "", r_accy);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('vcca_s.aspx', q_name + '_s', "550px", "450px", q_getMsg("popSeek"));
			}

			function btnIns() {
				curData.copy();
				_btnIns();
				curData.paste();
				if(q_getPara('sys.project').toUpperCase()=='ES')
					$('#txtMount').val(1);
				
				if(curData.origin=='TRD'){
					$('#txtCustno').val(curData.custno);
					$('#txtComp').val(curData.cust);
				}
				if(curData.orgcustno.length>0){
					t_where = " where=^^ noa='"+ curData.orgcustno +"' ^^";
					q_gt('cust', t_where, 0, 0, 0, "", r_accy);
				}
				//發票號碼+1
				var t_noa = trim($('#txtNoa').val());
				var str = '00000000'+(parseInt(t_noa.substring(2,10))+1);
				str = str.substring(str.length-8,str.length);
				t_noa = t_noa.substring(0,2)+str;
				$('#txtNoa').val(t_noa);
				
				$('#cmbTaxtype').val(1);
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
				sum();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
				$('#txtNoa').attr('readonly', true);
				$('#txtNoa').css('background-color','rgb(237,237,238)').css('color','green');
				//讓發票號碼不可修改
				sum();
			}

			function btnPrint() {
				q_box('z_vccadc.aspx?;;;'+r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function sum() {
				if(!(q_cur==1 || q_cur==2))
					return;		
				$('#txtMoney').attr('readonly',true);			
				$('#txtTax').attr('readonly',true);	
				$('#txtTotal').attr('readonly', true);
				$('#txtMoney').css('background-color','rgb(237,237,238)').css('color','green');
				$('#txtTax').css('background-color','rgb(237,237,238)').css('color','green');
				$('#txtTotal').css('background-color','rgb(237,237,238)').css('color','green');
				
				$('#txtCustno').attr('readonly', false);
				$('#txtComp').attr('readonly', false);
				$('#txtSerial').attr('readonly', false);
				$('#txtMon').attr('readonly', false);
				$('#txtBuyerno').attr('readonly', false);
				$('#txtBuyer').attr('readonly', false);
				
				var t_mount,t_price,t_money,t_taxrate,t_tax,t_total;
				t_mount = q_float('txtMount');
				t_price = q_float('txtPrice');
				t_money = round(t_mount*t_price,0);
				t_taxrate = parseFloat(q_getPara('sys.taxrate'))/100;
				switch ($('#cmbTaxtype').val()) {
					case '1':  // 應稅
						t_tax = round(t_money * t_taxrate, 0);
						t_total = t_money + t_tax;
						break;
					case '2': //零稅率
						t_tax = 0;
						t_total = t_money + t_tax;
						break;
					case '3':  // 內含
						t_tax = round(t_money / (1 + t_taxrate) * t_taxrate, 0);
						t_total = t_money;
						t_money = t_total - t_tax;
						break;
					case '4':  // 免稅
						t_tax = 0;
						t_total = t_money + t_tax;
						break;
					case '5':  // 自定
						$('#txtTax').attr('readonly',false);	
						$('#txtTax').css('background-color','white').css('color','black');
						t_tax = round(q_float('txtTax'),0);
						t_total = t_money + t_tax;
						break;
					case '6':  // 作廢-清空資料
						if(q_getPara('sys.project').toUpperCase()=='ES'){
							//再興  發票作廢 ,金額不必歸0,  另外修正報表
						}else{
							t_money = 0,t_tax = 0, t_total = 0;
							$('#txtCustno').val('');//銷貨客戶
							$('#txtCustno').attr('readonly', true);
							$('#txtComp').val('');
							$('#txtComp').attr('readonly', true);
							$('#txtSerial').val('');//統一編號
							$('#txtSerial').attr('readonly', true);
							$('#txtMoney').val(0);//產品金額
							$('#txtMoney').attr('readonly', true);
							$('#txtMon').val('');//帳款月份
							$('#txtMon').attr('readonly', true);
							$('#txtProductno').val('');//產品編號	
							$('#txtProductno').attr('readonly', true);
							$('#txtProduct').val('');//品名規格	
							$('#txtProduct').attr('readonly', true);
							$('#txtUnit').val('');//單位
							$('#txtUnit').attr('readonly', true);
							$('#txtMount').val(0);//數量
							$('#txtMount').attr('readonly', true);
							$('#txtPrice').val(0);//price
							$('#txtPrice').attr('readonly', true);
							$('#txtTax').val(0);//營業稅
							$('#txtTax').attr('readonly', true);
							$('#txtTotal').val(0);//總計
							$('#txtTotal').attr('readonly', true);
							$('#txtChkno').val('');//檢查號碼
							$('#txtChkno').attr('readonly', true);
							$('#txtAccno').val('');//轉會計傳票編號
							$('#txtAccno').attr('readonly', true);
							$('#txtBuyerno').val('');//買受人
							$('#txtBuyerno').attr('readonly', true);
							$('#txtBuyer').val('');//
							$('#txtBuyer').attr('readonly', true);
							$('#txtMemo').val('');//發票備註
						}
						break;		
					default:		
				}
				$('#txtMoney').val(t_money);
				$('#txtTax').val(t_tax);
				$('#txtTotal').val(t_total);
			}

			function refresh(recno) {
				_refresh(recno);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
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
			function checkId(str) {
				if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
					var key = 'ABCDEFGHJKLMNPQRSTUVXYWZIO';
					var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
					var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
					if ((n % 10) == 0)
						return 1;
				} else if ((/^[0-9]{8}$/g).test(str)) {//統一編號
					var key = '12121241';
					var n = 0;
					var m = 0;
					for (var i = 0; i < 8; i++) {
						n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
						m += Math.floor(n / 10) + n % 10;
					}
					if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
						return 2;
				}else if((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//西元年
					var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
			   		if(regex.test(str))
			   			return 3;
				}else if((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//民國年
					str = (parseInt(str.substring(0,3))+1911)+str.substring(3);
					var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
			   		if(regex.test(str))
			   			return 4
			   	}
			   	return 0;//錯誤
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 400px; 
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
				width: 600px;
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
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 61%;
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
			.tbbs input[type="text"] {
				width: 98%;
			}
			.tbbs a {
				font-size: medium;
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
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'></a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewNoa'></a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'></a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewBuyer'></a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewTotal'></a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='buyer,4' style="text-align: left;">~buyer,4</td>
						<td id='total,0,1' style="text-align: right;">~total,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
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
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtCno" type="text" style="float:left; width:15%;">
						<input id="txtAcomp" type="text" style="float:left; width:85%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBuyer' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtBuyerno"  type="text"  style="float:left; width:30%;"/>
							<input id="txtBuyer" type="text"  style="float:left; width:70%;"/>
						</td>
						<td><span> </span><a id='lblSerial' class="lbl"> </a></td>
						<td><input id="txtSerial" type="text" class="txt c1"/> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtCustno" type="text" style="float:left; width:30%;">
						<input id="txtComp" type="text" style="float:left; width:70%;"/>
						<input id="txtNick" type="text"  style="display:none;"/>
						</td>
					</tr>				
					<tr>
						<td><span> </span><a id='lblMount' class="lbl"> </a></td>
						<td><input id="txtMount"  type="text"  class="txt num c1"/></td>
						<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td><input id="txtPrice"  type="text"  class="txt num c1"/></td>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney"  type="text"  class="txt num c1"/></td>
					</tr>
					<tr class="tr6">
						<td><span> </span><a id='lblTaxtype' class="lbl"> </a></td>
						<td><select id="cmbTaxtype" class="txt c1" > </select></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax"  type="text"  class="txt num c1"/></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal"  type="text"  class="txt num c1"/>	</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblProduct' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtProductno"  type="text"  style="float:left; width:25%;"/>
							<input id="txtProduct"  type="text"  style="float:left; width:75%;"/>
						</td>
						<td><span> </span><a id='lblUnit' class="lbl"> </a></td>
						<td><input id="txtUnit"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan='5'><input id="txtMemo"  type="text"  class="txt c1"/>	</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblChkno' class="lbl"> </a></td>
						<td><input id="txtChkno"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblAccno' class="lbl btn"> </a></td>
						<td><input id="txtAccno"  type="text" class="txt c1"/>	</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTrdno' class="lbl btn"> </a></td>
						<td colspan="2"><input id="txtTrdno"  type="text" class="txt c1"/>	</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
