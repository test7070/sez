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

			q_desc = 1;
			q_tables = 's';
			var q_name = "workc";
			var decbbs = ['weight', 'mount'];
			var decbbm = ['mount', 'price'];
			var q_readonly = ['txtNoa', 'txtWorker', 'txtStore', 'txtTgg'];
			var q_readonlys = ['txtWorkno', 'txtWk_mount', 'txtWk_gmount', 'txtWk_emount'];
			var bbmNum = [];
			var bbsNum = [
				['txtMount', 15, 3, 1], ['txtWeight', 15, 3, 1], ['txtWk_mount', 15, 2, 1],
				['txtWk_gmount', 15, 2, 1], ['txtWk_emount', 15, 2, 1]
			];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(
				['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'],
				['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
				['txtStoreno_', 'btnStore_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'],
				['txtProcessno', 'lblProcess', 'process', 'noa,process', 'txtProcessno,txtProcess', 'process_b.aspx'],
				['txtProductno', 'lblProductno', 'ucaucc', 'noa,product', 'txtProductno,txtProduct', 'ucaucc_b.aspx'],
				['txtProcessno_', 'btnProcessno_', 'process', 'noa,process', 'txtProcessno_,txtProcess_', 'process_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product,spec', 'txtProductno_,txtProduct_,txtSpec_', 'ucaucc_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_mask(bbmMask);
				q_brwCount();
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
				bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('worka.typea'));
				$('#txtWorkno').change(function() {
					var t_where = "where=^^ noa ='" + $('#txtWorkno').val() + "' ^^";
					q_gt('works', t_where, 0, 0, 0, "", r_accy);
				});
				/*$('#lblWorkno').click(function() {
				var t_where = "enda!=1 ";
				t_where += emp($('#txtWorkno').val()) ? '' : " and charindex ('" + $('#txtWorkno').val() + "',noa)>0 ";
				t_where += emp($('#txtTggno').val()) ? '' : " and charindex ('" + $('#txtTggno').val() + "',tggno)>0 ";
				q_box('work_b.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy, 'work', "95%", "95%", q_getMsg('popWork'));
				});*/
				//1020729 顯示未完全入庫
				$('#btnOrdes').click(function() {
					if (q_cur == 1 || q_cur == 2) {
						if (!emp($('#txtTggno').val())) {
							var t_where = "enda!=1 and noa+'_'+no2 in (select a.ordeno+'_'+a.no2 from work" + r_accy + " a left join works" + r_accy + " b on a.noa=b.noa where a.tggno!='' and a.tggno='" + $('#txtTggno').val() + "' and a.mount > a.inmount group by a.ordeno,a.no2) ";
						} else {
							var t_where = "enda!=1 and noa+'_'+no2 in (select a.ordeno+'_'+a.no2 from work" + r_accy + " a left join works" + r_accy + " b on a.noa=b.noa where a.tggno!='' and a.mount > a.inmount group by a.ordeno,a.no2) ";
						}
						q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "95%", q_getMsg('popOrdes'));
					}
				});
				//1020729 顯示未完全入庫,0816取消但會顯示狀態
				$('#btnWork').click(function() {
					var t_where = '1=1 ';
					if (!emp($('#txtTggno').val())) {
						//var t_where += "and enda!=1 and tggno!='' and tggno='"+$('#txtTggno').val()+"' and noa in (select a.noa from work102 a left join works102 b on a.noa=b.noa where a.mount>a.inmount)";
						t_where += "and enda!=1 and tggno!='' and tggno='" + $('#txtTggno').val() + "'";
					} else {
						//var t_where += "and enda!=1 and tggno!='' and noa in (select a.noa from work102 a left join works102 b on a.noa=b.noa where a.mount<a.inmount)";
						t_where += "and enda!=1 and tggno!='' ";
					}
					var workno = $.trim($('#txtWorkno').val());
					if (workno.length > 0) {
						t_where += " and noa=N'" + workno + "'";
					}

					//1030310 加入應開工日的條件
					var t_bdate = $.trim($('#txtBdate').val());
					var t_edate = $.trim($('#txtEdate').val());
					if (t_bdate.length > 0 || t_edate.length > 0) {
						if (t_edate.length == 0)
							t_edate = '999/99/99'
						t_where += " and cuadate between '" + t_bdate + "' and '" + t_edate + "'";
					}
					q_box("work_chk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('popWork'));
					//1030310讀取倉庫
					if (!emp($('#txtStoreno').val()))
						var t_where = "where=^^ ['" + q_date() + "','" + $('#txtStoreno').val() + "','') group by productno order by productno^^";
					else
						var t_where = "where=^^ ['" + q_date() + "','','') group by productno order by productno^^";
					q_gt('work_stk', t_where, 0, 0, 0, "work_stk", r_accy);
				});

				$('#btnClose_div_stk').click(function() {
					$('#div_stk').toggle();
				});

				$('#btnWorks').click(function() {
					var t_where = '1=1 ';
					if (!emp($('#txtTggno').val())) {
						t_where += "and noa in ( select noa from view_work where enda!=1 and tggno!='' and tggno='" + $('#txtTggno').val() + "')";
					} else {
						t_where += "and noa in(select noa from view_work where enda!=1 and tggno!='')";
					}
					var workno = $.trim($('#txtWorkno').val());
					if (workno.length > 0) {
						t_where += " and noa=N'" + workno + "'";
					}

					//1030310 加入應開工日的條件
					var t_bdate = $.trim($('#txtBdate').val());
					var t_edate = $.trim($('#txtEdate').val());
					if (t_bdate.length > 0 || t_edate.length > 0) {
						if (t_edate.length == 0)
							t_edate = '999/99/99'
						t_where += " and cuadate between '" + t_bdate + "' and '" + t_edate + "'";
					}

					//t_where+=" and (isnull(mount,0)-isnull(gmount,0))>0"

					q_box("works_chk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'works', "95%", "95%", q_getMsg('popWork'));

					//1030310讀取倉庫
					if (!emp($('#txtStoreno').val()))
						var t_where = "where=^^ ['" + q_date() + "','" + $('#txtStoreno').val() + "','') group by productno order by productno^^";
					else
						var t_where = "where=^^ ['" + q_date() + "','','') group by productno order by productno^^";
					q_gt('work_stk', t_where, 0, 0, 0, "work_stk", r_accy);
				});
			}

			function getInStr(HasNoaArray) {
				var NewArray = new Array();
				for (var i = 0; i < HasNoaArray.length; i++) {
					NewArray.push("'" + HasNoaArray[i].noa + "'");
				}
				return NewArray.toString();
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop ) {
					case 'ordes':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();

							if (!b_ret || b_ret.length == 0)
								return;
							if (q_cur == 1 || q_cur == 2) {
								//清空表身資料
								for (var i = 0; i < q_bbsCount; i++) {
									$('#btnMinus_' + i).click();
								}
								for (var i = 0; i < b_ret.length; i++) {
									var t_where = "where=^^ ordeno ='" + b_ret[i].noa + "' and no2='" + b_ret[i].no2 + "' and tggno!='' and left(tggno,1)!='Z' ";
									if (!emp($('#txtTggno').val()))
										t_where += " and tggno='" + $('#txtTggno').val() + "'";

									t_where += "^^";

									q_gt('work', t_where, 0, 0, 0, "", r_accy);
								}
							}
						}
						break;
					case 'work':
						b_ret = getb_ret();
						if (b_ret && (q_cur == 1 || q_cur == 2)) {
							$('#txtModelno').val(b_ret[0].modelno);
							$('#txtModel').val(b_ret[0].model);
							$('#txtTggno').val(b_ret[0].tggno);
							$('#txtTgg').val(b_ret[0].comp);

							var t_where = "where=^^ noa in(" + getInStr(b_ret) + ")^^";
							q_gt('work', t_where, 0, 0, 0, "", r_accy);
						}
						break;
					case 'works':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							//將目前領料的數量加回目前庫存
							for (var i = 0; i < abbsNow.length; i++) {
								for (var j = 0; j < work_stk.length; j++) {
									if (abbsNow[i].productno == work_stk[j].productno) {
										work_stk[j].mount = dec(work_stk[j].mount) + dec(abbsNow[i].mount);
									}
								}
							}
							var t_msg = '', t_worksno = '';
							//判斷庫存量足夠
							for (var i = 0; i < b_ret.length; i++) {
								//應領料數量
								for (var j = 0; j < abbsNow.length; j++) {
									if (b_ret[i].noa == abbsNow[j].workno) {
										b_ret[i].gmount = dec(b_ret[i].gmount) - dec(abbsNow[j].mount)
									}
								}
								b_ret[i].xmount = dec(b_ret[i].mount) - dec(b_ret[i].gmount);
								b_ret[i].smount = dec(b_ret[i].mount) - dec(b_ret[i].gmount);
								for (var j = 0; j < work_stk.length; j++) {
									if (b_ret[i].productno == work_stk[j].productno) {
										if (dec(work_stk[j].mount) - dec(b_ret[i].mount) < 0) {
											if (t_worksno != b_ret[i].noa) {
												if (t_worksno == '')
													t_msg += "製令單：" + b_ret[i].noa + "\n";
												else
													t_msg += "\n製令單：" + b_ret[i].noa + "\n";
												t_worksno = b_ret[i].noa;
											}
											t_msg += "原料：" + b_ret[i].product + "，不足數量：" + (-1 * (dec(work_stk[j].mount) - dec(b_ret[i].mount))).toString() + "\n";
											if (dec(work_stk[j].mount) > 0) {
												b_ret[i].mount = work_stk[j].mount;
												work_stk[i].mount = 0;
											} else {
												b_ret.splice(i, 1);
												i--;
											}
										} else {
											work_stk[j].mount = dec(work_stk[j].mount) - dec(b_ret[i].mount);
										}
										break;
									}
								}
							}
							q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtSpec,txtMount,txtMemo,txtProcessno,txtProcess,txtWorkno,txtWk_mount,txtWk_gmount,txtWk_emount', b_ret.length, b_ret, 'productno,product,unit,spec,smount,memo,processno,process,noa,mount,gmount,xmount', '');
							if (t_msg.length > 0)
								alert(t_msg);
						}
						break;
					case 'workas':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							var i, j = 0;
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtUnit,txtMount,txtTypea', b_ret.length, b_ret, 'productno,product,spec,unit,mount,typea', 'txtProductno');
							bbsAssign();
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			var work_stk;
			//儲存目前倉庫庫存
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'msg_stk':
						var as = _q_appendData("stkucc", "", true);
						var stkmount = 0;
						t_msg = '';
						for (var i = 0; i < as.length; i++) {
							stkmount = stkmount + dec(as[i].mount);
						}
						t_msg = "庫存量：" + stkmount;
						q_msg($('#txtMount_' + b_seq), t_msg);
						break;
					case 'msg_stk_all':
						var as = _q_appendData("stkucc", "", true);
						var rowslength = document.getElementById("table_stk").rows.length - 3;
						for (var j = 1; j < rowslength; j++) {
							document.getElementById("table_stk").deleteRow(3);
						}
						var stk_row = 0;

						var stkmount = 0;
						for (var i = 0; i < as.length; i++) {
							//倉庫庫存
							if (dec(as[i].mount) != 0) {
								var tr = document.createElement("tr");
								tr.id = "bbs_" + j;
								tr.innerHTML = "<td id='stk_tdStoreno_" + stk_row + "'><input id='stk_txtStoreno_" + stk_row + "' type='text' class='txt c1' value='" + as[i].storeno + "' disabled='disabled'/></td>";
								tr.innerHTML += "<td id='stk_tdStore_" + stk_row + "'><input id='stk_txtStore_" + stk_row + "' type='text' class='txt c1' value='" + as[i].store + "' disabled='disabled' /></td>";
								tr.innerHTML += "<td id='stk_tdMount_" + stk_row + "'><input id='stk_txtMount_" + stk_row + "' type='text' class='txt c1 num' value='" + as[i].mount + "' disabled='disabled'/></td>";
								var tmp = document.getElementById("stk_close");
								tmp.parentNode.insertBefore(tr, tmp);
								stk_row++;
							}
							//庫存總計
							stkmount = stkmount + dec(as[i].mount);
						}
						var tr = document.createElement("tr");
						tr.id = "bbs_" + j;
						tr.innerHTML = "<td colspan='2' id='stk_tdStore_" + stk_row + "' style='text-align: right;'><span id='stk_txtStore_" + stk_row + "' class='txt c1' >倉庫總計：</span></td>";
						tr.innerHTML += "<td id='stk_tdMount_" + stk_row + "'><span id='stk_txtMount_" + stk_row + "' type='text' class='txt c1 num' > " + stkmount + "</span></td>";
						var tmp = document.getElementById("stk_close");
						tmp.parentNode.insertBefore(tr, tmp);
						stk_row++;

						$('#div_stk').css('top', mouse_point.pageY - parseInt($('#div_stk').css('height')));
						$('#div_stk').css('left', mouse_point.pageX - parseInt($('#div_stk').css('width')));
						$('#div_stk').toggle();
						break;
					case 'work':
						if (emp($('#txtTggno').val())) {
							var as = _q_appendData("work", "", true);
							var t_tggno = '', t_tgg = '';
							for ( i = 0; i < as.length; i++) {
								if (as[i].tggno != '') {
									t_tggno = as[i].tggno;
									t_tgg = as[i].comp;
									break;
								}
							}
							if (t_tggno.length != 0 || t_tgg.length != 0) {
								$('#txtTggno').val(t_tggno);
								$('#txtTgg').val(t_tgg);
							}
						}

						//將目前領料的數量加回目前庫存
						for (var i = 0; i < abbsNow.length; i++) {
							for (var j = 0; j < work_stk.length; j++) {
								if (abbsNow[i].productno == work_stk[j].productno) {
									work_stk[j].mount = dec(work_stk[j].mount) + dec(abbsNow[i].mount);
								}
							}
						}

						var as = _q_appendData("works", "", true);
						var t_msg = '', t_worksno = '';
						//判斷庫存量足夠
						for (var i = 0; i < as.length; i++) {
							//應領料數量
							for (var j = 0; j < abbsNow.length; j++) {
								if (as[i].noa == abbsNow[j].workno) {
									as[i].gmount = dec(as[i].gmount) - dec(abbsNow[j].mount)
								}
							}
							as[i].xmount = dec(as[i].mount) - dec(as[i].gmount);
							as[i].smount = dec(as[i].mount) - dec(as[i].gmount);
							for (var j = 0; j < work_stk.length; j++) {
								if (as[i].productno == work_stk[j].productno) {
									if (dec(work_stk[j].mount) - dec(as[i].smount) < 0) {
										if (t_worksno != as[i].noa) {
											if ( t_worksno = '')
												t_msg += "製令單：" + as[i].noa + "\n";
											else
												t_msg += "\n製令單：" + as[i].noa + "\n";
											t_worksno = as[i].noa;
										}
										t_msg += "原料：" + as[i].product + "，不足數量：" + (-1 * (dec(work_stk[j].mount) - dec(as[i].smount))).toString() + "\n";
										if (dec(work_stk[j].mount) > 0) {
											as[i].smount = work_stk[j].mount;
											work_stk[i].mount = 0;
										} else {
											as.splice(i, 1);
											i--;
										}
									} else {
										work_stk[j].mount = dec(work_stk[j].mount) - dec(as[i].smount);
									}
									break;
								}
							}
						}
						q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtUnit,txtMount,txtMemo,txtProcessno,txtProcess,txtWorkno,txtWk_mount,txtWk_gmount,txtWk_emount', as.length, as, 'productno,product,spec,unit,smount,memo,processno,process,noa,mount,gmount,xmount', '');
						if (t_msg.length > 0)
							alert(t_msg);
						break;
					case 'work_stk':
						work_stk = _q_appendData("stkucc", "", true);
						break;
					case 'btnOK_bbsstkchk':
						var bbs_seq = t_name.substr('btnOK_bbsstkchk_'.length, t_name.length)
						var as = _q_appendData("stkucc", "", true);
						//將之前領料的加回去
						for (var j = 0; j < abbsNow.length; j++) {
							if (abbsNow[j].productno == as[0].productno && abbsNow[j].storeno == as[0].storeno) {
								as[0].mount = dec(as[0].mount) + dec(abbsNow[j].mount);
							}
						}
						//判斷同一產品全部領料
						for (var i = 0; i < q_bbsCount; i++) {
							if ($('#txtProductno_' + i).val() == as[0].productno && $('#txtStoreno_' + i).val() == as[0].storeno) {
								as[0].mount = dec(as[0].mount) - dec($('#txtMount_' + i).val())
							}
						}

						//寫入訊息
						if (as[0].mount < 0) {
							btnok_msg += as[0].product + "數量不足：" + (-1 * dec(as[0].mount)).toString() + "\n";
						}

						stkchkcount2++;
						if (stkchkcount == stkchkcount2)
							btnok_bbsstkchk = true;

						if (btnok_bbsstkchk && btnok_msg.length == 0) {
							$('#txtWorker').val(r_name);
							sum();
							var t_date = $('#txtDatea').val();
							var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
							if (s1.length == 0 || s1 == "AUTO")
								q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
							else
								wrServer(s1);
						}
						if (btnok_bbsstkchk && btnok_msg.length > 0) {
							alert(btnok_msg);
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			var btnok_bbsstkchk = false, stkchkcount = 0, stkchkcount2 = 0, btnok_msg = '';
			function btnOk() {
				t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtTggno', q_getMsg('lblTgg')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				//如果表身倉庫沒填，表頭倉庫帶入
				for (var i = 0; i < q_bbsCount; i++) {
					if (emp($('#txtStoreno_' + i).val())) {
						if (!emp($('#txtProductno_' + i).val())) {
							$('#txtStoreno_' + i).val($('#txtStoreno').val());
							$('#txtStore_' + i).val($('#txtStore').val());
						}
					}
				}

				//判斷庫存是否足夠
				btnok_bbsstkchk = false;
				stkchkcount = 0, stkchkcount2 = 0, btnok_msg = '';
				var bbs_tmp = new Array();

				var bbs_repeat = false;
				for (var i = 0; i < q_bbsCount; i++) {
					if (emp($('#txtProductno_' + i).val()))
						continue;

					bbs_repeat = false;
					for (var j = 0; j < bbs_tmp.length; j++) {
						if (bbs_tmp[j].productno == $('#txtProductno_' + i).val() && bbs_tmp[j].storeno == $('#txtStoreno_' + i).val()) {
							bbs_repeat = true;
						}
						if (emp($('#txtProductno_' + i).val()))
							bbs_repeat = true;
					}
					if (!bbs_repeat) {
						bbs_tmp.push({
							productno : $('#txtProductno_' + i).val(),
							storeno : $('#txtStoreno_' + i).val()
						});
					}
				}

				for (var i = 0; i < bbs_tmp.length; i++) {
					var t_where = "where=^^ ['" + q_date() + "','','" + bbs_tmp[i].productno + "') where storeno='" + bbs_tmp[i].storeno + "' ^^";
					q_gt('calstk', t_where, 0, 0, 0, "btnOK_bbsstkchk", r_accy);
					stkchkcount++;
				}

				if (stkchkcount == 0) {
					$('#txtWorker').val(r_name);
					sum();
					var t_date = $('#txtDatea').val();
					var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
					if (s1.length == 0 || s1 == "AUTO")
						q_gtnoa(q_name, replaceAll(q_getPara('sys.key_worka') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
					else
						wrServer(s1);
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('workc_s.aspx', q_name + '_s', "510px", "380px", q_getMsg("popSeek"));
			}

			var mouse_point;
			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						/*$('#txtMount_' + i).focusin(function() {
						 if (q_cur == 1 || q_cur == 2) {
						 t_IdSeq = -1;
						 q_bodyId($(this).attr('id'));
						 b_seq = t_IdSeq;
						 if (!emp($('#txtProductno_' + b_seq).val())) {
						 //庫存
						 var t_where = "where=^^ ['" + q_date() + "','','" + $('#txtProductno_' + b_seq).val() + "') ^^";
						 q_gt('calstk', t_where, 0, 0, 0, "msg_stk", r_accy);
						 }
						 }
						 });*/
						$('#btnStk_' + i).mousedown(function(e) {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtProductno_' + b_seq).val()) && $("#div_stk").is(":hidden")) {
								mouse_point = e;
								document.getElementById("stk_productno").innerHTML = $('#txtProductno_' + b_seq).val();
								document.getElementById("stk_product").innerHTML = $('#txtProduct_' + b_seq).val();
								//庫存
								var t_where = "where=^^ ['" + q_date() + "','','" + $('#txtProductno_' + b_seq).val() + "') ^^";
								q_gt('calstk', t_where, 0, 0, 0, "msg_stk_all", r_accy);
							}
						});
					}
				}
				_bbsAssign();
				for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					$('#btnMinus_' + j).click(function() {
						btnMinus($(this).attr('id'));
					});
				}
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();

			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				//判斷是否由workf作業轉來>>鎖定欄位//0401改為workqno
				if (!emp($('#txtWorkqno').val())) {
					$('#cmbTypea').attr('disabled', 'disabled');
					$('#txtDatea').attr('disabled', 'disabled');
					$('#txtStoreno').attr('disabled', 'disabled');
					$('#txtTggno').attr('disabled', 'disabled');
					$('#lblStorek').css('display', 'inline').text($('#lblStore').text());
					$('#lblTggk').css('display', 'inline').text($('#lblTgg').text());
					$('#lblStore').css('display', 'none');
					$('#lblTgg').css('display', 'none');
					$('#btnWork').attr('disabled', 'disabled');
					$('#btnWorks').attr('disabled', 'disabled');
					$('#btnOrdes').attr('disabled', 'disabled');
					$('#btnPlus').attr('disabled', 'disabled');
					for (var j = 0; j < q_bbsCount; j++) {
						$('#btnMinus_' + j).attr('disabled', 'disabled');
						$('#txtProductno_' + j).attr('disabled', 'disabled');
						$('#btnProductno_' + j).attr('disabled', 'disabled');
						$('#txtProduct_' + j).attr('disabled', 'disabled');
						$('#txtUnit_' + j).attr('disabled', 'disabled');
						$('#txtSpec_' + j).attr('disabled', 'disabled');
						$('#txtMount_' + j).attr('disabled', 'disabled');
						$('#btnStore_' + j).attr('disabled', 'disabled');
						$('#txtStoreno_' + j).attr('disabled', 'disabled');
						$('#txtStore_' + j).attr('disabled', 'disabled');
					}
				}
				$('#txtProduct').focus();
			}

			function btnPrint() {
				q_box('z_workcp.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] && !as['product']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['datea'] = abbm2['datea'];
				as['custno'] = abbm2['custno'];
				as['tggno'] = abbm2['tggno'];
				return true;
			}

			function sum() {
				var t1 = 0, t_unit, t_mount, t_weight = 0;
				for (var j = 0; j < q_bbsCount; j++) {

				}
			}

			function refresh(recno) {
				_refresh(recno);
				$('#div_stk').hide();
				$('#lblStore').css('display', 'inline');
				$('#lblStation').css('display', 'inline');
				$('#lblStorek').css('display', 'none');
				$('#lblStationk').css('display', 'none');
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
				var hasSpec = q_getPara('sys.isspec');
				var isSpec = (hasSpec.toString()=='1'?$('.isSpec').show():$('.isSpec').hide());
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#btnWork').attr('disabled', 'disabled');
					$('#btnWorks').attr('disabled', 'disabled');
					$('#btnOrdes').attr('disabled', 'disabled');
				} else {
					$('#btnWork').removeAttr('disabled');
					$('#btnWorks').removeAttr('disabled');
					$('#btnOrdes').removeAttr('disabled');
				}
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
				if (!emp($('#txtWorkqno').val())) {
					alert("該領料單由委外廠QC作業(" + $('#txtWorkqno').val() + ")轉來，請至委外廠QC作業刪除!!!")
					return;
				}
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtWorkno':
						var t_where = "where=^^ noa ='" + $('#txtWorkno').val() + "' ^^";
						q_gt('works', t_where, 0, 0, 0, "", r_accy);
						break;
				}
			}
		</script>
		<style type="text/css">
			.tview {
				FONT-SIZE: 12pt;
				COLOR: Blue;
				background: #FFCC00;
				padding: 3px;
				TEXT-ALIGN: center;
			}
			.tbbm {
				FONT-SIZE: 12pt;
				COLOR: blue;
				TEXT-ALIGN: left;
				border-color: white;
				width: 100%;
				border-collapse: collapse;
				background: #cad3ff;
			}
			.tbbs {
				FONT-SIZE: 12pt;
				COLOR: blue;
				TEXT-ALIGN: left;
				BORDER: 1PX LIGHTGREY SOLID;
				width: 100%;
			}
			.tbbm tr {
				height: 35px;
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
			.txt {
				float: left;
			}
			.txt.c1 {
				width: 98%;
			}
			.txt.c2 {
				width: 47.5%;
			}
			.num {
				text-align: right;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="div_stk" style="position:absolute; top:300px; left:400px; display:none; width:400px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_stk" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;" align="center">產品編號</td>
					<td style="background-color: #f8d463;" colspan="2" id='stk_productno'></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">產品名稱</td>
					<td style="background-color: #f8d463;" colspan="2" id='stk_product'></td>
				</tr>
				<tr id='stk_top'>
					<td align="center" style="width: 30%;">倉庫編號</td>
					<td align="center" style="width: 45%;">倉庫名稱</td>
					<td align="center" style="width: 25%;">倉庫數量</td>
				</tr>
				<tr id='stk_close'>
					<td align="center" colspan='3'>
						<input id="btnClose_div_stk" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<div id="dmain" style="width: 1260px;">
			<!--#include file="../inc/toolbar.inc"-->
			<div class="dview" id="dview" style="float: left; width:25%;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:4%"><a id='vewChk'></a></td>
						<td align="center" style="width:10%"><a id='vewDatea'></a></td>
						<td align="center" style="width:30%"><a id='vewNoa'></a></td>
						<td align="center" style="width:30%"><a id='vewTgg'></a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='tgg,4'>~tgg,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 75%;float:left">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='0'>
					<tr style="height: 1px;">
						<td width="120px"></td>
						<td width="203px"></td>
						<td width="120px"></td>
						<td width="203px"></td>
						<td width="120px"></td>
						<td width="203px"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"></select></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStore' class="lbl btn"> </a><a id='lblStorek' class="lbl btn"> </a></td>
						<td>
							<input id="txtStoreno" type="text" class="txt c2"/>
							<input id="txtStore" type="text" class="txt c2"/>
						</td>
						<td><span> </span><a id='lblTgg' class="lbl btn"> </a><a id='lblTggk' class="lbl btn"> </a></td>
						<td>
							<input id="txtTggno" type="text" class="txt c2"/>
							<input id="txtTgg" type="text" class="txt c2"/>
						</td>
						<td><span> </span><a id='lblMold' class="lbl"> </a></td>
						<td>
							<input id="txtMoldno" type="text" class="txt c2"/>
							<input id="txtMold" type="text" class="txt c2"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBdate' class="lbl"> </a></td>
						<td>
							<input id="txtBdate" type="text" class="txt c3" style="width: 88px;"/>
							<a style="float: left;">~</a>
							<input id="txtEdate" type="text" class="txt c3" style="width: 88px;"/>
						</td>
						<td><span> </span><a id='lblWorkno' class="lbl"> </a></td>
						<td>
							<input id="txtWorkno" type="text" class="txt c1"/>
							<input id="txtWorkfno" type="hidden" />
							<input id="txtWorkqno" type="hidden" />
						</td>
						<td colspan='2'>
							<input type="button" id="btnWork">
							<input type="button" id="btnWorks">
							<input type="button" id="btnOrdes">
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan='3'><input id="txtMemo" type="text" style="width: 98%;"/></td>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1820px;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
					<td style="width:43px;" align="center">
						<input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
					</td>
					<td align="center" style="width:20px;"></td>
					<td style="width:180px;" align="center"><a id='lblProductnos'> </a></td>
					<td style="width:200px;" align="center"><a id='lblProducts'> </a></td>
					<td style="width:60px;" align="center"><a id='lblUnit'></a></td>
					<td style="width:120px;" align="center" class="isStyle"><a id='lblStyle'></a></td>
					<td style="width:80px;" align="center"><a id='lblWk_mounts'></a></td>
					<td style="width:80px" align="center"><a id='lblWk_gmounts'></a></td>
					<td style="width:80px;" align="center"><a id='lblWk_emounts'></a></td>
					<td style="width:90px;" align="center"><a id='lblMounts'> </a></td>
					<td style="width:180px;" align="center"><a id='lblStores'> </a></td>
					<td style="width:180px;" align="center"><a id='lblProcesss'> </a></td>
					<td style="width:200px;" align="center"><a id='lblMemos'> </a></td>
					<td style="width:180px;" align="center"><a id='lblWorknos'> </a></td>
					<td style="width:30px;" align="center"><a id='lblStks'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td>
						<input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input class="txt" id="txtProductno.*" type="text" style="width:85%;" />
						<input class="btn" id="btnProductno.*" type="button" value='.' style="width:1%;" />
					</td>
					<td>
						<input id="txtProduct.*" type="text" class="txt c1"/>
						<input id="txtSpec.*" type="text" class="txt c1 isSpec"/>
					</td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td class="isStyle"><input id="txtStyle.*" type="text" class="txt c1"/></td>
					<td><input id="txtWk_mount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWk_gmount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWk_emount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
					<td>
						<input class="btn" id="btnStore.*" type="button" value='.' style="width:1%;float: left;" />
						<input id="txtStoreno.*" type="text" class="txt c2" style="width: 30%;"/>
						<input id="txtStore.*" type="text" class="txt c3" style="width: 50%;"/>
					</td>
					<td>
						<input class="btn" id="btnProcessno.*" type="button" value='.' style="width:1%;float: left;" />
						<input class="txt" id="txtProcessno.*" type="text" style="width:25%;" />
						<input class="txt" id="txtProcess.*" type="text" style="width:60%;" />
					</td>
					<td>
						<input id="txtMemo.*" type="text" class="txt c1"/>
						<input id="txtNoq.*" type="hidden" />
						<input id="recno.*" type="hidden" />
					</td>
					<td><input id="txtWorkno.*" type="text" class="txt c1"/></td>
					<td align="center">
						<input class="btn" id="btnStk.*" type="button" value='.' style="width:1%;" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>