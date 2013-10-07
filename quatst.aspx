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
			q_desc=1;
			q_tables = 's';
			var q_name = "quat";
			var q_readonly = ['txtComp', 'txtAcomp','txtSales','txtWorker','txtNoa'];
			var q_readonlys = ['txtNo3','txtNo2'];
			var bbmNum = [['txtMoney', 15, 0, 1],['txtTax', 10, 0, 1],['txtTotal', 15, 0, 1],['txtTotalus', 15, 2, 1],
						 ['txtFloata', 15, 3, 1],['txtWeight', 15, 0, 1],['txtGweight', 10, 2, 1],
						 ['txtEweight', 15, 0, 1],['txtOrdgweight', 15, 3, 1],['txtOrdeweight', 15, 3, 1]
						];
			var bbsNum = [['textSize1', 10, 3, 1],['textSize2', 10, 2, 1],['textSize3', 10, 3, 1],
						 ['textSize4', 10, 2, 1],['txtMount', 10, 0, 1],['txtWeight', 15, 0, 1],
						 ['txtPrice', 10, 2, 1],['txtTotal', 15, 0, 1],['txtTheory', 15, 0, 1],['txtGweight', 10, 2, 1],
						 ['txtEweight', 15, 0, 1],['txtOrdgweight', 15, 3, 1],['txtOrdeweight', 15, 3, 1]
						];
			var bbmMask = [];
			var bbsMask = [['txtStyle','A']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx'],
			['txtCustno', 'lblCust', 'cust', 'noa,comp,paytype,trantype,tel,fax,zip_comp,addr_comp',
				'txtCustno,txtComp,txtPaytype,cmbTrantype,txtTel,txtFax,txtPost,txtAddr', 'cust_b.aspx'],
			['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
			['txtCno','lblAcomp','acomp','noa,acomp','txtCno,txtAcomp','acomp_b.aspx']);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no3'];
				q_brwCount();
				q_gt('style','',0,0,0,'');
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});
			
			//////////////////   end Ready
			function main() {
				if(dataErr) {
					dataErr = false;
					return;
				}

				mainForm(1);
			}
			
			var t_spec;//儲存spec陣列
			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd],['txtOdate',r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbStype", q_getPara('vcc.stype')); 
				q_cmbParse("cmbCoin", q_getPara('sys.coin'));	
				q_cmbParse("combPaytype", q_getPara('vcc.paytype'));  
				q_cmbParse("cmbTrantype", q_getPara('vcc.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));  
				q_cmbParse("cmbKind", q_getPara('sys.stktype')); 
				q_gt('spec', '', 0, 0, 0, "", r_accy);
				/* 若非本會計年度則無法存檔 */
				$('#txtDatea').focusout(function () {
					if($(this).val().substr( 0,3)!= r_accy){
							$('#btnOk').attr('disabled','disabled');
					}else{
								$('#btnOk').removeAttr('disabled');
					}
				});
				//變動尺寸欄位
				$('#cmbKind').change(function () {
					size_change();
				});
				$('#txtFloata').change(function () {sum();});
				$('#txtTotal').change(function () {sum();});
				$('#lblContract').click(function(){
					var t_contract = $.trim($('#txtContract').val());
					q_box("contst.aspx?;;;contract='" + t_contract + "';"+r_accy, 'cont', "95%", "95%", q_getMsg("popContst"));
				});
				$('#btnQuatst2Contst').click(function(){
					//動作執行順序 : 確認系統參數 > 確認欄位是否留空 > 產生對話框詢問是否執行 > 如選市則執行func否則跳出
					if((q_cur == 0 || q_cur == 4) && !emp($.trim($('#txtNoa').val()))){
						var t_quatstnoa = encodeURI($.trim($('#txtNoa').val()));
						var t_datea = encodeURI($.trim($('#txtDatea').val()));
						var t_contno = encodeURI($.trim($('#txtContract').val()));
						var t_contPreFix = encodeURI(q_getPara('sys.key_contst'));
						if(emp(r_accy) || emp(r_name) || emp(t_contPreFix)){
							alert('系統參數錯誤!!');
							return ;
						}else if(emp(t_quatstnoa) || t_quatstnoa == 'AUTO'){
							alert('請先產生' + q_getMsg('lblNoa'));
							return;
						}else if(emp(t_datea)){
							alert(q_getMsg('lblDatea') + '禁止為空!!');
							return;
						}else if(emp(t_contno)){
							alert('請先輸入' + q_getMsg('lblContract'));
							return;
						}
						var todo=confirm('你確定要執行嗎?');
						if(todo == true){
							q_func('qtxt.query.quatst2contst','quatst2contst.txt,quatst2contst,'+encodeURI(r_accy)+';'+t_quatstnoa+';'+
									t_datea+';'+t_contno+';' + t_contPreFix + ';' + encodeURI(r_name));
						}
					}else{
						alert('請點選確定後存檔才能執行!!');
					}
				});
				$('#txtAddr').change(function(){
					var t_custno = trim($(this).val());
					if(!emp(t_custno)){
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}  
				});
				$('#txtAddr2').change(function(){
					var t_custno = trim($(this).val());
					if(!emp(t_custno)){
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}  
				});
			}

			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.quatst2contst':
						alert('執行成功!!');
					break;
				}
			}

			function q_boxClose(s2) {///   q_boxClose 2/4
				var
				ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						///   q_boxClose 3/4
						break;
				}/// end Switch
				b_pop = '';
			}
			var focus_addr='';
			var StyleList = '';
			var t_uccArray = new Array;
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'cust':
						var as = _q_appendData("cust", "", true);
						if(as[0]!=undefined && focus_addr !=''){
							$('#'+focus_addr).val(as[0].addr_fact);
							focus_addr = '';
						}
						break;
					case 'spec': 
						t_spec= _q_appendData("spec", "", true);
					break;
					case 'style' :
						var as = _q_appendData("style", "", true);
						StyleList = new Array();
						StyleList = as;
					break;
					case q_name:
						t_uccArray = _q_appendData("ucc", "", true);
						if(q_cur == 4)
							q_Seek_gtPost();
						break;
				}  /// end switch
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if(t_err.length > 0) {
					alert(t_err);
					return;
				}
				$('#txtWorker').val(r_name);
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if(s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_quat') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if(q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('quat_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function combPaytype_chg() {
				var cmb = document.getElementById("combPaytype");
				if (!q_cur) 
					cmb.value = '';
				else
					$('#txtPaytype').val(cmb.value);
				cmb.value = '';
			}

			function getTheory(b_seq){
				t_Radius = dec($('#txtRadius_'+b_seq).val());
				t_Width = dec($('#txtWidth_'+b_seq).val());
				t_Dime = dec($('#txtDime_'+b_seq).val());
				t_Lengthb = dec($('#txtLengthb_'+b_seq).val());
				t_Mount = dec($('#txtMount_'+b_seq).val());
				t_Style = $('#txtStyle_'+b_seq).val();
				t_Stype = ($('#cmbStype').find("option:selected").text() == '外銷'?1:0);
                t_Productno = $('#txtProductno_' + b_seq).val();
				var theory_setting={
					calc:StyleList,
					ucc:t_uccArray,
					radius:t_Radius,
					width:t_Width,
					dime:t_Dime,
					lengthb:t_Lengthb,
					mount:t_Mount,
					style:t_Style,
					stype:t_Stype,
					productno:t_Productno
				};
				if($('#cmbKind').val().substr(1,1)=='4'){//鋼胚
					q_tr('txtTheory_'+b_seq,round(t_Mount*theory_bi(t_spec,$('#txtSpec_'+b_seq).val(),t_Dime,t_Width,t_Lengthb),0));
				}else{
					q_tr('txtTheory_'+b_seq ,theory_st(theory_setting));
				}
			}

			function bbsAssign() {
				for(var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtStyle_' + j).blur(function(){
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							ProductAddStyle(b_seq);
						});
						//將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
						$('#textSize1_' + j).change(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if ($('#cmbKind').val().substr(0,1)=='A'){	
								q_tr('txtDime_'+b_seq ,q_float('textSize1_'+b_seq));//厚度$('#txtDime_'+b_seq).val($('#textSize1_' + b_seq).val());
							}else if($('#cmbKind').val().substr(0,1)=='B'){
								q_tr('txtRadius_'+b_seq ,q_float('textSize1_'+b_seq));//短徑$('#txtRadius_'+b_seq).val($('#textSize1_' + b_seq).val());	
							}
							getTheory(b_seq);
						});
						$('#textSize2_' + j).change(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if ($('#cmbKind').val().substr(0,1)=='A'){	
								q_tr('txtWidth_'+b_seq ,q_float('textSize2_'+b_seq));//寬度$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());	
							}else if($('#cmbKind').val().substr(0,1)=='B'){
								q_tr('txtWidth_'+b_seq ,q_float('textSize2_'+b_seq));//長徑$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());	
							}
							getTheory(b_seq);
						});
						$('#textSize3_' + j).change(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if ($('#cmbKind').val().substr(0,1)=='A'){	
								q_tr('txtLengthb_'+b_seq ,q_float('textSize3_'+b_seq));//長度$('#txtLengthb_'+b_seq).val($('#textSize3_' + b_seq).val());	
							}else if($('#cmbKind').val().substr(0,1)=='B'){
								q_tr('txtDime_'+b_seq ,q_float('textSize3_'+b_seq));//厚度$('#txtDime_'+b_seq).val($('#textSize3_' + b_seq).val());		
							}else{//鋼筋、胚
								q_tr('txtLengthb_'+b_seq ,q_float('textSize3_'+b_seq));
							}
							getTheory(b_seq);
						});
						$('#textSize4_' + j).change(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if ($('#cmbKind').val().substr(0,1)=='A'){	
								q_tr('txtRadius_'+b_seq ,q_float('textSize4_'+b_seq));//短徑為0 $('#txtRadius_'+b_seq).val($('#textSize4_' + b_seq).val());	
							}else if($('#cmbKind').val().substr(0,1)=='B'){
								q_tr('txtLengthb_'+b_seq ,q_float('textSize4_'+b_seq));//長度$('#txtLengthb_'+b_seq).val($('#textSize4_' + b_seq).val());	
							}
							getTheory(b_seq);
						});
						$('#txtMount_' + j).change(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							getTheory(b_seq);
							sum();
						});
						//-------------------------------------------------------------------------------------
						
						$('#txtSpec_' + j).change(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							getTheory(b_seq);
						});
						
						$('#txtWeight_' + j).change(function () {sum();});
						$('#txtPrice_' + j).change(function () {sum();});
						$('#txtTotal_' + j).change(function () {sum();});
						$('#txtWeight_' + j).change(function () {sum();});
					}
				}
				_bbsAssign();
				size_change();
			}

			function btnIns() {
				_btnIns();
				$('#cmbKind').val(q_getPara('vcc.kind'));
				size_change();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
			}

			function btnModi() {
				if(emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtProduct').focus();
				size_change();
			}

			function btnPrint() {
				q_box('z_quatstp.aspx'+ "?;;;noa="+trim($('#txtNoa').val())+";"+r_accy, '', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if(!as['productno']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['datea'] = abbm2['datea'];
				
				return true;
			}

			function sum() {
				var t1 = 0, t_unit, t_mount, t_weight = 0,t_total=0;
				for(var j = 0; j < q_bbsCount; j++) {
					q_tr('txtTotal_'+j,round(q_float('txtWeight_'+j)*q_float('txtPrice_'+j),0));
					t_total+=q_float('txtTotal_'+j);
					t_weight+=q_float('txtWeight_'+j);
				}  // j
				q_tr('txtMoney',t_total);
				q_tr('txtWeight',t_weight);
				q_tr('txtTotal',t_total);
				calTax();
				q_tr('txtTotalus',q_float('txtTotal')*q_float('txtFloata'));
			}

			function refresh(recno) {
				_refresh(recno);
				size_change();
				$('input[id*="txtProduct_"]').each(function(){
					t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					OldValue = $(this).val();
					nowStyle = $('#txtStyle_'+b_seq).val();
					if(!emp(nowStyle) && (StyleList[0] != undefined)){
						for(var i = 0;i < StyleList.length;i++){
								if(StyleList[i].noa.toUpperCase() == nowStyle){
					 			styleProduct = StyleList[i].product;
								if(OldValue.substr(OldValue.length-styleProduct.length) == styleProduct){
									OldValue = OldValue.substr(0,OldValue.length-styleProduct.length);
								}
								}
							}
					}
					$(this).attr('OldValue',OldValue);
				});
			}
			function q_popPost(s1) {
				switch (s1) {
					case 'txtProductno_':
						$('input[id*="txtProduct_"]').each(function(){
							$(this).attr('OldValue',$(this).val());
						});
						ProductAddStyle(b_seq);
						$('#txtStyle_' + b_seq).focus();
						break;
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				size_change();
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				size_change();
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
			
		function size_change() {
			if(q_cur==1 || q_cur==2){
				$('input[id*="textSize"]').removeAttr('disabled');
			}else{
				$('input[id*="textSize"]').attr('disabled', 'disabled');
			}
		 	if( $('#cmbKind').val().substr(0,1)=='A'){
				$('#lblSize_help').text(q_getPara('sys.lblSizea'));
				for (var j = 0; j < q_bbsCount; j++) {
					$('#textSize1_'+j).show();
					$('#textSize2_'+j).show();
					$('#textSize3_'+j).show();
					$('#textSize4_'+j).hide();
					$('#x1_'+j).show();
					$('#x2_'+j).show();
					$('#x3_'+j).hide();
					$('#Size').css('width','222px');
					$('#textSize1_'+j).val($('#txtDime_'+j).val());
					$('#textSize2_'+j).val($('#txtWidth_'+j).val());
					$('#textSize3_'+j).val($('#txtLengthb_'+j).val());
					$('#textSize4_'+j).val(0);
					$('#txtRadius_'+j).val(0)
				}
			}else if( $('#cmbKind').val().substr(0,1)=='B'){
				$('#lblSize_help').text(q_getPara('sys.lblSizeb'));
				for (var j = 0; j < q_bbsCount; j++) {
					$('#textSize1_'+j).show();
					$('#textSize2_'+j).show();
					$('#textSize3_'+j).show();
					$('#textSize4_'+j).show();
					$('#x1_'+j).show();
					$('#x2_'+j).show();
					$('#x3_'+j).show();
					$('#Size').css('width','297px');
					$('#textSize1_'+j).val($('#txtRadius_'+j).val());
					$('#textSize2_'+j).val($('#txtWidth_'+j).val());
					$('#textSize3_'+j).val($('#txtDime_'+j).val());
					$('#textSize4_'+j).val($('#txtLengthb_'+j).val());
				}
			}else{//鋼筋和鋼胚
				$('#lblSize_help').text(q_getPara('sys.lblSizec'));
				for (var j = 0; j < q_bbsCount; j++) {
					$('#textSize1_'+j).hide();
					$('#textSize2_'+j).hide();
					$('#textSize3_'+j).show();
					$('#textSize4_'+j).hide();
					$('#x1_'+j).hide();
					$('#x2_'+j).hide();
					$('#x3_'+j).hide();
					$('#Size').css('width','70px');
					$('#textSize1_'+j).val(0);
					$('#txtDime_'+j).val(0)
					$('#textSize2_'+j).val(0);
					$('#txtWidth_'+j).val(0);
					$('#textSize3_' + j).val($('#txtLengthb_'+j).val());
					$('#textSize4_'+j).val(0);
					$('#txtRadius_'+j).val(0);
				}
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
				font-size: medium;
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
				width: 30%;
				float: left;
			}
			.txt.c5 {
				width: 70%;
				float: left;
			}
			.txt.c6 {
				width: 90%;
				text-align:center;
			}
			.txt.c7 {
				width: 95%;
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
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size:medium;
			}
			.dbbs {
				float:left;
				width: 1800px;
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
			.trX{
				background: pink;
			}
			.trTitle{
				padding-left: 18px;
				font-size: 18px;
				font-weight: bolder;
				color: brown;
				letter-spacing: 5px;
			}
			
	 
	</style>
</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
		<div class="dview" id="dview">
			<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
			<tr>
				<td align="center" style="width:5%"><a id='vewChk'></a></td>
				<td align="center" style="width:25%"><a id='vewDatea'></a></td>
				<td align="center" style="width:25%"><a id='vewNoa'></a></td>
				<td align="center" style="width:40%"><a id='vewComp'></a></td>
			</tr>
			<tr>
					<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
					<td align="center" id='datea'>~datea</td>
					<td align="center" id='noa'>~noa</td>
					<td align="center" id='custno comp,4'>~custno ~comp,4</td>
			</tr>
		</table>
		</div>
		<div class='dbbm' >
		<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
			<tr class="tr1">
				<td class="td1"><span> </span><a id='lblStype' class="lbl"></a></td>
				<td class="td2"><select id="cmbStype" class="txt c1"></select></td>
				<td class="td5"><input id="txtOdate" type="text"  class="txt c1"/></td>
				<td class="td4"><span> </span><a id='lblDatea' class="lbl"></a></td>
				<td class="td5"><input id="txtDatea" type="text"  class="txt c1"/></td>
				<td></td>
				<td class="td7"><span> </span><a id='lblNoa' class="lbl"></a></td>
				<td class="td8"><input id="txtNoa" type="text" class="txt c1"/></td> 
			</tr>	
			<tr class="tr2">
				<td class="td1"><span> </span><a id="lblAcomp" class="lbl btn" ></a></td>
				<td class="td2" colspan="2"><input id="txtCno"  type="text"  class="txt c4"/>
				<input id="txtAcomp"  type="text" class="txt c5"/></td>
				<td class="td4"><span> </span><a id='lblFloata' class="lbl"></a></td>
				<td class="td5"><select id="cmbCoin" class="txt c1" ></select></td>				
				<td class="td6"><input id="txtFloata"  type="text"  class="txt num c1" /></td>				
				<td class="td7"><span> </span><a id='lblContract' class="lbl btn"></a></td>
				<td class="td8"><input id="txtContract"  type="text"  class="txt c1"/></td> 
			</tr>
			<tr class="tr3">
				<td class="td1"><span> </span><a id="lblCust" class="lbl btn"></a></td>
				<td class="td2" colspan="2"><input id="txtCustno" type="text" class="txt c4"/>
				<input id="txtComp"  type="text" class="txt c5"/></td>
				<td class="td4"><span> </span><a id='lblPaytype' class="lbl"></a></td>
				<td class="td5"><input id="txtPaytype" type="text" class="txt c1" /></td> 
				<td class="td6"><select id="combPaytype" class="txt c1"  onchange='combPaytype_chg()'></select></td> 
				<td class="td7"></td> 
				<td class="td8"><input id="btnQuatst2Contst" type="button"/></td> 
			</tr>
			<tr class="tr4">
				<td class="td1"><span> </span><a id="lblSales" class="lbl btn"></a></td>
				<td class="td2" colspan="2"><input id="txtSalesno" type="text" class="txt c4"/> 
				<input id="txtSales" type="text" class="txt c5"/></td> 
				<td class="td4"><span> </span><a id='lblTel' class="lbl"></a></td>
				<td class="td5" colspan='2'><input id="txtTel"  type="text" class="txt c1"/></td>
				<td class="td7"><span> </span><a id='lblFax' class="lbl"></a></td>
				<td class="td8"><input id="txtFax"  type="text"  class="txt c1"/></td>
			</tr>
			<tr class="tr5">
				<td class="td1"><span> </span><a id='lblAddr' class="lbl"></a></td>
				<td class="td2"><input id="txtPost" type="text"  class="txt c1"></td>
				<td class="td3" colspan='4' ><input id="txtAddr" type="text"  class="txt c1" /></td>
				<td class="td7"><span> </span><a id='lblTrantype' class="lbl"></a></td>
				<td class="td8"><select id="cmbTrantype" class="txt c1" name="D1" ></select></td> 
			</tr>
			<tr class="tr6">
				<td class="td1"><span> </span><a id='lblAddr2' class="lbl"></a></td>
				<td class="td2"><input id="txtPost2"  type="text"  class="txt c1"/></td>
				<td class="td3" colspan='4'><input id="txtAddr2"  type="text"  class="txt c1"/></td>
				<td class='td7'><span> </span><a id="lblKind" class="lbl"> </a></td>
				<td class="td8"><select id="cmbKind" class="txt c1"> </select></td>
			</tr>
			<tr class="tr7">
				<td class="td1"><span> </span><a id='lblMoney' class="lbl"></a></td>
				<td class="td2" colspan='2'><input id="txtMoney" type="text" class="txt num c1" /></td> 
				<td class="td4"><span> </span><a id='lblTax' class="lbl"></a></td>
				<td class="td5"><input id="txtTax" type="text"  class="txt num c1" /></td>
				<td class="td6"><select id="cmbTaxtype" class="txt c1" onchange='calTax()'></select></td>
				<td class="td7"><span> </span><a id='lblTotal' class="lbl"></a></td>
				<td class="td8"><input id="txtTotal" type="text"  class="txt num c1" />
				</td> 
			</tr>
			<tr class="tr8">
				<td class="td1"><span> </span><a id='lblTotalus' class="lbl"></a></td>
				<td class="td2" colspan='2'><input id="txtTotalus" type="text"  class="txt num c1" /></td> 
				<td class="td4"><span> </span><a id='lblWeight' class="lbl"></a></td>
				<td class="td5" colspan='2' ><input id="txtWeight"  type="text"  class="txt num c1" /></td>
				<td class="td7"><span> </span><a id='lblApv' class="lbl"></a></td>
				<td class="td8"><input id="txtApv"  type="text"  class="txt c1" disabled="disabled"/></td> 
			</tr>
			<tr style="display: none;">
				<td class="tdZ trX" colspan="8"><span> </span><a id='lblTweight_st' class="trTitle"> </a></td>
				<td class="tdZ trX"> </td>
			</tr>
			<tr style="display: none;">
				<td class="trX"><span> </span><a id='lblGweight' class="lbl"> </a></td>
				<td class="trX"><input id="txtGweight" type="text" class="txt c1 num" /></td>
				<td class="trX"><span> </span><a id='lblEweight' class="lbl"> </a></td>
				<td class="trX"><input id="txtEweight" type="text" class="txt c1 num" /></td>
				<td class="tdZ trX"> </td>
				<td class="tdZ trX"> </td>
				<td class="tdZ trX"> </td>
				<td class="tdZ trX"> </td>
				<td class="tdZ trX"> </td>
			</tr>
			<tr>
				<td class="trX"><span> </span><a id='lblOrdgweight' class="lbl"> </a></td>
				<td class="trX"><input id="txtOrdgweight" type="text" class="txt c1 num" /></td>
				<td class="trX"><span> </span><a id='lblOrdeweight' class="lbl"> </a></td>
				<td class="trX"><input id="txtOrdeweight" type="text" class="txt c1 num" /></td>
				<td class="trX" colspan="2" align="center">
					<span> </span><a id='lblCtrlweight'> </a>
					<input id="chkCtrlweight" type="checkbox"/>
					<span> </span><a id='lblEnda'> </a>
					<input id="chkEnda" type="checkbox"/>
				</td>
				<td class="trX"><span> </span><a id='lblWorker' class="lbl"></a></td>
				<td class="trX"><input id="txtWorker"  type="text" class="txt c1" /></td> 
				<td class="tdZ trX"> </td>
			</tr>
			<tr class="tr9">
				<td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
				<td class="td2" colspan='7' ><textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"></textarea></td>
				</tr>
		</table>
		</div>
		<div class='dbbs' >
		<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
			 <tr style='color:White; background:#003366;' >
				<td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
				<td align="center" style="width:8%;"><a id='lblProductno_st'></a></td>
				<td align="center" style="width:30px;"><a id='lblStyle_st'></a></td>
				<td align="center" style="width:10%;"><a id='lblProduct_st'></a></td>
				<td align="center" style="width:60px;"><a id='lblClass_st'></a></td>
				<td align="center" id='Size'><a id='lblSize_help'> </a></br><a id='lblSize_st'> </a></td>
				<td align="center" style="width:10%;"><a id='lblSizea_st'></a></td>
				<td align="center" style="width:3%;"><a id='lblUnit_st'></a></td>
				<td align="center" style="width:5%;"><a id='lblMount_st'></a></td>
				<td align="center" style="width:7%;"><a id='lblWeight_st'></a></td>
				<td align="center" style="width:5%;"><a id='lblPrice_st'></a></td>
				<td align="center" style="width:8%;"><a id='lblTotal_st'></a></td>
				<td align="center"><a id='lblMemo_st'></a></td>
				<td align="center" style="width:5%;"><a id='lblGweight_st'></a></td>
				<td align="center" style="width:5%;"><a id='lblEweight_st'></a></td>
				<!--
				<td align="center" style="width:5%;"><a id='lblOrdgweight_st'></a></td>
				<td align="center" style="width:5%;"><a id='lblOrdeweight_st'></a></td>
				-->
				<td align="center" style="width:2%;"><a id='lblEnda_st'></a></td>
			</tr>
			<tr style='background:#cad3ff;'>
				<td ><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
				<td>
					<input class="btn"  id="btnProduct.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
					<input type="text" id="txtProductno.*"  style="width:76%; float:left;"/>
					<span style="display:block; width:1%;float:left;"> </span>
					<input type="text" id="txtNo3.*"  style="width:76%; float:left;"/>
				</td> 
				<td ><input id="txtStyle.*" type="text" class="txt c6"/></td>
				<td ><input id="txtProduct.*" type="text" class="txt c7"/></td>
				<td ><input id="txtClass.*" type="text" class="txt c6" /></td>
				<td><input class="txt num c8" id="textSize1.*" type="text" disabled="disabled"/><div id="x1.*" style="float: left"> x</div>
						<input class="txt num c8" id="textSize2.*" type="text" disabled="disabled"/><div id="x2.*" style="float: left"> x</div>
						<input class="txt num c8" id="textSize3.*" type="text" disabled="disabled"/><div id="x3.*" style="float: left"> x</div>
						<input class="txt num c8" id="textSize4.*" type="text" disabled="disabled"/>
						<!--上為虛擬下為實際-->
						<input id="txtRadius.*" type="hidden"/>
						<input  id="txtWidth.*" type="hidden"/>
						<input  id="txtDime.*" type="hidden"/>
						<input id="txtLengthb.*" type="hidden"/>
						<input class="txt c1" id="txtSpec.*" type="text"/>
				</td>
				<td ><input id="txtSize.*" type="text" class="txt c7"/></td>
				<td ><input id="txtUnit.*" type="text" class="txt c7"/></td>
				<td ><input id="txtMount.*" type="text"  class="txt num c7"/></td>
				<td ><input id="txtWeight.*" type="text"  class="txt num c7" /></td>
				<td ><input id="txtPrice.*" type="text" class="txt num c7" /></td>
				<td >
					<input id="txtTotal.*" type="text" class="txt num c7" />
					<input id="txtTheory.*" type="text" class="txt num c7" />
				</td>
				<td><input id="txtMemo.*" type="text" class="txt c7"/>
				<input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" />
				</td>
				<td ><input id="txtGweight.*" type="text" class="txt num c7" /></td>
				<td ><input id="txtEweight.*" type="text" class="txt num c7" /></td>
				<!--
				<td ><input id="txtOrdgweight.*" type="text" class="txt num c7" /></td>
				<td ><input id="txtOrdeweight.*" type="text" class="txt num c7" /></td>
				-->
				<td align="center"><input id="chkEnda.*" type="checkbox"/></td>
			</tr>
		</table>
		</div>
		</div>
		<input id="q_sys" type="hidden" />
</body>
</html>
