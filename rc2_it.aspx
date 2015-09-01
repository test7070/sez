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

			q_tables = 's';
			var q_name = "rc2";
			var decbbs = ['money', 'total', 'mount', 'price', 'sprice', 'dime', 'width', 'lengthb', 'weight2'];
			var decbbm = ['payed', 'unpay', 'usunpay', 'uspayed', 'ustotal', 'discount', 'money', 'tax', 'total', 'weight', 'floata', 'mount', 'price', 'tranmoney', 'totalus'];
			var q_readonly = ['txtNoa', 'txtAcomp', 'txtTgg', 'txtWorker', 'txtWorker2','txtTranstart','txtMoney','txtTotal'];
			var q_readonlys = ['txtNoq'];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'datea';
			aPop = new Array(
				['txtTggno', 'lblTgg', 'tgg', 'noa,nick,tel,zip_invo,addr_comp,paytype', 'txtTggno,txtTgg,txtTel,txtPost,txtAddr,txtPaytype', 'tgg_b.aspx'],
				['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'],
				['txtRackno_', 'btnRackno_', 'rack', 'noa,rack,storeno,store', 'txtRackno_', 'rack_b.aspx'],
				//['txtPost', 'lblAddr', 'addr', 'post,addr', 'txtPost,txtAddr', 'addr_b.aspx'],
				//['txtPost2', 'lblAddr2', 'addr', 'post,addr', 'txtPost2,txtAddr2', 'addr_b.aspx'],
				['txtPost', 'lblAddr', 'addr2', 'noa,post', 'txtPost', 'addr2_b.aspx'],
				['txtPost2', 'lblAddr2', 'addr2', 'noa,post', 'txtPost2', 'addr2_b.aspx'],
				['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp,addr', 'txtCno,txtAcomp,txtAddr2', 'acomp_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product,unit,spec', 'txtProductno_,txtProduct_,txtUnit_,txtSpec_', 'ucaucc_b.aspx'],
				['txtUno_', 'btnUno_', 'view_uccc', 'uno', 'txtUno_', 'uccc_seek_b.aspx?;;;1=0', '95%', '60%'],
				['txtCarno', 'lblCar', 'cardeal', 'noa,comp', 'txtCarno,txtCar', 'cardeal_b.aspx'],
				['txtTranstartno', 'lblTranstart', 'addr2', 'noa,post','txtTranstartno,txtTranstart', 'addr2_b.aspx']
			);

			var isinvosystem = false;
			//購買發票系統
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
				//判斷是否有買發票系統
				q_gt('ucca', 'stop=1 ', 0, 0, 0, "ucca_invo");
				q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function sum() {
				var t1 = 0, t_unit, t_mount, t_weight = 0;
				var t_money = 0;
				for (var j = 0; j < q_bbsCount; j++) {
					t_money = q_add(t_money, q_float('txtTotal_' + j));
					t_weight += q_float('txtMount_' + j);
				}
				q_tr('txtMoney', t_money);
				q_tr('txtTotal', q_add(q_float('txtMoney'), q_float('txtTax')));
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
				calTax();
				q_tr('txtTotalus', q_mul(q_float('txtTotal'), q_float('txtFloata')));
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
				q_mask(bbmMask);
				bbmNum = [['txtMoney', 15, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 15, 0, 1],['txtPrice', 10, q_getPara('rc2.pricePrecision'), 1], ['txtTotalus', 15, 0, 1], ['txtFloata', 10, 2, 1],['txtTranmoney',15,0,1],['txtTranadd',15,q_getPara('rc2.pricePrecision'),1]];
				bbsNum = [['txtMount', 15, q_getPara('rc2.mountPrecision'), 1], ['txtPrice', 15, q_getPara('rc2.pricePrecision'), 1], ['txtTotal', 15, 0, 1]];
				
				q_cmbParse("cmbTranstyle", q_getPara('sys.transtyle'));
				q_cmbParse("cmbTypea", q_getPara('rc2.typea'));
				/*if (q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1)
					q_cmbParse("cmbStype", q_getPara('rc2.stype_it'));
				else*/
					q_cmbParse("cmbStype", q_getPara('rc2.stype'));
				//q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_cmbParse("combPaytype", q_getPara('rc2.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				var t_where = "where=^^ 1=1 group by post,addr^^";
				q_gt('custaddr', t_where, 0, 0, 0, "");
				
				//限制帳款月份的輸入 只有在備註的第一個字為*才能手動輸入					
				$('#txtMemo').change(function(){
					if ($('#txtMemo').val().substr(0,1)=='*')
						$('#txtMon').removeAttr('readonly');
					else
						$('#txtMon').attr('readonly', 'readonly');
				});
				
				$('#txtMon').click(function(){
					if ($('#txtMon').attr("readonly")=="readonly" && (q_cur==1 || q_cur==2))
						q_msg($('#txtMon'), "月份要另外設定，請在"+q_getMsg('lblMemo')+"的第一個字打'*'字");
				});
				
				$('#lblAccc').click(function() {
					q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('lblAccc'), true);
				});
				
				$('#lblOrdc').click(function() {
					lblOrdc();
				});
				
				$('#lblInvono').click(function() {
					t_where = '';
					t_invo = $('#txtInvono').val();
					if (t_invo.length > 0) {
						t_where = "noa='" + t_invo + "'";
						q_box("rc2a.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'rc2a', "95%", "95%", q_getMsg('popRc2a'));
					}
				});
				
				$('#lblInvo').click(function() {
					t_where = '';
					t_invo = $('#txtInvo').val();
					if (t_invo.length > 0) {
						t_where = "noa='" + t_invo + "'";
						q_box("invoi.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'invoi', "95%", "95%", $('#lblInvo').val());
					}
				});
				
				$('#lblLcno').click(function() {
					t_where = '';
					t_lcno = $('#txtLcno').val();
					if (t_lcno.length > 0) {
						t_where = "lcno='" + t_lcno + "'";
						q_box("lcs.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'lcs', "95%", "95%", q_getMsg('popLcs'));
					}
				});
				
				$('#txtFloata').change(function() {
					sum();
				});
				
				$('#txtTotal').change(function() {
					sum();
				});
				
				$('#txtTggno').change(function() {
					if (!emp($('#txtTggno').val())) {
						var t_where = "where=^^ noa='" + $('#txtTggno').val() + "' group by post,addr^^";
						q_gt('custaddr', t_where, 0, 0, 0, "");
					}
				});

				$('#txtAddr').change(function() {
					var t_tggno = trim($(this).val());
					if (!emp(t_tggno)) {
						focus_addr = $(this).attr('id');
						zip_fact = $('#txtPost').attr('id');
						var t_where = "where=^^ noa='" + t_tggno + "' ^^";
						q_gt('tgg', t_where, 0, 0, 0, "");
					}
				});
				
				$('#txtAddr2').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						zip_fact = $('#txtPost2').attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}
				});
				
				$('#txtPost').change(function() {
					GetTranPrice();
				});
				
				$('#txtPost2').change(function() {
					GetTranPrice();
				});
				
				$('#txtTranstartno').change(function(){
					GetTranPrice();
				});
				
				$('#txtCardealno').change(function() {
					GetTranPrice();
					//取得車號下拉式選單
					var thisVal = $(this).val();
					var t_where = "where=^^ noa=N'" + thisVal + "' ^^";
					q_gt('cardeal', t_where, 0, 0, 0, "getCardealCarno");
				});
				
				$('#cmbTranstyle').change(function() {
					GetTranPrice();
				});
				
				if (isinvosystem)
					$('.istax').hide();
					
				$('#txtPrice').change(function(){
					sum();
				});
				
				$('#txtTranadd').change(function(){
					sum();
				});
				
				$('#cmbStype').change(function() {
					stype_chang();
				});
				
				if (q_getPara('sys.menu').substr(0,3)!='qra'){
					$('#lblTranadd').hide()
					$('#txtTranadd').hide()
				}
			}

			function GetTranPrice() {
				var Post2 = $.trim($('#txtPost2').val());
				var Post = $.trim($('#txtPost').val());
				var Transtartno = $.trim($('#txtTranstartno').val()); 
				var Cardealno = $.trim($('#txtCardealno').val());
				var TranStyle = $.trim($('#cmbTranstyle').val());
				var Carspecno = $.trim(thisCarSpecno);
				var t_where = 'where=^^ 1=1 ';
				t_where += " and post=N'" + (Post2.length > 0 ? Post2 : Post) + "' ";
				t_where += " and transtartno=N'" + Transtartno + "' ";
				t_where += " and cardealno=N'" + Cardealno + "' ";
				t_where += " and transtyle=N'" + TranStyle + "' ";
				if(Carspecno.length > 0){
					t_where += " and carspecno=N'" + Carspecno + "' ";
				}
				t_where += ' ^^';
				q_gt('addr', t_where, 0, 0, 0, "GetTranPrice");
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'ordcs':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0) {
								b_pop = '';
								return;
							}
							//取得採購的資料
							var t_where = "where=^^ noa='" + b_ret[0].noa + "' ^^";
							q_gt('ordc', t_where, 0, 0, 0, "", r_accy);

							$('#txtOrdcno').val(b_ret[0].noa);
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtUno,txtProductno,txtSpec,txtProduct,txtUnit,txtMount,txtOrdeno,txtNo2,txtPrice,txtTotal,txtMemo', b_ret.length, b_ret, 'uno,productno,spec,product,unit,mount,noa,no2,price,total,memo', 'txtProductno,txtProduct');
							bbsAssign();
							sum();
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			var focus_addr = '', zip_fact = '';
			var z_cno = r_cno, z_acomp = r_comp, z_nick = r_comp.substr(0, 2);
			var carnoList = [];
			var thisCarSpecno = '';
			var ordcoverrate = [],rc2soverrate = [];
			function q_gtPost(t_name) {
				switch (t_name) {
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
						} else {
							$('#txtPrice').val(0);
						}
						sum();
						break;
					case 'ucca_invo':
						var as = _q_appendData("ucca", "", true);
						if (as[0] != undefined) {
							isinvosystem = true;
							$('.istax').hide();
						} else {
							isinvosystem = false;
						}
						break;
					case 'cno_acomp':
						var as = _q_appendData("acomp", "", true);
						if (as[0] != undefined) {
							z_cno = as[0].noa;
							z_acomp = as[0].acomp;
							z_nick = as[0].nick;
						}
						break;
					case 'flors_coin':
						var as = _q_appendData("flors", "", true);
						var z_coin='';
						for ( i = 0; i < as.length; i++) {
							z_coin+=','+as[i].coin;
						}
						if(z_coin.length==0) z_coin=' ';
						
						q_cmbParse("cmbCoin", z_coin);
						if(abbm[q_recno])
							$('#cmbCoin').val(abbm[q_recno].coin);
						
						break;
					case 'flors':
						var as = _q_appendData("flors", "", true);
						if (as[0] != undefined) {
							q_tr('txtFloata',as[0].floata);
							sum();
						}
						break;
					case 'custaddr':
						var as = _q_appendData("custaddr", "", true);
						var t_item = " @ ";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].post + '@' + as[i].addr;
							}
						}
						document.all.combAddr.options.length = 0;
						q_cmbParse("combAddr", t_item);
						break;
					case 'tgg':
						var as = _q_appendData("tgg", "", true);
						if (as[0] != undefined && focus_addr != '') {
							$('#' + zip_fact).val(as[0].zip_fact);
							$('#' + focus_addr).val(as[0].addr_fact);
							zip_fact = '';
							focus_addr = '';
						}
						break;
					case 'cust':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined && focus_addr != '') {
							$('#' + zip_fact).val(as[0].zip_fact);
							$('#' + focus_addr).val(as[0].addr_fact);
							zip_fact = '';
							focus_addr = '';
						}
						break;
					case 'btnDele':
						var as = _q_appendData("pays", "", true);
						if (as[0] != undefined) {
							var t_msg = "", t_paysale = 0;
							for (var i = 0; i < as.length; i++) {
								t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
								if (t_paysale != 0)
									t_msg += String.fromCharCode(13) + '付款單號【' + as[i].noa + '】 ' + FormatNumber(t_paysale);
							}
							if (t_msg.length > 0) {
								alert('已沖帳:' + t_msg);
								Unlock(1);
								return;
							}
						}
						_btnDele();
						Unlock(1);
						break;
					case 'btnModi':
						var as = _q_appendData("pays", "", true);
						if (as[0] != undefined) {
							var t_msg = "", t_paysale = 0;
							for (var i = 0; i < as.length; i++) {
								t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
								if (t_paysale != 0)
									t_msg += String.fromCharCode(13) + '付款單號【' + as[i].noa + '】 ' + FormatNumber(t_paysale);
							}
							if (t_msg.length > 0) {
								alert('已沖帳:' + t_msg);
								Unlock(1);
								return;
							}
						}
						_btnModi();
						Unlock(1);
						$('#txtDatea').focus();
						if (!emp($('#txtTggno').val())) {
							var t_where = "where=^^ noa='" + $('#txtTggno').val() + "' group by post,addr^^";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}
						break;
					case 'ordc':
						var ordc = _q_appendData("ordc", "", true);
						if (ordc[0] != undefined) {
							$('#combPaytype').val(ordc[0].paytype);
							$('#txtPaytype').val(ordc[0].pay);
							$('#cmbTrantype').val(ordc[0].trantype);
							$('#cmbCoin').val(ordc[0].coin);
							$('#txtPost2').val(ordc[0].post2);
							$('#txtAddr2').val(ordc[0].addr2);
						}
						break;
					case 'startdate':
						var as = _q_appendData('tgg', '', true);
						var t_startdate='';
						if (as[0] != undefined) {
							t_startdate=as[0].startdate;
						}
						if(t_startdate.length==0 || ('00'+t_startdate).slice(-2)=='00' || $('#txtDatea').val().substr(7, 2)<('00'+t_startdate).substr(-2)){
							$('#txtMon').val($('#txtDatea').val().substr(0, 6));
						}else{
							var t_date=$('#txtDatea').val();
							var nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,1);
				    		nextdate.setMonth(nextdate.getMonth() +1)
				    		t_date=''+(nextdate.getFullYear()-1911)+'/'+(nextdate.getMonth()<9?'0':'')+(nextdate.getMonth()+1);
							$('#txtMon').val(t_date);
						}
						check_startdate=true;
						btnOk();
						break;
					case 'ordc_overrate':
						ordcoverrate = _q_appendData('view_ordc', '', true);
						if (ordcoverrate[0] != undefined) {
							//抓已進貨數量
							var t_where ='';
							for (var i = 0; i < ordcoverrate.length; i++) {
								t_where=t_where+" or ordeno='"+ordcoverrate[i].noa+"'";
							}
							if(t_where.length>0){
								t_where = "where=^^ (1=0 "+t_where+") and noa!='"+$('#txtNoa').val()+"' ^^";
								q_gt('view_rc2s', t_where, 0, 0, 0, "rc2s_overrate",'');
							}
						}else{
							check_ordc_overrate=true;
							btnOk();
						}
						break;
					case 'rc2s_overrate':
						rc2soverrate = _q_appendData('view_rc2s', '', true);
						//抓ordcs的資料
						var t_where ='';
						for (var i = 0; i < ordcoverrate.length; i++) {
							t_where=t_where+" or noa='"+ordcoverrate[i].noa+"'";
						}
						if(t_where.length>0){
							t_where = "where=^^ 1=0 "+t_where+" ^^";
							q_gt('view_ordcs', t_where, 0, 0, 0, "ordcs_overrate",'');
						}
						break;
					case 'ordcs_overrate':
						var as = _q_appendData('view_ordcs', '', true);
						var t_msg='';
						//計算超交數量
						for (var j = 0; j < as.length; j++) {
							as[j].overmount=as[j].mount;
							for (var i = 0; i < ordcoverrate.length; i++) {
								if(ordcoverrate[i].noa==as[j].noa){
									as[j].overmount=q_mul(as[j].mount,q_add(1,q_div(dec(ordcoverrate[i].overrate),100)));
								}
							}
						}
						//寫入已入庫數量
						for (var j = 0; j < as.length; j++) {
							as[j].rc2smount=0;
							for (var i = 0; i < rc2soverrate.length; i++) {
								if(as[j].noa==rc2soverrate[i].ordeno && as[j].no2==rc2soverrate[i].no2){
									as[j].rc2smount=q_add(dec(as[j].rc2smount),dec(rc2soverrate[i].mount));			
								}
							}
						}
						//判斷是否超交
						for (var i = 0; i < q_bbsCount; i++) {
							for (var j = 0; j < as.length; j++) {
								if (!emp($('#txtOrdeno_'+i).val()) && $('#txtOrdeno_'+i).val()==as[j].noa && $('#txtNo2_'+i).val()==as[j].no2	
									&& (q_sub(dec(as[j].overmount),dec(as[j].rc2smount))< dec($('#txtMount_'+i).val()))){
									t_msg=t_msg+(t_msg.length>0?',':'')+$('#txtProduct_'+i).val();
								}
							}
						}
						
						if(t_msg.length>0){
							alert(t_msg+'進貨數量高於允需超交數量!!');
						}else{
							check_ordc_overrate=true;
							btnOk();
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function lblOrdc() {
				var t_tggno = trim($('#txtTggno').val());
				var t_ordeno = trim($('#txtOrdeno').val());
				var t_where = " kind!='2' &&";
				if (t_tggno.length > 0) {
					if (t_ordeno.length > 0)
						t_where = "isnull(b.enda,0)=0 && isnull(cancel,'0')='0' && datea>='"+$('#txtDatea').val()+"' && isnull(view_ordcs.enda,0)=0 && " + (t_tggno.length > 0 ? q_sqlPara("tggno", t_tggno) : "") + "&& " + (t_ordeno.length > 0 ? q_sqlPara("noa", t_ordeno) : "");
					else
						t_where = "isnull(b.enda,0)=0 && isnull(cancel,'0')='0' && datea>='"+$('#txtDatea').val()+"' && isnull(view_ordcs.enda,0)=0 && " + (t_tggno.length > 0 ? q_sqlPara("tggno", t_tggno) : "");
					t_where = t_where;
				} else {
					var t_err = q_chkEmpField([['txtTggno', q_getMsg('lblTgg')]]);
					alert(t_err);
					return;
				}
				q_box("ordcs_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy, 'ordcs', "95%", "95%", $('#lblOrdc').text());
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				var s1 = xmlString.split(';');
				abbm[q_recno]['accno'] = s1[0];
				$('#txtAccno').val(s1[0]);
			}
			
			var check_startdate=false;
			var check_ordc_overrate=false;
			function btnOk() {
				var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtDatea', q_getMsg('lblDatea')], ['txtTggno', q_getMsg('lblTgg')], ['txtCno', q_getMsg('lblAcomp')]]);
				// 檢查空白
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				/*$('#txtMon').val($.trim($('#txtMon').val()));
				if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())) {
					alert(q_getMsg('lblMon') + '錯誤。');
					return;
				}
				
				if (emp($('#txtMon').val()))
					$('#txtMon').val($('#txtDatea').val().substr(0, 6));*/
					
				//檢查是否有超交	
				if(!check_ordc_overrate){
					var t_where ='';
					for (var i = 0; i < q_bbsCount; i++) {
						if (!emp($('#txtOrdeno_'+i).val()) && t_where.indexOf($('#txtOrdeno_'+i).val())==-1){
							t_where=t_where+" or noa='"+$('#txtOrdeno_'+i).val()+"'";
						}
					}
					if(t_where.length>0){
						t_where = "where=^^ (1=0 "+t_where+") and isnull(overrate,0)>0 ^^";
						q_gt('view_ordc', t_where, 0, 0, 0, "ordc_overrate",'');
						return;
					}
				}
				
				//判斷起算日,寫入帳款月份
				if(!check_startdate&&emp($('#txtMon').val())){
					var t_where = "where=^^ noa='"+$('#txtTggno').val()+"' ^^";
					q_gt('tgg', t_where, 0, 0, 0, "startdate", r_accy);
					return;
				}
				check_startdate=false;
				check_ordc_overrate=false;
				sum();
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				if (q_cur == 2)
					$('#txtWorker2').val(r_name);
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_rc2') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('rc2_s.aspx', q_name + '_s', "500px", "500px", q_getMsg("popSeek"));
			}

			function cmbPaytype_chg() {
				var cmb = document.getElementById("combPaytype");
				if (!q_cur)
					cmb.value = '';
				else
					$('#txtPaytype').val(cmb.value);
				cmb.value = '';
			}
			
			function coin_chg() {
				var t_where = "where=^^ ('" + $('#txtDatea').val() + "' between bdate and edate) and coin='"+$('#cmbCoin').find("option:selected").text()+"' ^^";
				q_gt('flors', t_where, 0, 0, 0, "");
			}

			function combAddr_chg() {
				if (q_cur == 1 || q_cur == 2) {
					$('#txtAddr2').val($('#combAddr').find("option:selected").text());
					$('#txtPost2').val($('#combAddr').find("option:selected").val());
				}
			}

			function bbsAssign() {
				for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#btnMinus_' + j).click(function() {
							btnMinus($(this).attr('id'));
						});
						$('#txtUnit_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_unit = $('#txtUnit_' + b_seq).val();
							var t_mount = $('#txtMount_' + b_seq).val();
							$('#txtTotal_' + b_seq).val(round(q_mul(dec($('#txtPrice_' + b_seq).val()), dec(t_mount)), 0));
						});
						$('#txtMount_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_unit = $('#txtUnit_' + b_seq).val();
							//var t_mount = (!t_unit || emp(t_unit) || trim( t_unit).toLowerCase() != 'kg' ? $('#txtMount_' + b_seq).val() : $('#txtWeight_' +b_seq).val()); // 計價量
							var t_mount = $('#txtMount_' + b_seq).val();
							$('#txtTotal_' + b_seq).val(round(q_mul(dec($('#txtPrice_' + b_seq).val()), dec(t_mount)), 0));
							sum();
						});
						$('#txtPrice_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_unit = $('#txtUnit_' + b_seq).val();
							//var t_mount = (!t_unit || emp(t_unit) || trim( t_unit).toLowerCase() != 'kg' ? $('#txtMount_' + b_seq).val() : $('#txtWeight_' +b_seq).val()); // 計價量
							var t_mount = $('#txtMount_' + b_seq).val();
							$('#txtTotal_' + b_seq).val(round(q_mul(dec($('#txtPrice_' + b_seq).val()), dec(t_mount)), 0));
							sum();
						});
						$('#txtTotal_' + j).focusout(function() {
							sum();
						});
						/*$('#btnRecord_' + j).click(function() {
						 t_IdSeq = -1;
						 q_bodyId($(this).attr('id'));
						 b_seq = t_IdSeq;
						 t_where = "tgg='" + $('#txtTggno').val() + "' and noq='" + $('#txtProductno_' + b_seq).val() + "'";
						 q_box("z_rc2record.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'rc2record', "95%", "95%", q_getMsg('lblRecord_s'));
						 });*/
						$('#btnRecord_' + j).click(function() {
							var n = replaceAll($(this).attr('id'), 'btnRecord_', '');
							q_box("z_rc2record.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";tgg=" + $('#txtTggno').val() + "&product=" + $('#txtProductno_' + n).val() + ";" + r_accy, 'z_vccstp', "95%", "95%", q_getMsg('popPrint'));
						});
					}
				}
				_bbsAssign();
				HiddenTreat();
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
				$('#cmbTaxtype').val(1);
				var t_where = "where=^^ 1=1 group by post,addr^^";
				q_gt('custaddr', t_where, 0, 0, 0, "");
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				Lock(1, {
					opacity : 0
				});
				//取得車號下拉式選單
				var thisVal = $('#txtCardealno').val();
				var t_where = "where=^^ noa=N'" + thisVal + "' ^^";
				q_gt('cardeal', t_where, 0, 0, 0, "getCardealCarno");
				var t_where = " where=^^ rc2no='" + $('#txtNoa').val() + "'^^";
				q_gt('pays', t_where, 0, 0, 0, 'btnModi', r_accy);
			}

			function btnPrint() {
				var hasStyle = q_getPara('sys.isstyle');
				if(hasStyle=='1'){
					q_box("z_rc2_ra.aspx?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
				}else{
					q_box("z_rc2p.aspx?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
				}
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] && !as['product'] && !as['spec'] && !dec(as['total'])) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['type'] = abbm2['type'];
				as['mon'] = abbm2['mon'];
				as['noa'] = abbm2['noa'];
				as['datea'] = abbm2['datea'];
				as['tggno'] = abbm2['tggno'];
				as['kind'] = abbm2['kind'];
				if (abbm2['storeno'])
					as['storeno'] = abbm2['storeno'];
				t_err = '';
				if (as['price'] != null && (dec(as['price']) > 99999999 || dec(as['price']) < -99999999))
					t_err = q_getMsg('msgPriceErr') + as['price'] + '\n';
				if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
					t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';
				if (t_err) {
					alert(t_err);
					return false;
				}
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				if (isinvosystem)
					$('.istax').hide();
				HiddenTreat();
				stype_chang();
			}

			function HiddenTreat(returnType){
				returnType = $.trim(returnType).toLowerCase();
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
				var hasSpec = q_getPara('sys.isspec');
				var isSpec = (hasSpec.toString()=='1'?$('.isSpec').show():$('.isSpec').hide());
				var hasRackComp = q_getPara('sys.rack');
				var isRack = (hasRackComp.toString()=='1'?$('.isRack').show():$('.isRack').hide());
				if(returnType=='style'){
					return (hasStyle.toString()=='1');
				}else if(returnType=='spec'){
					return (hasSpec.toString()=='1');
				}else if(returnType=='rack'){
					return (hasRackComp.toString()=='1');
				}
			}
			
			function stype_chang(){
				if($('#cmbStype').val()=='7'){
					$('.invo').show();
					$('.vcca').hide();
				}else{
					$('.invo').hide();
					$('.vcca').show();
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#combAddr').attr('disabled', 'disabled');
				} else {
					$('#combAddr').removeAttr('disabled');
				}
				HiddenTreat();
				
				//限制帳款月份的輸入 只有在備註的第一個字為*才能手動輸入
				if ($('#txtMemo').val().substr(0,1)=='*')
					$('#txtMon').removeAttr('readonly');
				else
					$('#txtMon').attr('readonly', 'readonly');
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
				Lock(1, {
					opacity : 0
				});
				var t_where = " where=^^ rc2no='" + $('#txtNoa').val() + "'^^";
				q_gt('pays', t_where, 0, 0, 0, 'btnDele', r_accy);
			}

			function btnCancel() {
				_btnCancel();
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtCardealno':
						//取得車號下拉式選單
						var thisVal = $('#txtCardealno').val();
						var t_where = "where=^^ noa=N'" + thisVal + "' ^^";
						q_gt('cardeal', t_where, 0, 0, 0, "getCardealCarno");
						GetTranPrice();
						break;
					case 'txtPost2':
						GetTranPrice();
						break;
					case 'txtPost':
						GetTranPrice();
						break;
					case 'txtTranstartno':
						GetTranPrice();
						break;	
					case 'txtTggno':
						if (!emp($('#txtTggno').val())) {
							var t_where = "where=^^ noa='" + $('#txtTggno').val() + "' ^^";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}
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

			function calTax() {
				var t_money = 0, t_tax = 0, t_total = 0;
				for (var j = 0; j < q_bbsCount; j++) {
					t_money += q_float('txtTotal_' + j);
				}
				t_total = t_money;
				if (!isinvosystem) {
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
							break;
					}
				}
				$('#txtMoney').val(FormatNumber(t_money));
				$('#txtTax').val(FormatNumber(t_tax));
				$('#txtTotal').val(FormatNumber(t_total));
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
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
				float: left;
			}
			.txt.c6 {
				width: 25%;
			}
			.txt.ime {
				ime-mode:disabled;
				-webkit-ime-mode: disabled;
				-moz-ime-mode:disabled;
				-o-ime-mode:disabled;
				-ms-ime-mode:disabled;
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
			.tbbm td {
				width: 9%;
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
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden; width: 1270px;">
			<div class="dview" id="dview">
				<table class="tview" id="tview" >
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:5%"><a id='vewTypea'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%"><a id='vewTgg'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='typea=rc2.typea'>~typea=rc2.typea</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='tggno tgg,4' style="text-align: left;">~tggno ~tgg,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm" style="width: 872px;">
					<tr class="tr1">
						<td class="td1"><span> </span><a id='lblType' class="lbl"> </a></td>
						<td class="td2">
							<input id="txtType" type="text" style='display:none;'/>
							<select id="cmbTypea" class="txt c1"></select>
						</td>
						<td class="td3"><span> </span><a id='lblStype' class="lbl"> </a></td>
						<td class="td4"><select id="cmbStype" class="txt c1"></select></td>
						<td class="td5"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td6"><input id="txtDatea" type="text" class="txt c1 ime"/></td>
						<td class="td7"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td8"><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td class="td2"><input id="txtCno" type="text" class="txt c1"/></td>
						<td class="td3" colspan="2"><input id="txtAcomp" type="text" class="txt c1"/></td>
						<td class="td7" ><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td class="td8"><input id="txtMon" type="text" class="txt c1"/></td>
						<td class="td7">
							<span> </span>
							<a id='lblInvono' class="lbl btn vcca"> </a>
							<a id='lblInvo' class="lbl btn invo"> </a>
						</td>
						<td class="td8">
							<input id="txtInvono" type="text" class="txt c1 vcca"/>
							<input id="txtInvo" type="text" class="txt c1 invo"/>
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id='lblTgg' class="lbl btn"> </a></td>
						<td class="td2"><input id="txtTggno" type="text" class="txt c1" /></td>
						<td class="td3" colspan="2"><input id="txtTgg" type="text" class="txt c1"/></td>
						<td class="td1"><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td class="td2"><input id="txtTel" type="text" class="txt c1"/></td>
						<td class="td7"><span> </span><a id='lblOrdc' class="lbl btn"> </a></td>
						<td class="td8"><input id="txtOrdcno" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblAddr' class="lbl btn"> </a></td>
						<td class="td2"><input id="txtPost" type="text" class="txt c1"/></td>
						<td class="td3" colspan='4' >
							<input id="txtAddr" type="text" class="txt" style="width: 98%;"/>
						</td>
						<td class="td7"><span> </span><a id='lblLcno' class="lbl btn invo"> </a></td>
						<td class="td8"><input id="txtLcno" type="text" class="txt c1  invo"/></td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id='lblAddr2' class="lbl btn"> </a></td>
						<td class="td2"><input id="txtPost2" type="text" class="txt c1"/></td>
						<td class="td3" colspan='4' >
							<input id="txtAddr2" type="text" class="txt" style="width: 95%;"/>
							<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'> </select>
						</td>
						<td class="td4"><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td class="td5"><select id="cmbTrantype" class="txt c1"></select></td>
					</tr>
					<tr class="tr6">
						<td class="td4"><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td class="td5" colspan='2'>
							<input id="txtPaytype" type="text" class="txt c3"/>
							<select id="combPaytype" class="txt c2" onchange='cmbPaytype_chg()'> </select>
						</td>
						<td class="td1"><span> </span><a id='lblCardeal' class="lbl btn"> </a></td>
						<td class="td2" colspan='2'>
							<input id="txtCardealno" type="text" class="txt c2"/>
							<input id="txtCardeal" type="text" class="txt c3"/>
						</td>
						<td class="td7"><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td class="td8"><input id="txtPrice" type="text" class="txt num c1" /></td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id='lblTranstart' class="lbl btn"> </a></td>
						<td class="td2"><input id="txtTranstartno" type="text" class="txt c1"/></td>
						<td class="td3"><input id="txtTranstart" type="text" class="txt c1"/></td>
						<td class="td4"><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td class="td5">
							<input id="txtCarno" type="text" class="txt" style="width:75%;"/>
							<select id="combCarno" style="width: 20%;"> </select>
						</td>
						<td><select id="cmbTranstyle" style="width: 100%;"> </select></td>
						<td class="td7"><span> </span><a id='lblTranadd' class="lbl"> </a></td>
						<td class="td8"><input id="txtTranadd" type="text" class="txt num c1" /></td>
					</tr>
					<tr class="tr8">
						<td class="td1"><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td class="td2"colspan='2'>
							<input id="txtMoney" type="text" class="txt num c1" />
						</td>
						<td class="td4" ><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td class="td5" colspan='2' >
							<input id="txtTax" type="text" class="txt num c1 istax" style="width: 49%;" />
							<select id="cmbTaxtype" class="txt c1" style="width: 49%;" onchange="calTax();"> </select>
						</td>
						<td class="td7"><span> </span><a id='lblTranmoney' class="lbl"> </a></td>
						<td class="td8"><input id="txtTranmoney" type="text" class="txt num c1" /></td>
					</tr>
					<tr class="tr9">
						<td class="td1"><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td class="td2" ><select id="cmbCoin" class="txt c1" onchange='coin_chg()'> </select></td>
						<td class="td3" ><input id="txtFloata" type="text" class="txt num c1" /></td>
						<td class="td4"><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td class="td5" colspan='2'>
							<input id="txtTotalus" type="text" class="txt num c1" />
						</td>
						<td class="td7"><span> </span><a id='lblTotal' class="lbl istax"> </a></td>
						<td class="td8"><input id="txtTotal" type="text" class="txt num c1 istax" /></td>
					</tr>
					<tr class="tr10">
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td class="td2" colspan='7' >
							<input id="txtMemo" type="text" class="txt" style="width:98%;"/>
						</td>
					</tr>
					<tr class="tr11">
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2"><input id="txtWorker" type="text" class="txt c1"/></td>
						<td class="td3"><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td class="td4"><span> </span><a id='lblAccc' class="lbl btn"> </a></td>
						<td class="td5" colspan="2"><input id="txtAccno" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1300px;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:1%;">
						<input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
					</td>
					<td align="center" style="width:180px;"><a id='lblProductno'> </a></td>
					<td align="center" style="width:220px;"><a id='lblProduct'> </a></td>
					<td align="center" style="width:95px;" class="isStyle"><a id='lblStyle'> </a></td>
					<td align="center" style="width:40px;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrices'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTotals'> </a></td>
					<td align="center" style="width:80px;"><a id='lblStore_s'> </a></td>
					<td align="center" style="width:80px;" class="isRack"><a id='lblRackno_s'> </a></td>
					<td align="center" style="width:180px;"><a id='lblMemos'> </a></td>
					<td align="center" style="width:40px;"><a id='lblRecord_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td>
						<input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
					</td>
					<td>
						<input id="txtProductno.*" type="text" class="txt c1"/>
						<input class="btn" id="btnProductno.*" type="button" value='.' style="font-weight: bold;" />
						<input id="txtNoq.*" type="text" class="txt c6"/>
					</td>
					<td>
						<input type="text" id="txtProduct.*" class="txt c1"/>
						<input type="text" id="txtSpec.*" class="txt c1 isSpec"/>
					</td>
					<td class="isStyle"><input id="txtStyle.*" type="text" class="txt c1"/></td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td><input id="txtMount.*" type="text" class="txt num c1" /></td>
					<td><input id="txtPrice.*" type="text" class="txt num c1" /></td>
					<td><input id="txtTotal.*" type="text" class="txt num c1" /></td>
					<td>
						<input id="txtStoreno.*" type="text" class="txt c1" style="width: 65%"/>
						<input class="btn" id="btnStoreno.*" type="button" value='.' style=" font-weight: bold;" />
						<input id="txtStore.*" type="text" class="txt c1"/>
					</td>
					<td class="isRack">
						<input class="btn" id="btnRackno.*" type="button" value='.' style="float:left;" />
						<input id="txtRackno.*" type="text" class="txt c1" style="width: 65%"/>
					</td>
					<td>
						<input id="txtMemo.*" type="text" class="txt c1"/>
						<input id="txtOrdeno.*" type="text" class="txt" style="width:65%;" />
						<input id="txtNo2.*" type="text" class="txt" style="width:25%;" />
						<input id="recno.*" style="display:none;"/>
					</td>
					<td align="center">
						<input class="btn" id="btnRecord.*" type="button" value='.' style=" font-weight: bold;" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>