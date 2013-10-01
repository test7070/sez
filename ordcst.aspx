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

			q_tables = 's';
			var q_name = "ordc";
			var q_readonly = ['txtTgg', 'txtAcomp', 'txtSales', 'txtNoa', 'txtWorker', 'txtWorker2','txtMoney','txtTax','txtTotal','txtTotalus','txtWeight'];
			var q_readonlys = ['txtC1', 'txtNotv', 'txtNo2', 'txtOrdbno', 'txtNo3'];
			var bbmNum = [['txtFloata', 10, 5, 1], ['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtTotalus', 10, 2, 1], ['txtWeight', 10, 1, 1]];
			var bbsNum = [['textSize1', 10, 3, 1], ['textSize2', 10, 2, 1], ['textSize3', 10, 3, 1], ['textSize4', 10, 2, 1], ['txtRadius', 10, 3, 1], ['txtWidth', 10, 2, 1], ['txtDime', 10, 3, 1], ['txtLengthb', 10, 2, 1], ['txtMount', 10, 2, 1], ['txtWeight', 10, 1, 1], ['txtTheory', 10, 1, 1], ['txtPrice', 10, 2, 1], ['txtTotal', 10, 0, 1]];
			var bbmMask = [];
			var bbsMask = [['txtStyle', 'A']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
			, ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
			, ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
			, ['txtUno_', 'btnUno_', 'view_uccc', 'uno', 'txtUno_', 'uccc_seek_b.aspx', '95%', '60%']
			, ['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick,paytype,tel,fax,addr_fact,zip_fact', 'txtTggno,txtTgg,txtNick,txtPaytype,txtTel,txtFax,txtAddr,txtPost', 'tgg_b.aspx']);
			brwCount2 = 10;
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no2'];
				q_brwCount();
				q_gt('style', '', 0, 0, 0, '');
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
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtOdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbKind", q_getPara('sys.stktype'));
				q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_cmbParse("combPaytype", q_getPara('rc2.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				
				$("#combPaytype").change(function(e) {
					if (q_cur == 1 || q_cur == 2)
						$('#txtPaytype').val($('#combPaytype').find(":selected").text());
				});
				$("#txtPaytype").focus(function(e) {
					var n = $(this).val().match(/[0-9]+/g);
					var input = document.getElementById("txtPaytype");
					if ( typeof (input.selectionStart) != 'undefined' && n != null) {
						input.selectionStart = $(this).val().indexOf(n);
						input.selectionEnd = $(this).val().indexOf(n) + (n+"").length;
					}
				}).click(function(e) {
					var n = $(this).val().match(/[0-9]+/g);
					var input = document.getElementById("txtPaytype");
					if ( typeof (input.selectionStart) != 'undefined' && n != null) {
						input.selectionStart = $(this).val().indexOf(n);
						input.selectionEnd = $(this).val().indexOf(n) + (n+"").length;
					}
				});
				
				$('#txtFloata').change(function() {
					sum();
				});
				$("#cmbTaxtype").change(function(e) {
					sum();
				});
				$('#txtTotal').change(function() {
					sum();
				});
				//變動尺寸欄位
				$('#cmbKind').change(function() {
					size_change();
				});

				$('#lblOrdb').click(function() {
					var t_tggno = trim($('#txtTggno').val());
					var t_ordbno = trim($('#txtOrdbno').val());
					var t_where = '';
					if (t_tggno.length > 0) {
						if (t_ordbno.length > 0)
							t_where = "enda=0 " + (t_tggno.length > 0 ? q_sqlPara2("tggno", t_tggno) : "") + " " + (t_ordbno.length > 0 ? q_sqlPara2("noa", t_ordbno) : "") + " && kind='" + $('#cmbKind').val() + "'";
						////  sql AND 語法，請用 &&
						else
							t_where = "enda=0 " + (t_tggno.length > 0 ? q_sqlPara2("tggno", t_tggno) : "") + " && kind='" + $('#cmbKind').val() + "'";
						////  sql AND 語法，請用 &&
						t_where = t_where;
					} else {
						alert(q_getMsg('msgTggEmp'));
						return;
					}
					q_box('ordbsst_b.aspx', 'ordbs;' + t_where, "95%", "650px", q_getMsg('popOrdbs'));
				});
			}
			
			function distinct(arr1) {
				for(var i = 0;i<arr1.length;i++){
					if((arr1.indexOf(arr1[i]) != arr1.lastIndexOf(arr1[i])) || arr1[i] == ''){
						arr1.splice(i, 1);
							i--;
					}
				}
				return arr1;
			}

			var ordbsArray = new Array;
			function q_boxClose(s2) {///   q_boxClose 2/4
				var ret;
				switch (b_pop) {
					case 'ordbs':
						if (q_cur > 0 && q_cur < 4) {
							ordbsArray = getb_ret();
							if (!ordbsArray || ordbsArray.length == 0){
								return;
							}else{
								var distinctArray = new Array;
								var inStr = '';
								for(var i=0;i<ordbsArray.length;i++){distinctArray.push(ordbsArray[i].noa);}
								distinctArray = distinct(distinctArray);
								for(var i=0;i<distinctArray.length;i++){
									inStr += "'"+distinctArray[i]+"',";
								}
								inStr = inStr.substring(0,inStr.length-1);
								var t_where = "where=^^ ordbno in("+inStr+") ^^";
								q_gt('ordcs', t_where, 0, 0, 0, '',r_accy);
							}
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						///   q_boxClose 3/4
						break;
				}/// end Switch
				b_pop = '';
			}

			var StyleList = '';
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'ordcs':
						var as = _q_appendData("ordcs", "", true);
						for(var i = 0;i<as.length;i++){
							for(var j=0;j<ordbsArray.length;j++){
								if(as[i].ordbno == ordbsArray[j].noa && as[i].no3 == ordbsArray[j].no3){
									ordbsArray[j].mount = dec(ordbsArray[j].mount)-dec(as[i].mount);
									ordbsArray[j].weight = dec(ordbsArray[j].weight)-dec(as[i].weight);
								}
							}
							for(var i=0;i<ordbsArray.length;i++){
								if (ordbsArray[i].mount <=0 || ordbsArray[i].weight <=0 || ordbsArray[i].noa == '') {
										ordbsArray.splice(i, 1);
										i--;
								}
							}
						}
						if (ordbsArray[0] != undefined){
							for(var i=0;i<q_bbsCount;i++){$('#btnMinus_'+i).click();}
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtDime,txtWidth,txtLengthb,txtRadius,txtOrdbno,txtNo3,txtPrice,txtMount,txtWeight,txtTotal,txtMemo,txtTheory,txtStyle,txtClass,txtUno,txtSize', 
														ordbsArray.length, ordbsArray,
														'productno,product,spec,dime,width,lengthb,radius,noa,no3,price,mount,weight,total,memo,theory,style,class,uno,size', 'txtProductno,txtProduct,txtSpec');
							bbsAssign();
							sum();
							size_change();
						}
						ordbsArray = new Array;
						break;
					case 'ordb':
						var ordb = _q_appendData("ordb", "", true);
						if (ordb[0] != undefined) {
							$('#combPaytype').val(ordb[0].paytype);
							$('#txtPaytype').val(ordb[0].pay);
							$('#txtPost').val(ordb[0].post);
							$('#txtAddr').val(ordb[0].addr);
							var ordbs = _q_appendData("ordbs", "", true);
							if (ordbs[0] != undefined) {
								q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtRadius,txtWidth,txtDime,txtLengthb,txtMount,txtWeight,txtPrice,txtTotal,txtTheory,txtMemo,txtOrdbno,txtNo3', ordbs.length, ordbs, 'productno,product,spec,radius,width,dime,lengthb,mount,weight,price,total,theory,memo,noa,no3', '');
							}
						}
						break;
					case 'style' :
						var as = _q_appendData("style", "", true);
						StyleList = new Array();
						StyleList = as;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}  /// end switch
			}
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock(1);
			}

			function GetOrdbnoList(){
				var ReturnStr = new Array;
				for(var i=0;i<q_bbsCount;i++){
					ReturnStr.push(trim($('#txtOrdbno_'+i).val()));
				}
				ReturnStr = distinct(ReturnStr).sort();
				return ReturnStr.toString();
			}


			function btnOk() {
				Lock(1, {
					opacity : 0
				});
				//日期檢查
				if ($('#txtOdate').val().length == 0 || !q_cd($('#txtOdate').val())) {
					alert(q_getMsg('lblOdate') + '錯誤。');
					Unlock(1);
					return;
				}
				if ($('#txtOdate').val().substring(0, 3) != r_accy) {
					alert('年度異常錯誤，請切換到【' + $('#txtOdate').val().substring(0, 3) + '】年度再作業。');
					Unlock(1);
					return;
				}
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				sum();
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtOdate').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ordc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('ordcst_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function getTheory(b_seq) {
				t_Radius = $('#txtRadius_' + b_seq).val();
				t_Width = $('#txtWidth_' + b_seq).val();
				t_Dime = $('#txtDime_' + b_seq).val();
				t_Lengthb = $('#txtLengthb_' + b_seq).val();
				t_Mount = $('#txtMount_' + b_seq).val();
				t_Style = $('#txtStyle_' + b_seq).val();
				return theory_st(StyleList, t_Radius, t_Width, t_Dime, t_Lengthb, t_Mount, t_Style);
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtMount_' + j).change(function() {sum();});
						$('#txtWeight_' + j).change(function() {sum();});
						$('#txtPrice_' + j).change(function() {sum();});
						$('#txtTotal_' + j).change(function() {sum();});
						$('#txtC1_' + j).change(function() {sum();});
						$('#txtStyle_' + j).blur(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							ProductAddStyle(b_seq);
						});
						//計算理論重
						$('#textSize1_' + j).change(function() {sum();});
						$('#textSize2_' + j).change(function() {sum();});
						$('#textSize3_' + j).change(function() {sum();});
						$('#textSize4_' + j).change(function() {sum();});
					}
				}
				_bbsAssign();
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtOdate').val(q_date());
				$('#txtOdate').focus();
				size_change();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtOdate').focus();
				size_change();
				sum();
			}

			function btnPrint() {
				t_where = "noa='" + $('#txtNoa').val() + "'";
				q_box("z_ordcstp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));
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
				as['date'] = abbm2['date'];
				as['kind'] = abbm2['kind'];
				as['tggno'] = abbm2['tggno'];
				as['odate'] = abbm2['kind'];
				as['enda'] = abbm2['enda'];

				return true;
			}

			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
				$('#txtMoney').attr('readonly', true);
				$('#txtTax').attr('readonly', true);
				$('#txtTotal').attr('readonly', true);
				$('#txtMoney').css('background-color', 'rgb(237,237,238)').css('color', 'green');
				$('#txtTax').css('background-color', 'rgb(237,237,238)').css('color', 'green');
				$('#txtTotal').css('background-color', 'rgb(237,237,238)').css('color', 'green');

				var t_mount = 0, t_price = 0, t_money = 0, t_weight = 0, t_total = 0, t_tax = 0;
				var t_mounts = 0, t_prices = 0, t_moneys = 0, t_weights = 0;
				var t_float = q_float('txtFloata');
				var t_unit = '';
				for (var j = 0; j < q_bbsCount; j++) {
					t_unit = trim($('#txtUnit_' + j).val()).toUpperCase();
					//---------------------------------------
					if ($('#cmbKind').val().substr(0, 1) == 'A') {
						q_tr('txtDime_' + j, q_float('textSize1_' + j));
						q_tr('txtWidth_' + j, q_float('textSize2_' + j));
						q_tr('txtLengthb_' + j, q_float('textSize3_' + j));
						q_tr('txtRadius_' + j, q_float('textSize4_' + j));
					} else if ($('#cmbKind').val().substr(0, 1) == 'B') {
						q_tr('txtRadius_' + j, q_float('textSize1_' + j));
						q_tr('txtWidth_' + j, q_float('textSize2_' + j));
						q_tr('txtDime_' + j, q_float('textSize3_' + j));
						q_tr('txtLengthb_' + j, q_float('textSize4_' + j));
					} else {//鋼筋、胚
						q_tr('txtLengthb_' + j, q_float('textSize3_' + j));
					}
					//---------------------------------------
					getTheory(j);
					t_weights = q_float('txtWeight_' + j);
					t_prices = q_float('txtPrice_' + j);
					t_mounts = q_float('txtMount_' + j);
					t_moneys = t_prices.mul((t_unit == 'KG' ? t_weights : t_mounts)).round(0);

					t_weight = t_weight.add(t_weights);
					t_mount = t_mount.add(t_mounts);
					t_money = t_money.add(t_moneys);

					$('#txtTotal_' + j).val(FormatNumber(t_moneys));
				}
				t_taxrate = parseFloat(q_getPara('sys.taxrate')) / 100;
				switch ($('#cmbTaxtype').val()) {
					case '1':
						// 應稅
						t_tax = round(t_money * t_taxrate, 0);
						t_total = t_money + t_tax;
						break;
					case '2':
						//零稅率
						t_tax = 0;
						t_total = t_money + t_tax;
						break;
					case '3':
						// 內含
						t_tax = round(t_money / (1 + t_taxrate) * t_taxrate, 0);
						t_total = t_money;
						t_money = t_total - t_tax;
						break;
					case '4':
						// 免稅
						t_tax = 0;
						t_total = t_money + t_tax;
						break;
					case '5':
						// 自定
						$('#txtTax').attr('readonly', false);
						$('#txtTax').css('background-color', 'white').css('color', 'black');
						t_tax = round(q_float('txtTax'), 0);
						t_total = t_money + t_tax;
						break;
					case '6':
						// 作廢-清空資料
						t_money = 0, t_tax = 0, t_total = 0;
						break;
					default:
				}
				t_price = q_float('txtPrice');
				if (t_price != 0) {
					$('#txtTranmoney').val(FormatNumber(t_weight.mul(t_price).round(0)));
				}
				$('#txtWeight').val(FormatNumber(t_weight));

				$('#txtMoney').val(FormatNumber(t_money));
				$('#txtTax').val(FormatNumber(t_tax));
				$('#txtTotal').val(FormatNumber(t_total));
				$('#txtTotalus').val(FormatNumber(Math.round(q_float('txtTotal').mul(q_float('txtFloata'), 2))));
				$('#txtOrdbno').val(GetOrdbnoList());
			}

			function refresh(recno) {
				_refresh(recno);
				size_change();
				$('input[id*="txtProduct_"]').each(function() {
					t_IdSeq = -1;
					/// 要先給  才能使用 q_bodyId()
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					OldValue = $(this).val();
					nowStyle = $('#txtStyle_' + b_seq).val();
					if (!emp(nowStyle) && (StyleList[0] != undefined)) {
						for (var i = 0; i < StyleList.length; i++) {
							if (StyleList[i].noa.toUpperCase() == nowStyle) {
								styleProduct = StyleList[i].product;
								if (OldValue.substr(OldValue.length - styleProduct.length) == styleProduct) {
									OldValue = OldValue.substr(0, OldValue.length - styleProduct.length);
								}
							}
						}
					}
					$(this).attr('OldValue', OldValue);
				});
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtProductno_':
						$('input[id*="txtProduct_"]').each(function() {
							$(this).attr('OldValue', $(this).val());
						});
						ProductAddStyle(b_seq);
						$('#txtClass_' + b_seq).focus();
						break;
					case 'txtTggno':
						$('#txtSalesno').focus();
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

			function size_change() {
				if (q_cur == 1 || q_cur == 2) {
					$('input[id*="textSize"]').removeAttr('disabled');
				} else {
					$('input[id*="textSize"]').attr('disabled', 'disabled');
				}
				if ($('#cmbKind').val().substr(0, 1) == 'A') {
					$('#lblSize_help').text("厚度x寬度x長度");
					$('#Size').css('width', '240px');
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).show();
						$('#textSize2_' + j).show();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).hide();
						$('#x1_' + j).show();
						$('#x2_' + j).show();
						$('#x3_' + j).hide();
						$('#txtSpec_'+j).css('width', '220px');
						$('#textSize1_' + j).val($('#txtDime_' + j).val());
						$('#textSize2_' + j).val($('#txtWidth_' + j).val());
						$('#textSize3_' + j).val($('#txtLengthb_' + j).val());
						$('#textSize4_' + j).val(0);
						$('#txtRadius_' + j).val(0);
					}
				} else if ($('#cmbKind').val().substr(0, 1) == 'B') {
					$('#lblSize_help').text("短徑x長徑x厚度x長度");
					$('#Size').css('width', '340px');
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).show();
						$('#textSize2_' + j).show();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).show();
						$('#x1_' + j).show();
						$('#x2_' + j).show();
						$('#x3_' + j).show();
						$('#txtSpec_'+j).css('width', '320px');
						$('#textSize1_' + j).val($('#txtRadius_' + j).val());
						$('#textSize2_' + j).val($('#txtWidth_' + j).val());
						$('#textSize3_' + j).val($('#txtDime_' + j).val());
						$('#textSize4_' + j).val($('#txtLengthb_' + j).val());
					}
				} else {//鋼筋和鋼胚
					$('#lblSize_help').text("長度");
					$('#Size').css('width', '200px');
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).hide();
						$('#textSize2_' + j).hide();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).hide();
						$('#x1_' + j).hide();
						$('#x2_' + j).hide();
						$('#x3_' + j).hide();
						$('#txtSpec_'+j).css('width', '180px');
						$('#textSize1_' + j).val(0);
						$('#txtDime_' + j).val(0);
						$('#textSize2_' + j).val(0);
						$('#txtWidth_' + j).val(0);
						$('#textSize3_' + j).val($('#txtLengthb_' + j).val());
						$('#textSize4_' + j).val(0);
						$('#txtRadius_' + j).val(0);
					}
				}
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


			Number.prototype.round = function(arg) {
				return Math.round(this.mul(Math.pow(10, arg))).div(Math.pow(10, arg));
			};
			Number.prototype.div = function(arg) {
				return accDiv(this, arg);
			};
			function accDiv(arg1, arg2) {
				var t1 = 0, t2 = 0, r1, r2;
				try {
					t1 = arg1.toString().split(".")[1].length;
				} catch (e) {
				}
				try {
					t2 = arg2.toString().split(".")[1].length;
				} catch (e) {
				}
				with (Math) {
					r1 = Number(arg1.toString().replace(".", ""));
					r2 = Number(arg2.toString().replace(".", ""));
					return (r1 / r2) * pow(10, t2 - t1);
				}
			}


			Number.prototype.mul = function(arg) {
				return accMul(arg, this);
			};
			function accMul(arg1, arg2) {
				var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
				try {
					m += s1.split(".")[1].length;
				} catch (e) {
				}
				try {
					m += s2.split(".")[1].length;
				} catch (e) {
				}
				return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
			}


			Number.prototype.add = function(arg) {
				return accAdd(arg, this);
			};
			function accAdd(arg1, arg2) {
				var r1, r2, m;
				try {
					r1 = arg1.toString().split(".")[1].length;
				} catch (e) {
					r1 = 0;
				}
				try {
					r2 = arg2.toString().split(".")[1].length;
				} catch (e) {
					r2 = 0;
				}
				m = Math.pow(10, Math.max(r1, r2));
				return (Math.round(arg1 * m) + Math.round(arg2 * m)) / m;
			}


			Number.prototype.sub = function(arg) {
				return accSub(this, arg);
			};
			function accSub(arg1, arg2) {
				var r1, r2, m, n;
				try {
					r1 = arg1.toString().split(".")[1].length;
				} catch (e) {
					r1 = 0;
				}
				try {
					r2 = arg2.toString().split(".")[1].length;
				} catch (e) {
					r2 = 0;
				}
				m = Math.pow(10, Math.max(r1, r2));
				n = (r1 >= r2) ? r1 : r2;
				return parseFloat(((Math.round(arg1 * m) - Math.round(arg2 * m)) / m).toFixed(n));
			}
		</script>
		<style type="text/css">
			#dmain {
				/*overflow: hidden;*/
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
				width: 800px;
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
				width: 10%;
			}
			.tbbm .tdZ {
				width: 1%;
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
				width: 1530px;
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
			#dbbt {
				width: 1525px;
			}
			#tbbt {
				margin: 0;
				padding: 2px;
				border: 2px pink double;
				border-spacing: 1;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: pink;
				width: 100%;
			}
			#tbbt tr {
				height: 35px;
			}
			#tbbt tr td {
				text-align: center;
				border: 2px pink double;
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
			<div class="dview" id="dview"  >
				<table class="tview" id="tview"	>
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%"><a id='vewTgg'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='odate'>~odate</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblKind' class="lbl"> </a></td>
						<td><select id="cmbKind" class="txt c1"> </select></td>
						<td><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td><input id="txtOdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td class="td7" align="right">
						<input id="chkAeno" type="checkbox"/>
						<a id='lblAeno' style="width: 50%;"> </a></td>
						<td class="td8" align="right">
						<input id="chkEnda" type="checkbox"/>
						<a id='lblEnd' style="width: 40%;"> </a><span> </span></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtCno" type="text" style="float:left;width:30%;"/>
						<input id="txtAcomp" type="text" style="float:left;width:70%;"/>
						</td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtNoa"   type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td ><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtTggno" type="text" style="float:left;width:30%;"/>
							<input id="txtTgg"  type="text" style="float:left;width:70%;"/>
							<input id="txtNick"  type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtPaytype" type="text" style="float:left; width:120px;"/>
						<select id="combPaytype" style="float:left; width:20px;"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan="3">
						<input id="txtTel"  type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td colspan="3"><input id="txtFax" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td colspan="5" >
							<input id="txtPost"  type="text" style="float:left; width:20%;"/>
							<input id="txtAddr"  type="text" style="float:left; width:80%;"/></td>
						<td>
							<span> </span><a id='lblTrantype' class="lbl"> </a>
						</td>
						<td><select id="cmbTrantype" class="txt c1" name="D1" ></select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td>
						<input id="txtMoney" type="text" class="txt num c1" />
						</td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td>
						<input id="txtTax" type="text" class="txt num c1" />
						</td>
						<td><span style="float:left;display:block;width:10px;"></span><select id="cmbTaxtype" style="float:left;width:80px;" ></select></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td>
						<input id="txtTotal" type="text" class="txt num c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td>
						<input id="txtWeight" type="text" class="txt num c1" />
						</td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><select id="cmbCoin" class="txt c1" ></select></td>
						<td>
						<input id="txtFloata" type="text" class="txt c1 num" />
						</td>
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td>
						<input id="txtTotalus" type="text" class="txt num c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblContract_st' class="lbl"> </a></td>
						<td><input id="txtContract"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td colspan="2">
						<input id="txtSalesno" type="text" style="float:left;width:50%;"/>
						<input id="txtSales" type="text" style="float:left;width:50%;"/>
						</td>
						<td><span> </span><a id='lblOrdb' class="lbl btn"> </a></td>
						<td colspan="2"><input id="txtOrdbno" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="7">
						<input id="txtMemo" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td>
						<input id="txtWorker"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td>
						<input id="txtWorker2"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblApv" class="lbl"> </a></td>
						<td>
						<input id="txtApv" type="text"  class="txt c1" disabled="disabled"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:150px;"><a id='lblUno_st'> </a></td>
					<td align="center" style="width:120px;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width:30px;"><a id='lblStyle_st'> </a></td>
					<td align="center" style="width:100px;"><a id='lblProduct_st'> </a></td>
					<td align="center" style="width:340px;" id='Size'><a id='lblSize_help'> </a>
					<BR>
					<a id='lblSize_st'> </a></td>
					<td align="center" style="width:150px;"><a id='lblSizea_st'> </a></td>
					<td align="center" style="width:50px;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount_st'> </a></td>
					<td align="center" style="width:80px;"><a id='lblWeights_st'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrices_st'> </a></td>
					<td align="center" style="width:100px;"><a id='lblTotals_st'> </a></td>
					<td align="center" style="width:80px;"><a id='lblGemounts'> </a></td>
					<td align="center" style="width:120px;"><a id='lblMemos_st'> </a><br><a id='lblOrdenos_st'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNo2.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="btnUno.*" type="button" value='.' style="float:left;width:20px;"/>
						<input id="txtUno.*" type="text" style="float:left;width:110px;" />
					</td>
					<td>
					<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:20px;float:left;" />
					<input type="text" id="txtProductno.*"  style="width:70px; float:left;"/>
					<span style="display:block; width:20px;float:left;"> </span>
					<input type="text" id="txtClass.*"  style="width:70px; float:left;"/>
					</td>
					<td>
					<input id="txtStyle.*" type="text" style="width:90%;" />
					</td>
					<td>
					<input id="txtProduct.*" type="text" style="width:90%;" />
					</td>
					<td>
					<input class="txt num" id="textSize1.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
					<div id="x1.*" style="float: left;display:block;width:20px;padding-top: 4px;" >
						x
					</div>
					<input class="txt num" id="textSize2.*" type="text" style="float: left;width:55px;"  disabled="disabled"/>
					<div id="x2.*" style="float: left;display:block;width:20px;padding-top: 4px;">
						x
					</div>
					<input class="txt num" id="textSize3.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
					<div id="x3.*" style="float: left;display:block;width:20px;padding-top: 4px;">
						x
					</div>
					<input class="txt num" id="textSize4.*" type="text"  style="float: left;width:55px;" disabled="disabled"/>
					<!--上為虛擬下為實際-->
					<input id="txtRadius.*" type="text" style="display:none;"/>
					<input id="txtWidth.*" type="text" style="display:none;"/>
					<input id="txtDime.*" type="text" style="display:none;"/>
					<input id="txtLengthb.*" type="text" style="display:none;"/>
					<input id="txtSpec.*" type="text" style="float:left;"/>
					</td>
					<td>
					<input id="txtSize.*" type="text" style="width:95%;"/>
					</td>
					<td >
					<input id="txtUnit.*" type="text" style="width:90%;"/>
					</td>
					<td>
					<input id="txtMount.*" type="text" class="txt num" style="width:95%;"/>
					</td>
					<td>
					<input id="txtWeight.*" type="text" class="txt num" style="width:95%;"/>
					</td>
					<td>
					<input id="txtPrice.*" type="text"  class="txt num" style="width:95%;"/>
					</td>
					<td>
					<input id="txtTotal.*" type="text" class="txt num" style="width:95%;"/>
					<input id="txtTheory.*" type="text" class="txt num" style="width:95%;"/>
					</td>
					<td>
					<input id="txtC1.*" type="text" class="txt num" style="width:95%;"/>
					<input id="txtNotv.*" type="text" class="txt num" style="width:95%;"/>
					</td>
					<td >
					<input id="txtMemo.*" type="text" style="width:140px; float:left;"/>
					<input id="txtOrdbno.*" type="text"  style="width:100px;float:left;"/>
					<input id="txtNo3.*" type="text"  style="width:30px;float:left;"/>
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
