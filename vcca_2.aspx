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

			var q_name = "vcca";
			var q_readonly = ['txtTotal', 'txtChkno', 'txtTax', 'txtAccno', 'txtWorker'];
			var bbmNum = [['txtMoney', 15, 1], ['txtTax', 15, 0], ['txtTotal', 15, 0], ['txtMount', 15, 3]];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtComp2', 'acomp_b.aspx'], ['txtCustno', 'lblCust', 'cust', 'noa,comp,serial,addr_invo,nick', 'txtCustno,txtComp,txtSeria,txtAddress,txtNick', 'cust_b.aspx'], ['txtBuyerno', 'lblBuyer', 'cust', 'noa,comp', 'txtBuyerno,txtBuyer', 'cust_b.aspx'], ['txtProductno', 'lblProductno', 'ucca', 'noa,product,unit', 'txtProductno,txtProduct,txtUnit', 'ucca_b.aspx']);

			function currentData() {
			}


			currentData.prototype = {
				data : [],
				/*新增時複製的欄位*/
				include : ['txtDatea', 'txtCno', 'txtComp2', 'txtCustno', 'txtComp', 'txtNick', 'txtSeria', 'txtAddress', 'txtMon','txtNoa','txtBuyerno','txtBuyer'],
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
				q_gt(q_name, q_content, q_sqlCount, 1)
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

				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				$('#txtMount').change(function() {
					sum();
				});
				$('#txtMoney').change(function() {
					sum();
				});

				$('#txtTax').change(function() {
					sum();
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

			var ins = false;
			//判斷是否在新增狀態
			var noaerror = false;
			//判斷發票號碼是否有錯誤

			function q_gtPost(t_name) {/// 資料下載後 ...
				switch (t_name) {
					case 'vccar':
						var as = _q_appendData("vccar", "", true);
						if (as[0] == undefined) {
							noaerror = true;
							alert("發票號碼不在範圍內或已輸入過");
						} else {
							noaerror = false;
							ins = false;
							btnOk();
						}
						break;
					case 'vcca1':
						var as = _q_appendData("vcca", "", true);
						if (!(as[0] == undefined))
							$('#txtNoa').val((as[0].noa).substr(0, as[0].noa.length - 2));
						break;
					case q_name:
						if (q_cur == 4)// 查詢
							q_Seek_gtPost();
						break;
				}/// end switch

				if (noaerror == true)
					return;
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCno', q_getMsg('lblAcomp')]]);
				// 檢查空白
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				/*if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
				 {
				 q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
				 }*/

				if (ins == true) {
					//判斷發票號碼是否存在或超過
					var t_where = "where=^^ cno = '" + $('#txtCno').val() + "' and bdate<='" + $('#txtDatea').val() + "' and edate>='" + $('#txtDatea').val()//判斷發票的日期
					+ "' and binvono<='" + $('#txtNoa').val() + "' and einvono>='" + $('#txtNoa').val()//判斷發票的範圍
					+ "' and '" + $('#txtNoa').val() + "' not in (select noa from vcca ) and len(binvono)=len('" + $('#txtNoa').val() + "') ^^";
					//判斷是否已存在與長度是否正確
					q_gt('vccar', t_where, 0, 0, 0, "", r_accy);
				} else {
					$('#txtWorker').val(r_name)
					sum();
					$('#txtNoa').attr('readonly', true);
					wrServer(s1);
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('vcca_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function combPay_chg() {   /// 只有 comb 開頭，才需要寫 onChange()   ，其餘 cmb 連結資料庫
			}

			function btnIns() {
				curData.copy();
				_btnIns();
				curData.paste();
				
				
				//發票號碼+1	
				var t_noa=trim($('#txtNoa').val());
				var t_noa_num=dec(t_noa.substr(2))+1;
				
				if(t_noa_num.toString().length==8)
					$('#txtNoa').val(t_noa.substr(0, 2)+t_noa_num);
				else
					$('#txtNoa').val(t_noa.substr(0, 2)+'0'+t_noa_num);
					
				//$('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				//取上個發票號碼並將後兩個數字拿掉
				//後面再寫判斷時間之間差12天
				//var t_where = "where=^^ datea between '" + q_date().substr(0, 6) + "' and '" + q_date() + "' and noa not like '%退貨%' ^^";
				ins = true;
				//q_gt('vcca1', t_where, 0, 0, 0, "", r_accy);
				$('#cmbTaxtype').val(1);
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
				$('#txtNoa').attr('readonly', true);
				//讓發票號碼不可修改

			}

			function btnPrint() {

			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function sum() {
				
				q_tr('txtTotal', Math.round(q_float('txtMount')*q_float('txtMoney')));
				calTax2();
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
				$('#txtNoa').attr('readonly', 'readonly');
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
			
			function calTax2(taxtype) {
			    if (!(q_cur > 0 && q_cur < 4))
			        return;
			    var cmb = document.getElementById("cmbTaxtype");
			    if (!cmb) {
			        alert('cmbTaxtype 不存在');
			        return;
			    }
			
			    if (!taxtype)
			        taxtype = cmb.value;
			
			    if (!taxtype) {
			        alert('稅別異常');
			        return;
			    }
			
			    taxtype = trim(taxtype);
			    var t_taxrate = dec(q_getPara('taxrate'))/100;
			    var t_money = Math.round(q_float('txtMount')*q_float('txtMoney')), t_tax = 0;
			    $('#txtTax').attr('readonly', true);
			    $('#txtTax').css('background', t_background2);
			
			    switch (taxtype) {
			        case '1':  // 應稅
			            t_tax = round(t_money * t_taxrate, 0);
			            q_tr('txtTax', t_tax, 0);
			            q_tr('txtTotal', t_money + t_tax, 0);
			            break;
			        case '2': //零稅率
			        case '4':  // 免稅
			            $('#txtTax').val(0);
			            q_tr('txtTotal', t_money, 0);
			            break;
			        case '3':  // 內含
			            t_tax = round(t_money / (1 + t_taxrate), 0) * t_taxrate;
			            q_tr('txtTax', t_tax, 0);
			            q_tr('txtTotal', t_money, 0);
			            q_tr('txtMoney', t_money - t_tax, 0);
			            break;
			        case '5':  // 自定
			            $('#txtTax').attr('readonly', false);
			            $('#txtTax').css('background', t_background);
			
			            q_tr('txtTotal', q_float('txtTax') + t_money, 0);
			            break;
			
			
			        default:
			
			    }
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
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
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview" style="float: left;  width:32%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:20%"><a id='vewNoa'></a></td>
						<td align="center" style="width:10%"><a id='vewDatea'></a></td>
						<td align="center" style="width:20%"><a id='vewNick'></a></td>
						<td align="center" style="width:10%"><a id='vewTotal'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox"/>
						</td>
						<td id='noa'>~noa</td>
						<td id='datea'>~datea</td>
						<td id='nick' style="text-align: left;">~nick</td>
						<td id='total' style="text-align: right;">~total</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 68%;float:left">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
					<tr class="tr1">
						<td class="td1"><span> </span><a id='lblDatea' class="lbl"></a></td>
						<td class="td2">
						<input id="txtDatea"  type="text"  class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblAcomp" class="lbl btn"></a></td>
						<td class="td4" colspan="3">
						<input id="txtCno" type="text" class="txt c2"/>
						<input id="txtComp2" type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id='lblNoa' class="lbl"></a></td>
						<td class="td2">
						<input id="txtNoa"  type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblCust" class="lbl btn" ></td>
						<td class="td4" colspan="3">
						<input id="txtCustno"  type="text"  class="txt c2"/>
						<input id="txtComp" type="text"  class="txt c3"/>
						<input id="txtNick" type="text"  style="display:none;"/>
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id='lblSeria' class="lbl"></a></td>
						<td class="td2">
						<input id="txtSeria" type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblAddress' class="lbl"></a></td>
						<td class="td4" colspan="3">
						<input id="txtAddress"  type="text" style="width: 99%;float: left;"/>
						</td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblMon' class="lbl"></a></td>
						<td class="td2">
							<input id="txtMon"  type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblProductno' class="lbl btn"></a></td>
						<td class="td4">
							<input id="txtProductno"  type="text"  class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id='lblProduct' class="lbl"></a></td>
						<td class="td6">
							<input id="txtProduct"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id='lblUnit' class="lbl"></a></td>
						<td class="td2">
							<input id="txtUnit"  type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblMount' class="lbl"></a></td>
						<td class="td4">
							<input id="txtMount"  type="text"  class="txt num c1"/>
						</td>
						<td class="td5"><span> </span><a id='lblMoney' class="lbl"></a></td>
						<td class="td6">
							<input id="txtMoney"  type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr6">
						<td class="td1"></td>
						<td class="td2"></td>
						<td class="td3"><span> </span><a id='lblTaxtype' class="lbl"></a></td>
						<td class="td4"><select id="cmbTaxtype" style='width:100%'  onchange='calTax2()' / ></select></td>
						<td class="td5"><span> </span><a id='lblTax' class="lbl"></a></td>
						<td class="td6">
						<input id="txtTax"  type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id='lblChkno' class="lbl"></a></td>
						<td class="td2">
						<input id="txtChkno"  type="text" class="txt c1" />
						</td>
						<td class="td3"><span> </span><a id='lblWorker' class="lbl"></a></td>
						<td class="td4">
						<input id="txtWorker"  type="text"  class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id='lblTotal' class="lbl"></a></td>
						<td class="td6">
						<input id="txtTotal"  type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr8">
						<td class="td1"><span> </span><a id='lblAccno' class="lbl"></a></td>
						<td class="td2">
						<input id="txtAccno"  type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblBuyer' class="lbl btn"></a></td>
						<td class="td4" colspan="3">
						<input id="txtBuyerno"  type="text"  class="txt c2"/>
						<input id="txtBuyer" type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr class="tr9">
						<td class="td1"><span> </span><a id="lblMemo" class="lbl" ></a></td>
						<td class="td2" colspan='5'>
						<input id="txtMemo"  type="text"  class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
