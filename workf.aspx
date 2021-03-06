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
			var q_name = "workf";
			var decbbs = ['weight', 'mount', 'gmount', 'emount', 'errmount', 'born'];
			var decbbm = ['mount', 'inmount', 'errmount', 'rmount', 'price', 'hours'];
			var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2', 'txtTotal','txtAccno'];
			var q_readonlys = ['txtOrdeno', 'txtNo2', 'txtNoq', 'txtWorkno','txtQcworker','txtQctime','txtPrice','txtMount','txtBkmount','txtWmount','txtWk_mount','txtWk_inmount','txtWk_unmount','txtTmount','txtTdate','txtQcdate','txtBkrea','txtWrea','txtQcresult'];
			var bbmNum = [['txtMoney', 15, 0, 1], ['txtTax', 15, 0, 1], ['txtTotal', 15, 0, 1]];
			var bbsNum = [
				['txtBorn', 15, 0, 1], ['txtMount', 15, 0, 1], ['txtPrice', 15, 0, 1],
				['txtTotal', 15, 0, 1], ['txtErrmount', 15, 0, 1], ['txtWmount', 15, 0, 1],
				['txtOutmount', 15, 0, 1], ['txtInmount', 15, 0, 1], ['txtWvalue', 15, 0, 1]
			];
			var bbmMask = [];
			var bbsMask = [['txtQctime','99:99']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = '';
			aPop = new Array(
				['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'],
				['tgg_txtTggno', '', 'tgg', 'noa,comp', 'tgg_txtTggno,tgg_txtTgg', 'tgg_b.aspx'],
				['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
				['txtStoreoutno', 'lblStoreout', 'store', 'noa,store', 'txtStoreoutno,txtStoreout', 'store_b.aspx'],
				['txtStoreno_', 'btnStore_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product,spec,price', 'txtProductno_,txtProduct_,txtSpec_,txtPrice_', 'ucaucc_b.aspx']
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
				bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm], ['txtBdate', r_picd], ['txtEdate', r_picd], ['txtTimea', '99:99'], ['tgg_txtBdate', r_picd], ['tgg_txtEdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				
				$('#lblAccno').click(function() {
					q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "97%", "1054px", q_getMsg('btnAccc'), true);
				});
				//1020729 排除已完全入庫&&完全未領料的成品
				$('#btnOrdes').click(function() {
					if (q_cur == 1 || q_cur == 2) {
						var t_err = '';
						t_err = q_chkEmpField([['txtTggno', q_getMsg('lblTgg')]]);
						// 檢查空白
						if (t_err.length > 0) {
							alert(t_err);
							return;
						}
						if (!emp($('#txtTggno').val())) {
							var t_where = "enda!=1 and noa+'_'+no2 in (select a.ordeno+'_'+a.no2 from view_work a left join view_works b on a.noa=b.noa where a.tggno!='' and a.tggno='" + $('#txtTggno').val() + "' and (a.mount>a.inmount and b.gmount>0)) ";
						} else {
							var t_where = "enda!=1 and noa+'_'+no2 in (select a.ordeno+'_'+a.no2 from view_work a left join view_works b on a.noa=b.noa where a.tggno!='' and (a.mount>a.inmount and b.gmount>0)) ";
						}
						q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "95%", q_getMsg('popOrdes'));
					}
				});
				$('#txtMoney').change(function() {
					sum();
				});
				
				$('#txtTax').change(function() {
					sum();
				});
				
				$('#txtTggno').change(function() {
					if(!emp($('#txtTggno').val())){
						var t_where = "where=^^ tggno ='" + $('#txtTggno').val() + "' ^^";
						q_gt('store', t_where, 0, 0, 0, "", r_accy);
					}
				});

				//1020729 排除已完全入庫&&完全未領料的成品,0816取消但會顯示狀態
				$('#btnWork').click(function() {
					var t_err = '';
					t_err = q_chkEmpField([['txtTggno', q_getMsg('lblTgg')]]);
					// 檢查空白
					if (t_err.length > 0) {
						alert(t_err);
						return;
					}
					var t_where = '1=1 ';
					if (!emp($('#txtTggno').val())) {
						t_where += "and enda!=1 and tggno!='' and tggno='" + $('#txtTggno').val() + "'";
					} else {
						t_where += "and enda!=1 and tggno!=''";
					}
					var workno = $.trim($('#textWorkno').val());
					if (workno.length > 0) {
						t_where += " and noa=N'" + workno + "'";
					}
					//1030310 加入應完工日的條件
					var t_bdate = $.trim($('#txtBdate').val());
					var t_edate = $.trim($('#txtEdate').val());
					if (t_bdate.length > 0 || t_edate.length > 0) {
						if (t_edate.length == 0)
							t_edate = r_picd
						t_where += " and uindate between '" + t_bdate + "' and '" + t_edate + "'";
					}
					q_box("work_chk_f_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('popWork'));
				});

				$('#btnClose_div_stk').click(function() {
					$('#div_stk').toggle();
				});
				
				$('#tgg_txtBdate').datepicker();
				$('#tgg_txtEdate').datepicker();
				
				var SeekF= new Array();
				$('#table_tgg td').children("input:text").each(function() {
					if($(this).attr('disabled')!='disabled')
						SeekF.push($(this).attr('id'));
				});
				
				SeekF.push('btnClose_div_tgg');
				$('#table_tgg td').children("input:text").each(function() {
					$(this).bind('keydown', function(event) {
						if( event.which == 13 || event.which == 40) {
							$('#'+SeekF[SeekF.indexOf($(this).attr('id'))+1]).focus();
							$('#'+SeekF[SeekF.indexOf($(this).attr('id'))+1]).select();
						}
					});
				});
				
				$('#btnClose_div_tgg').click(function() {
					$('#div_tgg').toggle();
					if(!emp($('#tgg_txtTggno').val())){
						var tgg_bdate=!emp($('#tgg_txtBdate').val())?$('#tgg_txtBdate').val():'000/00/00';
						var tgg_edate=!emp($('#tgg_txtEdate').val())?$('#tgg_txtEdate').val():r_picd;
						var t_where = "1=1 and isnull(enda,0)!=1 and isnull(isfreeze,0)!=1 and tggno!='' and tggno='" + $('#tgg_txtTggno').val() + "' ";
						t_where+=" and (cuadate between '"+tgg_bdate+"' and '"+tgg_edate+"') ";
						t_where+="and mount>isnull((select SUM(born-bkmount-wmount) from view_workfs where workno=view_work"+r_accy+".noa),0)";
						//t_where+=" and len(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(SUBSTRING(noa,2,1),'0',''),'1',''),'2',''),'3',''),'4',''),'5',''),'6',''),'7',''),'8',''),'9',''))=0";
						t_where+=" and noa like 'W[0-9]%' ";
						
						q_box("work_chk_f_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('popWork'));
					}else{
						_btnChange(0);
						q_cur=0;
					}
				});
				
				/*$('#txtWorkcno').click(function() {
					if (!emp($('#txtWorkcno').val())) {
						t_where = "noa='" + $('#txtWorkcno').val() + "'";
						q_box("workc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'workc', "95%", "95%", q_getMsg('PopWorkc'));
					}
				});*/
				
				$('#txtWorkno').change(function() {
					if(!emp($('#txtWorkno').val())){
						if($('#txtWorkno').val().substr(1,1).replace(/[^\d]/g,'')!=''){
							var t_where = "where=^^ noa ='" + $('#txtWorkno').val() + "' ^^";
							q_gt('work', t_where, 0, 0, 0, "", r_accy);
						}else{
							alert("【"+$('#txtWorkno').val()+"】是模擬製令不得入庫!!");
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

							if (!b_ret || b_ret.length == 0)
								return;
							if (q_cur == 1 || q_cur == 2) {
								for (var i = 0; i < q_bbsCount; i++) {
									$('#btnMinus_' + i).click();
								}
								for (var i = 0; i < b_ret.length; i++) {
									var t_where = "where=^^ charindex('"+b_ret[i].noa+'-'+b_ret[i].no2+"',ordeno)>0 and tggno!='' and left(tggno,1)!='Z' ";
									t_where+=" and isnull(enda,0)!=1 and isnull(isfreeze,0)!=1 and mount>inmount"; 
									//t_where+=" and len(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(SUBSTRING(noa,2,1),'0',''),'1',''),'2',''),'3',''),'4',''),'5',''),'6',''),'7',''),'8',''),'9',''))=0";
									t_where+=" and noa like 'W[0-9]%' ";
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
						if(q_cur==1){
							if (!b_ret || b_ret.length == 0){
								_btnChange(0);
								q_cur=0;
								return;	
							}
							//全部傳入 之後 txt 以同一個倉庫新增一張入庫單
							var t_workno='',t_born='',t_storeno='';
							for (var i = 0; i < b_ret.length; i++) {
								if(dec(b_ret[i].tBorn2)>0){//本次送驗量>0
									t_workno=t_workno+b_ret[i].noa+'&&';
									t_born=t_born+dec(b_ret[i].tBorn2)+'&&';
									t_storeno=t_storeno+b_ret[i].tStoreno2+'&&';
								}
							}
							if(t_workno.length>0&&t_born.length>0){
								//去除最後的資料區隔符號
								t_workno=t_workno.substr(0,t_workno.length-2);
								t_born=t_born.substr(0,t_born.length-2);
								t_storeno=t_storeno.substr(0,t_storeno.length-2);
								//執行txt 進行 ins
								q_func('qtxt.query.ins', 'workf.txt,ins,' + r_accy + ';' + r_name + ';' + encodeURI(t_workno)+ ';' + encodeURI(t_born)+ ';' + encodeURI(t_storeno));
							}
							_btnChange(0);
							q_cur=0;
						}
						
						if (!b_ret || b_ret.length == 0)
							return;
						if (b_ret && q_cur == 2) {
							$('#txtTggno').val(b_ret[0].tggno);
							$('#txtTgg').val(b_ret[0].comp);
							
							//清空表身資料
							for (var i = 0; i < q_bbsCount; i++) {
								$('#btnMinus_' + i).click();
							}
							
							//抓已入送驗數量
							var t_where = "where=^^ workno in(" + getInStr(b_ret) + ") and noa !='"+$('#txtNoa').val()+"'^^";
							q_gt('view_workfs', t_where, 0, 0, 0, "", r_accy);
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			
			var t_workfs='';
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'view_workfs':
						t_workfs = _q_appendData("view_workfs", "", true);
						var t_where = "where=^^ noa in(" + getInStr(b_ret) + ")^^";
						q_gt('work', t_where, 0, 0, 0, "", r_accy);
					break;
					case 'store':
						var as = _q_appendData("store", "", true);
						if (as[0] != undefined) {
							if(emp($('#txtStoreoutno').val())){
								$('#txtStoreno').val(as[0].noa);
								$('#txtStore').val(as[0].store);
							}
						}
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
						var as = _q_appendData("work", "", true);
						var t_tggno = '', t_tgg = '';
						for ( i = 0; i < as.length; i++) {
							if (as[i].tggno != '') {
								t_tggno = as[i].tggno;
								t_tgg = as[i].comp;
							}
							
							as[i].xmount=dec(as[i].mount)
							as[i].inmount=0;
							
							for ( j = 0; j < t_workfs.length; j++) {
								if(as[i].noa==t_workfs[j].workno){
									as[i].xmount=dec(as[i].xmount)-dec(t_workfs[j].born)-dec(t_workfs[j].bkmount)-dec(t_workfs[j].wmount);
									as[i].inmount=as[i].inmount+dec(t_workfs[j].born);
								}
							}
						}
						var ret = q_gridAddRow(
							bbsHtm, 'tbbs',
							'txtProductno,txtProduct,txtOrdeno,txtNo2,txtUnit,txtSpec,txtBorn,txtWk_mount,txtWk_inmount,txtWk_unmount,txtMemo,txtPrice,txtWorkno',
							as.length, as,
							'productno,product,ordeno,no2,unit,txtSpec,xmount,mount,inmount,xmount,memo,price,noa',''
						);
						
						if (t_tggno.length != 0 || t_tgg.length != 0) {
							$('#txtTggno').val(t_tggno);
							$('#txtTgg').val(t_tgg);
						}
						sum();
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

					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			//檢查領料是否等比例//1030325流程變成入庫後產生領料單因此檢查領料比例拿掉
			var checkok = true;//要判斷改回false
			function btnOk() {
				t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtTggno', q_getMsg('lblTgg')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				if (emp($('#txtMon').val()))
					$('#txtMon').val($('#txtDatea').val().substr(0, 6));

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
					
					if (q_cur == 1)
						$('#txtWorker').val(r_name);
					else
						$('#txtWorker2').val(r_name);
					sum();
					var t_date = $('#txtDatea').val();
					var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
					if (s1.length == 0 || s1 == "AUTO")
						q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workf') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
					else
						wrServer(s1);
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('workf_s.aspx', q_name + '_s', "510px", "380px", q_getMsg("popSeek"));
			}

			var mouse_point;
			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
				}
				_bbsAssign();
				for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					$('#btnMinus_' + j).click(function() {
						btnMinus($(this).attr('id'));
					});
					$('#txtMount_' + j).change(function() {
						sum();
					});
					$('#txtPrice_' + j).change(function() {
						sum();
					});
					$('#txtTotal_' + j).change(function() {
						sum();
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
					
					$('#txtWorkno_' + j).click(function() {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if (!emp($('#txtWorkno_' + b_seq).val())&& r_outs!='1' ) {
							t_where = "noa='" + $('#txtWorkno_' + b_seq).val() + "'";
							q_box("work.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'bbs_work', "95%", "95%", q_getMsg('PopWork'));
						}
					});
				}
				HideField();
			}

			function btnIns() {
				/*_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtTimea').val(padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2));
				$('#txtMon').val(q_date().substr(0, 6));
				$('#txtDatea').focus();
				$('#cmbTaxtype').val('1');*/
				//4001改由txt新增
				/*if(r_outs=='1'){
					var t_where = "1=1 and enda!=1 and tggno!='' and tggno='" + r_userno + "' and mount>isnull((select SUM(born-bkmount-wmount) from view_workfs where workno=work"+r_accy+".noa),0)";
					q_box("work_chk_f_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('popWork'));
				}else{
					q_cur=1;
					$('#div_tgg').show();	
					$('#tgg_txtTggno').val('');
					$('#tgg_txtTgg').val('');
					$('#tgg_txtTggno').focus();
				}*/
				//0616 都顯示div 但廠商要鎖定但提供應開工日的篩選
				$('#div_tgg').show();
				if(r_outs=='1'){
					$('#tgg_txtTggno').val(r_userno).attr('disabled', 'disabled');
					$('#tgg_txtTgg').val(r_name).attr('disabled', 'disabled');
					$('#tgg_txtBdate').focus();
				}else{
					$('#tgg_txtTggno').val('').removeAttr('disabled');
					$('#tgg_txtTgg').val('').removeAttr('disabled');
					$('#tgg_txtTggno').focus();
				}
				q_cur=1;
				$('#tgg_txtBdate').val('');
				$('#tgg_txtEdate').val('');
				_btnChange(1);
				$('#btnOk').attr('disabled', 'disabled').css("font-weight","").css("color","");
				$('#btnCancel').attr('disabled', 'disabled');
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtProduct').focus();
			}

			function btnPrint() {
				q_box('z_workfp.aspx' + "?;;;noa=" + $.trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
				
				/*if (q_cur == 1 || emp($('#txtWorkcno').val()))
					q_func('qtxt.query.c0', 'workf.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
				else {
					//處理workc內容
					q_func('workc_post.post.a1', r_accy + ',' + $('#txtWorkcno').val() + ',0');
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

			function sum() {
				var t_money=0,t_total=0,t_tax=0;
				var t_mounts=0,t_prices=0,t_totals=0;
				for(var k=0;k<q_bbsCount;k++){
					t_mounts = dec($('#txtBorn_'+k).val());
					t_prices = dec($('#txtPrice_'+k).val());
					t_totals = q_mul(t_mounts,t_prices);
					$('#txtTotal_'+k).val(t_totals);
					t_money = q_add(t_money,t_totals);
				}
				t_tax = dec($('#txtTax').val());
				t_total = q_add(t_money,t_tax);
				$('#txtMoney').val(t_money);
				$('#txtTotal').val(t_total);
			}

			function refresh(recno) {
				_refresh(recno);
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
				/*if (!confirm(mess_dele))
					return;
				q_cur = 3;
				//處理workc內容
				if(emp($('#txtWorkcno').val()))
					q_func('qtxt.query.c2', 'workf.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
				else
					q_func('workc_post.post.a2', r_accy + ',' + $('#txtWorkcno').val() + ',0');*/
			}

			function btnCancel() {
				_btnCancel();
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtWorkno':
						if($('#txtWorkno').val().substr(1,1).replace(/[^\d]/g,'')!=''){
							var t_where = "where=^^ noa ='" + $('#txtWorkno').val() + "' ^^";
							q_gt('work', t_where, 0, 0, 0, "", r_accy);
						}else{
							alert("【"+$('#txtWorkno').val()+"】是模擬製令不得入庫!!");
						}
						break;
					case 'txtTggno':
						if(!emp($('#txtTggno').val())){
							var t_where = "where=^^ tggno ='" + $('#txtTggno').val() + "' ^^";
							q_gt('store', t_where, 0, 0, 0, "", r_accy);
						}
						break;
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				abbm[q_recno]['accno'] = xmlString.split(";")[0];
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

			function calTax() {
				var t_money = 0, t_tax = 0, t_total = 0;
				for (var j = 0; j < q_bbsCount; j++) {
					t_money += q_float('txtTotal_' + j);
				}
				t_total = t_money;
				var t_taxrate = q_div(parseFloat(q_getPara('sys.taxrate')), 100);
				switch ($('#cmbTaxtype').val()) {
					case '0':
						// 無
						t_tax = 0;
						t_total = q_add(t_money, t_tax);
						break;
					case '1':
						// 應稅
						t_tax = round(q_mul(t_money, t_taxrate), 0);
						t_total = q_add(t_money, t_tax);
						break;
					case '2':
						//零稅率
						t_tax = 0;
						t_total = q_add(t_money, t_tax);
						break;
					case '3':
						// 內含
						t_tax = round(q_mul(q_div(t_money, q_add(1, t_taxrate)), t_taxrate), 0);
						t_total = t_money;
						t_money = q_sub(t_total, t_tax);
						break;
					case '4':
						// 免稅
						t_tax = 0;
						t_total = q_add(t_money, t_tax);
						break;
					case '5':
						// 自定
						$('#txtTax').attr('readonly', false);
						$('#txtTax').css('background-color', 'white').css('color', 'black');
						t_tax = round(q_float('txtTax'), 0);
						t_total = q_add(t_money, t_tax);
						break;
					case '6':
						// 作廢-清空資料
						t_money = 0, t_tax = 0, t_total = 0;
						break;
					default:
				}

				$('#txtMoney').val(FormatNumber(t_money));
				$('#txtTax').val(FormatNumber(t_tax));
				$('#txtTotal').val(FormatNumber(t_total));
			}
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					/*case 'workc_post.post.a1':
						//呼叫workf.post
						q_func('qtxt.query.c0', 'workf.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
						break;
					case 'workc_post.post.a2':
						//呼叫workf.post
						q_func('qtxt.query.c2', 'workf.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
						break;
					case 'qtxt.query.c0':
						q_func('qtxt.query.c1', 'workf.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';1');
						break;
					case 'qtxt.query.c1':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							abbm[q_recno]['workcno'] = as[0].workcno;
							$('#txtWorkcno').val(as[0].workcno);
							//處理workc內容
							if(!emp(as[0].workcno))
								q_func('workc_post.post', r_accy + ',' + $('#txtWorkcno').val() + ',1');
						}
						break;
					case 'qtxt.query.c2':
						_btnOk($('#txtNoa').val(), bbmKey[0], ( bbsHtm ? bbsKey[1] : ''), '', 3)
						break;*/
					case 'qtxt.query.ins':
							//重新整理
							location.href=location.href;
						break;
					default:
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
				width: 2600px;
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
				width: 97%;
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
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="div_tgg" style="position:absolute; top:300px; left:400px; display:none; width:400px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_tgg" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;" align="left">
						廠商編號：<input id='tgg_txtTggno' type='text' class='txt' style="float:none;width: 150px;"/>
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="left">
						廠商名稱：<input id='tgg_txtTgg' type='text' class='txt' style="float:none;width: 300px;"/>
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="left">
						應開工日：<input id='tgg_txtBdate' type='text' class='txt' style="float:none;width: 100px;"/>
						~ <input id='tgg_txtEdate' type='text' class='txt' style="float:none;width: 100px;"/>
					</td>
				</tr>
				<tr>
					<td align="center">
						<input id="btnClose_div_tgg" type="button" value="確定">
					</td>
				</tr>
			</table>
		</div>
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
						<td align="center" style="width:30%"><a id='vewTgg'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='tgg,4'>~tgg,4</td>
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
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblTimea' class="lbl"> </a></td>
						<td><input id="txtTimea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTgg' class="lbl btn"> </a></td>
						<td>
							<input id="txtTggno" type="text" class="txt" style='width:45%;'/>
							<input id="txtTgg" type="text" class="txt" style='width:50%;'/>
						</td>
						<td><span> </span><a id='lblBdate' class="lbl"> </a></td>
						<td>
							<input id="txtBdate" type="text" class="txt c3" style="width: 98px;"/>
							<a style="float: left;">~</a>
							<input id="txtEdate" type="text" class="txt c3" style="width: 98px;"/>
						</td>
					</tr>
					<tr>
						<!--<td><span> </span><a id='lblStoreout' class="lbl btn"> </a></td>
						<td>
							<input id="txtStoreoutno" type="text" class="txt" style='width:45%;'/>
							<input id="txtStoreout" type="text" class="txt" style='width:48%;'/>
						</td>-->
						<td><span> </span><a id='lblStore' class="lbl btn"> </a></td>
						<td>
							<input id="txtStoreno" type="text" class="txt" style='width:45%;'/>
							<input id="txtStore" type="text" class="txt" style='width:50%;'/>
						</td>
						<!--<td><span> </span><a id='lblWorkcno' class="lbl"> </a></td>
						<td><input id="txtWorkcno" type="text" class="txt c1"/></td>-->
						<td><span> </span><a id='lblWorkno' class="lbl"> </a></td>
						<td><input id="txtWorkno" type="text" class="txt c1"/></td>
						<!--<td><input type="button" id="btnWork"></td>-->
					</tr>
					<tr>
						<td><span> </span><a id='lblInvono' class="lbl"> </a></td>
						<td><input id="txtInvono" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
						<!--<td><input type="button" id="btnOrdes"></td>-->
					</tr>
					<tr>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td>
							<select id="cmbTaxtype" class="txt" onchange="calTax()" style='width:45%;'> </select>
							<input id="txtTax" type="text" class="txt c2 num" style="width: 52%;"/>
						</td>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan='3'><input id="txtMemo" type="text" class="txt c1" style="width: 99%;"/></td>
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
					<td align="center" style="width:20px;"> </td>
					<td style="width:200px;" align="center"><a id='lblProductnos'> </a></td>
					<td style="width:220px;" align="center"><a id='lblProduct_s'> </a></td>
					<td style="width:95px;" align="center" class="isStyle"><a id='lblStyle'> </a></td>
					<td style="width:40px;" align="center"><a id='lblUnit'> </a></td>
					<td style="width:100px;" align="center"><a id='lblWk_mounts'> </a></td>
					<td style="width:100px;" align="center"><a id='lblWk_inmounts'> </a></td>
					<td style="width:100px;" align="center"><a id='lblWk_unmounts'> </a></td>
					<td style="width:100px;" align="center"><a id='lblBorn' style="color: red;font-weight: bold;"> </a></td>
					<td style="width:150px;" align="center"><a id='lblStores' style="color: red;font-weight: bold;"> </a></td>
					<td style="width:100px;;" align="center"><a id='lblBwmounts'> </a></td>
					<td style="width:100px;" align="center"><a id='lblPrice_s'> </a></td>
					<td style="width:100px;" align="center"><a id='lblTotal_s'> </a></td>
					<!--<td style="width:100px;" align="center"><a id='lblInmount_s'> </a></td>
					<td style="width:100px;" align="center"><a id='lblOutmount_s'> </a></td>-->
					<td style="width:100px;" align="center"><a id='lblTmount'> </a>/<br><a id='lblTdate'> </a></td>
					<!--<td style="width:100px;" align="center"><a id='lblTdate'> </a></td>-->
					<td style="width:120px;" align="center"><a id='lblMounts'> </a>/<br><a id='lblQcdate'> </a></td>
					<!--<td style="width:100px;" align="center"><a id='lblQcdate'> </a></td>-->
					<td style="width:100px;" align="center"><a id='lblQcresult'> </a></td>
					<td style="width:110px;" align="center"><a id='lblBkmount_s'> </a></td>
					<td style="width:110px;" align="center"><a id='lblWmounts'> </a></td>
					<td style="width:110px;" align="center" class="JO"><a id='lblWvalues_jo' class="JO">殘值</a><a id='lblMethods_jo' class="JO">/處理方法</a></td>
					<!--<td style="width:150px;" align="center"><a id='lblErrmount'> </a></td>-->
					<td align="center"><a id='lblMemos'> </a></td>
					<td style="width:180px;" align="center"><a id='lblWorknos'> </a></td>
					<td style="width:100px;" align="center"><a id='lblQcworker'> </a>/<a id='lblQctime'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<!--1020702製造業通常只用到數量，所以重量隱藏，並將生產數量改為報廢數量-->
					<td><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input class="txt" id="txtProductno.*" type="text" style="width:88%;" />
						<input class="btn" id="btnProductno.*" type="button" value='.' style="width:1%;" />
					</td>
					<td>
						<input class="txt c1" id="txtProduct.*" type="text"/>
						<input class="txt c1 isSpec" id="txtSpec.*" type="text"/>
					</td>
					<td class="isStyle"><input class="txt c1" id="txtStyle.*" type="text"/></td>
					<td><input class="txt c1" id="txtUnit.*" type="text"/></td>
					<td><input class="txt c1 num" id="txtWk_mount.*" type="text"/></td>
					<td><input class="txt c1 num" id="txtWk_inmount.*" type="text"/></td>
					<td><input class="txt c1 num" id="txtWk_unmount.*" type="text"/></td>
					<td><input class="txt c1 num" id="txtBorn.*" type="text"/></td>
					<td>
						<input class="btn" id="btnStore.*" type="button" value='.' style="width:1%;float: left;" />
						<input id="txtStoreno.*" type="text" class="txt c2" style="width: 30%;"/>
						<input id="txtStore.*" type="text" class="txt c3" style="width: 50%;"/>
					</td>
					<td><input class="txt c1 num" id="txtBwmount.*" type="text"/></td>
					<td><input class="txt c1 num" id="txtPrice.*" type="text"/></td>
					<td><input class="txt c1 num" id="txtTotal.*" type="text"/></td>
					<!--<td><input class="txt c1 num" id="txtInmount.*" type="text"/></td>
					<td><input class="txt c1 num" id="txtOutmount.*" type="text"/></td>-->
					<td>
						<input class="txt c1 num" id="txtTmount.*" type="text"/>
						<input class="txt c1" id="txtTdate.*" type="text"/>
					</td>
					<td>
						<input class="txt c1 num" id="txtMount.*" type="text"/>
						<input class="txt c1" id="txtQcdate.*" type="text"/>
					</td>
					<td><input class="txt c1" id="txtQcresult.*" type="text"/></td>
					<td>
						<input class="txt c1 num" id="txtBkmount.*" type="text"/>
						<input class="txt c1" id="txtBkrea.*" type="text"/>
					</td>
					<td>
						<input class="txt c1 num" id="txtWmount.*" type="text"/>
						<input class="txt c1" id="txtWrea.*" type="text"/>
					</td>
					<td class="JO">
						<input class="txt c1 num JO" id="txtWvalue.*" type="text"/>
						<input class="txt c1 JO" id="txtMethod.*" type="text"/>
					</td>
					<!--<td>
						<input class="txt c1 num" id="txtErrmount.*" type="text"/>
						<input class="txt c1" id="txtErrmemo.*" type="text"/>
					</td>-->
					<td>
						<input class="txt c1" id="txtMemo.*" type="text"/>
						<input class="txt" id="txtOrdeno.*" type="hidden" style="width:70%;"/>
						<input class="txt" id="txtNo2.*" type="hidden" style="width:20%;"/>
						<input id="txtNoq.*" type="hidden" />
						<input id="recno.*" type="hidden" />
					</td>
					<td><input id="txtWorkno.*" type="text" class="txt c1"/></td>
					<td>
						<input id="txtQcworker.*" type="text" class="txt c1"/>
						<input id="txtQctime.*" type="text" class="txt c1"/>
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>