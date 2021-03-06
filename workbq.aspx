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
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_desc = 1;
			q_tables = 's';
			var q_name = "workbq";
			var decbbs = ['weight', 'mount', 'gmount', 'emount', 'errmount', 'born'];
			var decbbm = ['mount', 'inmount', 'errmount', 'rmount', 'price', 'hours'];
			var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2','txtStation','txtStationg','txtStore','txtAccno','txtWorkbno','txtWorkano'];
			var q_readonlys = ['txtOrdeno', 'txtNo2', 'txtNoq', 'txtWorkno','txtWorkfno','txtWorkfnoq','txtStore','txtWk_mount','txtWk_inmount','txtWk_unmount'];
			var bbmNum = [];
			var bbsNum = [
				['txtBorn', 15, 2, 1], ['txtMount', 15, 2, 1], ['txtPrice', 15, 2, 1],
				['txtTotal', 15, 0, 1], ['txtErrmount', 15, 2, 1], ['txtWmount', 15, 2, 1],['txtWvalue', 15, 2, 1],
				['txtOutmount', 15, 2, 1], ['txtInmount', 15, 2, 1], ['txtBkmount', 15, 2, 1]
			];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = '';
			aPop = new Array(
				['txtStationno', '', 'station', 'noa,station,storeno,store', 'txtStationno,txtStation,txtStoreno,txtStore', 'station_b.aspx'],
				['txtStationgno', 'lblStationg', 'stationg', 'noa,namea', 'txtStationgno,txtStationg', 'stationg_b.aspx'],
				['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
				['txtStoreno_', 'btnStore_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'],
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
				mainForm(1);
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm], ['txtBdate', r_picd], ['txtEdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbQcresult", q_getPara('workq.qcresult'));
				q_cmbParse("cmbQcresult", q_getPara('workq.qcresult'),'s');
				
				$('#lblAccno').click(function() {
					q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "97%", "1054px", q_getMsg('btnAccc'), true);
				});
				
				$('#lblStation').click(function() {
					if (q_cur == 1 || q_cur == 2) {
						if(emp($('#txtStationgno').val()))
							q_box("station_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";;;", 'station', "420px", "", q_getMsg('popStation'));
						else
							q_box("station_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";stationgno='"+$('#txtStationgno').val()+"';;", 'station', "420px", "", q_getMsg('popStation'));
					}
				});
				
				/*$('#lblStationmore').click(function() {
					if (q_cur == 1 || q_cur == 2) {
						if(emp($('#txtStationgno').val()))
							q_box("station_b2.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";;;", 'stationmore', "420px", "", q_getMsg('popStation'));
						else
							q_box("station_b2.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";stationgno='"+$('#txtStationgno').val()+"';;", 'stationmore', "420px", "", q_getMsg('popStation'));
					}
				});*/
				
				//1020729 排除已完全入庫&&完全未領料的成品
				$('#btnOrdes').click(function() {
					if (q_cur == 1 || q_cur == 2) {
						if (!emp($('#txtStationno').val())) {
							//var t_where = "enda!=1 and noa+'_'+no2 in (select a.ordeno+'_'+a.no2 from view_work a left join view_works b on a.noa=b.noa where (a.tggno is null or a.tggno='') and a.stationno='" + $('#txtStationno').val() + "' and (a.mount>a.inmount and b.gmount>0)) ";
							var t_where = "isnull(enda,0)!=1 and charindex(noa+'-'+no2,(select a.ordeno+',' from view_work a left join view_works b on a.noa=b.noa ";
							//t_where+=" where isnull(a.enda,0)!=1 and isnull(a.isfreeze,0)!=1 and len(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(SUBSTRING(a.noa,2,1),'0',''),'1',''),'2',''),'3',''),'4',''),'5',''),'6',''),'7',''),'8',''),'9',''))=0";
							t_where+=" where isnull(a.enda,0)!=1 and isnull(a.isfreeze,0)!=1 and  a.noa like 'W[0-9]%' ";
							t_where+=" and (a.tggno is null or a.tggno='')  and a.stationno='" + $('#txtStationno').val() + "' and (a.mount>a.inmount and b.gmount>0) and a.ordeno!='' group by a.ordeno FOR XML path('')))>0";
						} else {
							//var t_where = "enda!=1 and noa+'_'+no2 in (select a.ordeno+'_'+a.no2 from view_work a left join view_works b on a.noa=b.noa where (a.tggno is null or a.tggno='') and a.mount>a.inmount group by a.ordeno,a.no2) ";
							var t_where = "isnull(enda,0)!=1 and charindex(noa+'-'+no2,(select a.ordeno+',' from view_work a left join view_works b on a.noa=b.noa ";
							//t_where+=" where isnull(a.enda,0)!=1 and isnull(a.isfreeze,0)!=1 and len(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(SUBSTRING(a.noa,2,1),'0',''),'1',''),'2',''),'3',''),'4',''),'5',''),'6',''),'7',''),'8',''),'9',''))=0";
							t_where+=" where isnull(a.enda,0)!=1 and isnull(a.isfreeze,0)!=1 and noa like 'W[0-9]%' ";
							t_where+=" and (a.tggno is null or a.tggno='')  and (a.mount>a.inmount and b.gmount>0) and a.ordeno!='' group by a.ordeno FOR XML path('')))>0";						
						}
						q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "95%", q_getMsg('popOrdes'));
					}
				});
				
				//1020729 排除已完全入庫&&完全未領料的成品,0816取消但會顯示狀態
				$('#btnWork').click(function() {
					if(!emp($('#txtWorkno').val()) && $('#txtWorkno').val().substr(1,1).replace(/[^\d]/g,'')==''){
						alert("【"+$('#txtWorkno').val()+"】是模擬製令不得入庫!!");
						return;
					}
					
					if(!emp($('#txtWorkno').val())){
						var t_where = "where=^^ noa ='" + $('#txtWorkno').val() + "' and isnull(enda,0)!=1 and isnull(isfreeze,0)!=1 and (tggno is null or tggno='')^^";
						q_gt('work', t_where, 0, 0, 0, "", r_accy);
					}else{
						var t_where = '( 1=1 ';
						//var t_where += "and enda!=1 and (tggno is null or tggno='') and noa in (select a.noa from work102 a left join works102 b on a.noa=b.noa where (a.mount>a.inmount and b.gmount>0))";
						t_where += "and isnull(enda,0)!=1 and isnull(isfreeze,0)!=1 and (tggno is null or tggno='')";
						
						if (!emp($('#txtStationno').val())) 
							t_where += " and stationno='" + $('#txtStationno').val() + "' ";
							
						var workno = $.trim($('#txtWorkno').val());
						if(workno.length > 0 ){
							t_where += " and noa=N'"+workno+"'";
						}
						//1030310 加入應完工日的條件
						var t_bdate = $.trim($('#txtBdate').val());
						var t_edate = $.trim($('#txtEdate').val());
						if (t_bdate.length > 0 || t_edate.length > 0) {
							if (t_edate.length == 0)
								t_edate = r_picd
							t_where += " and uindate between '" + t_bdate + "' and '" + t_edate + "'";
						}
						
						//t_where += " and len(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(SUBSTRING(noa,2,1),'0',''),'1',''),'2',''),'3',''),'4',''),'5',''),'6',''),'7',''),'8',''),'9',''))=0 ";
						if (!emp($('#txtStationgno').val())) 
							t_where+=" and stationno in (select noa from station where stationgno='"+$('#txtStationgno').val()+"')";
							
						if (!emp($('#textStationno').val())) 
							t_where+=" and charindex(stationno,'"+$('#textStationno').val()+"')>0";
						
						t_where+=" and noa like 'W[0-9]%' )";
						//原先的資料
						t_where += " or noa in (select workno from view_workbqs where noa='" + $('#txtNoa').val() + "')";
	
						q_box("work_chk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('popWork'));
					}
				});

				$('#btnClose_div_stk').click(function() {
					$('#div_stk').toggle();
				});
				
				$('#txtWorkbno').click(function(){
					var thisVal = $.trim($(this).val());
					if(thisVal.length > 0){
						var t_where = "noa='" + thisVal + "'";
						q_box("workb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'workb', "95%", "95%", q_getMsg('popWorkb'));
					}					
				});
				
				$('#txtWorkano').click(function(){
					var thisVal = $.trim($(this).val());
					if(thisVal.length > 0){
						var t_where = "noa='" + thisVal + "'";
						q_box("worka.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'worka', "95%", "95%", q_getMsg('popWorka'));
					}					
				});
				
				$('#cmbQcresult').change(function() {
					for(var i=0;i<q_bbsCount;i++){
						if(!emp($('#txtProductno_'+i).val())){
							$('#cmbQcresult_'+i).val($('#cmbQcresult').val())
							if($('#cmbQcresult_'+i).val()=='AC')
								$('#txtMount_'+i).val($('#txtBorn_'+i).val())
							else
								$('#txtMount_'+i).val(0)
						}
					}
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
							if (!b_ret || b_ret.length == 0){
								b_pop = '';
								return;
							}
							if (q_cur == 1 || q_cur == 2) {
								for (var i = 0; i < q_bbsCount; i++) {
									$('#btnMinus_' + i).click();
								}
								for (var i = 0; i < b_ret.length; i++) {
									var t_where = "where=^^ ordeno ='" + b_ret[i].noa + "' and no2='" + b_ret[i].no2 + "' and (len(tggno)=0 or len(stationno)>0) ";
									t_where+=" and isnull(enda,0)!=1 and isnull(isfreeze,0)!=1 and mount>inmount"; 
									//t_where+=" and len(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(SUBSTRING(noa,2,1),'0',''),'1',''),'2',''),'3',''),'4',''),'5',''),'6',''),'7',''),'8',''),'9',''))=0";
									t_where+=" and noa like 'W[0-9]%' ";
									
									if (!emp($('#txtStationno').val()))
										t_where += " and stationno='" + $('#txtStationno').val() + "'";
										
									t_where += "^^";
									q_gt('work', t_where, 0, 0, 0, "", r_accy);
								}
							}
						}
						break;
					case 'work':
						b_ret = getb_ret();
						if (!b_ret || b_ret.length == 0){
							b_pop = '';
							return;
						}
						if (b_ret && (q_cur == 1 || q_cur == 2)) {
							$('#txtTggno').val(b_ret[0].tggno);
							$('#txtTgg').val(b_ret[0].comp);
							var t_where = "where=^^ noa in(" + getInStr(b_ret) + ")^^";
							q_gt('work', t_where, 0, 0, 0, "", r_accy);
						}
						break;
					case 'stationmore':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0){
								b_pop = '';
								return;
							}
							var stationno_more='';
							for (var i = 0; i < b_ret.length; i++) {
								stationno_more=stationno_more+(stationno_more.length>0?',':'')+b_ret[i].noa;
							}
							$('#textStationno').val(stationno_more);
						}
						break;
					case 'station':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0){
								b_pop = '';
								return;
							}
							var t_where = "where=^^ noa ='"+b_ret[0].noa+"' ^^";
							q_gt('station', t_where, 0, 0, 0, "", r_accy);
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
						var as = _q_appendData("work", "", true);
						var t_stationno = '', t_station = '';
						for ( i = 0; i < as.length; i++) {
							if (as[i].stationno != '') {
								t_stationno = as[i].stationno;
								t_station = as[i].station;
							}
							as[i].unmount=q_sub(dec(as[i].mount),dec(as[i].inmount))
						}
						q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtStyle,txtUnit,txtWk_mount,txtWk_inmount,txtWk_unmount,txtBorn,txtOrdeno,txtNo2,txtMemo,txtPrice,txtWorkno'
						, as.length, as, 'productno,product,spec,style,unit,mount,inmount,unmount,unmount,ordeno,no2,memo,price,noa', '');
						if (t_stationno.length != 0 || t_station.length != 0) {
							$('#txtStationno').val(t_stationno);
							$('#txtStation').val(t_station);
						}
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
										var work_inmount = dec(as[j].inmount) + dec($('#txtMount_' + i).val()) + dec($('#txtInmount_' + i).val()) - dec($('#txtOutmount_' + i).val());
										//work已入庫數量+要入庫的數量+移入-移出數量
										var works_mounts = dec(as[j].mounts);
										//works領料需求數量
										var works_gmounts = dec(as[j].gmounts);
										//works已領料數量
										var work_rate = work_inmount / work_mount;
										//入庫比率
										var works_rate = works_gmounts / works_mounts;
										//領料比率
										if (work_rate - works_rate > 0.01) {//誤差相差0.01
											pickerror = $('#txtProduct_' + i).val();
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
							alert(pickerror + ' 入庫與領料比例不符!!');
						}
						break;
					case 'station':
						var as = _q_appendData("station", "", true);
						if (as[0] != undefined) {
							$('#txtStationno').val(as[0].noa);
							$('#txtStation').val(as[0].station);
							$('#txtStoreno').val(as[0].storeno);
							$('#txtStore').val(as[0].store);
						}
						changeqphr();
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			//檢查領料是否等比例 //1030325流程變成入庫後產生領料單因此檢查領料比例拿掉
			var checkok = true;//要判斷改回false
			function btnOk() {
				t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtStationno', q_getMsg('lblStation')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				if (emp($('#txtMon').val()))
					$('#txtMon').val($('#txtDatea').val().substr(0, 6));

				/* 判斷暫時拿掉
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
				} else {}
					checkok = false;
				*/
				//如果表身倉庫沒填，表頭倉庫帶入
				for (var i = 0; i < q_bbsCount; i++) {
					if (emp($('#txtStoreno_' + i).val())) {
						$('#txtStoreno_' + i).val($('#txtStoreno').val());
						$('#txtStore_' + i).val($('#txtStore').val());
					}
				}
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
					
				var t_date = $('#txtDatea').val();
				
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workbq') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('workbq_s.aspx', q_name + '_s', "510px", "380px", q_getMsg("popSeek"));
			}

			var mouse_point;
			function bbsAssign() {
				_bbsAssign();
				for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					$('#btnMinus_' + j).click(function() {
						btnMinus($(this).attr('id'));
					});
					
					$('#btnStk_' + j).mousedown(function(e) {
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
					
					$('#cmbQcresult_' + j).click(function() {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if($('#cmbQcresult_'+b_seq).val()=='AC')
							$('#txtMount_'+b_seq).val($('#txtBorn_'+b_seq).val())
						else
							$('#txtMount_'+b_seq).val(0)
					});
					
					$('#combQphr_'+j).change(function() {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						$('#txtErrmemo_'+b_seq).val($('#combQphr_'+b_seq).find("option:selected").text());
					});
				}
				HideField();
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtMon').val(q_date().substr(0, 6));
				$('#txtDatea').focus();
				$('#cmbTaxtype').val('1');
				Fieldchange();
				changeqphr();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtProduct').focus();
				Fieldchange();
				changeqphr();
			}

			function btnPrint() {
				q_box('z_workbqp.aspx' + "?;;;noa=" + $.trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
				
				/*if (q_cur == 1 || (emp($('#txtWorkano').val()) && emp($('#txtWorkbno').val())))
					q_func('qtxt.query.c0', 'workbq.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
				else {
					//處理worka b 內容
					if(!emp($('#txtWorkano').val()))
						q_func('worka_post.post.a1', r_accy + ',' + $('#txtWorkano').val() + ',0');
					else
						q_func('workb_post.post.a1', r_accy + ',' + $('#txtWorkbno').val() + ',0');
				}*/
			}

			function bbsSave(as) {
				if (!as['productno'] && !as['product']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['datea'] = abbm2['datea'];
				as['tggno'] = abbm2['tggno'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				$('#div_stk').hide();
				HideField();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#btnWork').attr('disabled', 'disabled');
					$('#btnOrdes').attr('disabled', 'disabled');
				} else {
					$('#btnWork').removeAttr('disabled');
					$('#btnOrdes').removeAttr('disabled');
				}
				HideField();
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
				/*if (!confirm(mess_dele))
					return;
				q_cur = 3;
				//處理worka內容
				if(emp($('#txtWorkano').val()) && emp($('#txtWorkbno').val()))
					q_func('qtxt.query.c2', 'workbq.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
				else{
					if(!emp($('#txtWorkano').val()))
						q_func('worka_post.post.a2', r_accy + ',' + $('#txtWorkano').val() + ',0');
					else
						q_func('workb_post.post.a2', r_accy + ',' + $('#txtWorkbno').val() + ',0');
				}*/
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
					case 'txtStationno':
						changeqphr();
						break;
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				abbm[q_recno]['workano'] = xmlString.split(";")[0];
				abbm[q_recno]['workbno'] = xmlString.split(";")[1];
				/*var t_noa = $.trim($('#txtNoa').val());
				if((t_noa.length>0) && (r_name.length > 0)){
					Lock();
					q_func('qtxt.query.workbq', 'workbq.txt,workbqsave,' + encodeURI(t_noa) + ';' + encodeURI(r_name));
				}*/
			}

			function q_funcPost(t_func, result) {
				switch(t_func) {
					/*case 'worka_post.post.a1':
						if(!emp($('#txtWorkbno').val()))
							q_func('workb_post.post.a1', r_accy + ',' + $('#txtWorkbno').val() + ',0');
						else
							q_func('qtxt.query.c0', 'workbq.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
						break;
					case 'worka_post.post.a2':
						if(!emp($('#txtWorkbno').val()))
							q_func('workb_post.post.a2', r_accy + ',' + $('#txtWorkbno').val() + ',0');
						else
							q_func('qtxt.query.c2', 'workbq.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
						break;	
					case 'workb_post.post.a1':
							q_func('qtxt.query.c0', 'workbq.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
						break;
					case 'workb_post.post.a2':
							q_func('qtxt.query.c2', 'workbq.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
						break;
					case 'qtxt.query.c0':
						q_func('qtxt.query.c1', 'workbq.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';1');
						break;
					case 'qtxt.query.c1':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							abbm[q_recno]['workano'] = as[0].workano;
							abbm[q_recno]['workbno'] = as[0].workbno;
							$('#txtWorkano').val(as[0].workano);
							$('#txtWorkbno').val(as[0].workbno);
							//處理worka b內容
							if(!emp(as[0].workano))
								q_func('worka_post.post', r_accy + ',' + $('#txtWorkano').val() + ',1');
							if(!emp(as[0].workbno))
								q_func('workb_post.post', r_accy + ',' + $('#txtWorkbno').val() + ',1');
						}
						break;
					case 'qtxt.query.c2':
						_btnOk($('#txtNoa').val(), bbmKey[0], ( bbsHtm ? bbsKey[1] : ''), '', 3)
						break;
					default:
						break;*/
					/*case 'qtxt.query.workbq':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							var workbno = $.trim(as[0].workbno);
							abbm[q_recno]['workbno'] = as[0].workbno;
							$('#txtWorkbno').val(as[0].workbno);
							if(workbno.length > 0){
								q_func('workb_post.post',r_accy+','+workbno+',0');
								q_func('workb_post.post',r_accy+','+workbno+',1');
							}
						}
						Unlock();
						break;*/
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
			
			function HideField() {
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
				var hasSpec = q_getPara('sys.isspec');
				var isSpec = (hasSpec.toString()=='1'?$('.isSpec').show():$('.isSpec').hide());
				
				if(!(q_getPara('sys.project').toUpperCase()=='JO'|| q_getPara('sys.project').toUpperCase()=='AD')){
					$('.JO').hide();
				}else{
					$('.JO').show();
				}
				
			}
			function Fieldchange() {
				if(!r_modi && r_rank<'7'){
					$('#cmbQcresult').attr('disabled', 'disabled');
					for(var i=0;i<q_bbsCount;i++){
						$('#cmbQcresult_'+i).attr('disabled', 'disabled');
						$('#txtMount_'+i).attr('disabled', 'disabled');
						$('#btnStore_'+i).attr('disabled', 'disabled');
						$('#txtStoreno_'+i).attr('disabled', 'disabled');
						$('#txtBkmount_'+i).attr('disabled', 'disabled');
						$('#txtWmount_'+i).attr('disabled', 'disabled');
						$('#txtInmount_'+i).attr('disabled', 'disabled');
						$('#txtOutmount_'+i).attr('disabled', 'disabled');
						$('#txtErrmount_'+i).attr('disabled', 'disabled');
						$('#txtErrmemo_'+i).attr('disabled', 'disabled');
					}
				}
			}
			
			function changeqphr() {
				q_gt('station', "where=^^noa='"+$('#txtStationno').val()+"'^^", 0, 0, 0, "getPart",r_accy,1);
				var as1 = _q_appendData("station", "", true);
				var t_partno='';
				if (as1[0] != undefined) {
					t_partno=as1[0].partno;
				}
				
				if(t_partno.length>0){
					q_gt('reason', "where=^^partno='"+t_partno+"' and typea='workbq'^^", 0, 0, 0, "getreason",r_accy,1);
				}else{
					q_gt('reason', "where=^^partno='' and typea='workbq'^^", 0, 0, 0, "getreason",r_accy,1);
				}
				var as2 = _q_appendData("reasons", "", true);
				var t_item = "@";
				for (var i = 0; i < as2.length; i++) {
					t_item = t_item + (t_item.length > 0 ? ',' : '') + as2[i].reason;
				}
				
				for(var i=0;i<q_bbsCount;i++){
					$('#combQphr_'+i).text('');
					q_cmbParse("combQphr_"+i, t_item);
				}
			}
		</script>
		<style type="text/css">
			.tview {
				FONT-SIZE: 12pt;
				COLOR: Blue;
				background: #FFCC00;
				padding: 3px;
				TEXT-ALIGN: center
			}
			.tbbm {
				FONT-SIZE: 12pt;
				COLOR: blue;
				TEXT-ALIGN: left;
				border-color: white;
				width: 98%;
				border-collapse: collapse;
				background: #cad3ff;
			}
			.tbbs {
				FONT-SIZE: 12pt;
				COLOR: blue;
				TEXT-ALIGN: left;
				BORDER: 1PX LIGHTGREY SOLID;
				width: 2230px;
				height: 98%;
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
				width: 95%;
			}
			.txt.c2 {
				width: 50%;
			}
			.num {
				text-align: right;
			}
			input[type="text"], input[type="button"], select {
				font-size: medium;
			}
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				float: left;
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
		<div id="dmain" style="width: 1260px;">
			<!--#include file="../inc/toolbar.inc"-->
			<div class="dview" id="dview" style="float: left; width:32%;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:18%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:20%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:30%"><a id='vewStation'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='station,4'>~station,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 68%;float:left">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='0'>
					<tr style="height: 1px;">
						<td width="120px"> </td>
						<td width="203px"> </td>
						<td width="120px"> </td>
						<td width="203px"> </td>
						<td width="120px"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStation' class="lbl btn"> </a></td>
						<td>
							<input id="txtStationno" type="text" class="txt" style='width:45%;'/>
							<input id="txtStation" type="text" class="txt" style='width:48%;'/>
						</td>
						<td><span> </span><a id='lblStationg' class="lbl btn"> </a></td>
						<td>
							<input id="txtStationgno" type="text" class="txt" style='width:45%;'/>
							<input id="txtStationg" type="text" class="txt" style='width:48%;'/>
						</td>
					</tr>
					<!--<tr>
						<td><span> </span><a id='lblStationmore' class="lbl btn">多選線別</a></td>
						<td colspan="3"><input id="textStationno" type="text" class="txt c1" style="width: 98%;"/></td>
					</tr>-->
					<tr>
						<td><span> </span><a id='lblBdate' class="lbl"> </a></td>
						<td>
							<input id="txtBdate" type="text" class="txt c3" style="width: 98px;"/>
							<a style="float: left;">~</a>
							<input id="txtEdate" type="text" class="txt c3" style="width: 98px;"/>
						</td>
						<td><span> </span><a id='lblWorkno' class="lbl"> </a></td>
						<td><input id="txtWorkno" type="text" class="txt c1"/></td>
						<td><input type="button" id="btnWork"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblQcresult' class="lbl"> </a></td>
						<td><select id="cmbQcresult" class="txt c1"> </select></td>
						<td><span> </span><a id='lblStore' class="lbl btn"> </a></td>
						<td>
							<input id="txtStoreno" type="text" class="txt" style='width:45%;'/>
							<input id="txtStore" type="text" class="txt" style='width:48%;'/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorkbno' class="lbl"> </a></td>
						<td><input id="txtWorkbno" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorkano' class="lbl"> </a></td>
						<td><input id="txtWorkano" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td><input type="button" id="btnOrdes"></td>						
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan='4'><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1'>
				<tr style='color:White; background:#003366;' >
					<td style="width:30px;" align="center">
						<input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
					</td>
					<td style="width:180px;" align="center"><a id='lblProductnos'> </a></td>
					<td style="width:200px;" align="center"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:95px;" class="isStyle"><a id='lblStyle'> </a></td>
					<td style="width:40px;" align="center"><a id='lblUnit'> </a></td>
					<td style="width:100px;" align="center"><a id='lblWk_mounts'> </a></td>
					<td style="width:100px;" align="center"><a id='lblWk_inmounts'> </a></td>
					<td style="width:100px;" align="center"><a id='lblWk_unmounts'> </a></td>
					<td style="width:100px;" align="center"><a id='lblBorn'> </a></td>
					<td style="width:120px;" align="center"><a id='lblMounts'> </a></td>
					<td style="width:100px;" align="center"><a id='lblQcresults'> </a></td>
					<td style="width:150px;" align="center"><a id='lblStores'> </a></td>
					<td style="width:100px;" align="center"><a id='lblBkmounts'> </a></td>
					<td style="width:150px;" align="center"><a id='lblWmounts'> </a><a id='lblWreas_jo' class="JO">/原因</a></td>
					<td style="width:150px;" align="center" class="JO"><a id='lblWvalues_jo' class="JO">殘值</a><a id='lblMethods_jo' class="JO">/處理方法</a></td>
					<td style="width:100px;" align="center"><a id='lblInmount_s'> </a></td>
					<td style="width:100px;" align="center"><a id='lblOutmount_s'> </a></td>
					<td style="width:150px;" align="center"><a id='lblErrmount'> </a></td>
					<td style="width:200px;" align="center"><a id='lblMemos'> </a></td>
					<td style="width:200px;" align="center"><a id='lblWorknos'> </a></td>
					<!--<td style="width:200px;" align="center"><a id='lblWorkfnos'> </a></td>-->
					<td style="width:40px;" align="center"><a id='lblStks'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<!--1020702製造業通常只用到數量，所以重量隱藏，並將生產數量改為報廢數量-->
					<td><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td>
						<input class="txt" id="txtProductno.*" type="text" style="width:80%;" />
						<input class="btn" id="btnProductno.*" type="button" value='.' style="width:16%;" />
					</td>
					<td>
						<input class="txt c1" id="txtProduct.*" type="text"/>
						<input id="txtSpec.*" type="text" class="txt c1 isSpec"/>
					</td>
					<td class="isStyle"><input id="txtStyle.*" type="text" class="txt c1"/></td>
					<td><input class="txt c1" id="txtUnit.*" type="text"/></td>
					<td><input class="txt c1 num" id="txtWk_mount.*" type="text"/></td>
					<td><input class="txt c1 num" id="txtWk_inmount.*" type="text"/></td>
					<td><input class="txt c1 num" id="txtWk_unmount.*" type="text"/></td>
					<td><input class="txt c1 num" id="txtBorn.*" type="text"/></td>
					<td><input class="txt c1 num" id="txtMount.*" type="text"/></td>
					<td><select id="cmbQcresult.*" class="txt c1"> </select></td>
					<td>
						<input class="btn" id="btnStore.*" type="button" value='.' style="width:1%;float: left;" />
						<input id="txtStoreno.*" type="text" class="txt c2" style="width: 30%;"/>
						<input id="txtStore.*" type="text" class="txt c3" style="width: 50%;"/>
					</td>
					<td><input class="txt c1 num" id="txtBkmount.*" type="text"/></td>
					<td>
						<input class="txt c1 num" id="txtWmount.*" type="text"/>
						<input class="txt c1 JO" id="txtWrea.*" type="text"/>
					</td>
					<td class="JO">
						<input class="txt c1 num JO" id="txtWvalue.*" type="text"/>
						<input class="txt c1 JO" id="txtMethod.*" type="text"/>
					</td>
					<td><input class="txt c1 num" id="txtInmount.*" type="text"/></td>
					<td><input class="txt c1 num" id="txtOutmount.*" type="text"/></td>
					<td>
						<input class="txt c1 num" id="txtErrmount.*" type="text"/>
						<input class="txt c1" id="txtErrmemo.*" type="text" style="width:120px;"/>
						<select class=" txt c1" id="combQphr.*" style="width:20px;"> </select>
					</td>
					<td>
						<input class="txt c1" id="txtMemo.*" type="text"/>
						<input class="txt" id="txtOrdeno.*" type="text" style="width:70%;"/>
						<input class="txt" id="txtNo2.*" type="text" style="width:20%;"/>
						<input id="txtNoq.*" type="hidden" />
						<input id="recno.*" type="hidden" />
					</td>
					<td><input id="txtWorkno.*" type="text" class="txt c1"/></td>
					<!--<td>
						<input id="txtWorkfno.*" type="text" class="txt" style="width:68%;"/>
						<input id="txtWorkfnoq.*" type="text" class="txt" style="width:23%;"/>
					</td--->
					<td align="center">
						<input class="btn" id="btnStk.*" type="button" value='.' style="width:1%;" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>