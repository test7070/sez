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

			q_desc = 1;
			q_tables = 's';
			var q_name = "vcc";
			var q_readonly = ['txtVccatax', 'txtComp', 'txtAccno', 'txtAcomp', 'txtSales', 'txtNoa', 'txtWorker', 'txtWorker2', 'txtMoney', 'txtWeight', 'txtTotal', 'txtTotalus','txtTotal2','txtBenifit','txtCardeal'];
			var q_readonlys = ['txtTotal','txtSprice','txtTheory'];
			var bbmNum = [
				['txtVccatax', 10, 0, 1], ['txtMoney', 10, 0, 1],
				['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1],
				['txtTotalus', 10, 2, 1], ['txtWeight', 10, 2, 1], ['txtFloata', 10, 4, 1],
				['txtBenifit', 10, 0, 1],['txtTotal2', 10, 1, 1]
			];
			var bbsNum = [
				['txtPrice', 15, 3, 1], ['txtTotal', 12, 2, 1, 1], ['txtWeight', 10, 2, 1],
				['txtMount', 10, 2, 1], ['txtGweight', 10, 2, 1],
				['txtDime', 10, 3, 1], ['txtWidth', 10, 2, 1],['txtLengthb', 10, 1, 1],
				['txtMweight', 10, 2, 1],['txtSprice', 15, 3, 1],['txtTheory', 15, 3, 1]
			];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			//ajaxPath = "";
			aPop = new Array(
				['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,tel,zip_fact,addr_fact,paytype'
				, 'txtCustno,txtComp,txtNick,txtTel,txtPost,txtAddr,txtPaytype,txtPost2', 'cust_b.aspx'],
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
				['txtAddr', '', 'view_road', 'memo,zipcode', '0txtAddr,txtPost', 'road_b.aspx'],
				['txtSpec_', '', 'spec', 'noa,product', '0txtSpec_,txtSpec_', 'spec_b.aspx', '95%', '95%'],
				['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_', 'ucc_b.aspx'],
				//['txtUno_', 'btnUno_', 'view_uccc2', 'uno,uno,productno,spec,style,product,dime,width,lengthb,size,emount,eweight,sprice', 'txtUno_,txtUno_,txtProductno_,txtSpec_,txtStyle_,txtProduct_,txtDime_,txtWidth_,txtLengthb_,txtSize_,txtMount_,txtWeight_,txtSprice_,txtProductno_', 'uccc_seek_b2.aspx?;;;1=0', '95%', '60%'],
				['txtStoreno2_', 'btnStoreno2_', 'store', 'noa,store', 'txtStoreno2_,txtStore2_', 'store_b.aspx'],
				['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'],
				['txtStyle_', 'btnStyle_', 'style', 'noa,product', 'txtStyle_', 'style_b.aspx']
				
			);
			brwCount2 = 8;
			//購買發票系統
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt('style', '', 0, 0, 0, '');
				q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			var t_spec;
			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
				
				var t_mount = 0, t_price = 0, t_money = 0, t_moneyus = 0, t_weight = 0, t_total = 0, t_tax = 0;
				var t_mounts = 0, t_prices = 0, t_moneys = 0, t_weights = 0,t_sprices=0;
				var t_unit = '';
				var t_float = q_float('txtFloata');
				var t_kind = (($('#cmbKind').val()) ? $('#cmbKind').val() : '');
				t_kind = t_kind.substr(0, 1);
				var t_mweight=0,t_benifit=0;
				for (var j = 0; j < q_bbsCount; j++) {
					t_unit = $.trim($('#txtUnit_' + j).val()).toUpperCase();
					t_product = $.trim($('#txtProduct_' + j).val());
					if (t_unit.length == 0 && t_product.length > 0) {
						if (t_product.indexOf('管') > 0)
							t_unit = '支';
						else
							t_unit = 'KG';
						$('#txtUnit_' + j).val(t_unit);
					}
					getTheory(j);
					//---------------------------------------
					t_weights = q_float('txtWeight_' + j);
					t_prices = q_float('txtPrice_' + j);
					t_mounts = q_float('txtMount_' + j);
					
					if (t_unit.length == 0 || t_unit == 'KG' || t_unit == 'M2' || t_unit == 'M' || t_unit == '批' || t_unit == '公斤' || t_unit == '噸' || t_unit == '頓') {
						t_moneys = q_mul(t_prices, t_weights);
					} else {
						t_moneys = q_mul(t_prices, t_mounts);
					}
					if (t_float == 0) {
						t_moneys = round(t_moneys, 0);
					} else {
						t_moneyus = q_add(t_moneyus, round(t_moneys, 2));
						t_moneys = round(q_mul(t_moneys, t_float), 0);
					}
					
					t_sprices = q_float('txtSprice_' + j);
					if (t_unit.length == 0 || t_unit == 'KG' || t_unit == 'M2' || t_unit == 'M' || t_unit == '批' || t_unit == '公斤' || t_unit == '噸' || t_unit == '頓') {
						t_benifit=q_add(t_benifit,q_sub(t_moneys,q_mul(t_weights,t_sprices)));
					} else {
						t_benifit=q_add(t_benifit,q_sub(t_moneys,q_mul(t_mounts,t_sprices)));
					}
					
					var t_styles = $.trim($('#txtStyle_' + j).val());
					var t_unos = $.trim($('#txtUno_' + j).val());
					var t_dimes = $.trim($('#txtDime_' + j).val());
					if (!(t_styles == '' && t_unos == '' && t_dimes == 0))
						t_weight = q_add(t_weight, t_weights);
					t_mount = q_add(t_mount, t_mounts);
					t_money = q_add(t_money, t_moneys);
					$('#txtTotal_' + j).val(FormatNumber(t_moneys));
					
					t_mweight=q_add(t_mweight,dec($('#txtMweight_'+j).val()));
				}
				$('#txtTotal2').val(t_mweight);
				$('#txtBenifit').val(t_benifit);
				/*t_money = q_add(t_money,t_tranmoney);*/
				
				t_taxrate = parseFloat(q_getPara('sys.taxrate')) / 100;
				if($('#chkAtax').prop('checked'))
					t_tax = round(q_mul(t_money,t_taxrate),0);
				else
					t_tax = q_float('txtTax');
				t_total=q_add(t_money,t_tax)
				
				$('#txtWeight').val(FormatNumber(t_weight));
				$('#txtMoney').val(FormatNumber(t_money));
				$('#txtTax').val(FormatNumber(t_tax));
				$('#txtTotal').val(FormatNumber(t_total));
				if (t_float == 0)
					$('#txtTotalus').val(0);
				else
					$('#txtTotalus').val(FormatNumber(t_moneyus));
			}
			
			
			function mainPost() {// 載入資料完，未 refresh 前
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('vcc.typea'));
				q_cmbParse("cmbStype", q_getPara('vccst.stype'));
				//q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_cmbParse("combPaytype", q_getPara('rc2.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				//q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				q_cmbParse("cmbKind", q_getPara('sys.stktype'));
				q_gt('spec', '', 0, 0, 0, "", r_accy);
				var t_where = "where=^^ 1=0 ^^ stop=100";
				q_gt('custaddr', t_where, 0, 0, 0, "");
				//=======================================================
				//限制帳款月份的輸入 只有在備註的第一個字為*才能手動輸入
				/*$('#txtMemo').change(function() {
					if ($('#txtMemo').val().substr(0, 1) == '*')
						$('#txtMon').removeAttr('readonly');
					else
						$('#txtMon').attr('readonly', 'readonly');
				});
				$('#txtMon').click(function() {
					if ($('#txtMon').attr("readonly") == "readonly" && (q_cur == 1 || q_cur == 2))
						q_msg($('#txtMon'), "月份要另外設定，請在" + q_getMsg('lblMemo') + "的第一個字打'*'字");
				});*/

				$("#cmbTypea").focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				});
				$("#cmbKind").focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				}).click(function(e) {
					sum();
				});
				/*$("#cmbTaxtype").change(function(e) {
					sum();
				});*/
				$("#combPaytype").change(function(e) {
					if (q_cur == 1 || q_cur == 2)
						$('#txtPaytype').val($('#combPaytype').find(":selected").text());
				});
				$("#txtPaytype").focus(function(e) {
					var n = $(this).val().match(/[0-9]+/g);
					var input = document.getElementById("txtPaytype");
					if ( typeof (input.selectionStart) != 'undefined' && n != null) {
						input.selectionStart = $(this).val().indexOf(n);
						input.selectionEnd = $(this).val().indexOf(n) + (n + "").length;
					}
				}).click(function(e) {
					var n = $(this).val().match(/[0-9]+/g);
					var input = document.getElementById("txtPaytype");
					if ( typeof (input.selectionStart) != 'undefined' && n != null) {
						input.selectionStart = $(this).val().indexOf(n);
						input.selectionEnd = $(this).val().indexOf(n) + (n + "").length;
					}
				});
				//=====================================================================
				/* 若非本會計年度則無法存檔 */
				$('#txtDatea').focusout(function() {
					if ($(this).val().substr(0, 3) != r_accy) {
						$('#btnOk').attr('disabled', 'disabled');
						alert(q_getMsg('lblDatea') + '非本會計年度。');
					} else {
						$('#btnOk').removeAttr('disabled');
					}
				});
				
				$('#lblAccno').click(function() {
					q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('btnAccc'), true);
				});
				
				$('#txtFloata').change(function() {
					sum();
				});
				$('#chkAtax').change(function() {
					if($('#chkAtax').prop('checked')){
						$('#txtTax').attr('readonly', true);
						$('#txtTax').css('background-color', 'rgb(237,237,238)').css('color', 'green');
						sum();
					}else{
						$('#txtTax').removeAttr('readonly');
						$('#txtTax').css('background-color', 'rgb(255,255,255)').css('color', '');
					}
				});
				
				$('#txtTax').change(function() {
					sum();
				});
				$('#txtPrice').change(function() {
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
				})

				$('#txtCustno').change(function() {
					if (!emp($('#txtCustno').val())) {
						var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
						q_gt('custaddr', t_where, 0, 0, 0, "");
					}
				}).keydown(function(e) {
					if(e.which==13 && q_cur==1)
						$('#txtCardealno').focus();
				});
				
				$('#txtCarno').keydown(function(e) {
					if(e.which==13 && q_cur==1)
						$('#txtUno_0').focus();
				});
				
				$('#lblInvono').click(function() {
					if ($('#txtInvono').val().length > 0)
						q_pop('txtInvono', "vcca.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtInvono').val() + "';" + r_accy, 'vcca', 'noa', 'datea', "95%", "95%px", q_getMsg('lblInvono'), true);
					else{
						var t_where = "where=^^ vccno='" + $('#txtNoa').val() + "' ^^";
						//console.log(t_where);
						q_gt('vccat', t_where, 0, 0, 0, "");						
					}
				});
				$('#lblInvono').click(function() {
					if ($('#txtInvono').val().length > 0)
						q_pop('txtInvono', "vcca.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtInvono').val() + "';" + r_accy, 'vcca', 'noa', 'datea', "95%", "95%px", q_getMsg('lblInvono'), true);
					else{
						var t_where = "where=^^ vccno='" + $('#txtNoa').val() + "' ^^";
						//console.log(t_where);
						q_gt('vccat', t_where, 0, 0, 0, "");						
					}
				});
				
				$('#btnImportCut').click(function() {
					var t_custno = $('#txtCustno').val();
					var t_where = '1=1 and weight>0 ';
					if(t_custno.length>0){
						t_where += q_sqlPara2('custno', t_custno) ;
						q_box("vcce_import_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy, 'view_vcce_import', "900px", "95%", q_getMsg('popVcceImport'));
					}else{
						alert('請輸入客戶編號!!');
					}
				});
				
				$('#lblMweight').text('毛重');
				$('#lblBenifit').text('損益');
			}

			function q_boxClose(s2) {/// q_boxClose 2/4
				var ret;
				switch (b_pop) {
					case 'uccc_seek_b2':
						if (q_cur > 0 && q_cur < 4) {
							if (!b_ret || b_ret.length == 0) {
								b_pop = '';
								return;
							}
							$('#txtUno_' + b_seq).val(b_ret[0].uno);
							$('#txtProductno_' + b_seq).val(b_ret[0].productno);
							$('#txtSpec_' + b_seq).val(b_ret[0].spec);
							$('#txtStyle_' + b_seq).val(b_ret[0].style);
							$('#txtProduct_' + b_seq).val(b_ret[0].product);
							if(dec(b_ret[0].emount)<0)
								$('#txtMount_' + b_seq).val(1);
							else
								$('#txtMount_' + b_seq).val(b_ret[0].emount);
							$('#txtWeight_' + b_seq).val(b_ret[0].eweight);
							$('#txtGweight_' + b_seq).val(b_ret[0].eweight);
							$('#txtSprice_' + b_seq).val(b_ret[0].sprice);
							$('#txtDime_' + b_seq).val(b_ret[0].dime);
							$('#txtWidth_' + b_seq).val(b_ret[0].width);
							$('#txtLengthb_' + b_seq).val(b_ret[0].lengthb);
							$('#txtSize_' + b_seq).val(b_ret[0].size);
							$('#txtMemo_' + b_seq).val(b_ret[0].memo);
							sum();
							q_gt('view_vccs', "where=^^ uno='" + b_ret[0].uno + "' order by datea desc,noa desc ^^ stop=1 ", 0, 0, 0, 'getprice_' + b_seq, r_accy);
						}
						break;
					case 'view_vcce_import':
						if (q_cur > 0 && q_cur < 4) {
							if (!b_ret || b_ret.length == 0) {
								b_pop = '';
								return;
							}
							AddRet = q_gridAddRow(bbsHtm, 'tbbs', 'txtUno,txtProductno,txtProduct,txtWidth,txtDime,txtLengthb,txtSpec,txtMount,txtWeight,txtPrice,txtStyle,txtSize,txtGweight,txtSprice'
							, b_ret.length, b_ret, 'uno,productno,product,width,dime,lengthb,spec,mount,weight,price,style,size,weight,sprice', '');
						}
						sum();
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						/// q_boxClose 3/4
						break;
				}/// end Switch
				b_pop = '';
			}

			function distinct(arr1) {
				var uniArray = [];
				for (var i = 0; i < arr1.length; i++) {
					var val = arr1[i];
					if ($.inArray(val, uniArray) === -1) {
						uniArray.push(val);
					}
				}
				return uniArray;
			}

			var focus_addr = '';
			var StyleList = '';
			var vcces_as = new Array;
			var t_uccArray = new Array;
			var AddRet = new Array;
			var unostk = new Array;
			function q_gtPost(t_name) {/// 資料下載後 ...
				switch (t_name) {
					case 'vccat':
						var as = _q_appendData("vccat", "", true);
						if (as[0] != undefined) {
							var vccano = new Array();
							for(var i=0;i<as.length;i++){
								if(vccano.indexOf(as[i].noa)<0){
									vccano.push(as[i].noa);
								}								
							}
							var t_noa = '';
							for(var i=0;i<vccano.length;i++){
								t_noa += (t_noa.length>0?" or ":"")+"noa='"+vccano[i]+"'";
							}
							if(t_noa.length>0)
								q_box("vcca.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";"+t_noa + ";" + r_accy, 'vcca', "95%", "95%", q_getMsg("popVcca"));
						}
						break;
					case 'getVccatax':
						var as = _q_appendData("vcca", "", true);
						if (as[0] != undefined) {
							$('#txtVccatax').val(q_trv(as[0].tax, 0, 1));
							var t_noa = $('#txtNoa').val();
							for (var i = 0; i < abbm.length; i++) {
								if (abbm[i].noa == t_noa) {
									abbm[i].vccatax = as[0].tax;
									break;
								}
							}
						}
						break;
					case 'getAcomp':
						var as = _q_appendData("acomp", "", true);
						if (as[0] != undefined) {
							$('#txtCno').val(as[0].noa);
							$('#txtAcomp').val(as[0].acomp);
						}
						Unlock(1);
						$('#txtNoa').val('AUTO');
						$('#txtDatea').val(q_date());
						$('#txtMon').val(q_date().substring(0, 6));
						//$('#txtDatea').focus();
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
					case 'flors':
						var as = _q_appendData("flors", "", true);
						if (as[0] != undefined) {
							q_tr('txtFloata',as[0].floata);
							sum();
						}
						break;
					case 'spec':
						t_spec = _q_appendData("spec", "", true);
						break;
					case 'style' :
						var as = _q_appendData("style", "", true);
						StyleList = new Array();
						StyleList = as;
						q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
						break;
					case 'cust':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined && focus_addr != '') {
							$('#' + focus_addr).val(as[0].addr_fact);
							focus_addr = '';
						}
						break;
					case 'btnOk_unostk1':
						unostk = _q_appendData("uccy", "", true);
						
						var vcc_where = "where=^^ noa = '" + $.trim($('#txtNoa').val()) + "'^^";
						q_gt('view_vccs', vcc_where, 0, 0, 0, "btnOk_unostk2", r_accy);
						
						break;
					case 'btnOk_unostk2':
						var as = _q_appendData("view_vccs", "", true);
						
						var unostkList_Tmp = new Array();
						var ErrStr = '';
						if (unostk.length > 0 && unostk[0] != undefined) {
							for (var j = 0; j < unostk.length; j++) {
								unostkList_Tmp.push({
									uno : unostk[j].uno,
									unit : 'KG', //預設公斤
									mount : dec(unostk[j].emount),
									weight : dec(unostk[j].eweight),
									vmount:0,
									vweight:0
								});
							}
							//加回目前的出貨單資料
							for (var i = 0; i < as.length; i++) {
								var t_uno = as[i].uno;
								var t_weight = dec(as[i].gweight)!=0?dec(as[i].gweight):dec(as[i].weight);
								var t_mount = dec(as[i].mount);
								for (var k = 0; k < unostkList_Tmp.length; k++) {
									if (t_uno == $.trim(unostkList_Tmp[k].uno)) {
										unostkList_Tmp[k].weight = dec(unostkList_Tmp[k].weight) + t_weight;
										unostkList_Tmp[k].mount = dec(unostkList_Tmp[k].mount) + t_mount;
									}
								}
							}
							//扣除目前出貨單資料
							for (var i = 0; i < q_bbsCount; i++) {
								var t_uno = $.trim($('#txtUno_' + i).val());
								var t_weight = dec($('#txtGweight_' + i).val())!=0?dec($('#txtGweight_' + i).val()):dec($('#txtWeight_' + i).val());
								var t_mount = dec($('#txtMount_' + i).val());
								var t_unit = $('#txtUnit_' + i).val().toUpperCase();
								for (var k = 0; k < unostkList_Tmp.length; k++) {
									if (t_uno == $.trim(unostkList_Tmp[k].uno)) {
										unostkList_Tmp[k].unit = t_unit;
										unostkList_Tmp[k].weight = dec(unostkList_Tmp[k].weight) - t_weight;
										unostkList_Tmp[k].mount = dec(unostkList_Tmp[k].mount) - t_mount;
										unostkList_Tmp[k].vweight = dec(unostkList_Tmp[k].vweight) + t_weight;
										unostkList_Tmp[k].vmount = dec(unostkList_Tmp[k].vmount) + t_mount;
									}
								}
							}
							for (var k = 0; k < unostkList_Tmp.length; k++) {
								if(unostkList_Tmp[k].unit!='KG' && unostkList_Tmp[k].unit!=''){ //數量
									if (dec(unostkList_Tmp[k].mount) < 0) {
										ErrStr += '批號：' + unostkList_Tmp[k].uno + ' 庫存量：' +q_add(unostkList_Tmp[k].mount,dec(unostkList_Tmp[k].vmount))+ ' 本次出貨量：' + dec(unostkList_Tmp[k].vmount) + '\n';
									}
								}else{
									if (dec(unostkList_Tmp[k].weight) < 0) {
										ErrStr += '批號：' + unostkList_Tmp[k].uno + ' 庫存量：' + q_add(unostkList_Tmp[k].weight,dec(unostkList_Tmp[k].vweight)) + ' 本次出貨量：' + dec(unostkList_Tmp[k].vweight) + '\n';
									}
								}
							}
							if ($.trim(ErrStr).length > 0) {
								ErrStr = '警告：\n' + ErrStr;
								alert(ErrStr);
							}
						}
						var t_noa = trim($('#txtNoa').val());
						var t_date = trim($('#txtDatea').val());
						if (t_noa.length == 0 || t_noa == "AUTO")
							q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vcc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
						else
							wrServer(t_noa);
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
					case 'startdate':
						var as = _q_appendData('cust', '', true);
						var t_startdate = '';
						
						if (as[0] != undefined) {
							t_startdate = as[0].startdate;
						}	
						if (t_startdate.length == 0 || ('00' + t_startdate).slice(-2) == '00' || $('#txtDatea').val().substr(7, 2) < ('00' + t_startdate).slice(-2)) {
							$('#txtMon').val($('#txtDatea').val().substr(0, 6));
						} else {
							var t_date = $('#txtDatea').val();
							var nextdate = new Date(dec(t_date.substr(0, 3)) + 1911, dec(t_date.substr(4, 2)) - 1, dec(t_date.substr(7, 2)));
							nextdate.setMonth(nextdate.getMonth() + 1)
							t_date = '' + (nextdate.getFullYear() - 1911) + '/' + (nextdate.getMonth() < 9 ? '0' : '') + (nextdate.getMonth() + 1);
							$('#txtMon').val(t_date);
						}
						check_startdate = true;
						btnOk();
						break;
					case q_name:
						t_uccArray = _q_appendData("ucc", "", true);
						if (q_cur == 4)// 查詢
							q_Seek_gtPost();
						break;
					default:
						if (t_name.substring(0, 13) == 'afterPopUno1_') {
							var t_sel = parseInt(t_name.split('_')[1]);
							var as = _q_appendData("view_uccc2", "", true);
							if (as[0] != undefined) {
								$('#txtProductno_' + t_sel).val(as[0].productno);
								$('#txtSpec_' + t_sel).val(as[0].spec);
								$('#txtStyle_' + t_sel).val(as[0].style);
								$('#txtProduct_' + t_sel).val(as[0].product);
								if(dec(as[0].emount)<0)
									$('#txtMount_' + t_sel).val(1);
								else 
									$('#txtMount_' + t_sel).val(as[0].emount);
								$('#txtWeight_' + t_sel).val(as[0].eweight);
								$('#txtGweight_' + t_sel).val(as[0].eweight);
								$('#txtSprice_' + t_sel).val(as[0].sprice);
								$('#txtDime_' + t_sel).val(as[0].dime);
								$('#txtWidth_' + t_sel).val(as[0].width);
								$('#txtLengthb_' + t_sel).val(as[0].lengthb);
								$('#txtSize_' + t_sel).val(as[0].size);
								$('#txtMemo_' + t_sel).val(as[0].memo);
								//讀取上次出貨金額
								q_gt('view_vccs', "where=^^ uno='" + as[0].uno + "' order by datea desc,noa desc ^^ stop=1 ", 0, 0, 0, 'getprice_' + t_sel, r_accy);
								sum();
							}else{
								$('#btnUno_' + t_sel).click();
							}
						} else if (t_name.substring(0, 13) == 'afterPopUno2_') {
							var t_sel = parseInt(t_name.split('_')[1]);
							var as = _q_appendData("view_uccb", "", true);
							if (as[0] != undefined) {
								$('#txtDime_' + t_sel).val(as[0].dime);
								$('#txtWidth_' + t_sel).val(as[0].width);
								$('#txtLengthb_' + t_sel).val(as[0].lengthb);
								$('#txtSize_' + t_sel).val(as[0].size);
							} else {
								$('#txtDime_' + t_sel).val('');
								$('#txtWidth_' + t_sel).val('');
								$('#txtLengthb_' + t_sel).val('');
								$('#txtSize_' + t_sel).val('');
							}
							sum();
						}else if(t_name.substring(0, 11) == 'getproduct_'){
     						var t_seq = parseInt(t_name.split('_')[1]);
	                		as = _q_appendData('dbo.getproduct', "", true);
	                		if(as[0]!=undefined){
	                			$('#txtProduct_'+t_seq).val(as[0].product);
	                		}else{
	                			$('#txtProduct_'+t_seq).val('');
	                		}
	                		break;
                        }else if(t_name.substring(0, 9) == 'getprice_'){
     						var t_seq = parseInt(t_name.split('_')[1]);
	                		as = _q_appendData('view_vccs', "", true);
	                		if(as[0]!=undefined){
	                			$('#txtPrice_'+t_seq).val(as[0].price);
	                		}else{
	                			$('#txtPrice_'+t_seq).val(0);
	                		}
	                		sum();
	                		break;
                        }
				} /// end switch
			}
			
			function coin_chg() {
				var t_where = "where=^^ ('" + $('#txtDatea').val() + "' between bdate and edate) and coin='"+$('#cmbCoin').find("option:selected").text()+"' ^^";
				q_gt('flors', t_where, 0, 0, 0, "");
			}

			function GetUnoList() {
				var ReturnStr = new Array;
				for (var i = 0; i < q_bbsCount; i++) {
					var thisVal = replaceAll(trim($('#txtUno_' + i).val()),"'","~#$");
					if (thisVal.length > 0)
						ReturnStr.push(thisVal);
				}
				ReturnStr = distinct(ReturnStr).sort();
				return ReturnStr.toString();
			}

			var check_startdate = false;
			function btnOk() {
				var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtDatea', q_getMsg('lblDatea')], ['txtCustno', q_getMsg('lblCust')], ['txtCno', q_getMsg('lblAcomp')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}

				Lock(1, {
					opacity : 0
				});

				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					Unlock(1);
					return;
				}
				if ($('#txtDatea').val().substring(0, 3) != r_accy) {
					alert('年度異常錯誤，請切換到【' + $('#txtDatea').val().substring(0, 3) + '】年度再作業。');
					Unlock(1);
					return;
				}

				//判斷起算日,寫入帳款月份
				if (!check_startdate) {
					var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
					q_gt('cust', t_where, 0, 0, 0, "startdate", r_accy);
					return;
				}
				check_startdate = false;

				if ($.trim($('#txtNick').val()).length == 0 && $.trim($('#txtComp').val()).length > 0)
					$('#txtNick').val($.trim($('#txtComp').val()).substring(0, 4));
				sum();

				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				
				var UnoList = GetUnoList().split(',');
				var ReturnStr = '';
				for (var k = 0; k < UnoList.length; k++) {
					ReturnStr += "'" + UnoList[k] + "'";
					if (k < ((UnoList.length) - 1))
						ReturnStr += ',';
				}
				var unostkWhere ="where=^^ uno in (" + ReturnStr + ")^^";
				q_gt('uccy', unostkWhere, 0, 0, 0, "btnOk_unostk1", r_accy);
			}
			
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				$('#txtVccatax').val(0);
				var t_noa = $('#txtNoa').val();
				for (var i = 0; i < abbm.length; i++) {
					if (abbm[i].noa == t_noa) {
						abbm[i].vccatax = 0;
						break;
					}
				}
				var strSplit = xmlString.split(';');
				if (strSplit.length >= 2) {
					abbm[q_recno]['accno'] = strSplit[0];
					$('#txtAccno').val(strSplit[0]);
					/*abbm[q_recno]['invono'] = strSplit[1];
					$('#txtInvono').val(strSplit[1]);*/
					if (strSplit[1].length > 0)
						q_gt('vcca', "where=^^noa='" + strSplit[1] + "'^^", 0, 0, 0, 'getVccatax', r_accy);
				}
				Unlock(1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('vcc_pe_s.aspx', q_name + '_s', "500px", "540px", q_getMsg("popSeek"));
			}
			
			function getTheory(b_seq) {
				t_Radius = dec($('#txtRadius_' + b_seq).val());
				t_Width = dec($('#txtWidth_' + b_seq).val());
				t_Dime = dec($('#txtDime_' + b_seq).val());
				t_Lengthb = dec($('#txtLengthb_' + b_seq).val());
				t_Mount = dec($('#txtMount_' + b_seq).val());
				t_Style = $('#txtStyle_' + b_seq).val();
				t_Productno = $('#txtProductno_' + b_seq).val();
				var theory_setting = {
					calc : StyleList,
					ucc : t_uccArray,
					radius : t_Radius,
					width : t_Width,
					dime : t_Dime,
					lengthb : t_Lengthb,
					mount : t_Mount,
					style : t_Style,
					productno : t_Productno,
					round : 3
				};
				if ($('#cmbKind').val().substr(1, 1) == '4') {//鋼胚
					q_tr('txtTheory_' + b_seq, round(t_Mount * theory_bi(t_spec, $('#txtSpec_' + b_seq).val(), t_Dime, t_Width, t_Lengthb), 0));
				} else {
					q_tr('txtTheory_' + b_seq, theory_st(theory_setting));
				}
				var t_Product = $('#txtProduct_' + b_seq).val();
				if (t_Product.indexOf('管') > -1 && dec($('#txtWeight_' + b_seq).val()) == 0) {
					$('#txtWeight_' + b_seq).val($('#txtTheory_' + b_seq).val());
				}
			}
			
			function bbsAssign() {/// 表身運算式
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtStyle_' + j).blur(function() {
							$('input[id*="txtProduct_"]').each(function() {
								thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
								$(this).attr('OldValue', $('#txtProductno_' + thisId).val());
							});
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							sum();
						});
						//-------------------------------------------------
						$('#txtUnit_' + j).focusout(function() {
							if (q_cur == 1 || q_cur == 2)
								sum();
						});
						$('#txtWeight_' + j).focusout(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							if (q_cur == 1 || q_cur == 2){
								sum();
								$('#txtGweight_'+n).val($(this).val());	
							}
						});
						$('#txtPrice_' + j).focusout(function() {
							if (q_cur == 1 || q_cur == 2) {
								sum();
							}
						});
						$('#txtMweight_' + j).focusout(function() {
							if (q_cur == 1 || q_cur == 2) {
								sum();
							}
						});
						$('#txtSprice_' + j).focusout(function() {
							if (q_cur == 1 || q_cur == 2) {
								sum();
							}
						});
						$('#txtMount_' + j).focusout(function() {
							if (q_cur == 1 || q_cur == 2) {
								var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
								sum();
							}
						});
						$('#txtUno_' + j).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							var t_uno = replaceAll($.trim($('#txtUno_' + n).val()),"'","~#$");
							if (t_uno != undefined && t_uno.length > 0) {
								q_gt('view_uccc2', "where=^^ uno='" + t_uno + "'^^", 0, 0, 0, 'afterPopUno1_' + n, r_accy);
							}
						});
						$('#btnUno_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_box("uccc_seek_b2.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";1=0;" + r_accy, 'uccc_seek_b2', "900px", "95%", '');
						});
					}
				}//j
				_bbsAssign();
				
				$('#lblUno_st').text('鋼捲批號');
				$('#lblSpec_st').text('規格');
				$('#lblProductno_st').text('品號');
				$('#lblTotals_st').text('小計');
				$('#lblGweight_st').text('實際重量');
				$('#lblDime_st').text('厚度');
				$('#lblWidth_st').text('寬度');
				$('#lblLengthb_st').text('長度');
				$('#lblWeight_st').text('貨單重量');
				$('#lblPrices_st').text('實際單價');
			}

			function btnIns() {
				_btnIns();
				//$('#cmbTaxtype').val(1);
				Lock(1, {
					opacity : 0
				});
				q_gt('acomp', '', 0, 0, 0, 'getAcomp', r_accy);				
				var t_where = "where=^^ 1=0^^ stop=100";
				q_gt('custaddr', t_where, 0, 0, 0, "");
				
				$('#cmbKind').val('A1');
				$('#txtCustno').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
				sum();
			}

			function btnPrint() {
				q_box("z_vccp_pe.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa=" + $('#txtNoa').val() + ";" + r_accy, 'z_vccstp', "95%", "95%", q_getMsg('popPrint'));
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
				// key_value
			}

			function bbsSave(as) {
				if (!as['product'] && !as['uno'] && parseFloat(as['mount'].length == 0 ? "0" : as['mount']) == 0 && parseFloat(as['weight'].length == 0 ? "0" : as['weight']) == 0) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['typea'] = abbm2['typea'];
				as['mon'] = abbm2['mon'];
				as['noa'] = abbm2['noa'];
				as['datea'] = abbm2['datea'];
				as['tggno'] = abbm2['tggno'];
				as['kind'] = abbm2['kind'];
				if (abbm2['storeno'])
					as['storeno'] = abbm2['storeno'];

				t_err = '';
				if (as['price'] != null && (dec(as['price']) > 99999999 || dec(as['price']) < -99999999))
					t_err = q_getMsg('msgPriceErr') + as['price'] + '\n';

				if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
					t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

				if (t_err) {
					alert(t_err);
					return false;
				}

				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				if (r_rank < 9) {
					$('#btnImportVcce').css('display', 'none');
				}
				
				$('input[id*="txtProduct_"]').each(function() {
					thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
					$(this).attr('OldValue', $('#txtProductno_' + thisId).val());
				});
			}

			var ret; //勿刪
			var x_bseq = 0;
			function q_popPost(s1) {
				switch (s1) {
					case 'txtCustno':
						if (!emp($('#txtCustno').val())) {
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}
						break;
					case 'txtProductno_':
                        var t_productno = $.trim($('#txtProductno_'+b_seq).val());
	                	var t_style = $.trim($('#txtStyle_'+b_seq).val());
	                	var t_comp = q_getPara('sys.comp');          	
	                	q_gt('getproduct',"where=^^[N'"+t_productno+"',N'"+t_style+"',N'"+t_comp+"')^^", 0, 0, 0, "getproduct_"+b_seq); 
                        $('#txtStyle_' + b_seq).focus();
                        break;
                    case 'txtStyle_':
                   		var t_productno = $.trim($('#txtProductno_'+b_seq).val());
	                	var t_style = $.trim($('#txtStyle_'+b_seq).val());
	                	var t_comp = q_getPara('sys.comp');          	
	                	q_gt('getproduct',"where=^^[N'"+t_productno+"',N'"+t_style+"',N'"+t_comp+"')^^", 0, 0, 0, "getproduct_"+b_seq); 
                        $('#txtStyle_'+b_seq).blur();
                        break;
					case 'txtUno_':
						var t_uno = replaceAll($.trim($('#txtUno_' + b_seq).val()),"'","~#$");
						if (t_uno != undefined && t_uno.length > 0) {
							q_gt('view_uccb', "where=^^ uno='" + t_uno + "'^^", 0, 0, 0, 'afterPopUno2_' + b_seq, r_accy);
						}
						break;
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				var WantDisabledArray = ['btnImportVcce'];
				for (var k = 0; k < WantDisabledArray.length; k++) {
					if (q_cur == 1 || q_cur == 2) {
						$("#" + WantDisabledArray[k]).removeAttr('disabled', 'disabled');
					} else {
						$("#" + WantDisabledArray[k]).attr('disabled', 'disabled');
					}
				}
				if (t_para) {
					$('#combAddr').attr('disabled', 'disabled');
				} else {
					$('#combAddr').removeAttr('disabled');
				}

				//限制帳款月份的輸入 只有在備註的第一個字為*才能手動輸入
				/*if ($('#txtMemo').val().substr(0, 1) == '*')
					$('#txtMon').removeAttr('readonly');
				else
					$('#txtMon').attr('readonly', 'readonly');*/
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

			function FormatNumber(n) {
				var xx = "";
				if (n < 0) {
					n = Math.abs(n);
					xx = "-";
				}
				n += "";
				var arr = n.split(".");
				var re = /(\d{1,3})(?=(\d{3})+$)/g;
				return xx + arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
			}

			function tipShow() {
				Lock(1);
				tipInit();
				var t_set = $('body');
				t_set.find('.tip').eq(0).show();
				//tipClose
				for (var i = 1; i < t_set.data('tip').length; i++) {
					index = t_set.data('tip')[i].index;
					obj = t_set.data('tip')[i].ref;
					msg = t_set.data('tip')[i].msg;
					shiftX = t_set.data('tip')[i].shiftX;
					shiftY = t_set.data('tip')[i].shiftY;
					if (obj.is(":visible")) {
						t_set.find('.tip').eq(index).show().offset({
							top : round(obj.offset().top + shiftY, 0),
							left : round(obj.offset().left + obj.width() + shiftX, 0)
						}).html(msg);
					} else {
						t_set.find('.tip').eq(index).hide();
					}
				}
			}

			function tipInit() {
				tip($('#btnOrdeno'), '<a style="color:darkblue;font-size:16px;font-weight:bold;width:300px;display:block;">點擊【' + q_getMsg('btnOrdeno') + '】匯入訂單</a>', -20, -15);
				tip($('#btnImportVcce'), '<a style="color:darkblue;font-size:16px;font-weight:bold;width:300px;display:block;">匯入派車單資料。</a>', -20, 20);
			}

			function tip(obj, msg, x, y) {
				x = x == undefined ? 0 : x;
				y = y == undefined ? 0 : y;
				var t_set = $('body');
				if ($('#tipClose').length == 0) {
					//顯示位置在btnTip上
					t_set.data('tip', new Array());
					t_set.append('<input type="button" id="tipClose" class="tip" value="關閉"/>');
					$('#tipClose').css('position', 'absolute').css('z-index', '1001').css('color', 'red').css('font-size', '18px').css('display', 'none').click(function(e) {
						$('body').find('.tip').css('display', 'none');
						Unlock(1);
					});
					$('#tipClose').offset({
						top : round($('#btnTip').offset().top - 2, 0),
						left : round($('#btnTip').offset().left - 15, 0)
					});
					t_set.data('tip').push({
						index : 0,
						ref : $('#tipClose')
					});
				}
				if (obj.data('tip') == undefined) {
					t_index = t_set.find('.tip').length;
					obj.data('tip', t_index);
					t_set.append('<div class="tip" style="position: absolute;z-index:1000;display:none;"> </div>');
					t_set.data('tip').push({
						index : t_index,
						ref : obj,
						msg : msg,
						shiftX : x,
						shiftY : y
					});
				}
			}

			function combAddr_chg() {/// 只有 comb 開頭，才需要寫 onChange() ，其餘 cmb 連結資料庫
				if (q_cur == 1 || q_cur == 2) {
					$('#txtAddr2').val($('#combAddr').find("option:selected").text());
					$('#txtPost2').val($('#combAddr').find("option:selected").val());
				}
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 300px;
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
				width: 900px;
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
				/*width: 1%;*/
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
				width: 2050px;
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
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style="overflow: auto;display:block;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview">
				<table class="tview" id="tview"	>
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewNick'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td style="width: 80px;"> </td>
						<td style="width: 142px;"> </td>
						<td style="width: 80px;"> </td>
						<td style="width: 143px;"> </td>
						<td style="width: 80px;"> </td>
						<td style="width: 142px;"> </td>
						<td style="width: 80px;"> </td>
						<td style="width: 143px;"> </td>
						<td style="width: 10px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td>
							<select id="cmbTypea" class="txt" style="width:40%;"> </select>
							<select id="cmbStype" class="txt" style="width:60%;"> </select>
						</td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
						<!--<td><input type="button" id="btnTip" value="?" style="float:right;" onclick="tipShow()"/></td>-->
						<!--<td colspan="2">
							<input type="checkbox" id="chkIsgenvcca" style="float:left;"/>
							<a id='lblIsgenvcca' class="lbl" style="float:left;"> </a>
						</td>-->
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCustno" type="text" style="float:left;width:25%;"/>
							<input id="txtComp" type="text" style="float:left;width:75%;"/>
							<input id="txtNick" type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCno" type="text" style="float:left;width:25%;"/>
							<input id="txtAcomp" type="text" style="float:left;width:75%;"/>
						</td>
						<!--<td><span> </span><a id='lblInvono' class="lbl btn"> </a></td>
						<td colspan="2"><input id="txtInvono" type="text" class="txt c1"/></td>-->
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan="3"><input id="txtTel" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td>
							<input id="txtSalesno" type="text" style="float:left;width:40%;"/>
							<input id="txtSales" type="text" style="float:left;width:60%;"/>
						</td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td>
							<input id="txtPaytype" type="text" style="float:left; width:115px;"/>
							<select id="combPaytype" style="float:left; width:26px;"> </select>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td colspan="3" >
							<input id="txtPost" type="text" style="float:left; width:50px;"/>
							<input id="txtAddr" type="text" style="float:left; width:313px;"/>
						</td>
						<td><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td colspan="3" >
							<input id="txtPost2" type="text" style="float:left; width:50px;"/>
							<input id="txtAddr2" type="text" style="float:left; width:295px;"/>
							<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'> </select>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td><select id="cmbTrantype" class="txt c1" name="D1" > </select></td>
						<td><span> </span><a id='lblCardeal' class="lbl btn"> </a></td>
						<td>
							<input id="txtCardealno" type="text" style="float:left;width:25%;"/>
							<input id="txtCardeal" type="text" style="float:left;width:75%;" />
						</td>
						<td><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td><input id="txtCarno" type="text" class="txt c1" /></td>
						<td> </td>
						<td><input id="btnImportCut" type="button" value="訂單匯入"/></td>
					</tr>
					<tr style="display: none;">
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td><input id="txtTotalus" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><input id="txtFloata" type="text" class="txt num c1" /></td>
						<td>
							<span style="float:left;display:block;width:10px;"> </span>
							<select id="cmbCoin" style="float:left;width:80px;" onchange='coin_chg()'> </select>
						</td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td>
							<input id="txtTax" type="text" class="txt num c1" />
							<input id="txtVccatax" type="text" class="txt num c1 " style="display:none;" />
						</td>
						<td>
							<input type="checkbox" id="chkAtax" style="float:left;"/>
							<!--<span style="float:left;display:block;width:10px;"> </span>
							<select id="cmbTaxtype" style="float:left;width:80px;" > </select>-->
							<span> </span><a id='lblTotal' class="lbl"> </a>
						</td>
						<td><input id="txtTotal" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblBenifit' class="lbl"> </a></td>
						<td><input id="txtBenifit" type="text" class="txt num c1"/></td>
					</tr>
					<!---<tr>
						<td></td>
						<td><input type=button value="隨貨附材證" onclick="ShowAnswer()"></td>
					</tr>--->
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="7"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td><input id="txtWeight" type="text" class="txt num c1" /></td>
						<td><span> </span><a id="lblMweight" class="lbl"> </a></td>
						<td><input id="txtTotal2" type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td>
							<input id="txtWorker" type="text" class="txt c1" style="width: 49%;"/>
							<input id="txtWorker2" type="text" class="txt c1" style="width: 49%;"/>
						</td>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno" type="text" class="txt c1"/></td>
						<td style="display: none;"><span> </span><a id='lblKind' class="lbl"> </a></td>
						<td style="display: none;"><select id="cmbKind" class="txt c1"> </select></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:30px;"><input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;" /></td>
					<td align="center" style="width:20px;">序</td>
					<td align="center" style="width:30px;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width:15px;"><a id='lblStyle_st'> </a></td>
					<td align="center" style="width:120px;"><a id='lblProduct_st'> </a></td>
					<td align="center" style="width:30px;"><!---<a id='lblSpec_st'> </a>---->板面</td>
					<td align="center" style="width:50px;"><a id='lblDime_st'> </a></td>
					<td align="center" style="width:50px;"><!---<a id='lblWidth_st'> </a>---->寬度/OD</td>
					<td align="center" style="width:50px;"><!---<a id='lblLengthb_st'> </a>---->長度/ID</td>
					<td align="center" style="width:50px;">寬度2</td>
					<td align="center" style="width:50px;">寬度3</td>
					<td align="center" style="width:50px;"><a id='lblMount_st'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTheory'> </a></td>
					<td align="center" style="width:80px;"><a id='lblWeight_st'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrices_st'> </a></td>
					<td align="center" style="width:45px;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTotals_st'> </a></td>
					<td align="center" style="width:100px;"><!---<a id='lblSizea_st'> </a>---->爐號</td>
					<td align="center" style="width:70px;"><a id='lblGweight_st'> </a></td>
					<td align="center" style="width:180px;"><a id='lblMemo_s'> </a></td>
				</tr>
				
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<!---input class="btn" id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:15px;float:left;" /135px--->
						<input id="txtProductno.*" type="text" style="width:95%;" />
					</td>
					<td><input id="txtStyle.*" type="text" style="width:85%;text-align:center;" /></td>
					<td><input id="txtProduct.*" type="text" style="width:95%;" /></td>
					<td><input id="txtSpec.*" type="text" style="width:95%;" /></td>
					<td><input id="txtDime.*" type="text" class="txt num" style="width:95%;"/></td>
					<td><input id="txtWidth.*" type="text" class="txt num" style="width:95%;"/></td>
					<td><input id="txtLengthb.*" type="text" class="txt num" style="width:95%;"/></td>
					<td><input id="txtWidth2.*" type="text" class="txt num" style="width:95%;"/></td>
					<td><input id="txtWidth3.*" type="text" class="txt num" style="width:95%;"/></td>
					<td><input id="txtMount.*" type="text" class="txt num" style="width:95%;"/></td>
					<td><input id="txtTheory.*" type="text" class="txt num" style="width:95%;"/></td>
					<td><input id="txtWeight.*" type="text" class="txt num" style="width:95%;"/></td>
					<td><input id="txtPrice.*" type="text" class="txt num" style="width:95%;"/></td>
					<td><input id="txtUnit.*" type="text" class="txt" style="width:95%;text-align: center;"/></td>
					<td><input id="txtTotal.*" type="text" class="txt num" style="width:95%;"/></td>
					<td><input id="txtSize.*" type="text" style="width:95%;" /></td>
					<td><input id="txtGweight.*" type="text" class="txt num" style="width:95%;"/></td>
					<td>
						<input id="txtMemo.*" type="text" class="txt" style="width:95%;"/>
						<input id="recno.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
