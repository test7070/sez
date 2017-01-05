﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
			q_desc = 1
			q_tables = 's';
			var q_name = "umm";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtCno', 'txtAcomp', 'txtSale', 'txtTotal', 'txtPaysale', 'txtUnpay', 'txtOpay', 'textOpay', 'txtAccno', 'txtWorker2'];
			var q_readonlys = ['txtVccno', 'txtUnpay', 'txtUnpayorg', 'txtAcc2', 'txtPart2', 'txtMemo2'];
			var bbmNum = new Array(
				['txtSale', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtPaysale', 10, 0, 1],['txtUnpay', 10, 0, 1],
				['txtOpay', 10, 0, 1], ['txtUnopay', 10, 0, 1], ['textOpay', 10, 0, 1]
			);
			var bbsNum = [
				['txtMoney', 10, 0, 1], ['txtChgs', 10, 0, 1], ['txtPaysale', 10, 0, 1], ['txtUpay', 10, 0, 1],
				['txtUnpayorg', 10, 0, 1]
			];
			var bbmMask = [];
			var bbsMask = [];

			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwCount2 = 5;
			brwKey = 'Datea';
			aPop = new Array(
				['txtCustno', 'lblCust', 'cust_sssall', 'noa,comp', 'txtCustno,txtComp', 'cust_sssall_b.aspx'],
				['txtAcc1_', 'btnAcc_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_,txtMoney_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
				['txtBankno_', 'btnBankno_', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx'],
				['txtUmmaccno_', '', 'ummacc', 'noa,typea', 'txtUmmaccno_,txtTypea_', 'ummacc_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
			});
			function main() {
				mainForm(1);
			}

			function mainPost() {
				q_getFormat();

				if (r_rank < 7)
					q_readonly[q_readonly.length] = 'txtAccno';

				bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
				q_mask(bbmMask);
				bbsMask = [['txtIndate', r_picd], ['txtMon', r_picm],['txtUdate', r_picd]];
				q_gt('part', '', 0, 0, 0, "");
				q_gt('acomp', '', 0, 0, 0, "");

				$('#lblAccc').click(function() {
					q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substr(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('btnAccc'), true);
				});

				$('#lblCust2').click(function(e) {
					q_box("cust_b2.aspx", 'cust', "95%", "95%", q_getMsg("popCust"));
				});

				$('#txtOpay').change(function() {
					sum();
				});
				$('#txtUnopay').change(function() {
					sum();
				});

				$('#btnBank').click(function() {
					q_box('bank.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", "銀行主檔");
				});

				$('#btnAuto').click(function(e) {
					/// 自動沖帳
					//$('#txtOpay').val(0);
					//$('#txtUnopay').val(0);
					for (var i = 0; i < q_bbsCount; i++) {
						$('#txtPaysale_' + i).val(0);
						//歸零
						$('#txtUnpay_' + i).val($('#txtUnpayorg_' + i).val());
						//歸零
					}

					var t_money = 0 + q_float('txtUnopay');
					for (var i = 0; i < q_bbsCount; i++) {
						//$('#txtAcc1_' + i).val().indexOf('2121') == 0 ||
						/*if ( $('#txtAcc1_' + i).val().indexOf('7149') == 0 || $('#txtAcc1_' + i).val().indexOf('7044') == 0)
						 t_money -= q_float('txtMoney_' + i);
						 else*/
						t_money += q_float('txtMoney_' + i);

						t_money += q_float('txtChgs_' + i);
					}

					var t_unpay, t_pay = 0;
					for (var i = 0; i < q_bbsCount; i++) {
						if (q_float('txtUnpay_' + i) != 0) {
							t_unpay = q_float('txtUnpayorg_' + i);
							if (t_money >= t_unpay) {
								q_tr('txtPaysale_' + i, t_unpay);
								$('#txtUnpay_' + i).val(0);
								t_money = t_money - t_unpay;
							} else {
								q_tr('txtPaysale_' + i, t_money);
								q_tr('txtUnpay_' + i, t_unpay - t_money);
								t_money = 0;
							}
						}
					}
					if (t_money > 0)
						q_tr('txtOpay', t_money);
					sum();
				});
				//0926改為開啟視窗
				$('#btnVcc').click(function(e) {
					//umm_trd();
					//201307/16因客戶2會輸入很多，所以將判斷條件移到開起qbox才查詢
					var t_where = '', t_where1 = '', t_where2 = '', t_where3 = '', t_where4 = '', t_where5 = '', t_where6 = '', t_where7 = '';
					/*if (!emp($('#txtCustno').val())) {
					 // var t_custno = "'" + $.trim($('#txtCustno').val()) + "'";
					 t_where = "(a.custno='" + $.trim($('#txtCustno').val()) + "'";
					 t_where6= " where[6]=^^ (a.custno='" + $.trim($('#txtCustno').val()) + "'";
					 t_where3 = " where[3]=^^ (c.noa='" + $('#txtCustno').val() + "' ";
					 t_where5 = " where[5]=^^(((a.custno='" + $('#txtCustno').val() + "' ";

					 if(!emp($('#txtDatea').val()))
					 t_where4 = " where[4]=^^ mon='"+$('#txtDatea').val().substr(0,6)+"' ^^";
					 else
					 t_where4 = " where[4]=^^ carno+mon in (select carno+MAX(mon) from cara group by carno) ^^";

					 if (!emp($('#txtCustno2').val())) {
					 var t_custno2 = ($('#txtCustno2').val()).split(",");
					 for (var i = 0; i < t_custno2.length; i++) {
					 t_where += " or a.custno ='" + t_custno2[i] + "'"
					 t_where6+=" or a.custno ='" + t_custno2[i] + "'"
					 t_where3 += " or c.noa ='" + t_custno2[i] + "'"
					 t_where5 += " or a.custno ='" + t_custno2[i] + "'"
					 }
					 }
					 t_where+=") and (a.unpay+isnull(b.paysale,0))!=0 ";
					 t_where6+=") and (a.unpay+isnull(b.paysale,0))!=0 and (CHARINDEX('會計',kind)=0 or a.datea<'102/04/01')";//1020410會計部從102/04/01開始用明細匯入
					 t_where1 = " where[1]=^^ a.noa='" + $('#txtNoa').val() + "' and a.paysale!=0 ";

					 if(!emp($('#txtDatea').val()))
					 t_where2 = " where[2]=^^ left(a.datea,6)='" + $('#txtDatea').val().substr(0, 6) + "' ^^";
					 else
					 t_where2 = " where[2]=^^ 1=1 ^^";

					 t_where3 +=") ^^"

					 //1020410會計部從102/04/01開始用明細匯入
					 //1020509要不包含單據的立帳單
					 t_where5 += " ) and (CHARINDEX('會計',kind)>0) and a.unpay!=0) or ((a.noa+isnull(b.product,'')+b.noq in (select vccno+memo2 from umms where noa='"+$('#txtNoa').val()+"')))) and a.datea>='102/04/01' order by noa^^";
					 t_where7 = " where[7]=^^ noa!='"+$('#txtNoa').val()+"' ^^";

					 // 最後一個t_whereX 加 order by noa^^";

					 t_where += "^^";
					 t_where6 += "^^";
					 t_where1 += "^^";
					 } else {
					 t_where = "1=0^^";
					 t_where6 = " where[6]=^^ 1=0 ^^";
					 t_where1 = " where[1]=^^ 1=0 ^^";
					 t_where2 = " where[2]=^^ 1=1 ^^";
					 t_where3 = " where[3]=^^ 1=0 ^^";
					 t_where5 = " where[5]=^^ 1=0 order by noa ^^";
					 t_where4 = " where[4]=^^ carno+mon in (select carno+MAX(mon) from cara group by carno) ^^";
					 t_where7 = " where[7]=^^ 1=1 ^^";
					 }*/
					q_box("umm_trd_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + t_where1 + t_where2 + t_where3 + t_where4 + t_where5 + t_where6 + t_where7, 'umm_trd', "95%", "95%", q_getMsg('popUmm_trd'));
				});
			}

			function umm_trd() {
				var t_custno = "'" + $.trim($('#txtCustno').val()) + "'";
				t_where = "where=^^ custno=" + t_custno + " and unpay!=0 ";
				t_where1 = " where[1]=^^ noa!='" + $('#txtNoa').val() + "'";

				var j = 0, s2 = '', s1 = '';
				for (var i = 0; i < q_bbsCount; i++) {
					if ($.trim($('#txtVccno_' + i).val()).length > 0) {
						s2 = s2 + (j == 0 ? "" : " or ") + " noa='" + $('#txtVccno_' + i).val() + "'";
						s1 = s1 + (j == 0 ? "" : " or ") + " vccno='" + $('#txtVccno_' + i).val() + "'";
						j++;
					}
				}

				t_where = t_where + (s2.length > 0 ? " or (" + s2 + ")" : '') + "^^";
				t_where1 = t_where1 + (s1.length > 0 ? " or (" + s2 + ")" : '') + "^^";
				q_gt('umm_trd', t_where + t_where1, 0, 0, 0, "", r_accy);
			}

			function getOpay() {
				Lock(1, {
					opacity : 0
				});
				var t_custno = $('#txtCustno').val();
				var s2 = (q_cur == 2 ? " and noa!='" + $('#txtNoa').val() + "'" : '');

				if (q_cur == 4 || q_cur == 0)
					var t_where = "where=^^custno='" + t_custno + "'" + s2 + " and datea<='" + $('#txtDatea').val() + "' ^^";
				else
					var t_where = "where=^^custno='" + t_custno + "'" + s2 + "^^";

				q_gt("umm_opay", t_where, 1, 1, 0, '', r_accy);
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtAcc1_':
						sum();
						break;
					case 'txtCustno':
						getOpay();
						if ($('#txtCustno').val().substr(0, 1) >= '0' && $('#txtCustno').val().substr(0, 1) <= 'z')
							$('#btnVcc').click();
						break;
				}
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'umm_trd':
						if (q_cur > 0 && q_cur < 4) {// q_cur： 0 = 瀏覽狀態 1=新增 2=修改 3=刪除 4=查詢
							b_ret = getb_ret(); // q_box() 執行後，選取的資料
							if (!b_ret || b_ret.length == 0)
								return;

							for (var i = 0; i < b_ret.length; i++) {
								if (dec(b_ret[i].total) - dec(b_ret[i].paysale) == 0 && $('#txtCustno').val().substr(0, 1) != 'H') {
									b_ret.splice(i, 1);
									i--;
								} else {
									b_ret[i]._unpay = (dec(b_ret[i].total) - dec(b_ret[i].paysale)).toString();
									b_ret[i].paysale = 0;
								}
							}
							//清除單據bbs
							for (var i = 0; i < q_bbsCount; i++) {
								$('#txtVccno_' + i).val('');
								$('#txtPaysale_' + i).val('');
								$('#txtUnpayorg_' + i).val('');
								$('#txtUnpay_' + i).val('');
								$('#txtPart2_' + i).val('');
							}
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtAccy,txtTablea,txtVccno,txtPaysale,txtUnpay,txtUnpayorg,txtPart2,txtPartno,txtPart,txtMemo2,cmbPartno', b_ret.length, b_ret, 'accy,tablea,noa,paysale,_unpay,_unpay,part,partno,part,memo,partno', '');
							/// 最後 aEmpField 不可以有【數字欄位】
							sum();
							$('#txtAcc1_0').focus();
						}
						break;
					case 'cust':
						ret = getb_ret();
						if (q_cur > 0 && q_cur < 4) {
							if (ret[0] != undefined) {
								for (var i = 0; i < ret.length; i++) {
									if ($('#txtCustno2').val().length > 0) {
										var temp = $('#txtCustno2').val();
										$('#txtCustno2').val(temp + ',' + ret[i].noa);
									} else {
										$('#txtCustno2').val(ret[i].noa);
									}
								}
							}
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function sum() {
				var t_money = 0, t_pay = 0, t_sale = 0;
				for (var j = 0; j < q_bbsCount; j++) {
					//$('#txtAcc1_' + j).val().indexOf('2121') == 0 ||
					/*if ( $('#txtAcc1_' + j).val().indexOf('7149') == 0 || $('#txtAcc1_' + j).val().indexOf('7044') == 0)
					 t_money -= q_float('txtMoney_' + j);
					 else*/
					t_money += q_float('txtMoney_' + j);
					t_money += q_float('txtChgs_' + j);
					t_sale += q_float('txtUnpayorg_' + j);
					t_pay += q_float('txtPaysale_' + j);
				}

				//bbm收款金額(total)=bbs收款金額總額(money)
				//bbm應收金額(sale)=bbs應收金額總額(Unpayorg)
				//bbm本次沖帳(paysale)=bbs沖帳金額(paysale)+bbm預收沖帳(unopay)
				//bbm未收金額(unpay)=bbm應收金額(sale)-bbm本次沖帳(paysale)
				//bbm預收(opay)=bbm應收金額(total)-bbm本次沖帳(paysale)
				//bbm預收餘額=應收餘額+預收-預收沖帳

				q_tr('txtSale', t_sale);
				q_tr('txtTotal', t_money);
				q_tr('txtPaysale', t_pay);
				q_tr('txtUnpay', q_float('txtSale') - q_float('txtPaysale'));
				if (q_float('txtTotal') - q_float('txtPaysale') > 0) {
					q_tr('txtOpay', q_float('txtTotal') - q_float('txtPaysale'));
				} else {
					q_tr('txtOpay', 0);
				}
				q_tr('textOpay', q_float('textOpayOrg') + q_float('txtOpay') - q_float('txtUnopay'));
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'get_acc2':
						var as = _q_appendData("acc", "", true);
							if (as[0] != undefined) {
								$('#txtAcc2_'+b_seq).val(as[0].acc2);
							}
						break;
					case 'part':
						var as = _q_appendData("part", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
							}
							q_cmbParse("cmbPartno", t_item, 's');
							refresh(q_recno);
							/// 第一次需要重新載入
						}
						break;
					case 'acomp':
						var as = _q_appendData("acomp", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
							}
							q_cmbParse("cmbCno", t_item);
						}
						break;
					case 'umm_opay':
						var as = _q_appendData('umm', '', true);
						var s1 = q_trv((as.length > 0 ? round(as[0].total, 0) : 0));
						$('#textOpay').val(s1);
						$('#textOpayOrg').val(s1);
						Unlock(1);
						break;
					case 'umm_trd':
						for (var i = 0; i < q_bbsCount; i++) {
							if ($('#txtVccno_' + i).val().length > 0) {
								$('#txtVccno_' + i).val('');
								$('#txtPaysale_' + i).val('');
								$('#txtUnpay_' + i).val('');
								$('#txtPart2_' + i).val('');
								$('#txtUnpayorg_' + i).val('');
							}
						}
						var as = _q_appendData("view_trd", "", true);
						for (var i = 0; i < as.length; i++) {
							if (as[i].total - as[i].paysale == 0) {
								as.splice(i, 1);
								i--;
							} else {
								as[i]._unpay = (as[i].total - as[i].paysale).toString();
								as[i].paysale = 0;
							}
						}
						q_gridAddRow(bbsHtm, 'tbbs', 'txtVccno,txtPaysale,txtUnpay,txtUnpayorg,txtPart2', as.length, as, 'noa,paysale,_unpay,_unpay,part2', 'txtVccno', '');
						sum();
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					default:
						if (t_name.substring(0, 13) == 'gqb_btnOkbbs1') {
							//存檔時 bbs 支票號碼 先檢查view_gqb_chk,再檢查GQB
							var t_sel = parseFloat(t_name.split('_')[2]);
							var t_checkno = t_name.split('_')[3];
							var t_noa = t_name.split('_')[4];
							var as = _q_appendData("view_gqb_chk", "", true);
							if (as[0] != undefined) {
								var t_isExist = false, t_msg = '';
								for (var i in as) {
									if (as[i]['tablea'] != undefined) {
										t_isExist = true;
										if (as[i]['noa'] != t_noa) {
											t_msg += (t_msg.length == 0 ? '票據已存在:' : '') + String.fromCharCode(13) + '【' + as[i]['title'] + as[i]['noa'] + '】' + as[i]['checkno'];
										}
									}
								}
								if (t_isExist && t_msg.length == 0) {
									checkGqb_bbs(t_sel - 1);
								} else if (t_isExist && t_msg.length > 0) {
									alert('請由以下單據修改。' + String.fromCharCode(13) + t_msg);
									Unlock(1);
								} else if (t_msg.length > 0) {
									alert(t_msg);
									Unlock(1);
								} else {
									//檢查GQB
									var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
									q_gt('gqb', t_where, 0, 0, 0, "gqb_btnOkbbs2_" + t_sel, r_accy);
								}
							} else {
								//檢查GQB
								var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
								q_gt('gqb', t_where, 0, 0, 0, "gqb_btnOkbbs2_" + t_sel, r_accy);
							}
						} else if (t_name.substring(0, 13) == 'gqb_btnOkbbs2') {
							//存檔時 bbs 支票號碼檢查
							//檢查GQB
							var t_sel = parseFloat(t_name.split('_')[2]);
							var as = _q_appendData("gqb", "", true);
							if (as[0] != undefined) {
								alert('支票【' + as[0]['gqbno'] + '】已存在');
								Unlock(1);
							} else {
								checkGqb_bbs(t_sel - 1);
							}
						} else if (t_name.substring(0, 11) == 'gqb_change1') {
							//先檢查view_gqb_chk,再檢查GQB
							var t_sel = parseFloat(t_name.split('_')[2]);
							var t_checkno = t_name.split('_')[3];
							var t_noa = t_name.split('_')[4];
							var as = _q_appendData("view_gqb_chk", "", true);
							if (as[0] != undefined) {
								var t_isExist = false, t_msg = '';
								for (var i in as) {
									if (as[i]['tablea'] != undefined) {
										t_isExist = true;
										if (as[i]['noa'] != t_noa) {
											t_msg += (t_msg.length == 0 ? '票據已存在:' : '') + String.fromCharCode(13) + '【' + as[i]['title'] + as[i]['noa'] + '】' + as[i]['checkno'];
										}
									}
								}
								if (t_isExist && t_msg.length == 0) {
									Unlock(1);
								} else if (t_isExist && t_msg.length > 0) {
									alert('請由以下單據修改。' + String.fromCharCode(13) + t_msg);
									Unlock(1);
								} else if (t_msg.length > 0) {
									alert(t_msg);
									Unlock(1);
								} else {
									//檢查GQB
									var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
									q_gt('gqb', t_where, 0, 0, 0, "gqb_change2_" + t_sel, r_accy);
								}
							} else {
								//檢查GQB
								var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
								q_gt('gqb', t_where, 0, 0, 0, "gqb_change2_" + t_sel, r_accy);
							}
						} else if (t_name.substring(0, 11) == 'gqb_change2') {
							//檢查GQB
							var t_sel = parseFloat(t_name.split('_')[2]);
							var as = _q_appendData("gqb", "", true);
							if (as[0] != undefined) {
								alert('支票【' + as[0]['gqbno'] + '】已存在');
							}
							Unlock(1);
						} else if (t_name.substring(0, 11) == 'gqb_status1') {
							//檢查GQB
							var t_sel = parseFloat(t_name.split('_')[2]);
							var t_checkno = t_name.split('_')[3];
							var as = _q_appendData("chk2s", "", true);
							if (as[0] != undefined) {
								alert('支票【' + t_checkno + '】已託收，託收單號【' + as[0].noa + '】');
								//Unlock(1);
							}
							//else{
							var t_where = " where=^^ checkno='" + t_checkno + "'^^";
							q_gt('ufs', t_where, 0, 0, 0, "gqb_status2_" + t_sel + "_" + t_checkno, r_accy);
							//}
						} else if (t_name.substring(0, 11) == 'gqb_status2') {
							//檢查GQB
							var t_sel = parseFloat(t_name.split('_')[2]);
							var t_checkno = t_name.split('_')[3];
							var as = _q_appendData("ufs", "", true);
							if (as[0] != undefined) {
								alert('支票【' + t_checkno + '】已兌現，兌現單號【' + as[0].noa + '】');
								//Unlock(1);
							}
							//else{
							checkGqbStatus_btnModi(t_sel - 1);
							//}
						} else if (t_name.substring(0, 11) == 'gqb_statusA') {
							//檢查GQB
							var t_sel = parseFloat(t_name.split('_')[2]);
							var t_checkno = t_name.split('_')[3];
							var as = _q_appendData("chk2s", "", true);
							if (as[0] != undefined) {
								alert('支票【' + t_checkno + '】已託收，託收單號【' + as[0].noa + '】');
								//Unlock(1);
							}
							//else{
							var t_where = " where=^^ checkno='" + t_checkno + "'^^";
							q_gt('ufs', t_where, 0, 0, 0, "gqb_statusB_" + t_sel + "_" + t_checkno, r_accy);
							//}
						} else if (t_name.substring(0, 11) == 'gqb_statusB') {
							//檢查GQB
							var t_sel = parseFloat(t_name.split('_')[2]);
							var t_checkno = t_name.split('_')[3];
							var as = _q_appendData("ufs", "", true);
							if (as[0] != undefined) {
								alert('支票【' + t_checkno + '】已兌現，兌現單號【' + as[0].noa + '】');
								//Unlock(1);
							}
							//else{
							checkGqbStatus_btnDele(t_sel - 1);
							//}
						}
						break;
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				abbm[q_recno]['accno'] = xmlString;
				//$('#txtAccno').val(xmlString);
				Unlock(1);
			}

			function btnOk() {
				Lock(1, {
					opacity : 0
				});
				$('#txtAcomp').val($('#cmbCno').find(":selected").text());
				$('#txtMon').val($.trim($('#txtMon').val()));
				if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())) {
					alert(q_getMsg('lblMon') + '錯誤。');
					Unlock(1);
					return;
				}
				for (var i = 0; i < q_bbsCount; i++) {
					if ($('#txtIndate_' + i).val().length > 0 && $('#txtIndate_' + i).val().indexOf('_') > -1) {
						alert(q_getMsg('lblIndate') + '錯誤。');
						Unlock(1);
						return;
					}
				}
				var t_err = '';
				if (q_getPara('sys.project').toUpperCase()!='DC'){
					t_err = q_chkEmpField([['cmbCno', q_getMsg('lblAcomp')]]);
					if (t_err.length > 0) {
						alert(t_err);
						Unlock(1);
						return;
					}
				}
				
				if ($.trim($('#txtCustno').val()) == 0) {
					alert(m_empty + q_getMsg('lblCust'));
					Unlock(1);
					return false;
				}
				var t_money = 0, t_chgs = 0, t_paysale, t_mon = '';
				for (var i = 0; i < q_bbsCount; i++) {
					$('#txtCheckno_' + i).val($.trim($('#txtCheckno_' + i).val()));

					t_money = q_float('txtMoney_' + i);
					t_chgs = q_float('txtChgs_' + i);
					if ($.trim($('#txtAcc1_' + i).val()).length == 0 && t_money + t_chgs > 0) {
						t_err = true;
						break;
					}
					if (t_money != 0 || i == 0)
						t_mon = $('#txtVccno_' + i).val();
				}

				//檢查票據是否重複
				var checkno_repeat = false;
				for (var i = 0; i < q_bbsCount; i++) {
					for (var j = i + 1; j < q_bbsCount; j++) {
						if ($('#txtCheckno_' + i).val() == $('#txtCheckno_' + j).val() 
							&& ($('#txtAcc1_' + j).val().substring(0, 4) != '1121' && $('#txtAcc2_'+j).val().indexOf('應收票據')<0)
							&& !emp($('#txtCheckno_' + i).val()) && !emp($('#txtCheckno_' + j).val())) {
							checkno_repeat = true;
							alert('票據號碼：' + $('#txtCheckno_' + j).val() + '重複輸入!!');
							break;
						}
					}
					if (checkno_repeat)
						break;
				}

				if (checkno_repeat) {
					Unlock(1);
					return false;
				}

				sum();
				if (t_err) {
					alert(m_empty + q_getMsg('lblAcc1') + q_trv(t_money + t_chgs));
					Unlock(1);
					return false;
				}

				var t_opay = q_float('txtOpay');
				var t_unopay = q_float('txtUnopay');
				var t1 = q_float('txtPaysale') + q_float('txtOpay') - q_float('txtUnopay');
				var t2 = q_float('txtTotal') + t_chgs;
				if (t1 != t2) {
					alert('收款金額 ＋ 費用 ＝' + q_trv(t2) + '\r 【不等於】 沖帳金額 ＋ 預收 －　預收沖帳 ＝' + q_trv(t1) + '\r【差額】=' + Math.abs(t1 - t2));
					Unlock(1);
					return false;
				}
				//先檢查BBS沒問題才存檔
				checkGqb_bbs(q_bbsCount - 1);
			}

			function checkGqb_bbs(n) {
				if (n < 0) {
					for (var i = 0; i < q_bbsCount; i++) {
						$('#txtPart_' + i).val($('#cmbPartno_' + i).find(":selected").text());
					}
					//為了查詢
					var t_part = '', t_checkno = '';
					for (var i = 0; i < q_bbsCount; i++) {
						if (t_part.indexOf($.trim($('#txtPart_' + i).val())) == -1)
							t_part += (t_part.length > 0 ? ',' : '') + $.trim($('#txtPart_' + i).val());
						if ($.trim($('#txtCheckno_' + i).val()).length > 0 && t_checkno.indexOf($.trim($('#txtCheckno_' + i).val())) == -1)
							t_checkno += (t_checkno.length > 0 ? ',' : '') + $.trim($('#txtCheckno_' + i).val());
					}
					$('#txtPart').val(t_part);
					$('#txtCheckno').val(t_checkno);
					if (q_cur == 1) {
						$('#txtWorker').val(r_name);
					} else if (q_cur == 2) {
						$('#txtWorker2').val(r_name);
					} else {
						alert("error: btnok!");
					}
					var t_noa = trim($('#txtNoa').val());
					var t_date = trim($('#txtDatea').val());
					if (t_noa.length == 0 || t_noa == "AUTO")
						q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ummtran') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
					else
						wrServer(t_noa);
				} else {
					if ($.trim($('#txtCheckno_' + n).val()).length > 0 
						&& ($('#txtAcc1_' + n).val().substring(0, 4) == '1121' || $('#txtAcc2_'+n).val().indexOf('應收票據')>=0)
						&& q_float('txtMoney_' + n) < 0) {
						//收退 ,1121 , 金額負
						checkGqb_bbs(n - 1);
					} else if ($.trim($('#txtCheckno_' + n).val()).length > 0) {
						var t_noa = $('#txtNoa').val();
						var t_checkno = $('#txtCheckno_' + n).val();
						var t_where = "where=^^ checkno = '" + t_checkno + "' ^^";
						q_gt('view_gqb_chk', t_where, 0, 0, 0, "gqb_btnOkbbs1_" + n + "_" + t_checkno + "_" + t_noa, r_accy);
					} else {
						checkGqb_bbs(n - 1);
					}
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('umm_s.aspx', q_name + '_s', "600px", "600px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if ($('#btnMinus_' + i).hasClass('isAssign'))/// 重要
						continue;
					$('#txtAcc1_' + i).change(function() {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						
						var patt = /^(\d{4})([^\.,.]*)$/g;
						$(this).val($(this).val().replace(patt, "$1.$2"));
						sum();
						
						if(emp($('#txtAcc1_' + b_seq).val())){
							$('#txtAcc2_' + b_seq).val('');
						}/*else if(!emp($('#txtAcc1_'+b_seq).val()) && emp($('#txtAcc2_'+b_seq).val())){
							q_gt("acc", "where=^^acc1='" + $('#txtAcc1_'+b_seq).val() + "' ^^", 1, 1, 0, "get_acc2", r_accy + '_' + r_cno);
						}*/
						
					});
					$('#txtVccno_' + i).bind('contextmenu', function(e) {
						/*滑鼠右鍵*/
						e.preventDefault();
						var n = $(this).attr('id').replace('txtVccno_', '');
						var t_accy = $('#txtAccy_' + n).val();
						var t_tablea = trim($('#txtTablea_' + n).val());
						if (t_tablea.length > 0) {
							var t_form = (t_tablea == "vcc" ? 'vcctran' : t_tablea);
							t_form = (t_tablea == 'trd' && (q_getPara('sys.comp').substring(0, 2) == '日光' || q_getPara('sys.comp').substring(0, 2) == '東暉') ? 'trd_ds' : t_form);
							q_box(t_form + ".aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $(this).val() + "';" + t_accy, t_tablea, "95%", "95%", q_getMsg("pop" + t_tablea));
						}
					});
					$('#txtMoney_' + i).change(function(e) {
						sum();
					});
					$('#txtChgs_' + i).change(function(e) {
						sum();
					});
					$('#txtCheckno_' + i).change(function() {
						Lock(1, {
							opacity : 0
						});

						var n = $(this).attr('id').replace('txtCheckno_', '');
						var t_noa = $('#txtNoa').val();
						var t_checkno = $('#txtCheckno_' + n).val();
						var t_where = "where=^^ checkno = '" + t_checkno + "' ^^";
						if ($.trim($('#txtCheckno_' + n).val()).length > 0 
							&& ($('#txtAcc1_' + n).val().substring(0, 4) == '1121' || $('#txtAcc2_'+n).val().indexOf('應收票據')>=0)
							&& q_float('txtMoney_' + n) < 0) {
							//收退 ,1121 , 金額負
							Unlock(1);
						} else if ($.trim($('#txtCheckno_' + n).val()).length > 0) {
							q_gt('view_gqb_chk', t_where, 0, 0, 0, "gqb_change1_" + n + "_" + t_checkno + "_" + t_noa, r_accy);
						} else {
							Unlock(1);
						}
					}).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace('txtCheckno_', '');
                        var t_checkno = $.trim($(this).val());
                        if (t_checkno.length > 0) {
                            q_box("gqb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";gqbno='" + t_checkno + "';" + r_accy, 'gqb', "95%", "95%", q_getMsg("popGqb"));
                        }
                    });
					$('#txtPaysale_' + i).change(function(e) {
						t_IdSeq = -1;
						/// 要先給 才能使用 q_bodyId()
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;

						/* if(q_float('txtPaysale_'+b_seq)>q_float('txtUnpayorg_'+b_seq))
						 {
						 alert('請輸入正確沖帳金額!!');
						 $('#txtPaysale_'+b_seq).val(0);
						 $('#txtPaysale_'+b_seq).focus();
						 }*/
						var t_unpay = dec($('#txtUnpayorg_' + b_seq).val()) - dec($('#txtPaysale_' + b_seq).val());
						q_tr('txtUnpay_' + b_seq, t_unpay);
						sum();
					});
				}
				_bbsAssign();
				
				refreshFbbs();
			}

			function btnIns() {
				_btnIns();
				$('#txtDatea').focus();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				if (q_getPara('sys.project').toUpperCase()!='DC'){
					$("#cmbCno").get(0).selectedIndex=1;
				}
				refreshFbbs();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				if (q_chkClose())
					return;
				Lock(1, {
					opacity : 0
				});
				checkGqbStatus_btnModi(q_bbsCount - 1);
			}

			function checkGqbStatus_btnModi(n) {
				if (n < 0) {
					_btnModi();
					$('#textOpayOrg').val(q_float('textOpay') + q_float('txtUnopay') - q_float('txtOpay'));
					Unlock(1);
				} else {
					var t_checkno = $.trim($('#txtCheckno_' + n).val());
					if (t_checkno.length > 0) {
						var t_where = " where=^^ checkno='" + t_checkno + "'^^";
						q_gt('chk2s', t_where, 0, 0, 0, "gqb_status1_" + n + "_" + t_checkno, r_accy);
					} else {
						checkGqbStatus_btnModi(n - 1);
					}
				}
			}

			function checkGqbStatus_btnDele(n) {
				if (n < 0) {
					_btnDele();
					Unlock(1);
				} else {
					var t_checkno = $.trim($('#txtCheckno_' + n).val());
					if (t_checkno.length > 0) {
						var t_where = " where=^^ checkno='" + t_checkno + "'^^";
						q_gt('chk2s', t_where, 0, 0, 0, "gqb_statusA_" + n + "_" + t_checkno, r_accy);
					} else {
						checkGqbStatus_btnDele(n - 1);
					}
				}
			}

			function btnPrint() {
				q_box("z_ummtranp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy + "_" + r_cno, 'umm', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['acc1'] && (!as['money'] || as['money'] == 0) && (!as['paysale'] || as['paysale'] == 0)) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				if (q_cur == 1 || q_cur == 2) {
					$("#btnVcc").removeAttr("disabled");
					$("#btnAuto").removeAttr("disabled");
				} else {
					$("#btnVcc").attr("disabled", "disabled");
					$("#btnAuto").attr("disabled", "disabled");
				}
				getOpay();
				refreshFbbs();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (q_cur == 1 || q_cur == 2) {
					$("#btnVcc").removeAttr("disabled");
					$("#btnAuto").removeAttr("disabled");
				} else {
					$("#btnVcc").attr("disabled", "disabled");
					$("#btnAuto").attr("disabled", "disabled");
				}
				refreshFbbs();
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
				if (q_chkClose())
					return;
				Lock(1, {
					opacity : 0
				});
				checkGqbStatus_btnDele(q_bbsCount - 1);
			}

			function btnCancel() {
				_btnCancel();
			}
			
			function refreshFbbs() {
				if (q_getPara('sys.project').toUpperCase()=='YP'){
					$('.udate').show();
				}
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
				/*width: 1465px;*/
			}
			.dview {
				float: left;
				width: 20%;
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
				width: 80%;
				/*width: 1010px;*/
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
			.txt.c2 {
				width: 50%;
				float: left;
			}
			.txt.c3 {
				width: 50%;
				float: left;
			}
			.txt.c4 {
				width: 20%;
				float: left;
			}
			.txt.c5 {
				width: 80%;
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
				width: 100%;
				/*width: 1265px;*/
			}
			.tbbs a {
				font-size: medium;
			}
			input[type="text"], input[type="button"], select {
				font-size: medium;
			}
			.num {
				text-align: right;
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
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:30%"><a id='vewDatea'></a></td>
						<td align="center" style="width:30%"><a id='vewComp'></a></td>
						<td align="center" style="width:30%"><a id='vewTotal'></a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='comp,4'>~comp,4</td>
						<td id='total,0,1' style="text-align: right;">~total,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
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
						<td><span> </span><a id='lblNoa' class="lbl"></a></td>
						<td>
							<input id="txtNoa" type="text" class="txt c1"/>
							<input id="txtPart" type="text" style="display:none;"/>
							<input id="txtCheckno" type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id='lblDatea' class="lbl"></a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"></a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblPayc' class="lbl"></a></td>
						<td><input id="txtPayc" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr2">
						<td><span> </span><a id='lblAcomp' class="lbl"> </a></td>
						<td>
							<select id="cmbCno" class="txt c1"></select>
							<input id="txtAcomp" type="text" style="display:none;"/>
						</td>
						<td class="td3"><span> </span><a id='lblCust' class="lbl btn"></a></td>
						<td class="td4" colspan="2">
							<input id="txtCustno" type="text" class="txt c4"/>
							<input id="txtComp" type="text" class="txt c5"/>
						</td>
						<td class="6"><input type="button" id="btnVcc" class="txt c1" /></td>
						<td class="td7"><span> </span><a id='lblCust2' class="lbl btn"></a></td>
						<td class="td8"><input id="txtCustno2" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id='lblSale' class="lbl"></a></td>
						<td class="td2"><input id="txtSale" type="text" class="txt num c1"/></td>
						<td class="td3"><span> </span><a id='lblTotal' class="lbl"></a></td>
						<td class="td4"><input id="txtTotal" type="text" class="txt num c1"/></td>
						<td class="td5"><span> </span><a id='lblPaysale' class="lbl"></a></td>
						<td class="td6"><input id="txtPaysale" type="text" class="txt num c1"/></td>
						<td class="td7"><span> </span><a id='lblUnpay' class="lbl"></a></td>
						<td class="td8"><input id="txtUnpay" type="text" class="txt num c1"/></td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblOpay' class="lbl"></a></td>
						<td class="td2"><input id="txtOpay" type="text" class="txt num c1"/></td>
						<td class="td3"><span> </span><a id='lblUnopay' class="lbl"></a></td>
						<td class="td4"><input id="txtUnopay" type="text" class="txt num c1"/></td>
						<td class="td5"><span> </span><a id='lblTextopay' class="lbl"></a></td>
						<td class="td6">
							<input id="textOpay" type="text" class="txt num c1"/>
							<input type='hidden' id="textOpayOrg" />
						</td>
						<td><span> </span><a id='lblAccc' class="lbl btn"></a></td>
						<td><input id="txtAccno" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr5">
						<td class="td1"><a id='lblMemo' class="lbl"></a></td>
						<td class="td2" colspan='3'>
							<textarea id="txtMemo" rows='3' cols='3' style="width: 99%; height: 50px;" ></textarea>
						</td>
						<td class="td5"><a id='lblWorker' class="lbl" style="text-align: right;display:block;width:95%;"> </a><a id='lblWorker2' class="lbl" style="text-align: right;display:block;width:95%;"> </a></td>
						<td class="td6" >
							<input id="txtWorker" type="text" class="txt c1"/>
							<input id="txtWorker2" type="text" class="txt c1"/>
						</td>
						<td class="td7"><input type="button" id="btnAuto" class="txt c1 " style="color:Red"/></td>
						<td class="td8" >
							<input type="button" id="btnBank" class="txt c1 " />
						</td>
					</tr>
					<!--簽核<tr>
					<td class="td1"><span> </span><a id="lblChecker" class="lbl"></a></td>
					<td class="td2">
					<input id="txtchecker" type="text" class="txt c2"/>
					<input id="txtCheckermemo" type="text" class="txt c3"/>
					</td>
					<td class="td3"><span> </span><a id="lblApprov" class="lbl"></a></td>
					<td class="td4">
					<input id="txtApprov" type="text" class="txt c2"/>
					<input id="txtApprovmemo" type="text" class="txt c3"/>
					</td>
					<td class="td5"><span> </span><a id="lblApprove"class="lbl"></a></td>
					<td class="td6">
					<input id="txtApprove" type="text" class="txt c2"/>
					<input id="txtApprovememo" type="text" class="txt c3"/>
					</td>
					<td class="td7"><span> </span><a id="lblApprove2"class="lbl"></a></td>
					<td class="td8">
					<input id="txtApprove2" type="text" class="txt c2"/>
					<input id="txtApprove2memo" type="text" class="txt c3"/>
					</td>
					</tr>-->
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:1%;"><input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;" /></td>
					<td align="center" style="width:1%;"> </td>
					<td align="center" style="width:7%;"><a id='lblAcc1'> </a></td>
					<td align="center" style="width:8%;"><a id='lblMoney'> </a></td>
					<td align="center" style="width:9%;"><a id='lblCheckno'> </a></td>
					<td align="center" style="width:8%;"><a id='lblAccount'> </a></td>
					<td align="center" style="width:7%;"><a id='lblBank'> </a></td>
					<td align="center" style="width:5%;"><a id='lblUdate' class="udate" style="display: none;"> </a><BR class="udate"><a id='lblIndate'> </a></td>
					<td align="center" style="width:5%;"><a id='lblChgsTran'> </a></td>
					<td align="center" style="width:7%;"><a id='lblMemos'> </a></td>
					<td align="center" style="width:5%;"><a id='lblPaysales'> </a></td>
					<td align="center" style="width:5%;"><a id='lblUnpay_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input class="btn" id="btnAcc.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
						<input type="text" id="txtAcc1.*" style="width:85%; float:left;"/>
						<span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtAcc2.*" style="width:97%; float:left;"/>
					</td>
					<td>
						<input type="text" id="txtMoney.*" style="text-align:right;width:95%;"/>
						<input type="text" id="txtMemo.*" style="width:95%;"/>
					</td>
					<td>
						<input type="text" id="txtCheckno.*" style="width:95%;" />
						<input type="text" id="txtTitle.*" style="width:95%;" />
					</td>
					<td><input type="text" id="txtAccount.*" style="width:95%;" /></td>
					<td>
						<input class="btn" id="btnBankno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
						<input type="text" id="txtBankno.*" style="width:80%; float:left;"/>
						<span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtBank.*" style="width:97%; float:left;"/>
					</td>
					<td>
						<input type="text" id="txtUdate.*" style="width:95%;display: none;" class="udate" />
						<input type="text" id="txtIndate.*" style="width:95%;" />
					</td>
					<td>
						<input type="text" id="txtChgs.*" style="text-align:right;width:95%;"/>
						<select id="cmbPartno.*" style="float:left;width:95%;" > </select>
						<input type="text" id="txtPart.*" style="display:none;"/>
					</td>
					<td>
						<input type="text" id="txtMemo2.*" style="width:95%;"/>
						<input type="text" id="txtVccno.*" style="width:95%;" />
						<input type="text" id="txtTablea.*" style="display:none;" />
						<input type="text" id="txtAccy.*" style="display:none;" />
					</td>
					<td>
						<input type="text" id="txtPaysale.*" style="text-align:right;width:95%;"/>
						<input type="text" id="txtUnpayorg.*" style="text-align:right;width:95%;"/>
					</td>
					<td>
						<input type="text" id="txtUnpay.*" style="width:95%; text-align: right;" />
						<input type="text" id="txtPart2.*" style="float:left;width: 95%;"/>
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>