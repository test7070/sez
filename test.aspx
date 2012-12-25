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

			var q_name = "car2";
			var q_readonly = ['txtCardeal', 'txtCarowner', 'cmbSex', 'txtIdno', 'txtBirthday', 'txtTel1', 'txtTel2', 'txtMobile', 'txtFax', 'txtAddr_conn', 'txtAddr_home', 'txtDriver'];
			var bbmNum = [['txtInmoney', 10, 0], ['txtOutmoney', 10, 0], ['txtIrange', 10, 0], ["txtManage", 10, 0], ["txtGuile", 10, 0], ["txtLabor", 10, 0], ["txtHealth", 10, 0], ["txtReserve", 10, 0], ["txtHelp", 10, 0], ["txtVrate", 5, 2], ["txtRrate", 5, 2], ["txtOrate", 5, 2], ["txtIrate", 5, 2], ["txtPrate", 5, 2], ["txtUlicense", 10, 0], ["txtDlicense", 10, 0], ["txtSpring", 10, 0], ["txtSummer", 10, 0], ["txtFalla", 10, 0], ["txtWinter", 10, 0], ["txtCylinder", 2, 0], ["txtSalemoney", 10, 0], ["txtImprovemoney1", 10, 0], ["txtImprovemoney2", 10, 0], ["txtImprovemoney3", 10, 0], ["txtDiscountmoney", 10, 0], ["txtDurableyear", 2,0,0,0]];
			var bbmMask = [["txtIndate", "999/99/99"], ["txtOutdate", "999/99/99"], ["txtPassdate", "999/99/99"], ["txtLimitdate", "999/99/99"], ["txtCheckdate", "999/99/99"], ["txtCaryear", "9999"], ["txtCaryeartw", "999/99"], ["txtSaledate", "999/99/99"], ["txtImprovedate1", "999/99/99"], ["txtImprovedate2", "999/99/99"], ["txtImprovedate3", "999/99/99"], ["txtDiscountdate", "999/99/99"], ["txtStopdate", "999/99/99"], ["txtOverdate", "999/99/99"], ["txtEnddate", "999/99/99"]];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			//ajaxPath = ""; //  execute in Root
			q_alias = 'a';
			aPop = [['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'], ['txtCarownerno', 'lblCarowner', 'carowner', 'noa,namea,sex,idno,birthday,tel1,tel2,mobile,fax,addr_conn,addr_home', 'txtCarownerno,txtCarowner,cmbSex,txtIdno,txtBirthday,txtTel1,txtTel2,txtMobile,txtFax,txtAddr_conn,txtAddr_home', 'carowner_b.aspx'], ['txtSssno', 'lblSss', 'sss', 'noa,namea', 'txtSssno', 'sss_b.aspx'], ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']];

			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1)

			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}

				mainForm(0);
			}

			function mainPost() {
				q_mask(bbmMask);
				q_cmbParse("cmbSex", q_getPara('sys.sex'));
				q_cmbParse("cmbChecktype", q_getPara('car2.checktype'));
				q_cmbParse("cmbCartype", q_getPara('car2.cartype'));
				q_cmbParse("cmbIsprint", q_getPara('car2.isprint'));
				q_cmbParse("cmbAuto", q_getPara('car2.auto'));

				q_gt('carbrand', '', 0, 0, 0, "");
				q_gt('carkind', '', 0, 0, 0, "");
				q_gt('carspec', '', 0, 0, 0, "");
				q_gt('carstyle', '', 0, 0, 0, "");

				fbbm[fbbm.length] = 'cmbAuto';
				fbbm[fbbm.length] = 'txtIrange';
				fbbm[fbbm.length] = 'txtManage';
				fbbm[fbbm.length] = 'txtGuile';
				fbbm[fbbm.length] = 'txtLabor';
				fbbm[fbbm.length] = 'txtHealth';
				fbbm[fbbm.length] = 'txtReserve';
				fbbm[fbbm.length] = 'txtHelp';
				fbbm[fbbm.length] = 'txtVrate';
				fbbm[fbbm.length] = 'txtRrate';
				fbbm[fbbm.length] = 'txtOrate';
				fbbm[fbbm.length] = 'txtIrate';
				fbbm[fbbm.length] = 'txtPrate';
				fbbm[fbbm.length] = 'txtUlicense';
				fbbm[fbbm.length] = 'txtDlicense';
				fbbm[fbbm.length] = 'txtSpring';
				fbbm[fbbm.length] = 'txtSummer';
				fbbm[fbbm.length] = 'txtFalla';
				fbbm[fbbm.length] = 'txtWinter';
				fbbm[fbbm.length] = 'txtUlicensemon';
				fbbm[fbbm.length] = 'txtDlicensemon';
				fbbm[fbbm.length] = 'txtSpringmon';
				fbbm[fbbm.length] = 'txtSummermon';
				fbbm[fbbm.length] = 'txtFallamon';
				fbbm[fbbm.length] = 'txtWintermon';
				fbbm[fbbm.length] = 'txtImprovedate1';
				fbbm[fbbm.length] = 'txtImprovemoney1';
				fbbm[fbbm.length] = 'txtImprovedate2';
				fbbm[fbbm.length] = 'txtImprovemoney2';
				fbbm[fbbm.length] = 'txtImprovedate3';
				fbbm[fbbm.length] = 'txtImprovemoney3';
				fbbm[fbbm.length] = 'txtDiscountdate';
				fbbm[fbbm.length] = 'txtDiscountmoney';
				fbbm[fbbm.length] = 'txtSaledate';
				fbbm[fbbm.length] = 'txtSalemoney';

				$('#divCarexpense').find("input:text").bind('keydown', function(event) {
					keypress_bbm(event, $(this), fbbm, 'lblClose_DivCarexpense', bbmNum);
				});

				$('#divCarexpense').offset({
					top : $('.tr3').eq(0).offset().top,
					left : $('.tbbm').eq(0).offset().left + 10
				});
				$('#lblCarexpense').parent().click(function(e) {
					if ($('#divCarexpense').is(":hidden")) {
						$('#divCarexpense').show();
						$('#cmbAuto').focus();
					} else
						$('#divCarexpense').hide();
				});
				$('#lblClose_DivCarexpense').parent().click(function(e) {
					$('#lblCarexpense').parent().click();
				});
				$('#lblCarinsurance').parent().click(function(e) {
					q_box("carinsure.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'carinsure', "90%", "600px", q_getMsg("popCarinsure"));
				});
				$('#lblCarlender').parent().click(function(e) {
					q_box("carlender.aspx?;;;noa='" + $('#txtCarownerno').val() + "'", 'carlender', "95%", "95%", q_getMsg("popCarlender"));
				});
				$('#lblCaraccident').parent().click(function(e) {
					q_box("caraccident.aspx?;;;noa='" + $('#txtCarno').val() + "'", 'caraccident', "90%", "600px", q_getMsg("popCaraccident"));
				});
				$('#lblCarchange').parent().click(function(e) {
					q_box("carchange.aspx?;;;noa='" + $('#txtCarno').val() + "'", 'carchange', "90%", "600px", q_getMsg("popCarchange"));
				});
				$('#lblOil').parent().click(function(e) {
					q_box("oil.aspx?;;;carno='" + $('#txtCarno').val() + "'", 'oil', "90%", "600px", q_getMsg("popOil"));
				});
				$('#lblCartax').parent().click(function(e) {
					q_box("cartax.aspx?;;;noa='" + $('#txtCarno').val() + "'", 'cartax', "90%", "600px", q_getMsg("popCartax"));
				});
				
				//--11/21大昌改管理費+公會費=行費
				if(q_getPara('sys.comp').indexOf('大昌')>-1){
					$('#divGuile').hide();
					$('#lblGuile').hide();
					$('#txtGuile').hide();
				}
				
			     $('#txtInmoney').change(function () {
			     	if(!emp($('#txtInmoney').val())){
			     		if(dec($('#txtInmoney').val())>=1000000){
			     			$('#txtDurableyear').val(10);
			     		}else{
			     			if(replaceAll($('#txtNoa').val(),'-','').length==4)//板台
			     				$('#txtDurableyear').val(5);
			     			else	//車頭
			     				$('#txtDurableyear').val(4);
			     		}
			     	}
			     });
			      $('#txtImprovedate1').change(function () {
				 		Sale();
			     });
			      $('#txtImprovemoney1').change(function () {
				 		Sale();
			     });
			      $('#txtImprovedate2').change(function () {
				 		Sale();
			     });
			      $('#txtImprovemoney2').change(function () {
				 		Sale();
			     });
			      $('#txtImprovedate3').change(function () {
				 		Sale();
			     });
			      $('#txtImprovemoney3').change(function () {
				 		Sale();
			     });
			      $('#txtDiscountdate').change(function () {
				 		Sale();
			     });
			      $('#txtDiscountmoney').change(function () {
				 		Sale();
			     });
			     $('#txtSaledate').change(function () {
				 		Sale();
			     });
			     
			     $('#divSale').find("input:text").bind('keydown', function(event) {
					keypress_bbm(event, $(this), fbbm, 'lblClose_DivSale', bbmNum);
				});

				$('#divSale').offset({
					top : $('.tr3').eq(0).offset().top,
					left : $('.tbbm').eq(0).offset().left + 10
				});
			     $('#lblSale').parent().click(function(e) {
					if ($('#divSale').is(":hidden")) {
						$('#divSale').show();
						$('#cmbAuto').focus();
					} else
						$('#divSale').hide();
				});
				$('#lblClose_DivSale').parent().click(function(e) {
					$('#lblSale').parent().click();
				});
			}

			function q_boxClose(s2) {

				var ret;
				switch (b_pop) {

					case q_name + '_s':
						q_boxClose2(s2);
						///   q_boxClose 3/4
						break;
				}   /// end Switch

			}

			function q_gfPost() {

			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'carbrand':
						var as = _q_appendData("carbrand", "", true);
						var t_item = " @ ";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].brand;
						}
						q_cmbParse("cmbCarbrandno", t_item);
						$("#cmbCarbrandno").val(abbm[q_recno].carbrandno);
						break;
					case 'carkind':
						var as = _q_appendData("carkind", "", true);
						var t_item = " @ ";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].kind;
						}
						q_cmbParse("cmbCarkindno", t_item);
						$("#cmbCarkindno").val(abbm[q_recno].carkindno);
						break;
					case 'carspec':
						var as = _q_appendData("carspec", "", true);
						var t_item = " @ ";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].spec;
						}
						q_cmbParse("cmbCarspecno", t_item);
						$("#cmbCarspecno").val(abbm[q_recno].carspecno);
						break;
					case 'carstyle':
						var as = _q_appendData("carstyle", "", true);
						var t_item = " @ ";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].style;
						}
						q_cmbParse("cmbCarstyleno", t_item);
						$("#cmbCarstyleno").val(abbm[q_recno].carstyleno);
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();

						if (q_cur == 1 || q_cur == 2)
							q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('car2_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;

				_btnModi();
				$('#txtNoa').focus();
			}

			function btnPrint() {

			}

			function btnOk() {
				var t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtComp', q_getMsg('lblComp')]]);

				var t_noa = $('#txtNoa').val();
				$('#txtCarno').val(t_noa);
				wrServer(t_noa);
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

			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function q_appendData(t_Table) {
				dataErr = !_q_appendData(t_Table);
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
			function Sale() {
				//-----------------------折舊計算------------------------
				var depmoney=0;	//折舊後金額
				if(dec($('#txtInmoney').val())<=1000)	//取得金額1000以下不折舊
					depmoney=dec($('#txtInmoney').val());
				if(!emp($('#txtSaledate').val())&&dec($('#txtInmoney').val())>0 && dec($('#txtDurableyear').val())>0){
					//取得到開發票月數
					var t_mon=(dec($('#txtSaledate').val().substr(0,3))*12+dec($('#txtSaledate').val().substr(4,2)))-(dec($('#txtIndate').val().substr(0,3))*12+dec($('#txtIndate').val().substr(4,2)))
					//折舊後金額
					depmoney=round(dec($('#txtInmoney').val())-((dec($('#txtInmoney').val())/(dec($('#txtDurableyear').val())+1)/12)*t_mon),0)
					
					if(depmoney<0) depmoney=0;//已超過耐用年數才會為負值
				}
				//--------------------------改良計算---------------------------------
				var imsale1=0,imsale2=0,imsale3=0;//改良後金額
				if(!emp($('#txtImprovedate1').val())&&dec($('#txtImprovemoney1').val())>0 && !emp($('#txtSaledate').val()) && dec($('#txtDurableyear').val())>0){//改良1
					//改良日至耐用年限月數=取得日+耐用-改良日
					var t_imon1=(dec($('#txtIndate').val().substr(0,3))*12+dec($('#txtIndate').val().substr(4,2))+(dec($('#txtDurableyear').val())*12))-(dec($('#txtImprovedate1').val().substr(0,3))*12+dec($('#txtImprovedate1').val().substr(4,2)));
					//改良日至開發票月數=開發票日-改良日
					var t_ismon1=(dec($('#txtSaledate').val().substr(0,3))*12+dec($('#txtSaledate').val().substr(4,2)))-(dec($('#txtImprovedate1').val().substr(0,3))*12+dec($('#txtImprovedate1').val().substr(4,2)));
					//改良餘額
					imsale1=dec($('#txtImprovemoney1').val())-(dec($('#txtImprovemoney1').val())/(t_imon1+12)*t_ismon1);
					
					if(imsale1<0)	imsale1=0;//已超過耐用年數才會為負值
				}
				if(!emp($('#txtImprovedate2').val())&&dec($('#txtImprovemoney2').val())>0 && !emp($('#txtSaledate').val()) && dec($('#txtDurableyear').val())>0){//改良2
					var t_imon2=(dec($('#txtIndate').val().substr(0,3))*12+dec($('#txtIndate').val().substr(4,2))+(dec($('#txtDurableyear').val())*12))-(dec($('#txtImprovedate2').val().substr(0,3))*12+dec($('#txtImprovedate2').val().substr(4,2)));
					var t_ismon2=(dec($('#txtSaledate').val().substr(0,3))*12+dec($('#txtSaledate').val().substr(4,2)))-(dec($('#txtImprovedate2').val().substr(0,3))*12+dec($('#txtImprovedate2').val().substr(4,2)));
					imsale2=dec($('#txtImprovemoney2').val())-(dec($('#txtImprovemoney2').val())/(t_imon2+12)*t_ismon2);
					
					if(imsale2<0)	imsale2=0;//已超過耐用年數才會為負值
				}
				if(!emp($('#txtImprovedate3').val())&&dec($('#txtImprovemoney3').val())>0 && !emp($('#txtSaledate').val()) && dec($('#txtDurableyear').val())>0){//改良3
					var t_imon3=(dec($('#txtIndate').val().substr(0,3))*12+dec($('#txtIndate').val().substr(4,2))+(dec($('#txtDurableyear').val())*12))-(dec($('#txtImprovedate3').val().substr(0,3))*12+dec($('#txtImprovedate3').val().substr(4,2)));
					var t_ismon3=(dec($('#txtSaledate').val().substr(0,3))*12+dec($('#txtSaledate').val().substr(4,2)))-(dec($('#txtImprovedate3').val().substr(0,3))*12+dec($('#txtImprovedate3').val().substr(4,2)));
					imsale3=dec($('#txtImprovemoney3').val())-(dec($('#txtImprovemoney3').val())/(t_imon3+12)*t_ismon3);
					
					if(imsale3<0)	imsale3=0;//已超過耐用年數才會為負值
				}
				//------------------------------發票資售金額=原價折舊金額+改良折舊金額-折讓(折減)金額---------------------------------------
				q_tr('txtSalemoney',round(depmoney+imsale1+imsale2+imsale3-dec($('#txtDiscountmoney').val()),0));
				
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 23%;
			}
			.tview {
				width: 100%;
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
				float: left;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 75%;
			}
			.tbbm {
				margin: 0;
				padding: 2px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
				float: left;
			}
			.tbbm tr {
				height: 35px;
			}
			.td1, .td3, .td5, .td7 {
				width: 9%;
			}
			.td2, .td4, .td6, .td8 {
				width: 11%;
			}
			.label {
				float: right;
			}
			.popDiv {
				position: absolute;
				z-index: 99;
				background: #4297D7;
				height: 370px;
				width: 500px;
				border: 2px #EEEEEE solid;
				border-radius: 5px;
				padding-top: 10px;
				display: none;/*default*/
			}
			.popDiv .block {
				border: 1px #CCD9F2 solid;
				border-radius: 5px;
			}
			.popDiv .block .col {
				display: block;
				width: 600px;
				height: 30px;
				margin-top: 5px;
				margin-left: 5px;
			}
			.btnLbl {
				background: #cad3ff;
				border-radius: 5px;
				display: block;
				width: 95px;
				height: 25px;
				float: left;
				cursor: default;
			}
			.btnLbl.tb {
				float: right;
			}
			.btnLbl.button {
				cursor: pointer;
				background: #76A2FE;
			}
			.btnLbl.button.close {
				background: #cad3ff;
			}
			.btnLbl.button:hover {
				background: #FF8F19;
			}
			.btnLbl a {
				color: blue;
				font-size: medium;
				height: 25px;
				line-height: 25px;
				display: block;
				text-align: center;
			}
			.btnLbl.button a {
				color: #000000;
			}
			.btnLbl.close a {
				color: red;
				font-size: 16px;
				height: 25px;
				line-height: 25px;
				display: block;
				text-align: center;
			}
			.tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            input[type="text"],input[type="button"] {     
                font-size: medium;
            }
		</style>
	</head>
	<body>

		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td class="td1" style="width:10%"><a id='vewChk'></a></td>
						<td class="td2" style="width:30%"><a id='vewCarno'></a></td>
						<td class="td3" style="width:30%"><a id='vewCarowner'></a></td>
						<td class="td4" style="width:30%"><a id='vewDriver'></a></td>
					</tr>
					<tr>
						<td class="td1">
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td class="td2" id='carno'>~carno</td>
						<td class="td3" id='carowner'>~carowner</td>
						<td class="td4" id='driver'>~driver</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<div style="border: 1px solid #000000;border-radius: 5px;">
					<table class="tbbm"  id="tbbm">
						<tr class="tr0">
							<td class="td1" >
							<div class='btnLbl tb'>
								<a id='lblNoa'></a>
							</div></td>
							<td class="td2" >
							<input id="txtNoa"  type="text"  style='width:95%; max-width: 200px; float:left;'/>
							<input id="txtCarno" type="text"  style='display:none;'/>
							</td>
							<td class="td3" >
							<div class='btnLbl tb'>
								<a id='lblCarkind'></a>
							</div></td>
							<td class="td4" ><select id="cmbCarkindno" style="width:95%;"></select></td>
							<td class="td5" >
								<div class='btnLbl tb'>
									<a id='lblCarstyle'></a>
								</div>
							</td>
							<td class="td6" colspan="3"><select id="cmbCarstyleno" style="width:95%;"></select></td>
						</tr>
						<tr class="tr1">
							<td class="td1">
							<div class='btnLbl tb button'>
								<a id='lblCardeal'></a>
							</div></td>
							<td class="td2" colspan="3">
							<input id="txtCardealno" type="text"  style='width:20%; float:left;'/>
							<input id="txtCardeal" type="text"  style='width:73%; float:left;'/>
							</td>
							<td class="td5">
							<div class='btnLbl tb button'>
								<a id='lblDriver'></a>
							</div></td>
							<td class="td6">
							<input id="txtDriverno" type="text"  style='width:40%; float:left;'/>
							<input id="txtDriver" type="text"  style='width:53%; float:left;'/>
							</td>
							<td class="td7" >
							<div class='btnLbl tb'>
								<a id='lblCarspec'></a>
							</div></td>
							<td class="td8" ><select id="cmbCarspecno" style="width:95%;"></select></td>
						</tr>
						<tr class="tr2">
							<td class="td1" >
							<div class='btnLbl tb button'>
								<a id='lblCarowner'></a>
							</div></td><td class="td2" >
							<input id="txtCarownerno" type="text"  style='width:40%; max-width:200px; float:left;'/>
							<input id="txtCarowner" type="text"  style='width:50%; max-width:200px; float:left;'/>
							</td><td class="td3" >
							<div class='btnLbl tb'>
								<a id='lblSex'></a>
							</div></td><td class="td4" ><select id="cmbSex" style="width:95%;"></select></td><td class="td5" >
							<div class='btnLbl tb'>
								<a id='lblIdno'></a>
							</div></td><td class="td6" >
							<input id="txtIdno" type="text"  style='width:95%; max-width:200px; float:left;'/>
							</td><td class="td7" >
							<div class='btnLbl tb'>
								<a id='lblBirthday'></a>
							</div></td><td class="td8">
							<input id="txtBirthday" type="text"  style='width:95%; max-width:200px; float:left;'/>
							</td>
						</tr>
						<tr class="tr3">
							<td class="td1" >
							<div class='btnLbl tb'>
								<a id='lblTel1'></a>
							</div></td>
							<td class="td2">
							<input id="txtTel1" type="text"  style='width:95%; '/>
							</td>
							<td class="td3">
							<div class='btnLbl tb'>
								<a id='lblTel2'></a>
							</div></td>
							<td class="td4">
							<input id="txtTel2" type="text"  style='width:95%; '/>
							</td>
							<td class="td5">
							<div class='btnLbl tb'>
								<a id='lblMobile'></a>
							</div></td>
							<td class="td6">
							<input id="txtMobile" type="text"  style='width:95%; '/>
							</td>
							<td class="td7">
							<div class='btnLbl tb'>
								<a id='lblFax'></a>
							</div></td>
							<td class="td8">
							<input id="txtFax" type="text"  style='width:95%; '/>
							</td>
						</tr>
						<tr class="tr4">
							<td class="td1" >
							<div class='btnLbl tb'>
								<a id='lblAddr_conn'></a>
							</div></td>
							<td class="td2" colspan="7">
							<input id="txtAddr_conn" type="text"  style='width:95%; '/>
							</td>
						</tr>
						<tr class="tr5">
							<td class="td1" >
							<div class='btnLbl tb'>
								<a id='lblAddr_home'></a>
							</div></td>
							<td class="td2" colspan="7">
							<input id="txtAddr_home" type="text"  style='width:95%; '/>
							</td>
						</tr>
						<tr class="tr6">
							<td class="td1" >
							<div class='btnLbl tb'>
								<a id='lblIndate'></a>
							</div></td>
							<td class="td2" >
							<input id="txtIndate"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td3" >
							<div class='btnLbl tb'>
								<a id='lblInmoney'></a>
							</div></td>
							<td class="td4" >
							<input id="txtInmoney"  type="text"  style='width:95%; max-width: 200px; text-align: right;'/>
							</td>
							<td class="td5" >
							<div class='btnLbl tb'>
								<a id='lblInplace'></a>
							</div></td>
							<td class="td6" >
							<input id="txtInplace"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>

						</tr>
						<tr class="tr7">
							<td class="td1" >
							<div class='btnLbl tb'>
								<a id='lblOutdate'></a>
							</div></td>
							<td class="td2" >
							<input id="txtOutdate"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td3" >
							<div class='btnLbl tb'>
								<a id='lblOutmoney'></a>
							</div></td>
							<td class="td4" >
							<input id="txtOutmoney"  type="text"  style='width:95%; max-width: 200px; text-align: right;'/>
							</td>
							<td class="td5" >
							<div class='btnLbl tb'>
								<a id='lblOutplace'></a>
							</div></td>
							<td class="td6" >
							<input id="txtOutplace"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>

						</tr>
						<tr class="tr8">
							<td class="td1" >
							<div class='btnLbl tb'>
								<a id='lblPassdate'></a>
							</div></td>
							<td class="td2" >
							<input id="txtPassdate"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td3" >
							<div class='btnLbl tb'>
								<a id='lblLimitdate'></a>
							</div></td>
							<td class="td4" >
							<input id="txtLimitdate"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td5" >
							<div class='btnLbl tb'>
								<a id='lblCaryear'></a>
							</div></td>
							<td class="td6" >
							<input id="txtCaryear"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td7" >
							<div class='btnLbl tb'>
								<a id='lblCaryeartw'></a>
							</div></td>
							<td class="td8" >
							<input id="txtCaryeartw"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
						</tr>
						<tr class="tr9">
							<td class="td1" >
							<div class='btnLbl tb'>
								<a id='lblCheckdate'></a>
							</div></td>
							<td class="td2" >
							<input id="txtCheckdate"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td3" >
							<div class='btnLbl tb'>
								<a id='lblCarbrand'></a>
							</div></td>
							<td class="td4" ><select id="cmbCarbrandno" style="width:95%;"></select></td>
							<td class="td5" >
							<div class='btnLbl tb'>
								<a id='lblTon'></a>
							</div></td>
							<td class="td6" >
							<input id="txtTon"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td7" >
							<div class='btnLbl tb'>
								<a id='lblCc'></a>
							</div></td>
							<td class="td8" >
							<input id="txtCc"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
						</tr>
						<tr class="tr10">
							<td class="td1" >
							<div class='btnLbl tb'>
								<a id='lblPassno'></a>
							</div></td>
							<td class="td2" >
							<input id="txtPassno"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td3" >
							<div class='btnLbl tb'>
								<a id='lblCarmode'></a>
							</div></td>
							<td class="td4" >
							<input id="txtCarmode"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td5" >
							<div class='btnLbl tb'>
								<a id='lblChecktype'></a>
							</div></td>
							<td class="td6" ><select id="cmbChecktype" style="width:95%;"></select></td>
							<td class="td7" >
							<div class='btnLbl tb'>
								<a id='lblEngineno'></a>
							</div></td>
							<td class="td8" >
							<input id="txtEngineno"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
						</tr>
						<tr class="tr11">
							<td class="td1" >
							<div class='btnLbl tb'>
								<a id='lblWeight1'></a>
							</div></td>
							<td class="td2" >
							<input id="txtWeight1"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td3" >
							<div class='btnLbl tb'>
								<a id='lblWeight2'></a>
							</div></td>
							<td class="td4" >
							<input id="txtWeight2"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td5" >
							<div class='btnLbl tb'>
								<a id='lblCylinder'></a>
							</div></td>
							<td class="td6" >
							<input id="txtCylinder"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td7" ></td>
							<td class="td8" ></td>
						</tr>
						<tr class="tr12">
							<td class="td1" >
							<div class='btnLbl tb'>
								<a id='lblLengthb'></a>
							</div></td>
							<td class="td2" >
							<input id="txtLengthb"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td3" >
							<div class='btnLbl tb'>
								<a id='lblWidth'></a>
							</div></td>
							<td class="td4" >
							<input id="txtWidth"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td5" >
							<div class='btnLbl tb'>
								<a id='lblHeight'></a>
							</div></td>
							<td class="td6" >
							<input id="txtHeight"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td7" >
							<div class='btnLbl tb'>
								<a id='lblWheelbase'></a>
							</div></td>
							<td class="td8" >
							<input id="txtWheelbase"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
						</tr>
						<tr class="tr13">
							<td class="td1" >
							<div class='btnLbl tb'>
								<a id='lblOverdate'></a>
							</div></td>
							<td class="td2" >
							<input id="txtOverdate"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td3" >
							<div class='btnLbl tb'>
								<a id='lblStopdate'></a>
							</div></td>
							<td class="td4" >
							<input id="txtStopdate"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td5" >
							<div class='btnLbl tb'>
								<a id='lblEnddate'></a>
							</div></td>
							<td class="td6" >
							<input id="txtEnddate"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td7" >
							<div class='btnLbl tb'>
								<a id='lblOldnoa'></a>
							</div></td>
							<td class="td8" >
							<input id="txtOldnoa"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
						</tr>
						<tr class="tr14">
							<td class="td1" >
							<div class='btnLbl tb'>
								<a id='lblReferee'></a>
							</div></td>
							<td class="td2" >
							<input id="txtReferee"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td3" >
							<div class='btnLbl tb'>
								<a id='lblDurableyear'></a>
							</div></td>
							<td class="td4" >
							<input id="txtDurableyear"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<!--<td class="td5" >
							<div class='btnLbl tb'>
								<a id='lblSaledate'></a>
							</div></td>
							<td class="td6" >
							<input id="txtSaledate"  type="text"  style='width:95%; max-width: 200px; '/>
							</td>
							<td class="td7" >
							<div class='btnLbl tb'>
								<a id='lblSalemoney'></a>
							</div></td>
							<td class="td8" >
							<input id="txtSalemoney"  type="text"  style='width:95%; text-align: right;'/>
							</td>-->
						</tr>
						<tr class="tr15">
							<td class="td1" >
							<div class='btnLbl tb'>
								<a id='lblMemo'></a>
							</div></td>
							<td class="td2" colspan='7'><textarea id="txtMemo" rows="5" cols="10" style="width:95%; height: 127px;"></textarea></td>
						</tr>
						<tr class="tr16">
							<td class="td1" >
							<div class='btnLbl tb'>
								<a id='lblCartype'></a>
							</div></td>
							<td class="td2" ><select id="cmbCartype" style="width:95%;"></select></td>
							<td class="td3" >
							<div class='btnLbl tb'>
								<a id='lblIsprint'></a>
							</div></td>
							<td class="td4" ><select id="cmbIsprint" style="width:95%;"></select></td>
							<td class="td5" >
							<div class='btnLbl tb button'>
								<a id='lblSss'></a>
							</div></td>
							<td class="td6" >
							<input id="txtSssno"  type="text"  style='width:95%; max-width: 200px; float:left;'/>
							</td>
						</tr>
					</table>
					<div style="border: 1px solid #000000;border-radius: 5px; height:30px; padding: 5px 0 0 5px; ">
						<div id='divlblCarexpense' class='btnLbl button'>
							<a id='lblCarexpense'></a>
						</div>
						<div id='divlblCarinsurance' class='btnLbl button'>
							<a id='lblCarinsurance'></a>
						</div>
						<!--<div class='btnLbl button'>
							<a id='lblCarlender'></a>
						</div>-->
						<div id='divlblCaraccident' class='btnLbl button'>
							<a id='lblCaraccident'></a>
						</div>
						<div id='divlblCarchange' class='btnLbl button'>
							<a id='lblCarchange'></a>
						</div>
						<div id='divlblOil' class='btnLbl button'>
							<a id='lblOil'></a>
						</div>
						<div id='divlblCartax' class='btnLbl button'>
							<a id='lblCartax'></a>
						</div>
						<div id='divlblSale' class='btnLbl button'>
							<a id='lblSale'></a>
						</div>
					</div>
				</div>

			</div>
			<input id="q_sys" type="hidden" />
		</div>
		<div id="divCarexpense" class='popDiv'>
			<div class="block">
				<div class="col">
					<div class='btnLbl'>
						<a id='lblAuto'></a>
					</div>
					<div style='width:150px; float:left;'>
						<select id="cmbAuto" style="margin-left:5px; width: 85px; text-align: right;"></select>
					</div>
					<div class='btnLbl'>
						<a id='lblIrange'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtIrange"  type="text"  style='margin-left:5px; width: 85px; text-align: right;'/>
					</div>
				</div>
			</div>
			<div class="block">
				<div class="col">
					<div class='btnLbl'>
						<a id='lblManage'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtManage"  type="text"  style='margin-left:5px; width: 85px; text-align: right;'/>
					</div>
					<div class='btnLbl' id ='divGuile'>
						<a id='lblGuile'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtGuile"  type="text"  style='margin-left:5px; width: 85px; text-align: right;'/>
					</div>
				</div>
				<div class="col" style="display: none;">
					<div class='btnLbl'>
						<a id='lblLabor'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtLabor"  type="text"  style='margin-left:5px; width: 85px; text-align: right;'/>
					</div>
					<div class='btnLbl'>
						<a id='lblHealth'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtHealth"  type="text"  style='margin-left:5px; width: 85px; text-align: right;'/>
					</div>
				</div>
				<div class="col">
					<div class='btnLbl'>
						<a id='lblReserve'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtReserve"  type="text"  style='margin-left:5px; width: 85px; text-align: right;'/>
					</div>
					<div class='btnLbl'>
						<a id='lblHelp'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtHelp"  type="text"  style='margin-left:5px; width: 85px; text-align: right;'/>
					</div>
				</div>
			</div>
			<div class="block">
				<div class="col">
					<div class='btnLbl'>
						<a id='lblVrate'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtVrate"  type="text"  style='margin-left:5px; width: 85px; text-align: right;'/>
					</div>
					<div class='btnLbl'>
						<a id='lblRrate'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtRrate"  type="text"  style='margin-left:5px; width: 85px; text-align: right;'/>
					</div>
				</div>
				<div class="col">
					<div class='btnLbl'>
						<a id='lblOrate'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtOrate"  type="text"  style='margin-left:5px; width: 85px; text-align: right;'/>
					</div>
					<div class='btnLbl'>
						<a id='lblIrate'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtIrate"  type="text"  style='margin-left:5px; width: 85px; text-align: right;'/>
					</div>
				</div>
				<div class="col">
					<div class='btnLbl'>
						<a id='lblPrate'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtPrate"  type="text"  style='margin-left:5px; width: 85px; text-align: right;'/>
					</div>
				</div>
			</div>
			<div class="block">
				<div class="col">
					<div class='btnLbl'>
						<a id='lblUlicense'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtUlicense"  type="text"  style='margin-left:5px; width: 85px; text-align: right; float:left;'/>
						<input id="txtUlicensemon"  type="text"  style='margin-left:5px; width: 20px; text-align: center; float:left;'/>
						<a id='lblUlicense_memo' style='color:white; font-size: 12px; height:30px; line-height: 30px;'></a>
					</div>
					<div class='btnLbl'>
						<a id='lblDlicense'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtDlicense"  type="text"  style='margin-left:5px; width: 85px; text-align: right; float:left;'/>
						<input id="txtDlicensemon"  type="text"  style='margin-left:5px; width: 20px; text-align: center; float:left;'/>
						<a id='lblDlicense_memo' style='color:white; font-size: 12px;height:30px; line-height: 30px;'></a>
					</div>
				</div>
			</div>
			<div class="block">
				<div class="col">
					<div class='btnLbl'>
						<a id='lblSpring'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtSpring"  type="text"  style='margin-left:5px; width: 85px; text-align: right; float:left;'/>
						<input id="txtSpringmon"  type="text"  style='margin-left:5px; width: 20px; text-align: center; float:left;'/>
						<a id='lblSpring_memo' style='color:white; font-size: 12px;height:30px; line-height: 30px;'></a>
					</div>
					<div class='btnLbl'>
						<a id='lblSummer'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtSummer"  type="text"  style='margin-left:5px; width: 85px; text-align: right; float:left;'/>
						<input id="txtSummermon"  type="text"  style='margin-left:5px; width: 20px; text-align: center; float:left;'/>
						<a id='lblSummer_memo' style='color:white; font-size: 12px;height:30px; line-height: 30px;'></a>
					</div>
				</div>
				<div class="col">
					<div class='btnLbl'>
						<a id='lblFalla'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtFalla"  type="text"  style='margin-left:5px; width: 85px; text-align: right; float:left;'/>
						<input id="txtFallamon"  type="text"  style='margin-left:5px; width: 20px; text-align: center; float:left;'/>
						<a id='lblFalla_memo' style='color:white; font-size: 12px;height:30px; line-height: 30px;'></a>
					</div>
					<div class='btnLbl'>
						<a id='lblWinter'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtWinter"  type="text"  style='margin-left:5px; width: 85px; text-align: right; float:left;'/>
						<input id="txtWintermon"  type="text"  style='margin-left:5px; width: 20px; text-align: center; float:left;'/>
						<a id='lblWinter_memo' style='color:white; font-size: 12px;height:30px; line-height: 30px;'></a>
					</div>
				</div>
			</div>
			<div class="block">
				<div class='btnLbl button close' style="position:relative; top:5px; left:200px;">
					<a id='lblClose_DivCarexpense'></a>
				</div>
			</div>
		</div>
		
		<div id="divSale" class='popDiv' style="height: 220px;">
			<div class="block">
				<div class="col">
					<div class='btnLbl' style='width:105px;'>
						<a id='lblImprovedate1'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtImprovedate1"  type="text"  style='margin-left:5px; width: 100px; text-align: left; float:left;'/>
					</div>
					<div class='btnLbl' style='width:105px;'>
						<a id='lblImprovemoney1'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtImprovemoney1"  type="text"  style='margin-left:5px; width: 100px; text-align: right; float:left;'/>
					</div>
				</div>
				<div class="col">
					<div class='btnLbl' style='width:105px;'>
						<a id='lblImprovedate2'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtImprovedate2"  type="text"  style='margin-left:5px; width: 100px; text-align: left; float:left;'/>
					</div>
					<div class='btnLbl' style='width:105px;'>
						<a id='lblImprovemoney2'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtImprovemoney2"  type="text"  style='margin-left:5px; width: 100px; text-align: right; float:left;'/>
					</div>
				</div>
				<div class="col">
					<div class='btnLbl' style='width:105px;'>
						<a id='lblImprovedate3'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtImprovedate3"  type="text"  style='margin-left:5px; width: 100px; text-align: left; float:left;'/>
					</div>
					<div class='btnLbl' style='width:105px;'>
						<a id='lblImprovemoney3'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtImprovemoney3"  type="text"  style='margin-left:5px; width: 100px; text-align: right; float:left;'/>
					</div>
				</div>
				<div class="col">
					<div class='btnLbl' style='width:105px;'>
						<a id='lblDiscountdate'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtDiscountdate"  type="text"  style='margin-left:5px; width: 100px; text-align: left; float:left;'/>
					</div>
					<div class='btnLbl' style='width:105px;'>
						<a id='lblDiscountmoney'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtDiscountmoney"  type="text"  style='margin-left:5px; width: 100px; text-align: right; float:left;'/>
					</div>
				</div>
			</div>
			<div class="block">
				<div class="col">
					<div class='btnLbl' style='width:105px;'>
						<a id='lblSaledate'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtSaledate"  type="text"  style='margin-left:5px; width: 100px; text-align: left; float:left;'/>
					</div>
					<div class='btnLbl' style='width:105px;'>
						<a id='lblSalemoney'></a>
					</div>
					<div style='width:150px; float:left;'>
						<input id="txtSalemoney"  type="text"  style='margin-left:5px; width: 100px; text-align: right; float:left;'/>
					</div>
				</div>
			</div>
			<div class="block">
				<div class='btnLbl button close' style="position:relative; top:5px; left:200px;">
					<a id='lblClose_DivSale'></a>
				</div>
			</div>
		</div>

	</body>
</html>
