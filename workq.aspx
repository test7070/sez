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
			var q_name = "workq";
			var decbbs = ['weight', 'mount', 'gmount', 'emount', 'errmount', 'born'];
			var decbbm = ['mount', 'inmount', 'errmount', 'rmount', 'price', 'hours'];
			var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2','txtTgg','txtStore','txtAccno','txtWorkdno','txtWorkcno'];
			var q_readonlys = ['txtBorn','txtOrdeno', 'txtNo2', 'txtNoq', 'txtWorkno','txtWorkfno','txtWorkfnoq','txtStore','txtWk_mount','txtWk_inmount','txtWk_unmount'];
			var bbmNum = [];
			var bbsNum = [
				['txtBorn', 15, 0, 1], ['txtMount', 15, 0, 1], ['txtPrice', 15, 0, 1],
				['txtTotal', 15, 0, 1], ['txtErrmount', 15, 0, 1], ['txtWmount', 15, 0, 1],
				['txtOutmount', 15, 0, 1], ['txtInmount', 15, 0, 1], ['txtBkmount', 15, 0, 1]
			];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = '';
			aPop = new Array(
				['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'],
				['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
				['txtStoreoutno', 'lblStoreout', 'store', 'noa,store', 'txtStoreoutno,txtStoreout', 'store_b.aspx'],
				['txtStoreno_', 'btnStore_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product,spec', 'txtProductno_,txtProduct_,txtSpec_', 'ucaucc_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				
				if(r_outs!='1')
					q_content = "";
				else
					q_content = "where=^^tggno='" + r_userno + "'^^";
				
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
				//1020729 排除已完全入庫&&完全未領料的成品
				$('#btnOrdes').click(function() {
					if (q_cur == 1 || q_cur == 2) {
						if (!emp($('#txtTggno').val())) {
							var t_where = "enda!=1 and noa+'_'+no2 in (select a.ordeno+'_'+a.no2 from view_work a left join view_works b on a.noa=b.noa where a.tggno!='' and a.tggno='" + $('#txtTggno').val() + "' and (a.mount>a.inmount and b.gmount>0)) ";
						} else {
							var t_where = "enda!=1 and noa+'_'+no2 in (select a.ordeno+'_'+a.no2 from view_work a left join view_works b on a.noa=b.noa where a.tggno!='' and (a.mount>a.inmount and b.gmount>0)) ";
						}
						q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "95%", q_getMsg('popOrdes'));
					}
				});
				//1020729 排除已完全入庫&&完全未領料的成品,0816取消但會顯示狀態
				$('#btnWork').click(function() {
					var t_where = '1=1 ';
					if (!emp($('#txtTggno').val())) {
						//var t_where += "enda!=1 and tggno!='' and tggno='"+$('#txtTggno').val()+"' and noa in (select a.noa from view_work a left join view_works b on a.noa=b.noa where (a.mount>a.inmount and b.gmount>0))";
						t_where += "and enda!=1 and tggno!='' and tggno='" + $('#txtTggno').val() + "'";
					} else {
						//var t_where += "enda!=1 and tggno!='' and noa in (select a.noa from view_work a left join view_works b on a.noa=b.noa where (a.mount>a.inmount and b.gmount>0))";
						t_where += "and enda!=1 and tggno!=''";
					}
					t_where += "and (mount-isnull((select sum(mount) from view_workqs where (workno=work"+r_accy+".noa) and (noa!='"+$.trim($('#txtNoa').val())+"')),0)) > 0";
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

					q_box("work_chk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('popWork'));
				});

				$('#btnClose_div_stk').click(function() {
					$('#div_stk').toggle();
				});
				
				$('#txtWorkdno').click(function(){
					var thisVal = $.trim($(this).val());
					if(thisVal.length > 0){
						var t_where = "noa='" + thisVal + "'";
						q_box("workd.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'workd', "95%", "95%", q_getMsg('popWorkd'));
					}					
				});
				
				$('#txtWorkcno').click(function(){
					var thisVal = $.trim($(this).val());
					if(thisVal.length > 0){
						var t_where = "noa='" + thisVal + "'";
						q_box("workc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'workc', "95%", "95%", q_getMsg('popWorkc'));
					}					
				});
				
				$('#btnWorkf').click(function() {
					var thisVal = $.trim($('#txtWorkfno').val());
					var t_where='1=1 and tmount>0  and (tmount-mount-bkmount-wmount)>0 ';
					if(thisVal.length > 0){
						t_where += " and noa='" + $('#txtWorkfno').val() + "'";
					}
					
					for(var i=0;i<q_bbsCount;i++){
						if(!emp($('#txtWorkfno_'+i).val()))
						t_where += " or noa='" + $('#txtWorkfno_'+i).val() + "'"
					}
					
					if (!emp($('#txtTggno').val())) {
						t_where += "and tggno='" + $('#txtTggno').val() + "'";
					}
					
					var t_bdate = $.trim($('#txtBdate').val());
					var t_edate = $.trim($('#txtEdate').val());
					if (t_bdate.length > 0 || t_edate.length > 0) {
						if (t_edate.length == 0)
							t_edate = r_picd
						t_where += " and datea between '" + t_bdate + "' and '" + t_edate + "'";
					}
					
					q_box("workfs_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'workfs', "95%", "95%", q_getMsg('PopWorkfs'));
				});
				
				$('#txtWorkfno').change(function() {
					var thisVal = $.trim($('#txtWorkfno').val());
					if(thisVal.length > 0){
						var t_where = "where=^^ noa=N'" + thisVal + "' and tmount>0";
						q_gt('view_workfs', t_where, 0, 0, 0, "getWorkfs", r_accy);
					}
				});
				
				$('#txtTggno').change(function() {
					if(!emp($('#txtTggno').val())){
						var t_where = "where=^^ tggno ='" + $('#txtTggno').val() + "' ^^";
						q_gt('store', t_where, 0, 0, 0, "", r_accy);
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
					case 'workfs':
					if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0){
								b_pop = '';
								return;
							}
						q_gridAddRow(
							bbsHtm, 'tbbs',
							'txtProductno,txtProduct,txtUnit,txtSpec,txtWk_mount,txtBorn,txtOrdeno,txtNo2,txtMemo,txtPrice,txtStoreno,txtStore,txtWorkno,txtWorkfno,txtWorkfnoq',
							b_ret.length, b_ret,
							'productno,product,unit,spec,wk_mount,born,ordeno,no2,memo,price,storeno,store,workno,noa,noq', ''
						);
						
						//取得已送驗入庫的數量
						var WorkNoStr = new Array();
						for(var i=0;i<q_bbsCount;i++){
							var t_workno = $.trim($('#txtWorkno_'+i).val());
							WorkNoStr.push("'"+t_workno+"'");
						}
						var t_where = "where=^^ noa!='"+$('#txtNoa').val()+"' and workno in ("+WorkNoStr.toString()+") ^^";
						q_gt('view_workqs', t_where, 0, 0, 0, "GetMount", r_accy);
					}
					break;
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
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'store':
						var as = _q_appendData("store", "", true);
						if (as[0] != undefined) {
							if(emp($('#txtStoreoutno').val())){
								$('#txtStoreoutno').val(as[0].noa);
								$('#txtStoreout').val(as[0].store);
							}
						}
						break;
					case 'getWorkfs':
						var as = _q_appendData("view_workfs", "", true);
						q_gridAddRow(
							bbsHtm, 'tbbs',
							'txtProductno,txtProduct,txtUnit,txtSpec,txtWk_mount,txtBorn,txtOrdeno,txtNo2,txtMemo,txtPrice,txtStoreno,txtStore,txtWorkno,txtWorkfno,txtWorkfnoq',
							as.length, as,
							'productno,product,unit,spec,wk_mount,born,ordeno,no2,memo,price,storeno,store,workno,noa,noq', ''
						);
						
						//取得已送驗入庫的數量
						var WorkNoStr = new Array();
						for(var i=0;i<q_bbsCount;i++){
							var t_workno = $.trim($('#txtWorkno_'+i).val());
							WorkNoStr.push("'"+t_workno+"'");
						}
						var t_where = "where=^^ noa!='"+$('#txtNoa').val()+"' and workno in ("+WorkNoStr.toString()+") ^^";
						q_gt('view_workqs', t_where, 0, 0, 0, "GetMount", r_accy);
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
					/*case 'work':
						var as = _q_appendData("work", "", true);
						var t_tggno = '', t_tgg = '';
						for ( i = 0; i < as.length; i++) {
							if (as[i].tggno != '') {
								t_tggno = as[i].tggno;
								t_tgg = as[i].comp;
							}
						}
						var ret = q_gridAddRow(
							bbsHtm, 'tbbs',
							'txtProductno,txtProduct,txtUnit,txtWk_mount,txtOrdeno,txtNo2,txtMemo,txtPrice,txtWorkno',
							as.length, as,
							'productno,product,unit,mount,ordeno,no2,memo,price,noa', ''
						);

						var t_where = "where=^^ (workno in ("+ getInStr(as) +")) ^^";//and len(isnull(qcworker,''))=0
						q_gt('view_workfs', t_where, 0, 0, 0, "GetBorn", r_accy);
						if (t_tggno.length != 0 || t_tgg.length != 0) {
							$('#txtTggno').val(t_tggno);
							$('#txtTgg').val(t_tgg);
						}
						break;
					case 'GetBorn':
						var as = _q_appendData("view_workfs", "", true);
						for(var i=0;i<q_bbsCount;i++){
							var t_born=0
							if(!emp($('#txtWorkno_'+i).val())){
								for(var j=0;j<as.length;j++){
									if($('#txtWorkno_'+i).val()==as[j].workno){
										t_born+=dec(as[j].born);
									}
								}
							}
							$('#txtBorn_'+i).val(t_born);//取得workf送驗數量
						}
						
						//取得已送驗入庫的數量
						var WorkNoStr = new Array();
						for(var i=0;i<q_bbsCount;i++){
							var t_workno = $.trim($('#txtWorkno_'+i).val());
							WorkNoStr.push("'"+t_workno+"'");
						}
						var t_where = "where=^^ noa!='"+$('#txtNoa').val()+"' and workno in ("+WorkNoStr.toString()+") ^^";
						q_gt('view_workqs', t_where, 0, 0, 0, "GetMount", r_accy);
						break;*/
					case 'GetMount':
						var as = _q_appendData("view_workqs", "", true);
						for(var i=0;i<q_bbsCount;i++){
							var x_mount=0,t_mount=0,t_born=0,t_bkmount=0,t_wmount=0;
							if(!emp($('#txtWorkno_'+i).val())){
								for(var j=0;j<as.length;j++){
									if($('#txtWorkno_'+i).val()==as[j].workno&&$('#txtWorkfno_'+i).val()==as[j].workfno&&$('#txtWorkfnoq_'+i).val()==as[j].workfnoq){
										t_mount+=dec(as[j].mount);
										t_born+=dec(as[j].born);
										t_bkmount+=dec(as[j].bkmount);
										t_wmount+=dec(as[j].wmount);
									}
									if($('#txtWorkno_'+i).val()==as[j].workno){
										x_mount+=dec(as[j].mount);
									}
								}
							}
							$('#txtBorn_'+i).val(q_float('txtBorn_'+i)-t_mount-t_bkmount-t_wmount);
							$('#txtWk_inmount_'+i).val(x_mount);
							$('#txtWk_unmount_'+i).val(q_float('txtWk_mount_'+i)-q_float('txtWk_inmount_'+i));
						}
						break;
					case 'view_workus':
						var workuerror = '';
						var as = _q_appendData("view_workus", "", true);
						for (var i = 0; i < q_bbsCount; i++) {
							var worku_mount=0;
							if (!emp($('#txtWorkfno_' + i).val())) {
								for (var j = 0; j < as.length; j++) {
									if ($('#txtWorkfno_' + i).val() == as[j].workfno&&$('#txtWorkfnoq_' + i).val() == as[j].workfnoq) {
										worku_mount += dec(as[j].mount);
									}
								}
							}
							if((q_float('txtMount_' + i)+q_float('txtBkmount_' + i)+q_float('txtWmount_' + i))>worku_mount)
								workuerror+=$('#txtProduct_'+i).val()+"的\n【"+q_getMsg('lblMounts')+"+"+q_getMsg('lblBkmounts')+"+"+q_getMsg('lblWmounts')+"】："+(q_float('txtMount_' + i)+q_float('txtBkmount_' + i)+q_float('txtWmount_' + i))+"\n大於【暫收數量】："+worku_mount+"\n";
						}
						if (workuerror.length == 0) {
							checkok = true;
							btnOk();
						} else {
							alert(workuerror);
						}
						break;

					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			//檢查入庫和暫收
			var checkok = false;
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
					var workf_where = '';
					for (var i = 0; i < q_bbsCount; i++) {
						if (!emp($('#txtWorkfno_' + i).val()))
							workf_where += "workfno='" + $('#txtWorkfno_' + i).val() + "' or ";
					}
					if (workf_where.length > 0)
						workf_where = "and (" + workf_where.substr(0, workf_where.length - 3) + ")";

					var t_where = "where=^^ 1=1 " + workf_where + "^^";
					q_gt('view_workus', t_where, 0, 0, 0, "", r_accy);
				} else {
					checkok = false;
					//如果表身倉庫沒填，表頭倉庫帶入
					for (var i = 0; i < q_bbsCount; i++) {
						if (emp($('#txtStoreno_' + i).val())) {
							$('#txtStoreno_' + i).val($('#txtStoreno').val());
							$('#txtStore_' + i).val($('#txtStore').val());
						}
					}
					
					var t_error='';
					for (var i = 0; i < q_bbsCount; i++) {
						if (!emp($('#txtProductno_' + i).val())&&q_float('txtBorn_'+i)<(q_float('txtMount_'+i)+q_float('txtBkmount_'+i)+q_float('txtWmount_'+i))) {
							t_error+=$('#txtProduct_' + i).val()+"\n【"+q_getMsg('lblBorn')+"】："+$('#txtBorn_'+i).val()+" 小於\n【"+q_getMsg('lblMounts')+"+"+q_getMsg('lblBkmounts')+"+"+q_getMsg('lblWmounts')+"】："+(q_float('txtMount_'+i)+q_float('txtBkmount_'+i)+q_float('txtWmount_'+i))+"\n"
						}
					}
					
					if(t_error.length>0){
						alert(t_error);
						return;
					}
					
					if (q_cur == 1)
						$('#txtWorker').val(r_name);
					else
						$('#txtWorker2').val(r_name);
					var t_date = $('#txtDatea').val();
					var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
					if (s1.length == 0 || s1 == "AUTO")
						q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workq') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
					else
						wrServer(s1);
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('workq_s.aspx', q_name + '_s', "510px", "380px", q_getMsg("popSeek"));
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
					
					/*$('#txtMount_'+j).change(function(){
						var n=$(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
						var thisVal = dec($(this).val());
						var MaxVal = dec($(this).attr('maxValue'));
						if(thisVal>MaxVal){
							$(this).val(MaxVal);
						};
					});*/
					
					$('#txtWorkno_' + j).click(function() {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if (!emp($('#txtWorkno_' + b_seq).val())&& r_outs!='1' ) {
							t_where = "noa='" + $('#txtWorkno_' + b_seq).val() + "'";
							q_box("work.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'bbs_work', "95%", "95%", q_getMsg('PopWork'));
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
				}
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtMon').val(q_date().substr(0, 6));
				$('#txtDatea').focus();
				$('#cmbTaxtype').val('1');
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtProduct').focus();
			}

			function btnPrint() {
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
				as['tggno'] = abbm2['tggno'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				$('#div_stk').hide();
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
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
				var hasSpec = q_getPara('sys.isspec');
				var isSpec = (hasSpec.toString()=='1'?$('.isSpec').show():$('.isSpec').hide());
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
				//_btnDele();
				if (!confirm(mess_dele))
					return;
				q_cur = 3;
				//處理workc內容
				if(emp($('#txtWorkcno').val()))
					q_func('qtxt.query.c2', 'workq.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
				else{
					q_func('workc_post.post.a2', r_accy + ',' + $('#txtWorkcno').val() + ',0');
					q_func('workd_post.post.a2', r_accy + ',' + $('#txtWorkdno').val() + ',0');
				}
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

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				//abbm[q_recno]['accno'] = xmlString.split(";")[0];
				//var t_noa = $.trim($('#txtNoa').val());
				/*if((t_noa.length>0) && (r_name.length > 0)){
					Lock();
					q_func('qtxt.query.workq', 'workq.txt,workqsave,' + encodeURI(t_noa) + ';' + encodeURI(r_name));
				}*/
				if (q_cur == 1 || emp($('#txtWorkcno').val()))
					q_func('qtxt.query.c0', 'workq.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
				else {
					//處理workc d內容
					q_func('workc_post.post.a1', r_accy + ',' + $('#txtWorkcno').val() + ',0');
					q_func('workd_post.post.a1', r_accy + ',' + $('#txtWorkdno').val() + ',0');
				}
			}

			function q_funcPost(t_func, result) {
				switch(t_func) {
					/*case 'qtxt.query.workq':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							var workdno = $.trim(as[0].workdno);
							if(workdno.length > 0){
								q_func('workd_post.post',r_accy+','+workdno+',0');
								q_func('workd_post.post',r_accy+','+workdno+',1');
								abbm[q_recno]['workdno'] = as[0].workdno;
								$('#txtWorkdno').val(as[0].workdno);
							}
						}
						Unlock();
						break;*/
					case 'workc_post.post.a1':
						//呼叫workf.post
						q_func('qtxt.query.c0', 'workq.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
						break;
					case 'workc_post.post.a2':
						//呼叫workf.post
						q_func('qtxt.query.c2', 'workq.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
						break;
					case 'qtxt.query.c0':
						q_func('qtxt.query.c1', 'workq.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';1');
						break;
					case 'qtxt.query.c1':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							abbm[q_recno]['workcno'] = as[0].workcno;
							$('#txtWorkcno').val(as[0].workcno);
							abbm[q_recno]['workdno'] = as[0].workdno;
							$('#txtWorkdno').val(as[0].workdno);
							//處理workc內容
							if(!emp(as[0].workcno))
								q_func('workc_post.post', r_accy + ',' + $('#txtWorkcno').val() + ',1');
							if(!emp(as[0].workdno))
								q_func('workd_post.post', r_accy + ',' + $('#txtWorkdno').val() + ',1');
						}
						break;
					case 'qtxt.query.c2':
						_btnOk($('#txtNoa').val(), bbmKey[0], ( bbsHtm ? bbsKey[1] : ''), '', 3)
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
				width: 2500px;
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
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				float: left;
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
				width: 49%;
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
			<div class="dview" id="dview" style="float: left; width:32%;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:18%"><a id='vewDatea'></a></td>
						<td align="center" style="width:20%"><a id='vewNoa'></a></td>
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
			<div class='dbbm' style="width: 68%;float:left">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='0'>
					<tr style="height: 1px;">
						<td width="120px"></td>
						<td width="203px"></td>
						<td width="120px"></td>
						<td width="203px"></td>
						<td width="120px"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTgg' class="lbl btn"> </a></td>
						<td>
							<input id="txtTggno" type="text" class="txt" style='width:45%;'/>
							<input id="txtTgg" type="text" class="txt" style='width:48%;'/>
						</td>
						<td><span> </span><a id='lblQcresult' class="lbl"> </a></td>
						<td><select id="cmbQcresult" class="txt c1"> </select></td>
					</tr>
					<tr>
					<td><span> </span><a id='lblStoreout' class="lbl btn"> </a></td>
						<td>
							<input id="txtStoreoutno" type="text" class="txt" style='width:45%;'/>
							<input id="txtStoreout" type="text" class="txt" style='width:48%;'/>
						</td>
						<td><span> </span><a id='lblStore' class="lbl btn"> </a></td>
						<td>
							<input id="txtStoreno" type="text" class="txt" style='width:45%;'/>
							<input id="txtStore" type="text" class="txt" style='width:48%;'/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBdate' class="lbl"> </a></td>
						<td>
							<input id="txtBdate" type="text" class="txt c3" style="width: 98px;"/>
							<a style="float: left;">~</a>
							<input id="txtEdate" type="text" class="txt c3" style="width: 98px;"/>
						</td>
						<!--<td><span> </span><a id='lblWorkno' class="lbl"> </a></td>
						<td><input id="txtWorkno" type="text" class="txt c1"/></td>
						<td><input type="button" id="btnWork"></td>-->
						<td><span> </span><a id='lblWorkfno' class="lbl"> </a></td>
						<td><input id="txtWorkfno" type="text" class="txt c1"/></td>
						<td><input type="button" id="btnWorkf"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorkcno' class="lbl"> </a></td>
						<td><input id="txtWorkcno" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorkdno' class="lbl"> </a></td>
						<td><input id="txtWorkdno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td>
							<input id="txtWorker" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td>
							<input id="txtWorker2" type="text" class="txt c1"/>
						</td>
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
					<td align="center" style="width:20px;"> </td>
					<td style="width:180px;" align="center"><a id='lblProductnos'></a></td>
					<td style="width:200px;" align="center"><a id='lblProduct_s'></a></td>
					<td style="width:95px;" align="center" class="isStyle"><a id='lblStyle'></a></td>
					<td style="width:40px;" align="center"><a id='lblUnit'></a></td>
					<td style="width:100px;" align="center"><a id='lblWk_mounts'></a></td>
					<td style="width:100px;" align="center"><a id='lblWk_inmounts'></a></td>
					<td style="width:100px;" align="center"><a id='lblWk_unmounts'></a></td>
					<td style="width:100px;" align="center"><a id='lblBorn'></a></td>
					<td style="width:100px;" align="center"><a id='lblMounts'></a></td>
					<td style="width:70px;" align="center"><a id='lblQcresults'></a></td>
					<td style="width:150px;" align="center"><a id='lblStores'></a></td>
					<td style="width:100px;;" align="center"><a id='lblBkmounts'></a>/原因</td>
					<td style="width:100px;;" align="center"><a id='lblWmounts'></a>/原因</td>
					<!--<td style="width:100px;" align="center"><a id='lblInmount_s'></a></td>
					<td style="width:100px;" align="center"><a id='lblOutmount_s'></a></td>
					<td style="width:100px;" align="center"><a id='lblErrmount'></a></td>-->
					<td style="width:200px;" align="center"><a id='lblMemos'></a></td>
					<td style="width:200px;" align="center"><a id='lblWorknos'></a></td>
					<td style="width:200px;" align="center"><a id='lblWorkfnos'></a></td>
					<td style="width:30px;" align="center"><a id='lblStks'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<!--1020702製造業通常只用到數量，所以重量隱藏，並將生產數量改為報廢數量-->
					<td><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input class="txt" id="txtProductno.*" type="text" style="width:80%;" />
						<input class="btn" id="btnProductno.*" type="button" value='.' style="width:16%;" />
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
					<td><input class="txt c1 num" id="txtMount.*" type="text"/></td>
					<td><select id="cmbQcresult.*" class="txt c1"> </select></td>
					<td>
						<input class="btn" id="btnStore.*" type="button" value='.' style="width:1%;float: left;" />
						<input id="txtStoreno.*" type="text" class="txt c2" style="width: 30%;"/>
						<input id="txtStore.*" type="text" class="txt c3" style="width: 50%;"/>
					</td>
					<td>
						<input class="txt c1 num" id="txtBkmount.*" type="text"/>
						<input class="txt c1" id="txtBkrea.*" type="text"/>
					</td>
					<td>
						<input class="txt c1 num" id="txtWmount.*" type="text"/>
						<input class="txt c1" id="txtWrea.*" type="text"/>
					</td>
					<!--<td><input class="txt c1 num" id="txtInmount.*" type="text"/></td>
					<td><input class="txt c1 num" id="txtOutmount.*" type="text"/></td>
					<td>
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
						<input id="txtWorkfno.*" type="text" class="txt" style="width:68%;"/>
						<input id="txtWorkfnoq.*" type="text" class="txt" style="width:23%;"/>
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