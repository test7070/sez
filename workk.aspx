<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
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
			
			q_desc = 1;
			q_tables = 's';
			var q_name = "workk";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2', 'txtCngno', 'txtWorkano','txtStation','txtStorein','txtStore'];
			var q_readonlys = ['txtWorkno'];
			var bbmNum = [];
			var bbsNum = [['txtMount', 12, 2, 1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			aPop = new Array(
				['txtStoreno', 'lblStoreno', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
				['txtStoreinno', 'lblStoreinno', 'store', 'noa,store', 'txtStoreinno,txtStorein', 'store_b.aspx'],
				['txtStationno', 'lblStation', 'station', 'noa,station,storeno,store', 'txtStationno,txtStation,txtStoreinno,txtStorein', 'station_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function mainPost() {
				bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd]];
				q_getFormat();
				q_mask(bbmMask);
				//0313當撥料時同時做調撥和領料動作
				//q_cmbParse("cmbTypea", q_getPara('workk.typea'));
				$('#txtCngno').click(function() {
					if (!emp($('#txtCngno').val())) {
						t_where = "noa='" + $('#txtCngno').val() + "'";
						q_box("cng.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'cng', "95%", "95%", q_getMsg('PopCng'));
					}
				});
				$('#txtWorkano').click(function() {
					if (!emp($('#txtWorkano').val())) {
						t_where = "noa='" + $('#txtWorkano').val() + "'";
						q_box("worka.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'worka', "95%", "95%", q_getMsg('PopWorka'));
					}
				});

				$('#btnWork').click(function() {
					var t_where = "1=1 and enda!=1 and isnull(tggno,'')=''";
					if (!emp($('#txtStationno').val())) {
						t_where += " and stationno='" + $('#txtStationno').val() + "'";
					}
					var t_bdate = $.trim($('#txtBdate').val());
					var t_edate = $.trim($('#txtEdate').val());
					if (t_bdate.length > 0 || t_edate.length > 0) {
						if (t_edate.length == 0)
							t_edate = r_picd
						t_where += " and cuadate between '" + t_bdate + "' and '" + t_edate + "'";
					}
					q_box("work_chk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('popWork'));
					//1030310讀取倉庫
					var t_where = "where=^^ ['" + q_date() + "','','') group by productno order by productno^^";
					q_gt('work_stk', t_where, 0, 0, 0, "work_stk", r_accy);
				});
				
				$('#btnWorkImport').click(function() {
					if(q_cur==1 || q_cur==2){
						if(q_chkEmpField([['txtStationno', q_getMsg('lblStation')],['txtStoreinno', q_getMsg('lblStoreinno')]])!=""){
							alert(q_chkEmpField([['txtStationno', q_getMsg('lblStation')],['txtStoreinno', q_getMsg('lblStoreinno')]]));
							return;
						}
						
						//106/08/30 改用txt 匯入
						var t_issemi=0;
						if($('#chkIssemi').prop('checked'))
							t_issemi=1;
						
						q_func('qtxt.query.workimport', 'workk.txt,workimport,' + encodeURI(q_date()) + ';' + encodeURI($('#txtStoreno').val()) 
						+ ';' + encodeURI($('#txtStoreinno').val()) + ';' + encodeURI($('#txtStationno').val()) + ';' + encodeURI($('#txtBdate').val())
						+ ';' + encodeURI($('#txtEdate').val()) + ';' + encodeURI(t_issemi));
						
						/*var t_where = "where=^^ ['" + q_date() + "','" + $('#txtStoreinno').val() + "','') where productno=b.productno ^^";
						
						var t_where1 = "1=1 and isnull(a.enda,0)!='1' and isnull(a.isfreeze,0)!= '1'";
						t_where1+=" and a.stationno='"+$('#txtStationno').val()+"' ";
						var t_bdate = $.trim($('#txtBdate').val());
						var t_edate = $.trim($('#txtEdate').val());
						if (t_bdate.length > 0 || t_edate.length > 0) {
							if (t_edate.length == 0)
								t_edate = r_picd
							
							t_where1+=" and a.cuadate between '"+t_bdate+"' and '"+t_edate+"' and a.noa like 'W[0-9]%' ";
						}
						if(!$('#chkIssemi').prop('checked')){
							t_where1+=" and exists(select * from ucc where noa=b.productno) "
						}
						
						t_where1 = "where[1]=^^ "+t_where1+" ^^";
						
						q_gt('workk_works', t_where+t_where1, 0, 0, 0, "", r_accy);*/
					}
				});

				$('#btnClose_div_stk').click(function() {
					$('#div_stk').toggle();
				});
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'work':
						b_ret = getb_ret();
						if (b_ret && (q_cur == 1 || q_cur == 2)) {
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

			function getInStr(HasNoaArray) {
				var NewArray = new Array();
				for (var i = 0; i < HasNoaArray.length; i++) {
					NewArray.push("'" + HasNoaArray[i].noa + "'");
				}
				return NewArray.toString();
			}

			var work_stk; //儲存目前倉庫庫存
			var workk_import;
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'workk_works':
						var as = _q_appendData("stkucc", "", true);
						for (var i = 0; i < as.length; i++) {
							as[i].unmount=q_sub(dec(as[i].mount),dec(as[i].gmount));
							as[i].diffmount=q_mul(q_sub(dec(as[i].smount),dec(as[i].unmount)),-1);
							if(as[i].diffmount<0){
								as.splice(i, 1);
								i--;
								continue;
							}
							if(as[i].unmount<0){
								as.splice(i, 1);
								i--;
							}
						}
						as.sort(function(a,b){
							if (a.productno< b.productno)
								return -1;
							if (a.productno > b.productno)
								return 1;
							return 0;}
						);
						
						workk_import=as;
						//讀其他倉庫數量
						if(emp($('#txtStoreno').val()))
							var t_where = "where=^^ ['" + q_date() + "','','') where storeno!='"+$('#txtStoreinno').val()+"' and (mount>0 or weight>0) group by productno order by productno ^^";
						else
							var t_where = "where=^^ ['" + q_date() + "','','') where storeno='"+$('#txtStoreno').val()+"' and (mount>0 or weight>0) group by productno order by productno ^^";
							
						q_gt('work_stk', t_where, 0, 0, 0, "workk_work_stk", r_accy);
						
						//q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtStyle,txtUnit,txtMount', as.length, as, 'productno,product,spec,style,unit,diffmount', '');
						break;
					case 'workk_work_stk':
						var as= _q_appendData("stkucc", "", true);
						for (var i = 0; i < workk_import.length; i++) {
							for (var j = 0; j < as.length; j++) {
								if(workk_import[i].productno==as[j].productno){
									workk_import[i].stkmount=as[j].mount;
									
									if(dec(workk_import[i].diffmount)>dec(as[j].mount))
										as[j].mount=0;
									else 
										as[j].mount=dec(as[j].mount)-dec(workk_import[i].diffmount)
									
									break;
								}
							}
							if(dec(workk_import[i].stkmount)<=0){
								workk_import.splice(i, 1);
								i--;
								continue;
							}
							
							if(dec(workk_import[i].stkmount)<dec(workk_import[i].diffmount))
								workk_import[i].diffmount=workk_import[i].stkmount;
						}
					 	
					 	q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtStyle,txtUnit,txtMount', workk_import.length, workk_import, 'productno,product,spec,style,unit,diffmount', '');
						break;
					case 'getstore':
						var as = _q_appendData("store", "", true);
						var t_storeno=false,t_storeinno=false;
						for (var i = 0; i < as.length; i++) {
							if($('#txtStoreno').val()==as[i].noa)
								t_storeno=true;
							if($('#txtStoreinno').val()==as[i].noa)
								t_storeinno=true;
						}
						
						if(!t_storeno){
							alert(q_getMsg('lblStoreno')+'不存在');
							break;
						}
						
						if(!t_storeinno){
							alert(q_getMsg('lblStoreinno')+'不存在');
							break;
						}
						
						btnOk();
						instore=true;
						break;
					case 'work_stk':
						work_stk = _q_appendData("stkucc", "", true);
						break;
					case 'work':
						if (emp($('#txtStationno').val())) {
							var as = _q_appendData("work", "", true);
							var t_stationno = '', t_station = '';
							for ( i = 0; i < as.length; i++) {
								if (as[i].stationno != '') {
									t_stationno = as[i].stationno;
									t_station = as[i].station;
									break;
								}
							}
							if (t_stationno.length != 0 || t_station.length != 0) {
								$('#txtStationno').val(t_stationno);
								$('#txtStation').val(t_station);
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
							for (var j = 0; j < work_stk.length; j++) {
								if (as[i].productno == work_stk[j].productno) {
									if (dec(work_stk[j].mount) - dec(as[i].mount) < 0) {
										if (t_worksno != as[i].noa) {
											if ( t_worksno = '')
												t_msg += "製令單：" + as[i].noa + "\n";
											else
												t_msg += "\n製令單：" + as[i].noa + "\n";
											t_worksno = as[i].noa;
										}
										t_msg += "原料：" + as[i].product + "，不足數量：" + (-1 * (dec(work_stk[j].mount) - dec(as[i].mount))).toString() + "\n";
										if (dec(work_stk[j].mount) > 0) {
											as[i].mount = work_stk[j].mount;
											work_stk[i].mount = 0;
										} else {
											as.splice(i, 1);
											i--;
										}
									} else {
										work_stk[j].mount = dec(work_stk[j].mount) - dec(as[i].mount);
									}
									break;
								}
							}
						}
						q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtMount,txtMemo,txtWorkno', as.length, as, 'productno,product,unit,mount,memo,noa', '');
						if (t_msg.length > 0)
							alert(t_msg);
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
					case 'btnOK_bbsstkchk':
						var as = _q_appendData("stkucc", "", true);
							if (as[0] != undefined) {
							//將之前領料的加回去
							for (var j = 0; j < abbsNow.length; j++) {
								if (abbsNow[j].productno == as[0].productno) {
									as[0].mount = dec(as[0].mount) + dec(abbsNow[j].mount);
								}
							}
							//判斷同一產品全部領料
							for (var i = 0; i < q_bbsCount; i++) {
								if ($('#txtProductno_' + i).val() == as[0].productno) {
									as[0].mount = dec(as[0].mount) - dec($('#txtMount_' + i).val())
								}
							}
	
							//寫入訊息
							if (as[0].mount < 0) {
								btnok_msg += as[0].product + "數量不足：" + (-1 * dec(as[0].mount)).toString() + "\n";
							}
						}else{
							alert($('#txtStore').val()+'無產品庫存!!');
							Unlock();
							break;
						}

						stkchkcount2++;
						if (stkchkcount == stkchkcount2)
							btnok_bbsstkchk = true;

						if (btnok_bbsstkchk && btnok_msg.length == 0) {
							sum();
							instore=false;
							if (q_cur == 1)
								$('#txtWorker').val(r_name);
							else
								$('#txtWorker2').val(r_name);

							var t_noa = trim($('#txtNoa').val());
							var t_date = trim($('#txtDatea').val());

							if (t_noa.length == 0 || t_noa == "AUTO")
								q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workk') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
							else
								wrServer(t_noa);
						}
						if (btnok_bbsstkchk && btnok_msg.length > 0) {
							alert(btnok_msg);
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				} /// end switch
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				q_func('qtxt.query.c0', 'workk.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
			}

			var btnok_bbsstkchk = false, stkchkcount = 0, stkchkcount2 = 0, btnok_msg = '';
			var instore=false;
			function btnOk() {
				var t_err = '';
				t_err = q_chkEmpField([['txtDatea', q_getMsg('lblDatea')], ['txtStationno', q_getMsg('lblStation')]
				, ['txtBdate', q_getMsg('lblBdate')], ['txtEdate', q_getMsg('lblBdate')]
				, ['txtStoreno', q_getMsg('lblStoreno')], ['txtStoreinno', q_getMsg('lblStoreinno')]]);

				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				//1030627 判斷倉庫存在才能存檔
				if(!instore){
					q_gt('store', 'where=^^ 1=1 ^^', 0, 0, 0, "getstore", r_accy);
					return;
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
						if (bbs_tmp[j].productno == $('#txtProductno_' + i).val() && bbs_tmp[j].storeno == $('#txtStoreno').val()) {
							bbs_repeat = true;
						}
						if (emp($('#txtProductno_' + i).val()))
							bbs_repeat = true;
					}
					if (!bbs_repeat) {
						bbs_tmp.push({
							productno : $('#txtProductno_' + i).val(),
							storeno : $('#txtStoreno').val()
						});
					}
				}

				for (var i = 0; i < bbs_tmp.length; i++) {
					var t_where = "where=^^ ['" + q_date() + "','','" + bbs_tmp[i].productno + "') where storeno='" + bbs_tmp[i].storeno + "' ^^";
					q_gt('calstk', t_where, 0, 0, 0, "btnOK_bbsstkchk", r_accy);
					stkchkcount++;
				}

				if (stkchkcount == 0) {
					instore=false;
					sum();
					if (q_cur == 1)
						$('#txtWorker').val(r_name);
					else
						$('#txtWorker2').val(r_name);

					var t_noa = trim($('#txtNoa').val());
					var t_date = trim($('#txtDatea').val());

					if (t_noa.length == 0 || t_noa == "AUTO")
						q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workk') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
					else
						wrServer(t_noa);
				}

			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('workk_s.aspx', q_name + '_s', "500px", "420px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtBdate').val(q_date());
				$('#txtEdate').val(q_cdn(q_date(),10));
				$('#txtDatea').focus();
			}

			function q_popPost(id) {
				switch (id) {
					case 'txtStationno':
						$('#txtBdate').focus();
						break;
					default:
						break;
				}
			}
			
			
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
			}

			function btnPrint() {
				q_box("z_workkp.aspx" + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;
				xmlSql = '';
				if (q_cur == 2)
					xmlSql = q_preXml();

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			var mouse_point;
			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#txtWorkno_' + i).click(function() {
							t_IdSeq = -1;
							/// 要先給 才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtWorkno_' + b_seq).val())) {
								t_where = "noa='" + $('#txtWorkno_' + b_seq).val() + "'";
								q_box("work.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('PopWork'));
							}
						});
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
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
				var hasSpec = q_getPara('sys.isspec');
				var isSpec = (hasSpec.toString()=='1'?$('.isSpec').show():$('.isSpec').hide());
			}

			function bbsSave(as) {
				if (!as['productno']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['datea'] = abbm2['datea'];
				as['stationno'] = abbm2['stationno'];
				as['storeno'] = abbm2['storeno'];
				as['storeinno'] = abbm2['storeinno'];
				as['typea'] = abbm2['typea'];

				return true;
			}

			function sum() {
				var t1 = 0, t_unit, t_mount = 0, t_hours = 0;
				for (var j = 0; j < q_bbsCount; j++) {

				}
			}

			function refresh(recno) {
				_refresh(recno);
				$('#div_stk').hide();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
				var hasSpec = q_getPara('sys.isspec');
				var isSpec = (hasSpec.toString()=='1'?$('.isSpec').show():$('.isSpec').hide());
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
				//_btnDele();
				if (!confirm(mess_dele))
					return;
				q_cur = 3;
				q_func('qtxt.query.c2', 'workk.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
			}

			function btnCancel() {
				_btnCancel();
			}
			
			//0325 拿掉 workano 不產生領料
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.c0':
						q_func('qtxt.query.c1', 'workk.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';1');
						break;
					case 'qtxt.query.c1':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							abbm[q_recno]['cngno'] = as[0].cngno;
							$('#txtCngno').val(as[0].cngno);
						}
						break;
					case 'qtxt.query.c2':
						_btnOk($('#txtNoa').val(), bbmKey[0], ( bbsHtm ? bbsKey[1] : ''), '', 3)
						break;
					case 'qtxt.query.workimport':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							for (var i = 0; i < q_bbsCount; i++) {
								$('#btnMinus_' + i).click()
							}
							q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtStyle,txtUnit,txtMount', as.length, as, 'productno,product,spec,style,unit,diffmount', '');	
						}
						break;
					default:
						break;
				}
			}

		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
				width: 1260px;
			}
			.dview {
				float: left;
				width: 360px;
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
				width: 900px;
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
				width: 40%;
				float: right;
			}
			.txt.c3 {
				width: 59%;
				float: left;
			}
			.txt.c5 {
				width: 98%;
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
			.tbbm td input[type="button"] {
				float: left;
				width: auto;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
			}
			.num {
				text-align: right;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.tbbm select {
				font-size: medium;
			}
			.dbbs {
				width: 1060px;
			}
			.tbbs a {
				font-size: medium;
			}
			input[type="text"], input[type="button"] {
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
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:40%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:30%"><a id='vewStation'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='station'>~station</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height: 1px;">
						<td width="130px"> </td>
						<td width="255px"> </td>
						<td width="130px"> </td>
						<td width="255px"> </td>
						<td width="130px"> </td>
					</tr>
					<!--<tr>
					<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
					<td><select id="cmbTypea" class="txt c1"></select></td>
					</tr>-->
					<tr>
						<td class="td1"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td2"><input id="txtDatea" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td4"><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblStation' class="lbl btn"> </a></td>
						<td class="td2">
							<input id="txtStationno" type="text" class="txt c2"/>
							<input id="txtStation" type="text" class="txt c3"/>
						</td>
						<td><span> </span><a id='lblBdate' class="lbl"> </a></td>
						<td>
							<input id="txtBdate" type="text" class="txt c3" style="width: 120px;"/>
							<a style="float: left;">~</a>
							<input id="txtEdate" type="text" class="txt c3" style="width: 120px;"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblStoreno' class="lbl btn"> </a></td>
						<td class="td2">
							<input id="txtStoreno" type="text" class="txt c2"/>
							<input id="txtStore" type="text" class="txt c3"/>
						</td>
						<td class="td3"><span> </span><a id='lblStoreinno' class="lbl btn"> </a></td>
						<td class="td4">
							<input id="txtStoreinno" type="text" class="txt c2"/>
							<input id="txtStorein" type="text" class="txt c3"/>
						</td>
						<td class="td5"><input id="btnWorkImport" type="button" class="txt c5"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td class="td2" colspan="3"><input id="txtMemo" type="text" class="txt c5"/></td>
						<td><input id="chkIssemi" type="checkbox"><a id="lblIssemi"> </a></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCngno' class="lbl"> </a></td>
						<td class="td2"><input id="txtCngno" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td4">
							<input id="txtWorker" type="text" class="txt c1" style="width: 49%;"/>
							<input id="txtWorker2" type="text" class="txt c1" style="width: 49%;"/>
						</td>
						<!--<td class="td3"><span> </span><a id='lblWorkano' class="lbl"> </a></td>
						<td class="td4"><input id="txtWorkano" type="text" class="txt c1"/></td>-->
					</tr>
					<!--<tr>
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2"><input id="txtWorker" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td class="td4"><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>-->
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:30px;">
						<input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:220px;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:220px;"><a id='lblProduct_s'> </a></td>
					<td style="width:95px;" align="center" class="isStyle"><a id='lblStyle'> </a></td>
					<td align="center" style="width:40px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:120px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:220px;"><a id='lblUno_s'> </a></td>
					<td align="center" style="width:250px"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblStk_s'> </a></td>
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
					<td class="isStyle"><input id="txtStyle.*" type="text" class="txt c1"/></td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtUno.*" type="text" class="txt c1"/></td>
					<td>
						<input id="txtMemo.*" type="text" class="txt c1"/>
						<input id="txtNoq.*" type="hidden" />
					</td>
					<td align="center">
						<input class="btn" id="btnStk.*" type="button" value='.' style="width:1%;" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
