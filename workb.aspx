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
			var q_name = "workb";
			var decbbs = ['weight', 'mount', 'gmount', 'emount', 'errmount', 'born'];
			var decbbm = ['mount', 'inmount', 'errmount', 'rmount', 'price', 'hours'];
			var q_readonly = ['txtWorker', 'txtNoa','txtWorkano'];
			var q_readonlys = ['txtOrdeno', 'txtNo2', 'txtNoq', 'txtWorkno','txtWk_mount','txtWk_inmount','txtWk_unmount'];
			var bbmNum = [];
			var bbsNum = [
				['txtMount', 15, 2, 1], ['txtBorn', 15, 0, 1], ['txtLengthb', 15, 0, 1],
				['txtTheory', 15, 2, 1], ['txtWmount', 15, 2, 1],
				['txtWk_mount', 15, 2, 1], ['txtWk_inmount', 15, 2, 1], ['txtWk_unmount', 15, 2, 1],
			];
			var bbmMask = [];
			var bbsMask = [['txtTimea', '99:99']];

			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = '';

			aPop = new Array(
				['txtStationno', 'lblStation', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx'],
				['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
				['txtStoreno_', 'btnStore_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'],
				/*['txtWorkno', 'lblWorkno', 'work', 'noa', 'txtWorkno', 'work_b.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy],*/
				['txtMechno', 'lblMechno', 'mech', 'noa,mech', 'txtMechno,txtMech', 'mech_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);

			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				q_mask(bbmMask);
				mainForm(1);
				$('#txtDatea').focus();
			}
			
			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd]];
				q_mask(bbmMask);
				
				$('#txtWorkano').click(function() {
					if (!emp($('#txtWorkano').val())) {
						t_where = "noa='" + $('#txtWorkano').val() + "'";
						q_box("worka.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'worka', "95%", "95%", q_getMsg('PopWorka'));
					}
				});

				$('#txtWorkno').change(function() {
					var t_where = "where=^^ noa ='" + $('#txtWorkno').val() + "' ^^";
					q_gt('work', t_where, 0, 0, 0, "", r_accy);
				});

				/*$('#lblWorkno').click(function() {
					var t_where = "enda!=1 ";
					t_where += emp($('#txtWorkno').val()) ? '' : "and charindex ('" + $('#txtWorkno').val() + "',noa)>0 ";
					q_box('work_b.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy, 'work', "95%", "95%", q_getMsg('popWork'));
				});*/

				//1020729 排除已完全入庫&&完全未領料的成品
				$('#btnOrdes').click(function() {
					var t_err = '';
					t_err = q_chkEmpField([['txtStationno', q_getMsg('lblStation')]]);
					// 檢查空白
					if (t_err.length > 0) {
						alert(t_err);
						return;
					}
					
					if (!emp($('#txtStationno').val())) {
						var t_where = "enda!=1 and noa+'_'+no2 in (select a.ordeno+'_'+a.no2 from work102 a left join works102 b on a.noa=b.noa where (a.tggno is null or a.tggno='') and a.stationno='" + $('#txtStationno').val() + "' and (a.mount>a.inmount and b.gmount>0)) ";
					} else {
						//var t_where = "enda!=1 and noa+'_'+no2 in (select a.ordeno+'_'+a.no2 from work102 a left join works102 b on a.noa=b.noa where (a.tggno is null or a.tggno='') and (a.mount>a.inmount and b.gmount>0)) ";
						var t_where = "enda!=1 and noa+'_'+no2 in (select a.ordeno+'_'+a.no2 from view_work a left join view_works b on a.noa=b.noa where  (a.tggno is null or a.tggno='') and a.mount>a.inmount  group by a.ordeno,a.no2) ";
					}
					q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "95%", q_getMsg('popOrdes'));
				});

				//1020729 排除已完全入庫&&完全未領料的成品,0816取消但會顯示狀態
				$('#btnWork').click(function() {
					var t_err = '';
					t_err = q_chkEmpField([['txtStationno', q_getMsg('lblStation')]]);
					// 檢查空白
					if (t_err.length > 0) {
						alert(t_err);
						return;
					}
					var t_where = '1=1 ';
					if (!emp($('#txtStationno').val())) {
						//var t_where += "and enda!=1 and (tggno is null or tggno='') and stationno='"+$('#txtStationno').val()+"' and noa in (select a.noa from work102 a left join works102 b on a.noa=b.noa where (a.mount>a.inmount and b.gmount>0))";
						t_where += "and enda!=1 and (tggno is null or tggno='') and stationno='" + $('#txtStationno').val() + "'";
					} else {
						//var t_where += "and enda!=1 and (tggno is null or tggno='') and noa in (select a.noa from work102 a left join works102 b on a.noa=b.noa where (a.mount>a.inmount and b.gmount>0))";
						t_where += "and enda!=1 and (tggno is null or tggno='')";
					}
					var workno = $.trim($('#txtWorkno').val());
					if(workno.length > 0 ){
						t_where += " and noa=N'"+workno+"'";
					}
					//1030310 加入應完工日的條件
					var t_bdate = $.trim($('#txtBdate').val());
					var t_edate = $.trim($('#txtEdate').val());
					if(t_bdate.length > 0 || t_edate.length>0){
						if(t_edate.length == 0) t_edate='999/99/99'
						t_where += " and uindate between '"+t_bdate+"' and '"+t_edate+"'";
					}
					
					t_where += " or noa in (select workno from view_workbs where noa='" + $('#txtNoa').val() + "')";
					
					q_box("work_chk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('popWork'));
				});
				
				$('#btnClose_div_stk').click(function() {
					$('#div_stk').toggle();
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
				switch (b_pop) {
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
									//Z開頭的廠商為自己公司要算在內
									if (!emp($('#txtStationno').val())) {
										var t_where = "where=^^ ordeno ='" + b_ret[i].noa + "' and no2='" + b_ret[i].no2 + "' and stationno='" + $('#txtStationno').val() + "' ^^";
										q_gt('work', t_where, 0, 0, 0, "", r_accy);
									} else {
										var t_where = "where=^^ ordeno ='" + b_ret[i].noa + "' and no2='" + b_ret[i].no2 + "' and (len(tggno)=0 or len(stationno)>0 ) ^^";
										q_gt('work', t_where, 0, 0, 0, "", r_accy);
									}
								}
							}
						}
						break;
					case 'inbs':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							var i, j = 0;
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtOrdeno,txtNo2,txtBorn,txtBweight', b_ret.length, b_ret, 'productno,product,unit,ordeno,no2,mount,weight', 'txtProductno');
							/// 最後 aEmpField 不可以有【數字欄位】

							bbsAssign();
						}
						break;
					case 'workas':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							var i, j = 0;
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtBorn,txtBweight', b_ret.length, b_ret, 'productno,product,unit,mount,weight', 'txtProductno');
							/// 最後 aEmpField 不可以有【數字欄位】
							bbsAssign();
						}
						break;
					case 'work':
						b_ret = getb_ret();
						if (b_ret && (q_cur == 1 || q_cur == 2)) {
							$('#txtStationno').val(b_ret[0].stationno);
							$('#txtStation').val(b_ret[0].station);
							
							//清空表身資料
							for (var i = 0; i < q_bbsCount; i++) {
								$('#btnMinus_' + i).click();
							}
							
							var t_where = "where=^^ noa in(" + getInStr(b_ret) + ")^^";
							q_gt('work', t_where, 0, 0, 0, "", r_accy);
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'msg_stk_all':
						var as = _q_appendData("stkucc", "", true);
						var rowslength=document.getElementById("table_stk").rows.length-3;
							for (var j = 1; j < rowslength; j++) {
								document.getElementById("table_stk").deleteRow(3);
							}
						var stk_row=0;
						
						var stkmount = 0;
						for (var i = 0; i < as.length; i++) {
							//倉庫庫存
							if(dec(as[i].mount)!=0){
								var tr = document.createElement("tr");
								tr.id = "bbs_"+j;
								tr.innerHTML = "<td id='stk_tdStoreno_"+stk_row+"'><input id='stk_txtStoreno_"+stk_row+"' type='text' class='txt c1' value='"+as[i].storeno+"' disabled='disabled'/></td>";
								tr.innerHTML+="<td id='stk_tdStore_"+stk_row+"'><input id='stk_txtStore_"+stk_row+"' type='text' class='txt c1' value='"+as[i].store+"' disabled='disabled' /></td>";
								tr.innerHTML+="<td id='stk_tdMount_"+stk_row+"'><input id='stk_txtMount_"+stk_row+"' type='text' class='txt c1 num' value='"+as[i].mount+"' disabled='disabled'/></td>";
								var tmp = document.getElementById("stk_close");
								tmp.parentNode.insertBefore(tr,tmp);
								stk_row++;
							}
							//庫存總計
							stkmount = stkmount + dec(as[i].mount);
						}
						var tr = document.createElement("tr");
						tr.id = "bbs_"+j;
						tr.innerHTML="<td colspan='2' id='stk_tdStore_"+stk_row+"' style='text-align: right;'><span id='stk_txtStore_"+stk_row+"' class='txt c1' >倉庫總計：</span></td>";
						tr.innerHTML+="<td id='stk_tdMount_"+stk_row+"'><span id='stk_txtMount_"+stk_row+"' type='text' class='txt c1 num' > "+stkmount+"</span></td>";
						var tmp = document.getElementById("stk_close");
						tmp.parentNode.insertBefore(tr,tmp);
						stk_row++;
						
						$('#div_stk').css('top',mouse_point.pageY-parseInt($('#div_stk').css('height')));
						$('#div_stk').css('left',mouse_point.pageX-parseInt($('#div_stk').css('width')));
						$('#div_stk').toggle();
						break;
					case 'work':
						var as = _q_appendData("work", "", true);
						var t_stationno = '', t_station = '';
						for ( i = 0; i < as.length; i++) {
							if (as[i].stationno != '') {
								t_stationno = as[i].stationno;
								t_station = as[i].station;
							}
							
							//扣掉本入庫單以入庫的數量
							for (var j = 0; j < abbsNow.length; j++) {
								if (abbsNow[j].workno == as[i].noa) {
									as[i].inmount = dec(as[i].inmount) - dec(abbsNow[j].mount);
								}
							}
							
							//本次入庫量
							as[i].smount=dec(as[i].mount)-dec(as[i].inmount);
						}
						var ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtMount,txtMemo,txtWorkno,txtOrdeno,txtNo2,txtWk_mount,txtWk_inmount,txtWk_unmount', as.length, as
						, 'productno,product,unit,smount,memo,noa,ordeno,no2,mount,inmount,smount', '');

						if (t_stationno.length != 0 || t_station.length != 0) {
							$('#txtStationno').val(t_stationno);
							$('#txtStation').val(t_station);
						}
						break;
					case 'ucc':
						var as = _q_appendData("ucc", "", true);
						if (as[0] != undefined)
							$('#txtTheory_' + b_seq).val(round(dec($('#txtLengthb_' + b_seq).val()) * dec(as[0].uweight), 2));
						else
							$('#txtTheory_' + b_seq).val(0);
						break;

					case 'work_pick':
						var pickerror = '';
						var as = _q_appendData("workbs", "", true);
						//檢查每一筆入庫是否合領料比例
						for (var i = 0; i < q_bbsCount; i++) {
							if (!emp($('#txtWorkno_' + i).val())) {
								for (var j = 0; j < as.length; j++) {
									if ($('#txtWorkno_' + i).val() == as[j].noa) {
										var work_mount = dec(as[j].mount);
										//work需求數量
										var work_inmount = dec(as[j].inmount) + dec($('#txtMount_' + i).val());
										//work已入庫數量+要入庫的數量
										var works_mounts = dec(as[j].mounts);
										//works領料需求數量
										var works_gmounts = dec(as[j].gmounts);
										//works已領料數量
										var work_rate = work_inmount / work_mount;
										//入庫比率
										var works_rate = works_gmounts / works_mounts;
										//領料比率
										if (work_rate - works_rate > 0.01) {//誤差相差0.01
											pickerror = $('#txtProductno_' + i).val()+"【"+$('#txtProduct_' + i).val()+"】入庫與領料比例不符!!";
											pickerror += "\n最大可入庫數："+FormatNumber(round(work_mount*works_rate,2));
										}
									}
									if (pickerror.length > 0) {
										break;
									}
								}
							}
							if (pickerror.length > 0) {
								break;
							}
						}
						if (pickerror.length == 0) {
							checkok = true;
							btnOk();
						} else {
							alert(pickerror);
						}
						break;
					case q_name:
						if (q_cur == 4)// 查詢
							q_Seek_gtPost();
						break;
				}  /// end switch
			}

			//檢查領料是否等比例 //1030325流程變成入庫後產生領料單因此檢查領料比例拿掉
			var checkok = true;//要判斷改回false
			function btnOk() {
				t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtStationno', q_getMsg('lblStation')]]);
				// 檢查空白
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}

				if (!checkok) {
					var word_where = '';
					for (var i = 0; i < q_bbsCount; i++) {
						if (!emp($('#txtWorkno_' + i).val()))
							word_where += "a.noa='" + $('#txtWorkno_' + i).val() + "' or ";
					}
					if (word_where.length > 0)
						word_where = "and (" + word_where.substr(0, word_where.length - 3) + ")";

					var t_where = "where=^^ 1=1 " + word_where + "^^";
					var t_where1 = "where[1]=^^ noa='" + $('#txtNoa').val() + "' and productno=a.productno and workno=a.noa ^^";
					q_gt('work_pick', t_where + t_where1, 0, 0, 0, "", r_accy);
				} else {
					checkok = true;//要判斷改回false
					$('#txtWorker').val(r_name);

					//如果表身倉庫沒填，表頭倉庫帶入
					for (var i = 0; i < q_bbsCount; i++) {
						if (emp($('#txtStoreno_' + i).val())) {
							$('#txtStoreno_' + i).val($('#txtStoreno').val());
							$('#txtStore_' + i).val($('#txtStore').val());
						}
					}
					
					//檢查是否多入庫
					var err_mess='';
					for (var i = 0; i < q_bbsCount; i++) {
						var unmount=q_float('txtWk_mount_'+i)-q_float('txtWk_inmount_'+i)-q_float('txtMount_'+i);
						if(unmount<0){
							err_mess+=$('#txtProduct_'+i).val()+"多入"+-1*unmount+'\n';
						}
					}
					
					if(err_mess.length>0){
						alert(err_mess);
						return;
					}

					var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
					var t_date = $('#txtDatea').val();
					if (s1.length == 0 || s1 == "AUTO")
						q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workb') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
					else
						wrServer(s1);
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;

				q_box('workb_s.aspx', q_name + '_s', "510px", "350px", q_getMsg("popSeek"));
			}

			function combPay_chg() {
			}
			
			var mouse_point;
			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#txtLengthb_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;

							var t_where = "where=^^ noa='" + $('#txtProductno_' + b_seq).val() + "' ^^";
							q_gt('ucc', t_where, 0, 0, 0, "", r_accy);
						});
						$('#btnStk_' + i).mousedown(function(e) {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtProductno_' + b_seq).val()) && $("#div_stk").is(":hidden")) {
								mouse_point=e;
								document.getElementById("stk_productno").innerHTML = $('#txtProductno_' + b_seq).val();
								document.getElementById("stk_product").innerHTML = $('#txtProduct_' + b_seq).val();
								//庫存
								var t_where = "where=^^ ['" + q_date() + "','','" + $('#txtProductno_' + b_seq).val() + "') ^^";
								q_gt('calstk', t_where, 0, 0, 0, "msg_stk_all", r_accy);
							}
						});
						$('#txtMount_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							//$('#txtWk_unmount_'+b_seq).val(q_float('txtWk_mount_'+b_seq)-q_float('txtWk_inmount_'+b_seq)-q_float('txtMount_'+b_seq))
						});
						
						$('#txtWorkno_' + i).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtWorkno_' + b_seq).val())) {
								t_where = "noa='" + $('#txtWorkno_' + b_seq).val() + "'";
								q_box("work.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'bbs_work', "95%", "95%", q_getMsg('PopWork'));
							}
						});
					}
				}
				_bbsAssign();
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
				$('#txtProduct').focus();
			}

			function btnPrint() {
				q_box('z_workbp.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
				
				if (q_cur == 1 || emp($('#txtWorkano').val()))
					q_func('qtxt.query.c0', 'workb.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
				else {
					//處理worka內容
					q_func('worka_post.post.a1', r_accy + ',' + $('#txtWorkano').val() + ',0');
				}
				
			}

			function bbsSave(as) {
				if (!as['productno'] && !as['product']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['datea'] = abbm2['datea'];
				as['cuano'] = abbm2['cuano'];
				as['stationno'] = abbm2['stationno'];

				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				$('#div_stk').hide();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}

			function btnMinus(id) {
				_btnMinus(id);
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
				//_btnDele();
				if (!confirm(mess_dele))
					return;
				q_cur = 3;
				//處理worka內容
				if(emp($('#txtWorkano').val()))
					q_func('qtxt.query.c2', 'workb.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
				else
					q_func('worka_post.post.a2', r_accy + ',' + $('#txtWorkano').val() + ',0');
			}

			function btnCancel() {
				_btnCancel();
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtWorkno':
						var t_where = "where=^^ noa ='" + $('#txtWorkno').val() + "' ^^";
						q_gt('work', t_where, 0, 0, 0, "", r_accy);
						break;
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
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'worka_post.post.a1':
						//呼叫workb.post
						q_func('qtxt.query.c0', 'workb.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
						break;
					case 'worka_post.post.a2':
						//呼叫workb.post
						q_func('qtxt.query.c2', 'workb.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
						break;
					case 'qtxt.query.c0':
						q_func('qtxt.query.c1', 'workb.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';1');
						break;
					case 'qtxt.query.c1':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							abbm[q_recno]['workano'] = as[0].workano;
							$('#txtWorkano').val(as[0].workano);
							//處理worka內容
							if(!emp(as[0].workano))
								q_func('worka_post.post', r_accy + ',' + $('#txtWorkano').val() + ',1');
						}
						break;
					case 'qtxt.query.c2':
						_btnOk($('#txtNoa').val(), bbmKey[0], ( bbsHtm ? bbsKey[1] : ''), '', 3)
						break;
					default:
						break;
				}
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 30%;
				border-width: 0px;
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
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 70%;
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
				/*width: 9%;*/
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
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
				float: left;
			}
			.txt.c4 {
				width: 18%;
				float: left;
			}
			.txt.c5 {
				width: 90%;
				float: left;
			}
			.txt.c6 {
				width: 50%;
				float: left;
			}
			.txt.c7 {
				float: left;
				width: 22%;
			}
			.txt.c8 {
				float: left;
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
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.tbbm textarea {
				font-size: medium;
			}

			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1px;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
			}
			.dbbs .tbbs tr {
				height: 35px;
			}
			.dbbs .tbbs tr td {
				text-align: center;
				border: 2px lightgrey double;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="div_stk" style="position:absolute; top:300px; left:400px; display:none; width:400px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_stk" style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;" align="center">產品編號</td>
					<td style="background-color: #f8d463;" colspan="2" id='stk_productno'> </td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">產品名稱</td>
					<td style="background-color: #f8d463;" colspan="2" id='stk_product'> </td>
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
			<div class="dview" id="dview">
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:20%"><a id='vewDatea'></a></td>
						<td align="center" style="width:40%"><a id='vewNoa'></a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
					<tr style="height: 1px;">
						<td width="133px"> </td>
						<td width="241px"> </td>
						<td width="133px"> </td>
						<td width="241px"> </td>
						<td width="135px"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStation' class="lbl btn"> </a></td>
						<td>
							<input id="txtStationno" type="text" class="txt c2"/>
							<input id="txtStation" type="text" class="txt c3"/>
						</td>
						<td><span> </span><a id='lblMechno' class="lbl btn"> </a></td>
						<td>
							<input id="txtMechno" type="text" class="txt c2"/>
							<input id="txtMech" type="text" class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBdate' class="lbl"> </a></td>
						<td>
							<input id="txtBdate" type="text"  class="txt c3" style="width: 113px;"/>
							<a style="float: left;">~</a>
							<input id="txtEdate" type="text"  class="txt c3" style="width: 113px;"/>
						</td>
						<td><span> </span><a id='lblWorkno' class="lbl"> </a></td>
						<td ><input id="txtWorkno" type="text"  class="txt c1"/></td>
						<td><input type="button" id="btnWork"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStore' class="lbl btn"> </a></td>
						<td>
							<input id="txtStoreno" type="text" class="txt c2"/>
							<input id="txtStore" type="text" class="txt c3"/>
						</td>
						<td><span> </span><a id='lblWorkano' class="lbl"> </a></td>
						<td><input id="txtWorkano" type="text" class="txt c1"/></td>
						<td><input type="button" id="btnOrdes"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan='3'><input id="txtMemo" type="text" class="txt c1" style="width: 99%;"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1700px;">
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:43px;">
						<input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:226px;"><a id='lblProductnos'></a></td>
					<td align="center" style="width:251px;"><a id='lblProducts'></a></td>
					<td align="center" style="width:50px;"><a id='lblUnit'></a></td>
					<td align="center" style="width:80px;"><a id='lblWk_mounts'></a></td>
					<td align="center" style="width:80px"><a id='lblWk_inmounts'></a></td>
					<td align="center" style="width:80px;"><a id='lblWk_unmounts'></a></td>
					<td align="center" style="width:80px;"><a id='lblMounts'></a></td>
					<!--<td align="center" style="width:7%;"><a id='lblTheory'></a></td>-->
					<td align="center" style="width:80px;"><a id='lblWmount'></a></td>
					<td align="center" style="width:200px;"><a id='lblStores'></a></td>
					<td align="center" ><a id='lblMemos'></a></td>
					<!--<td align="center" style="width:45px;"><a id='lblEnda'> </a></td>-->
					<td align="center" style="width:163px;"><a id='lblWorknos'></a></td>
					<td align="center" style="width:30px;"><a id='lblStks'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<!--1020702製造業通常只用到數量，所以重量隱藏，並將生產數量改為報廢數量-->
					<td><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input class="btn"  id="btnProductno.*" type="button" value='.' style="width:8%;"  />
						<input id="txtProductno.*" type="text" style="width:76%;"/>
					</td>
					<td><input id="txtProduct.*" type="text" class="txt c1"/></td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td style="display: none;"><input id="txtLengthb.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWk_mount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWk_inmount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWk_unmount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
					<!--<td><input id="txtTheory.*" type="text" class="txt c1 num"/></td>-->
					<td><input id="txtWmount.*" type="text" class="txt c1 num"/></td>
					<td>
						<input class="btn"  id="btnStore.*" type="button" value='.' style="width:1%;float: left;"  />
						<input id="txtStoreno.*"  type="text" class="txt c2" style="width: 33%;"/>
						<input id="txtStore.*" type="text" class="txt c3" style="width: 50%;"/>
					</td>
					<td>
						<input id="txtMemo.*" type="text" class="txt c1"/>
						<input id="txtOrdeno.*" type="text" style="width:73%;"/>
						<input id="txtNo2.*" type="text" style="width:20%;"/>
						<input id="txtNoq.*" type="hidden" />
						<input id="recno.*" type="hidden" />
					</td>
					<!--<td><input id="chkEnda.*" type="checkbox"/></td>-->
					<td><input id="txtWorkno.*" type="text" class="txt c1"/></td>
					<td align="center">
						<input class="btn"  id="btnStk.*" type="button" value='.' style="width:1%;"  />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>