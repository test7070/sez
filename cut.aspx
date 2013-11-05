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
			var q_name = "cut";
			var q_readonly = ['txtNoa', 'txtProductno', 'txtProduct', 'txtSpec', 'txtDime', 'txtWidth', 'txtLengthb', 'txtRadius', 'txtOweight', 'txtEweight', 'txtTotalout', 'txtTheyout', 'txtWorker', 'txtWorker2'];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtCust', 'cust_b.aspx'], ['txtUno', 'lblUno', 'view_uccc', 'uno,productno,product,spec,dime,width,lengthb,radius,weight,eweight', 'txtUno,txtProductno,txtProduct,txtSpec,txtDime,txtWidth,txtLengthb,txtRadius,txtOweight,txtEweight', 'uccc_seek_b.aspx', '95%', '60%'], ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'], ['txtCustno_', 'btnCust_', 'cust', 'noa,comp', 'txtCustno_,txtCust_', 'cust_b.aspx'], ['txtMechno', 'lblMech', 'mech', 'noa,mech', 'txtMechno,txtMech', 'mech_b.aspx'], ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx']);
			q_desc = 1;
			brwCount2 = 11;
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

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
				bbsMask = [['txtStyle', "A"]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('cut.typea'));
				q_cmbParse("combType2", q_getPara('cut.type2'));
				q_cmbParse("combType2A", q_getPara('cut.type2A'));
				q_cmbParse("cmbKind", q_getPara('sys.stktype'));
				//q_cmbParse("cmbKind", q_getPara('cut.kind'));
				//重新計算理論重
				$('#cmbTypea').change(function() {
					cut_save_db();
					sum();
				});
				$('#combType2').change(function() {
					$('#txtType2').val($('#combType2').val());
					var choiceItem = $(this).val().toUpperCase();
					switch(choiceItem){
						case 'A':
							$('#lblWidth').text(q_getMsg('lblWidth2'));
							$('#lblRadius').css('display','');
							$('#txtRadius').css('display','');
							break;
						default:
							$('#lblWidth').text(q_getMsg('lblWidth'));
							$('#lblRadius').css('display','none');
							$('#txtRadius').css('display','none');
							break;
					}
					cut_save_db();
					sum();
				});
				$('#combType2A').change(function() {
					$('#txtType2').val($('#combType2A').val());
					var choiceItem = $(this).val().toUpperCase();
					switch(choiceItem){
						case 'A':
							$('#lblWidth').text(q_getMsg('lblWidth2'));
							$('#lblRadius').css('display','');
							$('#txtRadius').css('display','');
							break;
						default:
							$('#lblWidth').text(q_getMsg('lblWidth'));
							$('#lblRadius').css('display','none');
							$('#txtRadius').css('display','none');
							break;
					}
					cut_save_db();
					sum();
				});
				$('#txtGweight').change(function() {
					cut_save_db();
					sum();
				});
				//變動尺寸欄位
				$('#cmbKind').change(function() {
					size_change();
				});
				$('#btnOrdesImport').click(function() {
					if (q_cur == 1 || q_cur == 2) {
						var t_bdime = dec($('#txtBdime').val()) - 0.5;
						var t_edime = dec($('#txtEdime').val());
						var t_width = dec($('#txtWidth').val());
						var t_productno = trim($('#txtProductno').val());
						var t_custno = trim($('#txtCustno').val());
						t_edime = (t_edime == 0 ? 999 : t_edime);
						var t_where = " 1=1 and isnull(enda,0)='0'";
						t_where += q_sqlPara2('dime', t_bdime, t_edime) + q_sqlPara2('productno', t_productno);
						if(t_width!=0)
							t_where += q_sqlPara2('width', 0, t_width+11);
						if (!emp(t_custno))
							t_where += q_sqlPara2('custno', t_custno);
						q_box("ordests_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "95%", q_getMsg('popOrde'));
					}
				});
			}

			function q_boxClose(s2) {///   q_boxClose 2/4
				var ret;
				switch (b_pop) {
					case 'ordes':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0){
								b_pop = '';
								return;
							}
							bbsClear();
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtCustno,txtCust,txtStyle,txtRadius,txtWidth,txtDime,txtLengthb,txtMount,txtWeight,txtMemo,txtProductno,txtSpec,txtOrdeno,txtNo2,txtClass,txtSize', b_ret.length, b_ret, 'custno,cust,style,radius,width,dime,lengthb,mount,weight,memo,productno,spec,noa,no2,class,size', '');
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

			function q_popPost(s1) {
				switch(s1){
					case 'txtUno':
						$('#txtGweight').val($('#txtEweight').val());
						$('#txtGmount').val(1);
						break;
					case 'txtProductno_':
						$('input[id*="txtProduct_"]').each(function() {
							$(this).attr('OldValue', $(this).val());
						});
						ProductAddStyle(b_seq);
						$('#txtStyle_' + b_seq).focus();
						break;
				}
			}
			function SetEmpUno(){
				
			}
			function bbsClear() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#btnMinus_' + i).click();
				}
			}

			var StyleList = '';
			var unoArray = new Array;
			var t_uccArray = new Array;
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'ordes':
						ordes = _q_appendData("ordes", "", true);
						if (ordes[0] == undefined)
							alert("訂單不存在");
						break;
					case 'style' :
						var as = _q_appendData("style", "", true);
						StyleList = new Array();
						StyleList = as;
						break;
					case 'uccb':
						var i_uno = 1;
						uccb = _q_appendData("uccb", "", true);
						//取得餘料編號
						if (uccb[uccb.length - 1] != undefined) {
							if (uccb[uccb.length - 1].noa.indexOf('-') > -1)//取-之後的數字
							{
								i_uno = parseInt(uccb[uccb.length - 1].noa.slice(uccb[uccb.length - 1].noa.indexOf('-') + 1).toString(10)) + 1;
							}
						}
						//判斷已有領用
						if (uccb[0] != undefined) {
							for (var i = 0; i < uccb.length; i++) {
								if ($('#txtUno').val() == uccb[i].noa) {
									uccb_gweight = uccb[i].gweight;
								}
							}
						}
						break;
					case 'deleUccy':
						var as = _q_appendData("uccy", "", true);
						var err_str = '';
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								if (dec(as[i].gweight) > 0) {
									err_str += as[i].uno + '已領料，不能刪除!!\n';
								}
							}
							if (trim(err_str).length > 0) {
								alert(err_str);
								return;
							} else {
								_btnDele();
							}
						} else {
							_btnDele();
						}
						break;
					case q_name:
						t_uccArray = _q_appendData("ucc", "", true);
						if (q_cur == 1)
							cuts = _q_appendData("cut", "", true);
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					case 'view_uccb':
						var as = _q_appendData("view_uccb", "", true);
						for (var i = 0; i < as.length; i++) {
							unoArray.push(as[i].uno);
						}
						setEmpUno();
						break;
					default:
						if (t_name.substring(0, 9) == 'checkUno_') {
							var n = t_name.split('_')[1];
							var as = _q_appendData("view_uccb", "", true);
							if (as[0] != undefined) {
								var t_uno = $('#txtBno_' + n).val();
								alert(t_uno + ' 此批號已存在!!\n【' + as[0].action + '】單號：' + as[0].noa);
								$('#txtUno_' + n).focus();
							}
						} else if (t_name.substring(0, 14) == 'btnOkcheckUno_') {
							var n = parseInt(t_name.split('_')[1]);
							var as = _q_appendData("view_uccb", "", true);
							if (as[0] != undefined) {
								var t_uno = $('#txtBno_' + n).val();
								alert(t_uno + ' 此批號已存在!!\n【' + as[0].action + '】單號：' + as[0].noa);
								Unlock(1);
								return;
							} else {
								btnOk_checkUno(n - 1);
							}
						}
						break;
				}  /// end switch
			}

			function setNewBno(w_unoArray, idno, IndexNum, IndexEng) {
				var newIndexNum = (dec(IndexNum) > 0 ? dec(IndexNum) + 1 : 1);
				var newIndexEng = (dec(IndexEng) > 0 ? dec(IndexEng) : 65);
				if (newIndexNum > 9) {
					newIndexNum = 1;
					newIndexEng = dec(IndexEng) + 1;
				}
				var newBno = trim($('#txtUno').val()) + newIndexNum + String.fromCharCode(newIndexEng);
				if (w_unoArray.indexOf(newBno) == -1) {
					$('#txtBno_' + idno).val(newBno);
					unoArray.push(newBno);
				} else {
					setNewBno(unoArray, idno, newIndexNum, newIndexEng);
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				var s1 = xmlString.split(';');
				Unlock(1);
			}

			function CheckInputError(){
				var t_err = '';
				var t_theyout = dec($('#txtTheyout').val());
				var t_gweight = dec($('#txtGweight').val());
				var t_gmount = dec($('#txtGmount').val());
				var t_eweight = dec($('#txtEweight').val());
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					t_err += q_getMsg('lblDatea') + '錯誤。\n';
				}
				if ($('#txtDatea').val().substring(0, 3) != r_accy) {
					t_err += '年度異常錯誤，請切換到【' + $('#txtDatea').val().substring(0, 3) + '】年度再作業。\n';
				}
				if (emp($('#txtUno').val())) {
					t_err += "批號不可為空白\n";
				}
				if (uccb_gweight > 0){
					t_err += "此批號已有領用\n";
				}
				if (emp($('#txtTggno').val()) && $('#cmbTypea').find("option:selected").text().indexOf('委') > -1) {
					t_err += "委外廠商不可為空白\n";
				}
				if (t_theyout != 0 && t_gweight == 0) {
					t_err += "領料重為零\n";
				}
				if (t_theyout != 0 && t_gmount == 0) {
					t_err += "領料數為零\n";
				}
				if (t_theyout > t_gweight) {
					t_err += "產出實際重 > 領料重\n";
				}
				if (t_gweight > t_eweight) {
					t_err += "領料重 > 可領料重\n";
				}
				if (t_theyout > 0 && t_gweight > 0 && ((Math.abs(t_theyout - t_gweight)) / t_gweight) > 0.05) {
					t_err += "產出實際重、領料重，差異過大\n";
				}
				if ($('#cmbTypea').find("option:selected").text().indexOf('委') == -1) {
					for (var j = 0; j < q_bbsCount; j++) {
						var thisWaste = trim($('#txtWaste_' + j).val()).toUpperCase();
						if (emp($('#txtBno_' + j).val()) && thisWaste >= 'X') {
							$('#txtBno_' + j).val(thisWaste + '001');
						}
						if (emp($('#txtStyle_' + j).val()) && !emp($('#txtBno_' + j).val()) && (thisWaste.length ==0)) {
							t_err += "第 "+(j+1)+" 筆無型別,請檢查\n";
						}
					}
				}
				for (var j = 0; j < q_bbsCount; j++) {
					if (!emp($('#txtOrdeno_' + j).val()) && emp($('#txtNo2_' + j).val())) {
						t_err += "第 "+(j+1)+" 筆訂序為空\n";
					}
					if (dec($('#txtWeight_' + j).val()) > 0 && emp($('#txtDatea').val())) {
						t_err += "第 "+(j+1)+" 筆表身有重量,日期為空\n";
					}
					if (dec($('#txtWeight_' + j).val()) > 0 && emp($('#txtWidth_' + j).val())) {
						t_err += "第 "+(j+1)+" 筆表身重量或寬度小於零\n";
					}
					if ($('#cmbTypea').find("option:selected").text().indexOf('委') > -1 && $('#txtWaste_' + j).val() >= 'X') {
						$('#txtBno_' + j).val($('#txtWaste_' + j).val() + '001');
					}
					if (dec($('#txtDime_' + j).val()) == dec($('#txtWidth_' + j).val()) && dec($('#txtWidth_' + j).val()) > 0) {
						t_err += "第 "+(j+1)+" 筆表身尺寸異常\n";
					}
				}
				return t_err;
			}

			function setEmpUno(){
				for(var j=0;j<q_bbsCount;j++){
					var thisBno = trim($('#txtBno_' + j).val());
					var thisMount = dec($('#txtMount_' + j).val());
					var thisWeight = dec($('#txtWeight_' + j).val());
					if((thisBno.length==0) && (thisMount >0) && (thisWeight>0)){
						setNewBno(unoArray, j);
					}
				}
				btnOk_checkUno(q_bbsCount - 1);
			}

			function btnOk() {
				Lock(1, {
					opacity : 0
				});
				if($('#combType2').is(":visible")){
					$('#txtType2').val($('#combType2').val());
				}
				if($('#combType2A').is(":visible")){
					$('#txtType2').val($('#combType2A').val());
				}
				
				var t_err = CheckInputError();
				if(t_err.length>0){
					alert(t_err);
					Unlock(1);
					return;					
				}
				if (q_cur > 0 && dec($('#txtPrice').val()) > 0)
					$('#txtTranmoney').val(dec($('#txtPrice').val()) * dec($('#txtTheyout').val()));
				//檢查BBS批號
				for (var i = 0; i < q_bbsCount; i++) {
					for (var j = i + 1; j < q_bbsCount; j++) {
						var iBno = $.trim($('#txtBno_' + i).val()).toUpperCase();
						var jBno = $.trim($('#txtBno_' + j).val()).toUpperCase();
						if ((iBno.length > 0 && iBno == jBno) && iBno.substring(0,1) <'X') {
							alert('【' + iBno + '】' + q_getMsg('lblBno') + '重覆。\n' + (i + 1) + ', ' + (j + 1));
							Unlock(1);
							return;
						}
					}
					$('#txtStyle_'+i).blur();
				}
				var t_noa = trim($('#txtUno').val());
				if (t_noa.length > 0) {
					var t_where = "where=^^ left(uno," + t_noa.length + ")='" + t_noa + "' ^^";
					q_gt('view_uccb', t_where, 0, 0, 0, "view_uccb", r_accy);
				}
			}

			function btnOk_checkUno(n) {
				if (n < 0) {
					if (q_cur == 1)
						$('#txtWorker').val(r_name);
					else
						$('#txtWorker2').val(r_name);
					sum();
					var t_noa = trim($('#txtNoa').val());
					var t_date = trim($('#txtDatea').val());
					if (t_noa.length == 0 || t_noa == "AUTO")
						q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cut') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
					else
						wrServer(t_noa);
				} else {
					if ($('#txtWaste_' + n).val().length == 0) {
						var t_uno = $.trim($('#txtBno_' + n).val());
						var t_noa = $.trim($('#txtNoa').val());
						q_gt('view_uccb', "where=^^uno='" + t_uno + "' and not(accy='" + r_accy + "' and tablea='cuts' and noa='" + t_noa + "')^^", 0, 0, 0, 'btnOkcheckUno_' + n);
					} else {
						btnOk_checkUno(n - 1);
					}
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('cut_s.aspx', q_name + '_s', "500px", "530px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#txtTheory_'+j).change(function(e){sum();});
						$('#txtWeight_'+j).change(function(e){sum();});
						$('#txtBno_' + j).change(function() {
							var n = $(this).attr('id').replace('txtBno_', '');
							var t_uno = $.trim($(this).val());
							var t_noa = $.trim($('#txtNoa').val());
							if ($('#txtWaste_' + n).val().length == 0) {
								q_gt('view_uccb', "where=^^uno='" + t_uno + "' and not(accy='" + r_accy + "' and tablea='cuts' and noa='" + t_noa + "')^^", 0, 0, 0, 'checkUno_' + n);
							}
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
						//計算理論重
						$('#txtRadius_' + j).change(function() {
							sum();
						});
						$('#txtDivide_' + j).change(function() {
							sum();
						});
						$('#txtWidth_' + j).change(function() {
							sum();
						});
						$('#txtMount_' + j).change(function() {
							sum();
						});
						$('#txtDime_' + j).change(function() {
							sum();
						});
						$('#txtLengthb_' + j).change(function() {
							sum();
						});
						//判斷訂單是否存在
						$('#txtOrdeno_' + j).change(function() {
							t_IdSeq = -1;
							/// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtOrdeno_' + b_seq)) && !emp($('#txtOrdeno_' + b_seq))) {
								var t_where = "where=^^ noa = '" + $('#txtOrdeno_' + b_seq).val() + "' and no2 = '" + $('#txtNo2_' + b_seq).val() + "' ^^";
								q_gt('ordes', t_where, 0, 0, 0, "", r_accy);
							}
						});
						$('#txtNo2_' + j).change(function() {
							t_IdSeq = -1;
							/// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtOrdeno_' + b_seq)) && !emp($('#txtOrdeno_' + b_seq))) {
								var t_where = "where=^^ noa = '" + $('#txtOrdeno_' + b_seq).val() + "' and no2 = '" + $('#txtNo2_' + b_seq).val() + "' ^^";
								q_gt('ordes', t_where, 0, 0, 0, "", r_accy);
							}
						});
						$('#txtStyle_'+j).focus(function(){
							var thisVal = trim($(this).val());
							if(thisVal.length=0){
								if($('#combType2').is(":visible") && $('#combType2').val()=='1'){
									$(this).val('B');
								}
								if($('#combType2A').is(":visible") && $('#combType2A').val()=='1'){
									$(this).val('B');
								}
							}
						}).focusout(function(){
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var dimeVal = dec($('#txtDime_'+b_seq).val());
							if(dimeVal == 0){
								$('#txtDime_'+b_seq).val($('#txtDime').val());
								size_change();
							}
						});
						$('#txtStyle_' + j).blur(function() {
							var n = $(this).attr('id').replace('txtStyle_', '');
							ProductAddStyle(n);
						});
					}
				}
				_bbsAssign();
				size_change();
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtProduct').focus();
				size_change();
				//取得餘料編號
				/*t_where = "where=^^ noa like '%" + $('#txtUno').val() + "%' ^^";
				q_gt('uccb', t_where, 0, 0, 0, "", r_accy);*/
				sum();
			}

			function btnPrint() {
				q_box('z_cut.aspx', '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['bno'] && !as['productno'] && !as['product'] && !as['spec'] && parseFloat(as['mount'].length==0?"0":as['mount'])==0) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['datea'] = abbm2['datea'];
				return true;
			}

			function sum() {
				var t_theyout = 0,t_totalout=0;
				var t_weights,t_theorys;
				var t_kind = $('#cmbKind').val();
				var t_typea = $('#cmbTypea').find(":selected").text();	
                var t_kind = (($('#cmbKind').val())?$('#cmbKind').val():'');
                t_kind = t_kind.substr(0, 1);
                var t_type2 = $('#txtType2').val();
                var t_array = new Array();
                if($('#combType2').is(":visible")){
                	t_array = q_getPara('cut.type2').split(',');
				}
				if($('#combType2A').is(":visible") && $('#combType2A').val()=='1'){
					t_array = q_getPara('cut.type2A').split(',');
				}
				for(var j=0;j<t_array.length;j++){
            		if(t_array[j].substring(0,t_type2.length+1)==t_type2+'@')
            			t_type2 = t_array[j].substring(t_type2.length+1,t_type2.length);
            	}
                
				for (var j = 0; j < q_bbsCount; j++) {
					t_unit = $.trim($('#txtUnit_' + j).val()).toUpperCase();
					t_mount = q_float('txtMount_'+j);
					//---------------------------------------
					if (t_kind == 'A') {
						q_tr('txtDime_' + j, q_float('textSize1_' + j));
						q_tr('txtWidth_' + j, q_float('textSize2_' + j));
						q_tr('txtLengthb_' + j, q_float('textSize3_' + j));
						q_tr('txtRadius_' + j, q_float('textSize4_' + j));
					} else if (t_kind == 'B') {
						q_tr('txtRadius_' + j, q_float('textSize1_' + j));
						q_tr('txtWidth_' + j, q_float('textSize2_' + j));
						q_tr('txtDime_' + j, q_float('textSize3_' + j));
						q_tr('txtLengthb_' + j, q_float('textSize4_' + j));
					} else {//鋼筋、胚
						q_tr('txtLengthb_' + j, q_float('textSize3_' + j));
					}
					if(t_type2.indexOf('條')>0 || t_type2.indexOf('貼膜')>0){
						if($('#txtStyle_'+j).val().length>0){
							t_theory = (q_float('txtGweight')>0?q_float('txtGweight'):q_float('txtEweight'));
							t_theory = (isNaN(t_theory)?0:t_theory);
							t_theory = round(q_div(q_mul(q_mul(q_div(t_theory,q_float('txtWidth')),q_float('txtWidth_'+j)),q_float('txtMount_'+j)),(q_float('txtDivide_'+j)>0?q_float('txtDivide_'+j):1)),0);
							$('#txtTheory_'+j).val(dec(t_theory));
						}			   
					}else{
						 getTheory(j);
					}
					//---------------------------------------
					t_weights = q_float('txtWeight_'+j);
					t_theorys = q_float('txtTheory_'+j);
					t_theyout = q_add(t_theyout,t_weights);
					t_totalout = q_add(t_totalout,t_theorys);  
				}
				$('#txtTheyout').val(FormatNumber(t_theyout));
				$('#txtTotalout').val(FormatNumber(t_totalout));
				$('#txtLoss').val(q_sub(dec($('#txtGweight').val()),dec($('#txtTheyout').val())));
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

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (q_cur == 2) {
					$('#txtUno').attr('readonly', 'readonly').css('background-color', t_background2);
				}
				if(q_cur == 1 || q_cur ==2){
					$('#combType2').removeAttr('disabled');
					$('#combType2A').removeAttr('disabled');
				}else{
					$('#combType2').attr('disabled','disabled');
					$('#combType2A').attr('disabled','disabled');
				}
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
				var t_where = 'where=^^ uno in(' + getBBSWhere('Bno') + ') ^^';
				q_gt('uccy', t_where, 0, 0, 0, 'deleUccy', r_accy);
			}

			function btnCancel() {
				_btnCancel();
			}

			function getTheory(b_seq) {
				t_Radius = dec($('#txtRadius_' + b_seq).val());
				t_Width = dec($('#txtWidth_' + b_seq).val());
				t_Dime = dec($('#txtDime_' + b_seq).val());
				t_Lengthb = dec($('#txtLengthb_' + b_seq).val());
				t_Mount = dec($('#txtMount_' + b_seq).val());
				t_Style = $('#txtStyle_' + b_seq).val();
				t_spec = $('#txtSpec_' + b_seq).val();
				t_Divide = dec($('#txtDivide_' + b_seq).val());
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
					stype:t_spec
				};
				if (dec(t_Divide) == 0)
					t_Divide = 1;
				if (trim($('#cmbKind').val()).substring(1, 1) == '4') {//鋼胚
					q_tr('txtTheory_' + b_seq, round(t_Mount * theory_bi(t_spec, $('#txtSpec_' + b_seq).val(), t_Dime, t_Width, t_Lengthb), 0));
				} else {
					//q_tr('txtTheory_' + b_seq, theory_st(StyleList, t_Radius, t_Width, t_Dime, t_Lengthb, t_Mount, t_Style) / t_Divide);
					q_tr('txtTheory_' + b_seq, theory_st(theory_setting) / t_Divide);
				}
				if (dec($('#txtRadius_' + b_seq).val()) != 0) {
					$('#txtWeight_' + b_seq).val($('#txtTheory_' + b_seq).val());
				}
				var t_Product = $('#txtProduct_' + b_seq).val();
				if(t_Product.indexOf('管') > -1){
					$('#txtWeight_' + b_seq).val($('#txtTheory_' + b_seq).val());
				}
			}

			function distinct(arr1){
				var uniArray = [];
				for(var i=0;i<arr1.length;i++){
					var val = arr1[i];
					if($.inArray(val, uniArray)===-1){
						uniArray.push(val);
					}
				}
				return uniArray;
			}

			function getBBSWhere(objname) {
				var tempArray = new Array();
				for (var j = 0; j < q_bbsCount; j++) {
					tempArray.push($('#txt' + objname + '_' + j).val());
				}
				var TmpStr = distinct(tempArray).sort();
				TmpStr = TmpStr.toString().replace(/,/g, "','").replace(/^/, "'").replace(/$/, "'");
				return TmpStr;
			}

			var ordes = [];
			//ordes資料內容
			var uccb = [];
			//uccb資料內容
			var uccb_gweight = 0;
			var cuts = [];
			//cut資料內容
			function cut_save_db() {
				//取得品名的密度-計算理論重
				var t_where = "where=^^ noa = '" + $('#txtProductno').val() + "' ^^";
				q_gt('ucc', t_where, 0, 0, 0, "", r_accy);
				//取得餘料編號
				t_where = "where=^^ noa like '%" + $('#txtUno').val() + "%' ^^";
				q_gt('uccb', t_where, 0, 0, 0, "", r_accy);
				if (q_cur == 1) {
					//取得是否重複分條
					t_where = "where=^^ uno = '" + $('#txtUno').val() + "' ^^";
					q_gt('cut', t_where, 0, 0, 0, "", r_accy);
				} else {
					cuts = [];
				}
			}
			function size_change() {
				if (q_cur == 1 || q_cur == 2) {
					$('input[id*="textSize"]').removeAttr('disabled');
				} else {
					$('input[id*="textSize"]').attr('disabled', 'disabled');
				}
				$('#cmbKind').val((($('#cmbKind').val())?$('#cmbKind').val():q_getPara('vcc.kind')));
                var t_kind = (($('#cmbKind').val())?$('#cmbKind').val():'');
                t_kind = t_kind.substr(0, 1);				
				if (t_kind == 'A') {
					$('#txtPaytype').val($('#combPaytype').find(":selected").text());
					
					$('#combType2').show().val($('#txtType2').val());
					$('#combType2A').hide();

					$('#lblSize_help').text(q_getPara('sys.lblSizea'));
					$('#Size').css('width', '225px');
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).show();
						$('#textSize2_' + j).show();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).hide();
						$('#x1_' + j).show();
						$('#x2_' + j).show();
						$('#x3_' + j).hide();
						$('#textSize1_' + j).val($('#txtDime_' + j).val());
						$('#textSize2_' + j).val($('#txtWidth_' + j).val());
						$('#textSize3_' + j).val($('#txtLengthb_' + j).val());
						$('#textSize4_' + j).val(0);
						$('#txtRadius_' + j).val(0);
					}
				} else if (t_kind == 'B') {
					$('#lblSize_help').text(q_getPara('sys.lblSizeb'));
					$('#Size').css('width', '325px');
					
					$('#combType2A').show().val($('#txtType2').val());
					$('#combType2').hide();
					
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).show();
						$('#textSize2_' + j).show();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).show();
						$('#x1_' + j).show();
						$('#x2_' + j).show();
						$('#x3_' + j).show();
						$('#textSize1_' + j).val($('#txtRadius_' + j).val());
						$('#textSize2_' + j).val($('#txtWidth_' + j).val());
						$('#textSize3_' + j).val($('#txtDime_' + j).val());
						$('#textSize4_' + j).val($('#txtLengthb_' + j).val());
					}
				} else {//鋼筋和鋼胚
					$('#lblSize_help').text(q_getPara('sys.lblSizec'));
					$('#Size').css('width', '55px');
					
					$('#combType2').show().val($('#txtType2').val());
					$('#combType2A').hide();
					
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).hide();
						$('#textSize2_' + j).hide();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).hide();
						$('#x1_' + j).hide();
						$('#x2_' + j).hide();
						$('#x3_' + j).hide();
						//$('#txtSpec_' + j).css('width', '180px');
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
			Number.prototype.round = function (arg) {
			    return Math.round(this.mul(Math.pow(10, arg))).div(Math.pow(10, arg));
			};
			Number.prototype.div = function (arg) {
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
			Number.prototype.mul = function (arg) {
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
			Number.prototype.add = function (arg) {
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
			Number.prototype.sub = function (arg) {
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
			.dview {
				float: left;
				width: 320px;
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
				width: 1000px;
				border-radius: 5px;
			}
			.tbbm {
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: larger;
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
				width: 95%;
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
				width: 1950px;
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
		<div style="overflow: auto;display:block;width:1400px;">
			<div class="dview" id="dview"  >
				<table class="tview" id="tview"	>
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewUno'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewProduct'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='uno'>~uno</td>
						<td align="center" id='productno product,5'>~productno ~product,5</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl" > </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblKind" class="lbl"> </a></td>
						<td><select id="cmbKind" class="txt c1"> </select></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtNoa" type="text" class="txt c1"/>
							<select id="cmbTypea" style="display:none;"> </select>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMech" class="lbl btn" > </a></td>
						<td>
							<input id="txtMechno" type="text" style="float:left;width:50%;" />
							<input id="txtMech"  type="text" style="float:left;width:50%;"/>
						</td>
						<td><span> </span><a id="lblType2" class="lbl" > </a></td>
						<td><select id="combType2" class="txt c1"> </select>
							<select id="combType2A" class="txt c1"> </select>
							<input id="txtType2" type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblCust" class="lbl btn" > </a></td>
						<td colspan="3">
							<input id="txtCustno" type="text" style="float:left;width:30%;"/>
							<input id="txtCust" type="text" style="float:left;width:70%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblUno" class="lbl btn"> </a></td>
						<td><input id="txtUno" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblProduct" class="lbl"> </a></td>
						<td>
							<input id="txtProductno" type="text" style="float:left;width:40%;"/>
							<input id="txtProduct" type="text" style="float:left;width:60%;"/>
						</td>
						<td><span> </span><a id="lblSpec" class="lbl"> </a></td>
						<td><input id="txtSpec" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblCuano" class="lbl"> </a></td>
						<td><input id="txtCuano" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDime" class="lbl"> </a></td>
						<td><input id="txtDime" type="text" class="txt num c1" /></td>
						<td><span> </span><a id="lblWidth" class="lbl" > </a></td>
						<td><input id="txtWidth" type="text" class="txt num c1" /></td>
						<td><span> </span><a id="lblLengthb" class="lbl"> </a></td>
						<td><input id="txtLengthb" type="text" class="txt num c1"  /></td>
						<td><span> </span><a id="lblRadius" class="lbl"> </a></td>
						<td><input id="txtRadius" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOweight" class="lbl" > </a></td>
						<td><input id="txtOweight" type="text" class="txt num c1" /></td>
						<td><span> </span><a id="lblEweight" class="lbl"> </a></td>
						<td><input id="txtEweight" type="text" class="txt num c1" /></td>
						<td> </td>
						<td><input id="btnOrdesImport" type="button"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblGweight" class="lbl" > </a></td>
						<td><input id="txtGweight" type="text" class="txt num c1" /></td>
						<td><span> </span><a id="lblGtime" class="lbl"> </a></td>
						<td><input id="txtGtime" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblGmount" class="lbl"> </a></td>
						<td><input id="txtGmount" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td><input id="txtTggno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtTgg" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblLoss" class="lbl"> </a></td>
						<td><input id="txtLoss" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblTheyout" class="lbl" > </a></td>
						<td><input id="txtTheyout" type="text" class="txt num c1" /></td>
						<td><span> </span><a id="lblTotalout" class="lbl" > </a></td>
						<td><input id="txtTotalout" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan='7'><input id="txtMemo" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCarno"  class="lbl"> </a></td>
						<td><input id="txtCarno" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblCardeal" class="lbl btn"> </a></td>
						<td>
							<input id="txtCardealno" type="text" style="float:left;width:30%;"/>
							<input id="txtCardeal" type="text" style="float:left;width:70%;"/>
						</td>
						<td><span> </span><a id="lblPrice" class="lbl" > </a></td>
						<td><input id="txtPrice" type="text" class="txt num c1" /></td>
						<td><span> </span><a id="lblTranmoney" class="lbl" > </a></td>
						<td><input id="txtTranmoney" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl" > </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl" > </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
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
					<td style="width:110px;" align="center"><a id='lblCustno'> </a></td>
					<td style="width:80px;" align="center"><a id='lblComps'> </a></td>
					<td style="width:30px;" align="center"><a id='lblStyle'> </a></td>
					<td align="center" style="width:340px;" id='Size'><a id='lblSize_help'> </a></td>
					<td style="width:50px;" align="center"><a id='lblMounts'> </a></td>
					<td style="width:20px;" align="center"><a id='lblDivide'> </a></td>
					<td style="width:80px;" align="center"><a id='lblTheory'> </a></td>
					<td style="width:80px;" align="center"><a id='lblHweight'> </a></td>
					<td style="width:80px;" align="center"><a id='lblWeight'> </a></td>
					<td style="width:50px;" align="center"><a id='lblWaste'> </a></td>
					<td style="width:150px;" align="center"><a id='lblBno'> </a></td>
					<td style="width:50px;" align="center">入庫<br>倉庫</td>
					<td style="width:150px;" align="center"><a id='lblMemos'> </a></td>
					<td style="width:50px;" align="center" ><a id='lbltime'> </a></td>
					<td style="width:50px;" align="center" ><a id='lblProductno'> </a></td>
					<td style="width:50px;" align="center" ><a id='lblProduct_s'> </a></td>
					<td style="width:50px;" align="center" ><a id='lblSpecs'> </a></td>
					<td style="width:50px;" align="center">加工<br>單價</td>
					<td style="width:100px;" align="center"><a id='lblSize'> </a></td>
					<td style="width:80px;" align="center"><a id='lblMweight'> </a></td>
					<td style="width:120px;" align="center"><a id='lblOrdenos'> </a></td>
					<td style="width:30px;" align="center" ><a id='lblNo2'> </a></td>
					<td style="width:50px;" align="center" ><a id='lblSpecial'> </a></td>
					<td style="width:50px;" align="center" ><a id='lblCname'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:1%;">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="btnCust.*" type="button" value="." style="width: 20px; float:left;"/>
						<input id="txtCustno.*" type="text" style="width: 70px; float:left;"/>
					</td>
					<td><input id="txtCust.*" type="text" class="txt c2"/></td>
					<td><input style="width:95%;text-align: center;" id="txtStyle.*" type="text" /></td>
					<td>
						<input class="txt num" id="textSize1.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
						<div id="x1.*" style="float: left;display:block;width:20px;padding-top: 4px;" >x</div>
						<input class="txt num" id="textSize2.*" type="text" style="float: left;width:55px;"  disabled="disabled"/>
						<div id="x2.*" style="float: left;display:block;width:20px;padding-top: 4px;">x</div>
						<input class="txt num" id="textSize3.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
						<div id="x3.*" style="float: left;display:block;width:20px;padding-top: 4px;">x</div>
						<input class="txt num" id="textSize4.*" type="text"  style="float: left;width:55px;" disabled="disabled"/>
						<!--上為虛擬下為實際-->
						<input id="txtRadius.*" type="text" style="display:none;"/>
						<input id="txtWidth.*" type="text" style="display:none;"/>
						<input id="txtDime.*" type="text" style="display:none;"/>
						<input id="txtLengthb.*" type="text" style="display:none;"/>
					</td>
					<td><input id="txtMount.*" type="text" class="txt c2 num"/></td>
					<td><input id="txtDivide.*" type="text" class="txt c2 num"/></td>
					<td><input id="txtTheory.*" type="text" class="txt c2 num"/></td>
					<td><input id="txtHweight.*" type="text" class="txt c2 num"/></td>
					<td><input id="txtWeight.*" type="text"  class="txt c2 num"/></td>
					<td><input id="txtWaste.*" type="text" class="txt c2"/></td>
					<td><input id="txtBno.*" type="text" class="txt c2"/></td>
					<td><input id="txtStoreno.*" type="text" class="txt c2"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c2"/></td>
					<td><input id="txtTime.*" type="text" class="txt c2"/></td>
					<td><input id="txtProductno.*" type="text" class="txt c2"/></td>
					<td><input id="txtProduct.*" type="text" class="txt c2"/></td>
					<td><input id="txtSpec.*" type="text" class="txt c2"/></td>
					<td><input id="txtWprice.*" type="text" class="txt c2 num"/></td>
					<td><input id="txtSize.*" type="text" class="txt c2"/></td>
					<td><input id="txtMweight.*" type="text" class="txt c2 num"/></td>
					<td><input id="txtOrdeno.*" type="text" class="txt c2"/></td>
					<td><input id="txtNo2.*" type="text" class="txt c2"/></td>
					<td><input id="txtSpecial.*" type="text" class="txt c2"/></td>
					<td><input id="txtCname.*" type="text" class="txt c2"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>