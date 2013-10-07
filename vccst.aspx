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

			q_desc = 1;
			q_tables = 's';
			var q_name = "vcc";
			var q_readonly = ['txtComp', 'txtAccno', 'txtAcomp', 'txtSales', 'txtNoa', 'txtWorker', 'txtWorker2','txtMoney','txtWeight','txtTotal','txtTax','txtTotalus'];
			var q_readonlys = ['txtTotal', 'txtOrdeno', 'txtNo2'];
			var bbmNum = [['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtTotalus', 10, 2, 1], ['txtWeight', 10, 2, 1], ['txtFloata', 10, 4, 1]];
			var bbsNum = [['txtPrice', 12, 2, 1], ['txtTotal', 12, 2, 1, 1], ['txtWeight', 10, 2, 1], ['txtMount', 10, 2, 1],['txtTheory',10,2,1], ['txtGweight', 10, 2, 1]];
			var bbmMask = [];
			var bbsMask = [['txtStyle', 'A']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			//ajaxPath = "";
			aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,tel,zip_fact,addr_fact,paytype', 'txtCustno,txtComp,txtTel,txtPost,txtAddr,txtPaytype', 'cust_b.aspx'], ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'], ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx'], ['txtUno_', 'btnUno_', 'view_uccc', 'uno,productno,class,spec,style,product,radius,width,dime,lengthb', 'txtUno_,txtProductno_,txtClass_,txtSpec_,txtStyle_,txtProduct_,txtRadius_,txtWidth_,txtDime_,txtLengthb_', 'uccc_seek_b.aspx', '95%', '60%'], ['txtStoreno2_', 'btnStoreno2_', 'store', 'noa,store', 'txtStoreno2_,txtStore2_', 'store_b.aspx'], ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx']);
			brwCount2 = 12;
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
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
			var t_spec;
			function mainPost() {// 載入資料完，未 refresh 前
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('vcc.typea'));
				q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_cmbParse("combPaytype", q_getPara('rc2.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				q_cmbParse("cmbKind", q_getPara('sys.stktype'));
				q_gt('spec', '', 0, 0, 0, "", r_accy);
				//=======================================================
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
					size_change();
					sum();
				});
				$("#cmbTrantype").focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				});
				$("#cmbTaxtype").change(function(e) {
					sum();
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
                $('#btnVcceImport').click(function() {
                    var t_ordeno = $('#txtOrdeno').val();
                    var t_custno = $('#txtCustno').val();
                    var t_where = '1=1 ';
                    t_where += q_sqlPara2('ordeno', t_ordeno) + q_sqlPara2('custno', t_custno) + " and ((len(gmemo)=0) or gmemo='cubu')";
                    q_box("vcce_import_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy, 'view_vcce_import', "95%", "95%", q_getMsg('popVcceImport'));
                });
				$('#lblOrdeno').click(function() {
					btnOrdes();
				});
				$('#lblAccno').click(function() {
					q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('btnAccc'), true);
				});

				$('#lblInvono').click(function() {
					t_where = '';
					t_invo = $('#txtInvono').val();
					if (t_invo.length > 0) {
						t_where = "noa='" + t_invo + "'";
						q_box("invoice.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'invo', "95%", "95%", q_getMsg('popInvo'));
					}
				});
				$('#btnImportVcce').click(function() {
					if (q_cur == 1 || q_cur == 2) {
						var t_carno = $('#txtCarno').val();
						if (emp(t_carno)) {
							alert('請輸入 : 【' + q_getMsg('lblCarno') + '】');
						} else {
							t_where = "where=^^ carno='" + t_carno + "' ^^";
							q_gt('vcce', t_where, 0, 0, 0, "", r_accy);
						}
					}
				});
				$('#txtFloata').change(function() {
					sum();
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
			}

			function q_boxClose(s2) {///   q_boxClose 2/4
				var
				ret;
				switch (b_pop) {
                    case 'view_vcce_import':
                        if (q_cur > 0 && q_cur < 4) {
                            if (!b_ret || b_ret.length == 0)
                                return;
                            AddRet = q_gridAddRow(bbsHtm, 'tbbs', 'txtUno,txtOrdeno,txtNo2,txtProductno,txtProduct,txtRadius,txtWidth,txtDime,txtLengthb,txtSpec,txtMount,txtWeight,txtPrice', b_ret.length, b_ret, 'uno,ordeno,no2,productno,product,radius,width,dime,lengthb,spec,mount,weight,price', '');
							//get ordes.price <Start>
							var distinctArray = new Array;
							var inStr = '';
							for(var i=0;i<b_ret.length;i++){distinctArray.push(b_ret[i].ordeno);}
							distinctArray = distinct(distinctArray);
							for(var i=0;i<distinctArray.length;i++){
								inStr += "'"+distinctArray[i]+"',";
							}
							inStr = inStr.substring(0,inStr.length-1);
							var t_where = "where=^^ noa in("+inStr+") and (isnull(noa,'') != '') ^^";
							q_gt('ordes', t_where , 0, 0, 0, "", r_accy);
							//get ordes.price <End>
                            /// 最後 aEmpField 不可以有【數字欄位】
                            size_change();
                        }
                        sum();
                        break;
					case 'ordet':
						if (q_cur > 0 && q_cur < 4) {//  q_cur： 0 = 瀏覽狀態  1=新增  2=修改 3=刪除  4=查詢
							b_ret = getb_ret();
							///  q_box() 執行後，選取的資料
							if (!b_ret || b_ret.length == 0)
								return;
							for(var i=0;i<q_bbsCount;i++){$('#btnMinus_'+i).click();}
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtDime,txtWidth,txtLengthb,txtUnit,txtOrdeno,txtNo2,txtUno,txtMount,txtWeight', 
																b_ret.length, b_ret, 
																'productno,product,dime,width,lengthb,unit,noa,no3,uno,mount,weight', 'txtProductno,txtProduct');
							/// 最後 aEmpField 不可以有【數字欄位】
							for (var i = 0; i < ret.length; i++) {
								$('#txtMount_' + i).change();
							}
							sum();
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						///   q_boxClose 3/4
						break;
				}/// end Switch
				b_pop = '';
			}

			var focus_addr = '';
			var StyleList = '';
			var vcces_as = new Array;
			var t_uccArray = new Array;
			var AddRet = new Array;
			function q_gtPost(t_name) {/// 資料下載後 ...
				switch (t_name) {
					case 'spec':
						t_spec = _q_appendData("spec", "", true);
						break;
					case 'style' :
						var as = _q_appendData("style", "", true);
						StyleList = new Array();
						StyleList = as;
						break;
					case 'cust':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined && focus_addr != '') {
							$('#' + focus_addr).val(as[0].addr_fact);
							focus_addr = '';
						}
						break;
					case 'vcce':
						vcces_as = _q_appendData("vcces", "", true);
						if (vcces_as[0] != undefined) {
							var distinctArray = new Array;
							var inStr = '';
							for(var i=0;i<vcces_as.length;i++){distinctArray.push(vcces_as[i].ordeno);}
							distinctArray = distinct(distinctArray);
							for(var i=0;i<distinctArray.length;i++){
								inStr += "'"+distinctArray[i]+"',";
							}
							inStr = inStr.substring(0,inStr.length-1);
							var t_where = "where=^^ ordeno in("+inStr+") and (isnull(ordeno,'') != '') ^^";
							q_gt('vccs', t_where , 0, 0, 0, "", r_accy);
						}
						sum();
						break;
					case 'vccs':
						var vccs_as = _q_appendData("vccs", "", true);
						for(var i=0;i<vccs_as.length;i++){
							for(var j=0;j<vcces_as.length;j++){
								if((vcces_as[j].ordeno == vccs_as[i].ordeno) && (vcces_as[j].no2 == vccs_as[i].no2)){
									vcces_as[j].mount = dec(vcces_as[j].mount)-dec(vccs_as[i].mount);
									vcces_as[j].weight = dec(vcces_as[j].weight)-dec(vccs_as[i].weight);
								}
							}
						}
						for(var i=0;i<vcces_as.length;i++){
							if (vcces_as[i].mount <=0 || vcces_as[i].weight <=0 || vcces_as[i].ordeno == '') {
									vcces_as.splice(i, 1);
									i--;
							}
						}
						if (vcces_as[0] != undefined) {
							AddRet = q_gridAddRow(bbsHtm, 'tbbs', 'txtUno,txtProductno,txtProduct,txtSpec,textSize1,textSize2,textSize3,txtDime,txtWidth,txtLengthb,txtMount,txtWeight,txtPrice,txtStyle,txtOrdeno,txtNo2', vcces_as.length, vcces_as, 'uno,productno,product,spec,dime,width,lengthb,dime,width,lengthb,mount,weight,price,style,ordeno,no2', 'txtUno');
							//get ordes.price <Start>
							var distinctArray = new Array;
							var inStr = '';
							for(var i=0;i<vcces_as.length;i++){distinctArray.push(vcces_as[i].ordeno);}
							distinctArray = distinct(distinctArray);
							for(var i=0;i<distinctArray.length;i++){
								inStr += "'"+distinctArray[i]+"',";
							}
							inStr = inStr.substring(0,inStr.length-1);
							var t_where = "where=^^ noa in("+inStr+") and (isnull(noa,'') != '') ^^";
							q_gt('ordes', t_where , 0, 0, 0, "", r_accy);
							//get ordes.price <End>
						}
						vcces_as = new Array;
						break;
					case 'ordes':
						var ordes_as = _q_appendData("ordes", "", true);
						if (AddRet[0] != undefined && ordes_as[0] != undefined) {
							for(var i=0;i<ordes_as.length;i++){
								for(var j=0;j<AddRet.length;j++){
									var t_ordeno = $('#txtOrdeno_'+j).val();
									var t_no2 = $('#txtNo2_'+j).val();
									if(ordes_as[i].noa == t_ordeno && ordes_as[i].no2 == t_no2){
										$('#txtPrice_'+j).val(ordes_as[i].price);
									}
								}
							}
						}
						AddRet = new Array;
						break;
					case q_name:
						t_uccArray = _q_appendData("ucc", "", true);
						if (q_cur == 4)// 查詢
							q_Seek_gtPost();
						break;
				}  /// end switch
			}

			function btnOrdes() {
				var t_custno = trim($('#txtCustno').val());
				var t_where = " 1=1 and issale='1' ";
				if (t_custno.length > 0) {
					t_where += (t_custno.length > 0 ? q_sqlPara2("custno", t_custno) : "");
					////  sql AND 語法，請用 &&
					t_where = t_where;
				} else {
					alert(q_getMsg('msgCustEmp'));
					return;
				}
				q_box("ordet_chk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordet', "95%", "650px", q_getMsg('popOrde'));
			}/// q_box()  開 視窗

			function distinct(arr1) {
				for(var i = 0;i<arr1.length;i++){
					if((arr1.indexOf(arr1[i]) != arr1.lastIndexOf(arr1[i])) || arr1[i] == ''){
						arr1.splice(i, 1);
							i--;
					}
				}
				return arr1;
			}

			function GetOrdenoList(){
				var ReturnStr = new Array;
				for(var i=0;i<q_bbsCount;i++){
					ReturnStr.push(trim($('#txtOrdeno_'+i).val()));
				}
				ReturnStr = distinct(ReturnStr).sort();
				return ReturnStr.toString();
			}

			function btnOk() {
				Lock(1, {
					opacity : 0
				});
				$('#txtOrdeno').val(GetOrdenoList());
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					Unlock(1);
					return;
				}
				if ($('#txtMon').val().length == 0)
					$('#txtMon').val($('#txtDatea').val().substring(0, 6));
				if (!q_cd($('#txtMon').val() + '/01')) {
					alert(q_getMsg('lblMon') + '錯誤。');
					Unlock(1);
					return;
				}
				if ($('#txtDatea').val().substring(0, 3) != r_accy) {
					alert('年度異常錯誤，請切換到【' + $('#txtDatea').val().substring(0, 3) + '】年度再作業。');
					Unlock(1);
					return;
				}
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				sum();

				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vcc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				abbm[q_recno]['accno'] = xmlString;
				$('#txtAccno').val(xmlString);
				Unlock(1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('vccst_s.aspx', q_name + '_s', "500px", "530px", q_getMsg("popSeek"));
			}

			function getTheory(b_seq) {
				t_Radius = dec($('#txtRadius_' + b_seq).val());
				t_Width = dec($('#txtWidth_' + b_seq).val());
				t_Dime = dec($('#txtDime_' + b_seq).val());
				t_Lengthb = dec($('#txtLengthb_' + b_seq).val());
				t_Mount = dec($('#txtMount_' + b_seq).val());
				t_Style = $('#txtStyle_' + b_seq).val();
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
					productno:t_Productno
				};
				if ($('#cmbKind').val().substr(1, 1) == '4') {//鋼胚
					q_tr('txtTheory_' + b_seq, round(t_Mount * theory_bi(t_spec, $('#txtSpec_' + b_seq).val(), t_Dime, t_Width, t_Lengthb), 0));
				} else {
					q_tr('txtTheory_' + b_seq, theory_st(theory_setting));
				}
			}

			function bbsAssign() {/// 表身運算式
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtStyle_' + j).blur(function() {
							t_IdSeq = -1;
							/// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							ProductAddStyle(b_seq);
							sum();
						});
						//將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
						$('#textSize1_' + j).change(function() {
							sum();
						});
						$('#textSize2_' + j).change(function() {
							sum();
						});
						$('#textSize3_' + j).change(function() {
							sum();
						});
						$('#textSize4_' + j).change(function() {
							sum();
						});
						//-------------------------------------------------
						$('#txtSpec_' + j).change(function() {
							t_IdSeq = -1;
							/// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;

							if ($('#cmbKind').val().substr(1, 1) == '4') {//鋼胚
								q_tr('txtTheory_' + b_seq, theory_bi(t_spec, $('#txtSpec_' + b_seq).val(), dec($('#txtDime_' + b_seq).val()), dec($('#txtWidth_' + b_seq).val()), dec($('#txtLengthb_' + b_seq).val())));
							}
						});
						$('#txtUnit_' + j).focusout(function() {
							sum();
						});
						$('#txtWeight_' + j).focusout(function() {
							sum();
						});
						$('#txtPrice_' + j).focusout(function() {
							sum();
						});
						$('#txtMount_' + j).focusout(function() {
							sum();
						});
						$('#txtTotal_' + j).focusout(function() {
							sum();
						});
					}
				}//j
				_bbsAssign();
				size_change();
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtMon').val(q_date().substring(0, 6));
				$('#txtDatea').focus();
				size_change();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;

				_btnModi();
				$('#txtDatea').focus();
				size_change();
				sum();
			}

			function btnPrint() {
				q_box('z_vccstp.aspx', '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
				// key_value
			}

			function bbsSave(as) {
				if (!as['product'] && !as['uno'] && parseFloat(as['mount'].length==0?"0":as['mount'])==0 && parseFloat(as['weight'].length==0?"0":as['weight'])==0) {
                    as[bbsKey[1]] = '';
                    return;
                }

				q_nowf();
				as['type'] = abbm2['type'];
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

			function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
                $('#txtMoney').attr('readonly', true);
                $('#txtTax').attr('readonly', true);
                $('#txtTotal').attr('readonly', true);
                $('#txtMoney').css('background-color', 'rgb(237,237,238)').css('color', 'green');
                $('#txtTax').css('background-color', 'rgb(237,237,238)').css('color', 'green');
                $('#txtTotal').css('background-color', 'rgb(237,237,238)').css('color', 'green');

                var t_mount = 0, t_price = 0, t_money = 0, t_moneyus=0, t_weight = 0, t_total = 0, t_tax = 0;
                var t_mounts = 0, t_prices = 0, t_moneys = 0, t_weights = 0;
                var t_unit = '';
                var t_float = q_float('txtFloata');

                for (var j = 0; j < q_bbsCount; j++) {
                    t_unit = $.trim($('#txtUnit_' + j).val()).toUpperCase();
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
                    getTheory(j);
                    //---------------------------------------
                    t_weights = q_float('txtWeight_' + j);
                    t_prices = q_float('txtPrice_' + j);
                    t_mounts = q_float('txtMount_' + j);
                    if(t_unit.length==0 ||t_unit=='KG' || t_unit=='M2' || t_unit=='M' || t_unit=='批' || t_unit=='公斤' || t_unit=='噸' || t_unit=='頓'){
                    	t_moneys = t_prices.mul(t_weights);
                    }else{
                    	t_moneys = t_prices.mul(t_mounts);
                    }
                    if(t_float==0){
                    	t_moneys = t_moneys.round(0);
                    }else{
                    	t_moneyus = t_moneyus.add(t_moneys.round(2));
                    	t_moneys = t_moneys.mul(t_float).round(0);
                    }
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
                if(t_float==0)
                	$('#txtTotalus').val(0);
                else
                	$('#txtTotalus').val(FormatNumber(t_moneyus));
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
						$('#txtStyle_' + b_seq).focus();
						break;
					case 'txtUno_':
						size_change();
						$('#txtMount_' + b_seq).focus();
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

			function size_change() {
				if (q_cur == 1 || q_cur == 2) {
					$('input[id*="textSize"]').removeAttr('disabled');
				} else {
					$('input[id*="textSize"]').attr('disabled', 'disabled');
				}
				if ($('#cmbKind').val().substr(0, 1) == 'A') {
					$('#lblSize_help').text(q_getPara('sys.lblSizea'));
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).show();
						$('#textSize2_' + j).show();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).hide();
						$('#x1_' + j).show();
						$('#x2_' + j).show();
						$('#x3_' + j).hide();
						$('#Size').css('width', '230px');
						$('#txtSpec_' + j).css('width', '229px');
						$('#textSize1_' + j).val($('#txtDime_' + j).val());
						$('#textSize2_' + j).val($('#txtWidth_' + j).val());
						$('#textSize3_' + j).val($('#txtLengthb_' + j).val());
						$('#textSize4_' + j).val(0);
						$('#txtRadius_' + j).val(0);
					}
				} else if ($('#cmbKind').val().substr(0, 1) == 'B') {
					$('#lblSize_help').text(q_getPara('sys.lblSizeb'));
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).show();
						$('#textSize2_' + j).show();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).show();
						$('#x1_' + j).show();
						$('#x2_' + j).show();
						$('#x3_' + j).show();
						$('#Size').css('width', '313px');
						$('#txtSpec_' + j).css('width', '311px');
						$('#textSize1_' + j).val($('#txtRadius_' + j).val());
						$('#textSize2_' + j).val($('#txtWidth_' + j).val());
						$('#textSize3_' + j).val($('#txtDime_' + j).val());
						$('#textSize4_' + j).val($('#txtLengthb_' + j).val());
					}
				} else {//鋼筋和鋼胚
					$('#lblSize_help').text(q_getPara('sys.lblSizec'));
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).hide();
						$('#textSize2_' + j).hide();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).hide();
						$('#x1_' + j).hide();
						$('#x2_' + j).hide();
						$('#x3_' + j).hide();
						$('#Size').css('width', '65px');
						$('#txtSpec_' + j).css('width', '60px');
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
				width: 1560px;
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
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
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
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id='lblKind' class="lbl"> </a></td>
						<td><select id="cmbKind" class="txt c1"> </select></td>
						<td></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtNoa"   type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
						<td></td>
						<td><span> </span><a id='lblInvono' class="lbl"> </a></td>
						<td colspan="2"><input id="txtInvono" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td colspan="4">
						<input id="txtCno" type="text" style="float:left;width:25%;"/>
						<input id="txtAcomp" type="text" style="float:left;width:75%;"/>
						</td>
						<td><span> </span><a id='lblOrdeno' class="lbl btn"> </a></td>
						<td colspan="2"><input id="txtOrdeno" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td ><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtCustno" type="text" style="float:left;width:25%;"/>
							<input id="txtComp"  type="text" style="float:left;width:75%;"/>
							<input id="txtNick"  type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td colspan="2">
						<input id="txtSalesno" type="text" style="float:left;width:50%;"/>
						<input id="txtSales" type="text" style="float:left;width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan="4">
						<input id="txtTel"  type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td colspan="2"><select id="cmbTrantype" class="txt c1" name="D1" ></select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td colspan="4" >
							<input id="txtPost"  type="text" style="float:left; width:25%;"/>
							<input id="txtAddr"  type="text" style="float:left; width:75%;"/></td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtPaytype" type="text" style="float:left; width:165px;"/>
						<select id="combPaytype" style="float:left; width:20px;"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCardeal' class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtCardealno" type="text" style="float:left;width:25%;"/>
							<input id="txtCardeal" type="text" style="float:left;width:75%;" />
						</td>
						<td><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td colspan="2"><input id="txtCarno" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td>
						<input id="txtTotalus" type="text" class="txt num c1" />
						</td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td>
						<input id="txtFloata" type="text" class="txt num c1" />
						</td>
						<td><span style="float:left;display:block;width:10px;"></span><select id="cmbCoin" style="float:left;width:80px;" > </select></td>
						<td></td>
						<td colspan="2">
						<input id="btnImportVcce" type="button" />
						<input id="btnVcceImport" type="button" title="cut cubu"/>
						</td>
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
						<td><span style="float:left;display:block;width:10px;"></span><select id="cmbTaxtype" style="float:left;width:80px;" > </select></td>
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
						<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td>
						<input id="txtPrice" type="text" class="txt num c1" />
						</td>
						<td></td>
						<td><span> </span><a id='lblTranmoney' class="lbl"> </a></td>
						<td>
						<input id="txtTranmoney" type="text" class="txt num c1" />
						</td>
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
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td>
						<input id="txtAccno" type="text"  class="txt c1"/>
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
					<td align="center" style="width:20px;"></td>
					<td align="center" style="width:150px;"><a id="lblUno_st" > </a></td>
					<td align="center" style="width:120px;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width:20px;"><a id='lblStyle_st'> </a></td>
					<td align="center" style="width:120px;"><a id='lblProduct_st'> </a></td>
					<td align="center" id="Size"><a id='lblSize_help'> </a>
					<BR>
					<a id='lblSize_st'> </a></td>
					<td align="center" style="width:30px;"><a id='lblUnit'></a></td>
					<td align="center" style="width:80px;"><a id='lblMount_st'></a></td>
					<td align="center" style="width:80px;"><a id='lblWeight_st'></a></td>
					<td align="center" style="width:80px;"><a id='lblPrices_st'></a></td>
					<td align="center" style="width:80px;">合計<br>理論重</td>
					<td align="center" style="width:80px;"><a id='lblGweight_st'></a></td>
					<td align="center" style="width:60px;">寄Y
					<BR>
					代Z</td>
					<td align="center" style="width:80px;"><a id='lblStore2_st'> </a></td>
					<td align="center" style="width:120px;"><a id='lblMemos_st'></a></td>
					<td align="center" style="width:180px;"><a id='lblSizea_st'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
					<input class="btn" id="btnUno.*" type="button" value='.' style="width:15px;"/>
					<input id="txtUno.*" type="text" style="width:110px;"/>
					</td>
					<td>
					<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:15px;float:left;" />
					<input  id="txtProductno.*" type="text" style="width:85px;" />
					<span style="display:block;width:15px;"> </span>
					<input id="txtClass.*" type="text" style='width: 85px;'/>
					</td>
					<td>
					<input type="text" id="txtStyle.*" style="width:90%;text-align:center;" />
					</td>
					<td>
					<input type="text" id="txtProduct.*" style="width:95%;" />
					</td>
					<!--<td><input class="txt c1" id="txtSpec.*" type="text"/></td>-->
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
					<input id="txtUnit.*" type="text" class="txt num" style="width:95%;text-align: center;"/>
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
					<input id="txtGweight.*" type="text"  class="txt num" style="width:95%;"/>
					</td>
					<td >
					<input class="txt" id="txtUsecoil.*" type="text" style="text-align:center;width:95%;"/>
					</td>
					<td >
					<input class="btn"  id="btnStoreno2.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;display:none;" />
					<input  id="txtStoreno2.*" type="text" style="width:95%;" />
					<input id="txtStore2.*" type="text" style='width: 95%;'/>
					</td>
					<td>
					<input id="txtMemo.*" type="text" class="txt" style="width:95%;"/>
					<input id="txtOrdeno.*" type="text" style="width:80px;" />
					<input id="txtNo2.*" type="text" style="width:20px;" />
					<input id="recno.*" type="hidden" />
					</td>
					<td>
					<input id="txtSize.*" type="text" style="width:95%;" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
