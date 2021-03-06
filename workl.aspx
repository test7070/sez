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
		<script type="text/javascript">
			this.errorHandler = null;
			
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			
			q_desc = 1;
			q_tables = 's';
			var q_name = "workl";
			var q_readonly = ['txtNoa','txtTheory','txtDiffweight', 'txtWorker', 'txtWorker2', 'txtCngno', 'txtWorkcno','txtTgg','txtStorein','txtStore','txtCardeal','txtTranstart','txtAddr'];
			var q_readonlys = ['txtWorkno','txtTheory'];
			var bbmNum = [['txtPrice', 12, 2, 1],['txtTranmoney', 12, 0, 1],['txtTranadd', 12, 2, 1],['txtWeight', 12, 2, 1],['txtTheory', 12, 2, 1],['txtDiffweight', 12, 2, 1]];
			var bbsNum = [['txtMount', 12, 2, 1],['txtTheory', 12, 2, 1]];
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
				['txtTggno', 'lblTgg', 'tgg', 'noa,nick', 'txtTggno,txtTgg', 'tgg_b.aspx'],
				['txtCardealno', 'lblCardealno', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'],
				['txtPost', 'lblPost', 'addr2', 'noa,post', 'txtPost,txtAddr', 'addr2_b.aspx'],
				['txtTranstartno', 'lblTranstart', 'addr2', 'noa,post','txtTranstartno,txtTranstart', 'addr2_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucaucc_b.aspx']
				
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
				q_cmbParse("cmbTranstyle", q_getPara('sys.transtyle'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				//0313當撥料時同時做調撥和領料動作
				//q_cmbParse("cmbTypea", q_getPara('workl.typea'));
				$('#txtCngno').click(function() {
					if (!emp($('#txtCngno').val())) {
						t_where = "noa='" + $('#txtCngno').val() + "'";
						q_box("cng.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'cng', "95%", "95%", q_getMsg('PopCng'));
					}
				});
				$('#txtWorkcno').click(function() {
					if (!emp($('#txtWorkcno').val())) {
						t_where = "noa='" + $('#txtWorkcno').val() + "'";
						q_box("workc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'workc', "95%", "95%", q_getMsg('PopWorkc'));
					}
				});
				q_gt('style', '', 0, 0, 0, '');
				$('#btnWork').click(function() {
					var t_where = "1=1 and enda!=1 and isnull(tggno,'')=''";
					if (!emp($('#txtTggno').val())) {
						t_where += " and tggno='" + $('#txtTggno').val() + "'";
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
				$('#btnUcas').click(function(){
					if(q_cur==1 || q_cur==2){
						var tggno = $.trim($('#txtTggno').val());
						if(emp(tggno)){
							alert(q_chkEmpField([['txtTggno', q_getMsg('lblTgg')]]));
							return;
						}else{
							var t_where = '1=1 ';
							t_where += " and (noa in (select noa from uca where tggno='"+tggno+"')) ";
							t_where += ' ';
							q_box("ucas_dist_chk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucas', "550px", "600px", $('#btnUcas').val());
						}
					}
				});
				
				$('#btnWorkImport').click(function() {
					if(q_cur==1 || q_cur==2){
						if(q_chkEmpField([['txtTggno', q_getMsg('lblTgg')],['txtStoreinno', q_getMsg('lblStoreinno')]])!=""){
							alert(q_chkEmpField([['txtTggno', q_getMsg('lblTgg')],['txtStoreinno', q_getMsg('lblStoreinno')]]));
							return;
						}
						//106/08/30 改用txt 匯入
						q_func('qtxt.query.worklimport', 'workl.txt,worklimport,' + encodeURI(q_date()) + ';' + encodeURI($('#txtStoreno').val()) 
						+ ';' + encodeURI($('#txtStoreinno').val()) + ';' + encodeURI($('#txtStationno').val()) + ';' + encodeURI($('#txtTggno').val())
						+ ';' + encodeURI($('#txtBdate').val()) + ';' + encodeURI($('#txtEdate').val()) );
												
						/*var t_where = "where=^^ ['" + q_date() + "','" + $('#txtStoreinno').val() + "','') where productno=b.productno ^^";
						
						var t_where1 = "1=1 and isnull(a.enda,0)!='1' and isnull(a.isfreeze,0)!= '1'";
						t_where1+=" and a.tggno='"+$('#txtTggno').val()+"' ";
						var t_bdate = $.trim($('#txtBdate').val());
						var t_edate = $.trim($('#txtEdate').val());
						if (t_bdate.length > 0 || t_edate.length > 0) {
							if (t_edate.length == 0)
								t_edate = r_picd
							
							t_where1+=" and a.cuadate between '"+t_bdate+"' and '"+t_edate+"' and a.noa like 'W[0-9]%' ";
						}
						t_where1 = "where[1]=^^ "+t_where1+" ^^";
						q_gt('workk_works', t_where+t_where1, 0, 0, 0, "", r_accy);*/
					}
				});
				
				$('#btnStoreImport').click(function(){
					if(q_cur==1 || q_cur==2){
						var storeno = $.trim($('#txtStoreno').val());
						if(emp(storeno)){
							alert(q_chkEmpField([['txtStoreno', q_getMsg('lblStoreno')]]));
							return;
						}else{
							var t_where = "['"+q_date()+"','"+storeno+"','') where (mount>0)";
							q_box("calstk_chk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'StoreImport', "95%", "95%", q_getMsg('PopStkucc'));
						}
					}
				});
				$('#btnClose_div_stk').click(function() {
					$('#div_stk').toggle();
				});
				$('#txtWeight').change(function(){
					sum();
				});
				
				$('#txtPost').change(function(){
					GetTranPrice();
				});
				$('#txtTranstartno').change(function(){
					GetTranPrice();
				});
				$('#txtCardealno').change(function(){
					GetTranPrice();
					//取得車號下拉式選單
					var thisVal = $(this).val();
					var t_where = "where=^^ noa=N'" + thisVal + "' ^^";
					q_gt('cardeal', t_where, 0, 0, 0, "getCardealCarno");
				});
				$('#cmbTranstyle').change(function(){
					GetTranPrice();
				});
				$('#txtPrice').change(function(){
					sum();
				});
				$('#txtTranadd').change(function(){
					sum();
				});
				if (q_getPara('sys.menu').substr(0,3)!='qra'){
					$('#lblTranadd').hide()
					$('#txtTranadd').hide()
				}
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'StoreImport':
						b_ret = getb_ret();
						if((b_ret != undefined) && (b_ret.length > 0)){
							var ret = q_gridAddRow(bbsHtm, 'tbbs',
								'txtProductno,txtProduct,txtUnit,txtMount,txtSpec,txtStyle',
								b_ret.length, b_ret,
								'productno,product,unit,mount,spec,style', 'txtProductno,txtProduct,txtUnit,txtMount,txtMemo'
							);
							for(var k=0;k<ret.length;k++){
								$('#txtMount_'+ret[k]).change();
							}
						}
						break;
					case 'work':
						b_ret = getb_ret();
						if (b_ret && (q_cur == 1 || q_cur == 2)) {
							var t_where = "where=^^ noa in(" + getInStr(b_ret) + ")^^";
							q_gt('work', t_where, 0, 0, 0, "", r_accy);
						}
						break;
					case 'ucas':
						b_ret = getb_ret();
						if((b_ret != undefined) && (b_ret.length > 0)){
							var ret = q_gridAddRow(bbsHtm, 'tbbs',
								'txtProductno,txtProduct,txtUnit,txtMemo,txtSpec',
								b_ret.length, b_ret,
								'productno,product,unit,memo,spec', 'txtProductno,txtProduct,txtUnit,txtMount,txtMemo'
							);
							for(var k=0;k<ret.length;k++){
								$('#txtMount_'+ret[k]).change();
							}
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

			var StyleList = '';
			var work_stk;
			//儲存目前倉庫庫存
			var carnoList = [];
			var thisCarSpecno = '';
			var workl_import;
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
						
						workl_import=as;
						//讀其他倉庫數量
						if(emp($('#txtStoreno').val()))
							var t_where = "where=^^ ['" + q_date() + "','','') where storeno!='"+$('#txtStoreinno').val()+"' group by productno order by productno^^";
						else
							var t_where = "where=^^ ['" + q_date() + "','','') where storeno='"+$('#txtStoreno').val()+"' group by productno order by productno^^";
							
						q_gt('work_stk', t_where, 0, 0, 0, "workl_work_stk", r_accy);
						break;
					case 'workl_work_stk':
						var as= _q_appendData("stkucc", "", true);
						for (var i = 0; i < workl_import.length; i++) {
							for (var j = 0; j < as.length; j++) {
								if(workl_import[i].productno==as[j].productno){
									workl_import[i].stkmount=as[j].mount;
									
									if(dec(workl_import[i].diffmount)>dec(as[j].mount))
										as[j].mount=0;
									else 
										as[j].mount=dec(as[j].mount)-dec(workl_import[i].diffmount)
									
									break;
								}
							}
							if(dec(workl_import[i].stkmount)<=0){
								workl_import.splice(i, 1);
								i--;
								continue;
							}
							
							if(dec(workl_import[i].stkmount)<dec(workl_import[i].diffmount))
								workl_import[i].diffmount=workl_import[i].stkmount;
						}
					 	
					 	q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtStyle,txtUnit,txtMount', workl_import.length, workl_import, 'productno,product,spec,style,unit,diffmount', '');
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
							Unlock();
							break;
						}
						
						if(!t_storeinno){
							alert(q_getMsg('lblStoreinno')+'不存在');
							Unlock();
							break;
						}
						
						btnOk();
						instore=true;
						break;
					case 'GetStoreno':
						var as = _q_appendData("store", "", true);
						if(as[0] != undefined){
							$('#txtStoreinno').val(as[0].noa);
							$('#txtStorein').val(as[0].store);
						}
						break;
					case 'style' :
						var as = _q_appendData("style", "", true);
						StyleList = new Array();
						StyleList = as;
						q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
						break;
					case 'work_stk':
						work_stk = _q_appendData("stkucc", "", true);
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
								q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workl') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
							else
								wrServer(t_noa);
						}
						if (btnok_bbsstkchk && btnok_msg.length > 0) {
							alert(btnok_msg);
							Unlock();
						}
						break;
					case 'getCardealCarno' :
						var as = _q_appendData("cardeals", "", true);
						carnoList = as;
						var t_item = " @ ";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].carno + '@' + as[i].carno;
							}
						}
						for(var k=0;k<carnoList.length;k++){
							if(carnoList[k].carno==$('#txtCarno').val()){
								thisCarSpecno = carnoList[k].carspecno;
								break;
							}
						}
						document.all.combCarno.options.length = 0;
						q_cmbParse("combCarno", t_item);
						$('#combCarno').unbind('change').change(function(){
							if (q_cur == 1 || q_cur == 2) {
								$('#txtCarno').val($('#combCarno').find("option:selected").text());
							}
							for(var k=0;k<carnoList.length;k++){
								if(carnoList[k].carno==$('#txtCarno').val()){
									thisCarSpecno = carnoList[k].carspecno;
									break;
								}
							}
							GetTranPrice();
						});
						break;
					case 'GetTranPrice' :
						var as = _q_appendData("addr", "", true);
						if (as[0] != undefined) {
							$('#txtPrice').val(as[0].driverprice2);
						}else{
							$('#txtPrice').val(0);
						}
						sum();
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				} /// end switch
			}

			function q_stPost() {
				Unlock();
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				//if (q_cur == 1 || emp($('#txtCngno').val()) || emp($('#txtWorkcno').val()))
				q_func('qtxt.query.c0', 'workl.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
				/*else {
					//處理workc內容
					q_func('workc_post.post.a1', r_accy + ',' + $('#txtWorkcno').val() + ',0');
				}*/
			}

			var btnok_bbsstkchk = false, stkchkcount = 0, stkchkcount2 = 0, btnok_msg = '';
			var instore=false;
			function btnOk() {
				Lock();
				var t_err = '';
				t_err = q_chkEmpField([['txtDatea', q_getMsg('lblDatea')], ['txtTggno', q_getMsg('lblTgg')]
				, ['txtBdate', q_getMsg('lblBdate')], ['txtEdate', q_getMsg('lblBdate')]
				, ['txtStoreno', q_getMsg('lblStoreno')], ['txtStoreinno', q_getMsg('lblStoreinno')]]);

				if (t_err.length > 0) {
					alert(t_err);
					Unlock()
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
					sum();
					instore=false;
					if (q_cur == 1)
						$('#txtWorker').val(r_name);
					else
						$('#txtWorker2').val(r_name);

					var t_noa = trim($('#txtNoa').val());
					var t_date = trim($('#txtDatea').val());

					if (t_noa.length == 0 || t_noa == "AUTO")
						q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workl') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
					else
						wrServer(t_noa);
				}

			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('workl_s.aspx', q_name + '_s', "500px", "420px", q_getMsg("popSeek"));
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
					case 'txtTggno':
						$('#txtBdate').focus();
						var t_tggno = $.trim($('#txtTggno').val());
						var t_where = "where=^^ tggno=N'" + t_tggno + "' ^^";
						q_gt('store', t_where, 0, 0, 0, "GetStoreno", r_accy);
						break;
					case 'txtCardealno':
						//取得車號下拉式選單
						var thisVal = $('#txtCardealno').val();
						var t_where = "where=^^ noa=N'" + thisVal + "' ^^";
						q_gt('cardeal', t_where, 0, 0, 0, "getCardealCarno");
						GetTranPrice();
						break;
					case 'txtPost':
						GetTranPrice();
						break;
					case 'txtTranstartno':
						GetTranPrice();
						break;	
					default:
						break;
				}
			}
			
			function GetTranPrice(){
				var Post = $.trim($('#txtPost').val()); 
				var Cardealno = $.trim($('#txtCardealno').val()); 
				var TranStyle = $.trim($('#cmbTranstyle').val());
				var Transtartno = $.trim($('#txtTranstartno').val()); 
				var Carspecno = $.trim(thisCarSpecno);
				var t_where = 'where=^^ 1=1 ';
				t_where += " and post=N'" + Post + "' ";
				t_where += " and transtartno=N'" + Transtartno + "' ";
				t_where += " and cardealno=N'" + Cardealno + "' ";
				t_where += " and transtyle=N'" + TranStyle + "' ";
				if(Carspecno.length > 0){
					t_where += " and carspecno=N'" + Carspecno + "' ";
				}
				t_where += ' ^^';
				q_gt('addr', t_where, 0, 0, 0, "GetTranPrice");
			}
			
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
			}

			function btnPrint() {
				q_box("z_worklp.aspx" + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
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
						$('#txtMount_' + i).change(function(){
							sum();
						});
						$('#txtMemo_' + i).change(function(){
							sum();
						});
						$('#txtTheory_'+i).change(function(){
							sum();
						});
					}
				}
				_bbsAssign();
			}

			function bbsSave(as) {
				if (!as['productno']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['datea'] = abbm2['datea'];
				as['tggno'] = abbm2['tggno'];
				as['storeno'] = abbm2['storeno'];
				as['storeinno'] = abbm2['storeinno'];
				as['typea'] = abbm2['typea'];

				return true;
			}

			function sum() {
				var t_theory=0,t_weight=0,t_diffweight=0;
				var t_theorys=0;
				t_weight = dec($('#txtWeight').val());
				for(var n=0;n<q_bbsCount;n++){
					var t_memo = $.trim($('#txtMemo_'+n).val());
					if(t_memo.length > 0){
						var SizeArray = tranSize(t_memo);
						var theory_setting = {
							calc : StyleList,
							radius : 0,
							dime : (SizeArray[0]?dec(SizeArray[0]):0),
							width : (SizeArray[1]?dec(SizeArray[1]):0),
							lengthb : (SizeArray[2]?dec(SizeArray[2]):0),
							mount : dec($('#txtMount_'+n).val()),
							style : 'S',
							round : 2
						};
						t_theorys = theory_st(theory_setting);
						t_theory = q_add(t_theory,t_theorys);
						$('#txtTheory_'+n).val(t_theorys);
					}
				}
				t_diffweight = q_sub(t_weight,t_theory);
				$('#txtTheory').val(t_theory);
				$('#txtDiffweight').val(t_diffweight);
				var price = dec($('#txtPrice').val());
				var addMoney = dec(q_getPara('sys.tranadd'));
				var addMul = dec($('#txtTranadd').val());
				var total = 0
				var transtyle = $.trim($('#cmbTranstyle').val());
				if(transtyle=='4' || transtyle=='9'){
					price = 0;
				}
				total = q_add(q_mul(addMoney,addMul),price);
				q_tr('txtTranmoney', total);
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
				//處理workc內容
				//q_func('workc_post.post.a2', r_accy + ',' + $('#txtWorkcno').val() + ',0');
				q_func('qtxt.query.c2', 'workl.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
			}

			function btnCancel() {
				_btnCancel();
			}
			
			//0325 拿掉 workcno 不產生領料
			function q_funcPost(t_func, result) {
				switch(t_func) {
					/*case 'workc_post.post.a1':
						//呼叫workl.post
						q_func('qtxt.query.c0', 'workl.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
						break;
					case 'workc_post.post.a2':
						//呼叫workl.post
						q_func('qtxt.query.c2', 'workl.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';0');
						break;*/
					case 'qtxt.query.c0':
						q_func('qtxt.query.c1', 'workl.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val()) + ';1');
						break;
					case 'qtxt.query.c1':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							abbm[q_recno]['cngno'] = as[0].cngno;
							//abbm[q_recno]['workcno'] = as[0].workcno;
							$('#txtCngno').val(as[0].cngno);
							//$('#txtWorkcno').val(as[0].workcno);
						}
						//處理workc內容
						//q_func('workc_post.post', r_accy + ',' + $('#txtWorkcno').val() + ',1');
						break;
					case 'qtxt.query.c2':
						_btnOk($('#txtNoa').val(), bbmKey[0], ( bbsHtm ? bbsKey[1] : ''), '', 3)
						break;
					case 'qtxt.query.worklimport':
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
				width: 96%;
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
				width: 1350px;
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
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:40%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:30%"><a id='vewTgg'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='tgg'>~tgg</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height: 1px;">
						<td width="130px"></td>
						<td width="255px"></td>
						<td width="130px"></td>
						<td width="255px"></td>
						<td width="130px"></td>
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
						<td class="td1"><span> </span><a id='lblTgg' class="lbl btn"> </a></td>
						<td class="td2">
							<input id="txtTggno" type="text" class="txt c2"/>
							<input id="txtTgg" type="text" class="txt c3"/>
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
						<td class="td1"><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td class="td2"><select id="cmbTrantype" class="txt c1"> </select></td>
						<td class="td3"><span> </span><a id="lblTranstyle" class="lbl" > </a></td>
						<td class="td4"><select id="cmbTranstyle" class="txt c1"> </select></td>
						<td class="td5"><input id="btnUcas" type="button" class="txt c5"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCardealno' class="lbl btn"> </a></td>
						<td class="td2">
							<input id="txtCardealno" type="text" class="txt c2"/>
							<input id="txtCardeal" type="text" class="txt c3"/>
						</td>
						<td class="td3"><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td class="td4">
							<input id="txtCarno" type="text" class="txt" style="width:90%;"/>
							<select id="combCarno" style="width: 20px;"> </select>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblTranstart' class="lbl btn"> </a></td>
						<td class="td2">
							<input id="txtTranstartno" type="text" class="txt c2"/>
							<input id="txtTranstart" type="text" class="txt c3"/>
						</td>
						<td class="td1"><span> </span><a id='lblPost' class="lbl btn"> </a></td>
						<td class="td2">
							<input id="txtPost" type="text" class="txt c2"/>
							<input id="txtAddr" type="text" class="txt c3"/>
						</td>
						<td style="display:none;" class="td2"><input id="btnStoreImport" type="button" class="txt c5"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td class="td2"><input id="txtWeight" type="text" class="txt c5 num"/></td>
						<td class="td1"><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td class="td2"><input id="txtPrice" type="text" class="txt c5 num"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblTheory' class="lbl"> </a></td>
						<td class="td2"><input id="txtTheory" type="text" class="txt c5 num"/></td>
						<td class="td1"><span> </span><a id='lblTranadd' class="lbl"> </a></td>
						<td class="td2"><input id="txtTranadd" type="text" class="txt c5 num"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblDiffweight' class="lbl"> </a></td>
						<td class="td2"><input id="txtDiffweight" type="text" class="txt c5 num"/></td>
						<td class="td1"><span> </span><a id='lblTranmoney' class="lbl"> </a></td>
						<td class="td2"><input id="txtTranmoney" type="text" class="txt c5 num"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCngno' class="lbl"> </a></td>
						<td class="td2"><input id="txtCngno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td class="td2" colspan="3"><input id="txtMemo" type="text" class="txt c5"/></td>
					</tr>
					<tr>
						<td class="td3"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td4"><input id="txtWorker" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
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
					<td align="center" style="width:200px;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:250px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:95px;" class="isStyle"><a id='lblStyle'> </a></td>
					<td align="center" style="width:40px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblUno_s'> </a></td>
					<td align="center" style="width:250px;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblStk_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblTheory_s'> </a></td>
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
					<td><input id="txtTheory.*" type="text" class="txt c1 num"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
