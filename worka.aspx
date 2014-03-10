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
			var q_name = "worka";
			var decbbs = ['mount', 'weight'];
			var decbbm = ['mount'];
			var q_readonly = ['txtWorker'];
			var q_readonlys = ['txtWorkno'];
			var bbmNum = [];
			// 允許 key 小數
			var bbsNum = [['txtMount', 12, 2, 1], ['txtWeight', 15, 2, 1]];
			var bbmMask = [['txtTimea', '99:99']];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(
				['txtStationno', 'lblStation', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx'],
				['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
				['txtStoreno_', 'btnStore_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'],
				['txtCuano', 'lblCuano', 'inb', 'noa,datea', 'txtCuano,txtCuadate', 'inb_b.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy],
				['txtMechno_', 'btnMechno_', 'mech', 'noa,mech', 'txtMechno_,txtMech_', 'mech_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx'],
				['txtProductno', 'lblProductno', 'ucaucc', 'noa,product', 'txtProductno,txtProduct', 'ucaucc_b.aspx'],
				['txtProcessno', 'lblProcess', 'process', 'noa,process', 'txtProcessno,txtProcess', 'process_b.aspx', '95%'],
				['txtOrdeno', 'lblOrdeno', 'ordes', 'noa,no2,productno,product', 'txtOrdeno,txtNo2,txtProductno,txtProduct', 'ordes_b.aspx', '95%']
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

				$('#txtDatea').focus();

			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtCuadate', r_picd], ['txtTimea', '99:99'], ['txtBdate', r_picd], ['txtEdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('worka.typea'));

				//1020729 顯示未完全入庫
				$('#btnOrdes').click(function() {
					if (!emp($('#txtStationno').val())) {
						var t_where = "enda!=1 and noa+'_'+no2 in (select a.ordeno+'_'+a.no2 from view_work a left join view_works b on a.noa=b.noa where  (a.tggno is null or a.tggno='') and a.stationno='" + $('#txtStationno').val() + "' and a.mount>a.inmount  group by a.ordeno,a.no2) ";
					} else {
						var t_where = "enda!=1 and noa+'_'+no2 in (select a.ordeno+'_'+a.no2 from view_work a left join view_works b on a.noa=b.noa where  (a.tggno is null or a.tggno='') and a.mount>a.inmount  group by a.ordeno,a.no2) ";
					}
					q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "95%", q_getMsg('popOrdes'));
				});
				//1020729 顯示未完全入庫,0816取消但會顯示狀態
				$('#btnWork').click(function() {
					var t_where = '1=1 ';
					if (!emp($('#txtStationno').val())) {
						//var t_where = "and enda!=1 and (tggno is null or tggno='') and stationno='"+$('#txtStationno').val()+"' and noa in (select a.noa from view_work a left join view_works b on a.noa=b.noa where a.mount>a.inmount)";
						t_where += "and enda!=1 and (tggno is null or tggno='') and stationno='" + $('#txtStationno').val() + "'";
					} else {
						//var t_where = "and enda!=1 and (tggno is null or tggno='') and noa in (select a.noa from view_work a left join view_works b on a.noa=b.noa where a.mount>a.inmount)";
						t_where += "and enda!=1 and (tggno is null or tggno='') ";
					}
					var workno = $.trim($('#txtWorkno').val());
					if(workno.length > 0 ){
						t_where += " and noa=N'"+workno+"'";
					}
					//1030310 加入應開工日的條件
					var t_bdate = $.trim($('#txtBdate').val());
					var t_edate = $.trim($('#txtEdate').val());
					if(t_bdate.length > 0 || t_edate.length>0){
						if(t_edate.length == 0) t_edate='999/99/99'
						t_where += " and cuadate between '"+t_bdate+"' and '"+t_edate+"'";
					}
					q_box("work_chk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('popWork'));
					
					//1030310讀取倉庫
					if(!emp($('#txtStoreno').val()))
						var t_where = "where=^^ ['" + q_date() + "','"+$('#txtStoreno').val()+"','') group by productno order by productno^^";
					else
						var t_where = "where=^^ ['" + q_date() + "','','') group by productno order by productno^^";
					q_gt('work_stk', t_where, 0, 0, 0, "work_stk", r_accy);
				});

				/*$('#txtWorkno').change(function() {
					var t_where = "where=^^ noa ='" + $('#txtWorkno').val() + "' ^^";
					q_gt('works', t_where, 0, 0, 0, "", r_accy);
				});
				$('#lblWorkno').click(function() {
					var t_where = "enda!=1 ";
					t_where += emp($('#txtWorkno').val()) ? '' : "and charindex ('" + $('#txtWorkno').val() + "',noa)>0 ";
					q_box('work_b.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy, 'work', "95%", "95%", q_getMsg('popWork'));
				});*/
				
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
										//102/07/06寫入工作中心,只有Z開頭
										var t_where = "where=^^ ordeno ='" + b_ret[i].noa + "' and no2='" + b_ret[i].no2 + "' and (len(tggno)=0 or len(stationno)>0 )^^";
										q_gt('work', t_where, 0, 0, 0, "", r_accy);
									}
								}
							}
						}
						break;

					case 'work':
						b_ret = getb_ret();
						if (b_ret && (q_cur == 1 || q_cur == 2)) {
							$('#txtStationno').val(b_ret[0].stationno);
							$('#txtStation').val(b_ret[0].station);
							$('#txtProcessno').val(b_ret[0].processno);
							$('#txtProcess').val(b_ret[0].process);
							$('#txtModelno').val(b_ret[0].modelno);
							$('#txtModel').val(b_ret[0].model);
							var t_where = "where=^^ noa in(" + getInStr(b_ret) + ")^^";
							q_gt('work', t_where, 0, 0, 0, "", r_accy);
						}
						break;
					case 'works':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							var i, j = 0;
							for ( i = 0; i < b_ret.length; i++) {
								if (b_ret[i].istd == 'true') {
									b_ret[i].productno = b_ret[i].tproductno;
									b_ret[i].product = b_ret[i].tproduct;
								}

								if (b_ret[i].unit.toUpperCase() == 'KG') {
									b_ret[i].xmount = 0;
									b_ret[i].xweight = b_ret[i].mount;
								} else {
									b_ret[i].xmount = b_ret[i].mount;
									b_ret[i].xweight = 0;
								}
							}

							q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtMount,txtWeight,txtMemo', b_ret.length, b_ret, 'productno,product,unit,xmount,xweight,memo', 'txtProductno');
							bbsAssign();
						}
						break;

					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			
			var work_stk;//儲存目前倉庫庫存
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'msg_stk':
						var as = _q_appendData("stkucc", "", true);
						var stkmount = 0;
						t_msg = '';
						for (var i = 0; i < as.length; i++) {
							stkmount = stkmount + dec(as[i].mount);
						}
						t_msg = "總庫存量：" + stkmount;
						q_msg($('#txtMount_' + b_seq), t_msg);
						break;
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

						var as = _q_appendData("works", "", true);
						var t_msg='',t_worksno='';
						//判斷庫存量足夠
						for (var  i = 0; i < as.length; i++) {
							for (var j=0;j< work_stk.length;j++){
								if(as[i].productno==work_stk[j].productno){
									if(dec(work_stk[j].mount)-dec(as[i].mount)<0){
										if(t_worksno!=as[i].noa){
											if(t_worksno='')
												t_msg+="製令單："+as[i].noa+"\n";
											else
												t_msg+="\n製令單："+as[i].noa+"\n";
											t_worksno=as[i].noa;
										}
										t_msg+="原料："+as[i].product+"，不足數量："+(dec(work_stk[j].mount)-dec(as[i].mount)).toString()+"\n";
										as.splice(i, 1);
                                    	i--;
                                   }else{
                                   		work_stk[j].mount=dec(work_stk[j].mount)-dec(as[i].mount);
                                   }
                                   break;
								}
							}
						}
						q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtMount,txtMemo,txtWorkno', as.length, as, 'productno,product,unit,mount,memo,noa', '');
						alert(t_msg);
						break;
					case 'work_stk':
						work_stk = _q_appendData("stkucc", "", true);
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
				if(t_name.substr(0,'btnOK_bbsstkchk_'.length)=='btnOK_bbsstkchk_'){
					var bbs_seq=t_name.substr('btnOK_bbsstkchk_'.length,t_name.length)
					var as = _q_appendData("stkucc", "", true);
					//將之前領料的加回去
					for (var j = 0; j < abbsNow.length; j++) {
						if(abbsNow[j].productno==as[0].productno){
							as[0].mount=as[0].mount+abbsNow[j].mount;
						}
					}
					if()abbsNow
					
					stkchkcount2++;
					if(stkchkcount==stkchkcount2)
						btnok_bbsstkchk=true;
				}
				if(btnok_bbsstkchk){
					/*$('#txtWorker').val(r_name);
					sum();
					var t_date = $('#txtDatea').val();
					var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
					if (s1.length == 0 || s1 == "AUTO")
						q_gtnoa(q_name, replaceAll(q_getPara('sys.key_worka') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
					else
						wrServer(s1);
				*/
				}
			}
			
			var btnok_bbsstkchk=false,stkchkcount=0,stkchkcount2=0;
			function btnOk() {
				t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				// 檢查空白
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				//如果表身倉庫沒填，表頭倉庫帶入
				for (var i = 0; i < q_bbsCount; i++) {
					if (emp($('#txtStoreno_' + i).val())) {
						$('#txtStoreno_' + i).val($('#txtStoreno').val());
						$('#txtStore_' + i).val($('#txtStore').val());
					}
				}
				
				//判斷庫存是否足夠
				stkchkcount=0,stkchkcount2=0;
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtProductno_' + i).val())){
						var t_where = "where=^^ ['" + q_date() + "','"+$('#txtStoreno_' + i).val()+"','" + $('#txtProductno_' + i).val() + "') ^^";
						q_gt('calstk', t_where, 0, 0, 0, "btnOK_bbsstkchk_"+i, r_accy);
						stkchkcount++;
					}
				}
			}
			
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('worka_s.aspx', q_name + '_s', "500px", "410px", q_getMsg("popSeek"));
			}
			
			var mouse_point;
			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#txtMount_' + i).focusin(function() {
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
					}
				}
				_bbsAssign();
				for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					$('#btnMinus_' + j).click(function() {
						btnMinus($(this).attr('id'));
					});

				} //j
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
				q_box('z_workap.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", m_print);
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
				as['datea'] = abbm2['datea'];
				as['cuano'] = abbm2['cuano'];
				as['stationno'] = abbm2['stationno'];

				return true;
			}

			function sum() {
				var t1 = 0, t_unit, t_mount, t_weight = 0;
				for (var j = 0; j < q_bbsCount; j++) {

				}
			}

			function refresh(recno) {
				_refresh(recno);
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
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 98%;
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
				width: 98%;
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
				width: 80%;
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
				width: 100%;
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
	<body>
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
			<div class="dview" id="dview" style="float: left;  width:23%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:40%"><a id='vewDatea'></a></td>
						<td align="center" style="width:55%"><a id='vewNoa'></a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' ' /></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 77%;float:left">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
					<tr style="height: 1px;">
						<td width="120px"> </td>
						<td width="203px"> </td>
						<td width="120px"> </td>
						<td width="203px"> </td>
						<td width="120px"> </td>
						<td width="203px"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"></select></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"   type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStore' class="lbl btn"> </a></td>
						<td>
							<input id="txtStoreno"  type="text" class="txt c2"/>
							<input id="txtStore" type="text" class="txt c3"/>
						</td>
						<td><span> </span><a id='lblStation' class="lbl btn"> </a></td>
						<td>
							<input id="txtStationno" type="text" class="txt c2"/>
							<input id="txtStation" type="text" class="txt c3"/>
						</td>
						<td><span> </span><a id='lblProcess' class="lbl btn"> </a></td>
						<td>
							<input id="txtProcessno" type="text" class="txt c2"/>
							<input id="txtProcess" type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTimea' class="lbl"> </a></td>
						<td><input id="txtTimea" type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblModel' class="lbl"> </a></td>
						<td>
							<input id="txtModelno" type="text" class="txt c2"/>
							<input id="txtModel" type="text" class="txt c3"/>
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
							<input id="txtBdate" type="text"  class="txt c3" style="width: 95px;"/>
							<a style="float: left;">~</a>
							<input id="txtEdate" type="text"  class="txt c3" style="width: 95px;"/>
						</td>
						<td><span> </span><a id='lblWorkno' class="lbl"> </a></td>
						<td ><input id="txtWorkno" type="text"  class="txt c1"/></td>
						<td><input type="button" id="btnWork"></td>
						<td><input type="button" id="btnOrdes"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan='3'><input id="txtMemo" type="text"  style="width: 99%;"/></td>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1260px;">
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:White; background:#003366;' >
					<td align="center">
						<input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  />
					</td>
					<td align="center"><a id='lblProductnos'> </a></td>
					<td align="center"><a id='lblProduct_s'> </a></td>
					<td align="center"><a id='lblUnit'> </a></td>
					<td align="center"><a id='lblMounts'> </a></td>
					<td align="center"><a id='lblStores'> </a></td>
					<td align="center"><a id='lblMemos'> </a></td>
					<td align="center"><a id='lblWorknos'> </a></td>
					<td align="center"><a id='lblStks'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<!--1020702製造業通常只用到數量，所以重量隱藏-->
					<td style="width:1%;">
						<input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
					</td>
					<td style="width:14%;">
						<input class="txt"  id="txtProductno.*" type="text" style="width:75%;" />
						<input class="btn"  id="btnProductno.*" type="button" value='.' style="width:10%;"  />
					</td>
					<td style="width:18%;"><input id="txtProduct.*" type="text" class="txt c1"/></td>
					<td style="width:4%;"><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td style="width:10%;"><input id="txtMount.*" type="text" class="txt c1" style="text-align:right"/></td>
					<td style="width:14%;">
						<input class="btn"  id="btnStore.*" type="button" value='.' style="width:1%;float: left;"  />
						<input id="txtStoreno.*"  type="text" class="txt c2" style="width: 30%;"/>
						<input id="txtStore.*" type="text" class="txt c3" style="width: 50%;"/>
					</td>
					<td>
						<input id="txtMemo.*" type="text" class="txt c1"/>
						<input id="txtNoq.*" type="hidden" />
						<input id="recno.*" type="hidden" />
					</td>
					<td style="width:15%;"><input id="txtWorkno.*" type="text" class="txt c1"/></td>
					<td align="center" style="width:4%;">
						<input class="btn"  id="btnStk.*" type="button" value='.' style="width:1%;"  />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>