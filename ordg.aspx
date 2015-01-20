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
			var q_name = "ordg";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2', 'txtComp', 'txtAcomp', 'txtTgg', 'txtOrdeno', 'txtOrdcno','txtObu','txtSupacomp','txtOordeno','txtOordcno','txtSordeno','txtSordcno'];
			var q_readonlys = ['txtProfit'];
			var bbmNum = [['txtTaxrate', 15, 2, 1], ['txtFloata', 15, 4, 1], ['txtBfloat', 15, 4, 1], ['txtOfloat', 15, 4, 1], ['txtObfloat', 15, 4, 1], ['txtSfloat', 15, 4, 1], ['txtSbfloat', 15, 4, 1]];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'datea';
			brwCount2 = 15;
			aPop = new Array(
				['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,spec,unit', 'txtProductno_,txtProduct_,txtSpec_,txtUnit_,txtProduct_', 'ucc_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
				['txtObuno', 'lblObu', 'acomp', 'noa,acomp', 'txtObuno,txtObu', 'acomp_b.aspx'],
				['txtSupno', 'lblSup', 'acomp', 'noa,acomp', 'txtSupno,txtSupacomp', 'acomp_b.aspx'],
				['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
				['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
			);
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
				q_gt('flors_coin', '', 0, 0, 0, "florss_coin");
				$('#txtDatea').focus();
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
				for (var j = 0; j < q_bbsCount; j++) {
					bbs_sum(j);
					bbs_bsum(j);	
				}
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', '9999/99/99']];
				q_mask(bbmMask);
				bbsNum = [['txtPrice', 15, q_getPara('vcc.pricePrecision'), 1], ['txtMount', 15, q_getPara('vcc.mountPrecision'), 1], ['txtWeight', 15, q_getPara('vcc.weightPrecision'), 1], ['txtTotal', 15, 0, 1]
								,['txtBprice', 15, q_getPara('rc2.pricePrecision'), 1], ['txtBmount', 15, q_getPara('rc2.mountPrecision'), 1], ['txtBweight', 15, q_getPara('rc2.weightPrecision'), 1], ['txtBtotal', 15, 0, 1]
								,['txtOprice', 15, q_getPara('vcc.pricePrecision'), 1],['txtObprice', 15, q_getPara('rc2.pricePrecision'), 1],['txtSprice', 15, q_getPara('vcc.pricePrecision'), 1],['txtSbprice', 15, q_getPara('rc2.pricePrecision'), 1]];
				//q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				//q_cmbParse("cmbBcoin", q_getPara('sys.coin'));
				//q_cmbParse("cmbOcoin", q_getPara('sys.coin'));
				//q_cmbParse("cmbObcoin", q_getPara('sys.coin'));
				//q_cmbParse("cmbScoin", q_getPara('sys.coin'));
				//q_cmbParse("cmbSbcoin", q_getPara('sys.coin'));
				q_cmbParse("cmbTypea", q_getPara('ordg.typea'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				
				$('#lblOrdeno').click(function() {
					if(!emp($('#txtOrdeno').val()))
						q_box('orde.aspx' + "?;;;noa='" + trim($('#txtOrdeno').val()) + "';" + (dec($('#txtDatea').val().substr(0,4))-1911), '', "95%", "95%", q_getMsg("popOrde"));
				});
				
				$('#lblOrdcno').click(function() {
					if(!emp($('#txtOrdcno').val()))
						q_box('ordc.aspx' + "?;;;noa='" + trim($('#txtOrdcno').val()) + "';" + (dec($('#txtDatea').val().substr(0,4))-1911), '', "95%", "95%", q_getMsg("popOrdc"));
				});
				//OBU
				$('#lblOordeno').click(function() {
					if(!emp($('#txtOordeno').val()) && !emp($('#txtOdatabase').val()))
						q_box(location.origin+'/'+$('#txtOdatabase').val()+'/orde.aspx' + "?;;;noa='" + trim($('#txtOordeno').val()) + "';" + (dec($('#txtDatea').val().substr(0,4))-1911), '', "95%", "95%", q_getMsg("popOrde"));
				});
				
				$('#lblOordcno').click(function() {
					if(!emp($('#txtOordcno').val()) && !emp($('#txtOdatabase').val()))
						q_box(location.origin+'/'+$('#txtOdatabase').val()+'/ordc.aspx' + "?;;;noa='" + trim($('#txtOordcno').val()) + "';" + (dec($('#txtDatea').val().substr(0,4))-1911), '', "95%", "95%", q_getMsg("popOrdc"));
				});
				//SUP
				$('#lblSordeno').click(function() {
					if(!emp($('#txtSordeno').val()) && !emp($('#txtSdatabase').val()))
						q_box(location.origin+'/'+$('#txtSdatabase').val()+'/orde.aspx' + "?;;;noa='" + trim($('#txtSordeno').val()) + "';" + (dec($('#txtDatea').val().substr(0,4))-1911), '', "95%", "95%", q_getMsg("popOrde"));
				});
				
				$('#lblSordcno').click(function() {
					if(!emp($('#txtSordcno').val()) && !emp($('#txtSdatabase').val()))
						q_box(location.origin+'/'+$('#txtSdatabase').val()+'/ordc.aspx' + "?;;;noa='" + trim($('#txtSordcno').val()) + "';" + (dec($('#txtDatea').val().substr(0,4))-1911), '', "95%", "95%", q_getMsg("popOrdc"));
				});
				
				$('#lblInvono').click(function() {
					if(!emp($('#txtInvono').val()) &&q_cur!=1 &&q_cur!=2)
						q_box('invo.aspx' + "?;;;noa='" + trim($('#txtInvono').val()) + "';" + (dec($('#txtDatea').val().substr(0,4))-1911), '', "95%", "95%", q_getMsg("popInvo"));
				});
				
				$('#lblInvoino').click(function() {
					if(!emp($('#txtInvoino').val()) &&q_cur!=1 &&q_cur!=2)
						q_box('invoi.aspx' + "?;;;noa='" + trim($('#txtInvoino').val()) + "';" + (dec($('#txtDatea').val().substr(0,4))-1911), '', "95%", "95%", q_getMsg("popInvoi"));
				});
				
				$('#cmbTaxtype').change(function() {
					if($('#cmbTaxtype').val()=='1' || $('#cmbTaxtype').val()=='3')
						$('#txtTaxrate').val(q_getPara('sys.taxrate'));
					else 
						$('#txtTaxrate').val(0);
					Taxtype_change();
				});
			}
			
			function Taxtype_change(){
				if(q_cur==1 || q_cur==2){
					if($('#cmbTaxtype').val()=='1' || $('#cmbTaxtype').val()=='3'){
		            	$('#txtTaxrate').css('color','black').css('background','white').removeAttr('readonly');
		            }else{
		            	$('#txtTaxrate').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
		            }
	           }
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			var z_cno = r_cno, z_acomp = r_comp, z_nick = r_comp.substr(0, 2);
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'cno_acomp':
						var as = _q_appendData("acomp", "", true);
						if (as[0] != undefined) {
							z_cno = as[0].noa;
							z_acomp = as[0].acomp;
							z_nick = as[0].nick;
						}
						break;
					case 'florss_coin':
						var as = _q_appendData("flors", "", true);
						var z_coin='';
						for ( i = 0; i < as.length; i++) {
							z_coin+=','+as[i].coin;
						}
						if(z_coin.length==0) z_coin=' ';
						
						q_cmbParse("cmbCoin", z_coin);
						q_cmbParse("cmbBcoin", z_coin);
						q_cmbParse("cmbOcoin", z_coin);
						q_cmbParse("cmbObcoin", z_coin);
						q_cmbParse("cmbScoin", z_coin);
						q_cmbParse("cmbSbcoin", z_coin);
						if(abbm[q_recno]){
							$('#cmbCoin').val(abbm[q_recno].coin);
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
				if(t_name.substr(0,6)=='flors_'){
		        	var as = _q_appendData("flors", "", true);
					if (as[0] != undefined) {
						switch (t_name.split('_')[1]) {
							case '1':
								q_tr('txtFloata',as[0].floata);
							break;
							case '2':
								q_tr('txtBfloat',as[0].floata);
							break;
							case '3':
								q_tr('txtOfloat',as[0].floata);
							break;
							case '4':
								q_tr('txtObfloat',as[0].floata);
							break;
							case '5':
								q_tr('txtSfloat',as[0].floata);
							break;
							case '6':
								q_tr('txtSbfloat',as[0].floata);
							break;
						}
					}
		        }
				
			}
			
			function coin_chg(i) {
				switch (i) {
					case 1:
						var t_where = "where=^^ ('" +  (dec($('#txtDatea').val().substr(0,4))-1911)+'/'+$('#txtDatea').val().substr(5) + "' between bdate and edate) and coin='"+$('#cmbCoin').find("option:selected").text()+"' ^^";
						q_gt('flors', t_where, 0, 0, 0, "flors_"+i);
						break;
					case 2:
						var t_where = "where=^^ ('" +  (dec($('#txtDatea').val().substr(0,4))-1911)+'/'+$('#txtDatea').val().substr(5) + "' between bdate and edate) and coin='"+$('#cmbBcoin').find("option:selected").text()+"' ^^";
						q_gt('flors', t_where, 0, 0, 0, "flors_"+i);
						break;
					case 3:
						var t_where = "where=^^ ('" +  (dec($('#txtDatea').val().substr(0,4))-1911)+'/'+$('#txtDatea').val().substr(5) + "' between bdate and edate) and coin='"+$('#cmbOcoin').find("option:selected").text()+"' ^^";
						q_gt('flors', t_where, 0, 0, 0, "flors_"+i);
						break;
					case 4:
						var t_where = "where=^^ ('" +  (dec($('#txtDatea').val().substr(0,4))-1911)+'/'+$('#txtDatea').val().substr(5) + "' between bdate and edate) and coin='"+$('#cmbObcoin').find("option:selected").text()+"' ^^";
						q_gt('flors', t_where, 0, 0, 0, "flors_"+i);
						break;
					case 5:
						var t_where = "where=^^ ('" +  (dec($('#txtDatea').val().substr(0,4))-1911)+'/'+$('#txtDatea').val().substr(5) + "' between bdate and edate) and coin='"+$('#cmbScoin').find("option:selected").text()+"' ^^";
						q_gt('flors', t_where, 0, 0, 0, "flors_"+i);
						break;
					case 6:
						var t_where = "where=^^ ('" +  (dec($('#txtDatea').val().substr(0,4))-1911)+'/'+$('#txtDatea').val().substr(5) + "' between bdate and edate) and coin='"+$('#cmbSbcoin').find("option:selected").text()+"' ^^";
						q_gt('flors', t_where, 0, 0, 0, "flors_"+i);
						break;
				}
			}

			function btnOk() {
				t_err = '';
				if($('#cmbTypea').val()=='1'){
					t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtDatea', q_getMsg('lblDatea')]]);
				}else{
					t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtDatea', q_getMsg('lblDatea')], ['txtInvono', q_getMsg('lblInvono')], ['txtInvoino', q_getMsg('lblInvoino')]]);
				}
				
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				sum();

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ordg') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}
			
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				if(q_cur != 2)
					q_func('qtxt.query.u2', 'ordg.txt,post,' + encodeURI($('#txtNoa').val()) + ';1;'+q_getPara('sys.key_orde')+';'+q_getPara('sys.key_ordc')+';'+r_userno+';'+r_name+';'+q_getPara('sys.dateformat')+';'+q_getPara('vcc.pricePrecision')+';'+q_getPara('rc2.pricePrecision'));//新增,修改
			}
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.u1':
						//呼叫workf.post
						q_func('qtxt.query.u2', 'ordg.txt,post,' + encodeURI($('#txtNoa').val()) + ';1;'+q_getPara('sys.key_orde')+';'+q_getPara('sys.key_ordc')+';'+r_userno+';'+r_name+';'+q_getPara('sys.dateformat')+';'+q_getPara('vcc.pricePrecision')+';'+q_getPara('rc2.pricePrecision'));//新增,修改
						break;
					case 'qtxt.query.u2':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							abbm[q_recno]['ordeno'] = as[0].ordeno;
							abbm[q_recno]['ordcno'] = as[0].ordcno;
							abbm[q_recno]['oordeno'] = as[0].oordeno;
							abbm[q_recno]['oordcno'] = as[0].oordcno;
							abbm[q_recno]['sordeno'] = as[0].sordeno;
							abbm[q_recno]['sordcno'] = as[0].sordcno;
							abbm[q_recno]['odatabase'] = as[0].odatabase;
							abbm[q_recno]['sdatabase'] = as[0].sdatabase;
							$('#txtOrdeno').val(as[0].ordeno);
							$('#txtOrdcno').val(as[0].ordcno);
							$('#txtOordeno').val(as[0].oordeno);
							$('#txtOordcno').val(as[0].oordcno);
							$('#txtSordeno').val(as[0].sordeno);
							$('#txtSordcno').val(as[0].sordcno);
							$('#txtOdatabase').val(as[0].odatabase);
							$('#txtSdatabase').val(as[0].sdatabase);
						}
						break;
					case 'qtxt.query.u3':
						_btnOk($('#txtNoa').val(), bbmKey[0], ( bbsHtm ? bbsKey[1] : ''), '', 3)
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('ordg_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtMount_'+j).change(function() {
							var n = $(this).attr('id').split('_')[1];
							bbs_sum(n);
						});
						$('#txtWeight_'+j).change(function() {
							var n = $(this).attr('id').split('_')[1];
							bbs_sum(n);
						});
						$('#txtPrice_'+j).change(function() {
							var n = $(this).attr('id').split('_')[1];
							$('#txtBunit_'+n).val($('#txtUnit_'+n).val());
							$('#txtBmount_'+n).val($('#txtMount_'+n).val());
							$('#txtBweight_'+n).val($('#txtWeight_'+n).val());
							bbs_sum(n);
						});
						$('#txtTotal_'+j).change(function() {
							var n = $(this).attr('id').split('_')[1];
							bbs_sum(n);
						});
						$('#txtBunit_'+j).change(function() {
							var n = $(this).attr('id').split('_')[1];
							if($('#txtBunit_'+n).val()=='='){
								$('#txtBunit_'+n).val($('#txtUnit_'+n).val());
								$('#txtBmount_'+n).val($('#txtMount_'+n).val());
								$('#txtBweight_'+n).val($('#txtWeight_'+n).val());
								bbs_bsum(n);
							}
						});
						$('#txtBmount_'+j).change(function() {
							var n = $(this).attr('id').split('_')[1];
							bbs_bsum(n);
						});
						$('#txtBweight_'+j).change(function() {
							var n = $(this).attr('id').split('_')[1];
							bbs_bsum(n);
						});
						$('#txtBprice_'+j).change(function() {
							var n = $(this).attr('id').split('_')[1];
							bbs_bsum(n);
						});
						$('#txtBtotal_'+j).change(function() {
							var n = $(this).attr('id').split('_')[1];
							bbs_bsum(n);
						});
					}
				}
				_bbsAssign();
				field_hide();
			}
			
			function bbs_sum(seq) {
				if(q_float('txtPrice_'+seq)!=0){
					var t_unit = $.trim($('#txtUnit_' + seq).val()).toUpperCase();
					if(t_unit=='KG' || t_unit=='M2' || t_unit=='M' || t_unit=='批' || t_unit=='公斤' || t_unit=='噸' || t_unit=='頓'){
						q_tr('txtTotal_'+seq,q_mul(q_float('txtWeight_'+seq),q_float('txtPrice_'+seq)));
					}else{
						q_tr('txtTotal_'+seq,q_mul(q_float('txtMount_'+seq),q_float('txtPrice_'+seq)));
					}
				}
				q_tr('txtProfit_'+seq,q_sub(q_float('txtTotal_'+seq),q_float('txtBtotal_'+seq)));
			}
			
			function bbs_bsum(seq) {
				if(q_float('txtBprice_'+seq)!=0){
					var t_unit = $.trim($('#txtBunit_' + seq).val()).toUpperCase();
					if(t_unit=='KG' || t_unit=='M2' || t_unit=='M' || t_unit=='批' || t_unit=='公斤' || t_unit=='噸' || t_unit=='頓'){
						q_tr('txtBtotal_'+seq,q_mul(q_float('txtBweight_'+seq),q_float('txtBprice_'+seq)));
					}else{
						q_tr('txtBtotal_'+seq,q_mul(q_float('txtBmount_'+seq),q_float('txtBprice_'+seq)));
					}
				}
				q_tr('txtProfit_'+seq,q_sub(q_float('txtTotal_'+seq),q_float('txtBtotal_'+seq)));
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);
				
				var t_date,t_year,t_month,t_day;
				t_date = new Date();
				t_year = t_date.getUTCFullYear();
				t_month = t_date.getUTCMonth()+1;
				t_month = t_month>9?t_month+'':'0'+t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day>9?t_day+'':'0'+t_day;
				$('#txtDatea').val(t_year+'/'+t_month+'/'+t_day);
				
				$('#txtDatea').focus();
				$('#chkImport').prop("checked",true);
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
			}

			function btnPrint() {
                /*var t_where = "noa='" + $.trim($('#txtNoa').val()) + "'";
                q_box("z_ordep.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));*/
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				xmlSql = '';
				if (q_cur == 2)
					xmlSql = q_preXml();
					
				if(q_cur == 2)
					q_func('qtxt.query.u1', 'ordg.txt,post,' + encodeURI($('#txtNoa').val()) + ';0;'+q_getPara('sys.key_orde')+';'+q_getPara('sys.key_ordc')+';'+r_userno+';'+r_name+';'+q_getPara('sys.dateformat')+';'+q_getPara('vcc.pricePrecision')+';'+q_getPara('rc2.pricePrecision'));

				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] && !as['product'] && !as['spec'] && !dec(as['total'])) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();

				if (!emp(abbm2['datea']))
					as['datea'] = abbm2['datea'];

				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				field_hide();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					
				} else {
					
				}	
				
				field_hide();
				Taxtype_change();
			}
			
			function field_hide() {
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
				q_func('qtxt.query.u3', 'ordg.txt,post,' + encodeURI($('#txtNoa').val()) + ';0;'+q_getPara('sys.key_orde')+';'+q_getPara('sys.key_ordc')+';'+r_userno+';'+r_name+';'+q_getPara('sys.dateformat')+';'+q_getPara('vcc.pricePrecision')+';'+q_getPara('rc2.pricePrecision'));//刪除
			}

			function btnCancel() {
				_btnCancel();
			}

			function q_popPost(s1) {
				switch (s1) {
					
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
				width: auto;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.dbbs {
				width: 100%;
			}
			.tbbs a {
				font-size: medium;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 48%;
				float: left;
			}
			.txt.c3 {
				width: 50%;
				float: left;
			}
			.txt.c6 {
				width: 25%;
			}
			.txt.c7 {
				width: 95%;
				float: left;
			}
			.num {
				text-align: right;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;width: 1260px;">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
						<!--<td align="center" style="width:25%"><a id='vewNoa'> </a></td>-->
						<td align="center" style="width:30%"><a id='vewComp'> </a></td>
						<td align="center" style="width:30%"><a id='vewTgg'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<!--<td align="center" id='noa'>~noa</td>-->
						<td align="center" id='comp,4'>~comp,4</td>
						<td align="center" id='tgg,4'>~tgg,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm" style="width: 872px;">
					<tr class="tr1" style="height: 0px">
						<td class="td1" style="width: 108px;"> </td>
						<td class="td2" style="width: 108px;"> </td>
						<td class="td3" style="width: 108px;"> </td>
						<td class="td4" style="width: 108px;"> </td>
						<td class="td5" style="width: 108px;"> </td>
						<td class="td6" style="width: 108px;"> </td>
						<td class="td7" style="width: 108px;"> </td>
						<td class="td8" style="width: 108px;"> </td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td2"><input id="txtDatea" type="text" class="txt c1"/></td>
						<td class="td3" > </td>
						<td class="td4"> </td>
						<td class="td5"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td6" colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td class="td8" align="center"> </td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtCno" type="text" class="txt c1"/></td>
						<td class="td3" colspan="2"><input id="txtAcomp" type="text" class="txt c1"/></td>
						<td class="td5" ><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td class="td6"  colspan="2"><input id="txtContract" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblCoin" class="lbl"> </a></td>
						<td class="td2"><select id="cmbCoin" class="txt c1" onchange='coin_chg(1)'> </select></td>
						<td class="td3"><input id="txtFloata" type="text" class="txt num c1" /></td>
						<td class="td4"> </td>
						<td class="td5"><span> </span><a id="lblBcoin" class="lbl"> </a></td>
						<td class="td6"><select id="cmbBcoin" class="txt c1" onchange='coin_chg(2)'> </select></td>
						<td class="td7"><input id="txtBfloat" type="text" class="txt num c1" /></td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtCustno" type="text" class="txt c1"/></td>
						<td class="td3" colspan="2"><input id="txtComp" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr6" style="background-color: lightcoral;">
						<td class="td1"><span> </span><a id="lblObu" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtObuno" type="text" class="txt c1"/></td>
						<td class="td3" colspan="2"><input id="txtObu" type="text" class="txt c1"/></td>
						<!--<td class="td4">
							<a id="lblImport" class="lbl"> </a><span> </span>
							<input id="chkImport" type="checkbox" style="float:right;"/>
						</td>
						<td class="td5">
							<a id="lblExport" class="lbl"> </a><span> </span>
							<input id="chkExport" type="checkbox" style="float:right;"/>
						</td>-->
						<td class="td5"> </td>
						<td class="td6"> </td>
						<td class="td7"> </td>
						<td class="td8"> </td>
					</tr>
					<tr class="tr7" style="background-color: lightcoral;">
						<td class="td1"><span> </span><a id="lblOcoin" class="lbl"> </a></td>
						<td class="td2"><select id="cmbOcoin" class="txt c1" onchange='coin_chg(3)'> </select></td>
						<td class="td3"><input id="txtOfloat" type="text" class="txt num c1" /></td>
						<td class="td4"> </td>
						<td class="td5"><span> </span><a id="lblObcoin" class="lbl"> </a></td>
						<td class="td6"><select id="cmbObcoin" class="txt c1" onchange='coin_chg(4)'> </select></td>
						<td class="td7"><input id="txtObfloat" type="text" class="txt num c1" /></td>
						<td class="td8"> </td>
					</tr>
					<tr class="tr8" style="background-color: gold;">
						<td class="td1"><span> </span><a id="lblSup" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtSupno" type="text" class="txt c1"/></td>
						<td class="td3" colspan="2"><input id="txtSupacomp" type="text" class="txt c1"/></td>
						<td class="td5"> </td>
						<td class="td6"> </td>
						<td class="td7"> </td>
						<td class="td8"> </td>
					</tr>
					<tr class="tr9" style="background-color: gold;">
						<td class="td1"><span> </span><a id="lblScoin" class="lbl"> </a></td>
						<td class="td2"><select id="cmbScoin" class="txt c1" onchange='coin_chg(5)'> </select></td>
						<td class="td3"><input id="txtSfloat" type="text" class="txt num c1" /></td>
						<td class="td4"> </td>
						<td class="td5"><span> </span><a id="lblSbcoin" class="lbl"> </a></td>
						<td class="td6"><select id="cmbSbcoin" class="txt c1" onchange='coin_chg(6)'> </select></td>
						<td class="td7"><input id="txtSbfloat" type="text" class="txt num c1" /></td>
						<td class="td8"> </td>
					</tr>
					<tr class="tr10" >
						<td class="td1"><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtTggno" type="text" class="txt c1"/></td>
						<td class="td3" colspan="2"><input id="txtTgg" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr11">
						<td class="td1" ><span> </span><a id='lblManu' class="lbl"> </a></td>
						<td class="td2" colspan="3"><input id="txtManu" type="text" class="txt c1"/></td>
						<td class="td5" ><span> </span><a id='lblTaxtype' class="lbl"> </a></td>
						<td class="td6"><select id="cmbTaxtype" class="txt c1"> </select></td>
						<td class="td7" ><span> </span><a id='lblTaxrate' class="lbl"> </a></td>
						<td class="td8"><input id="txtTaxrate" type="text" class="txt c1 num" style="width: 80%;"/>%</td>
					</tr>
					<tr class="tr12">
						<td class="td1" ><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td class="td2"><select id="cmbTypea" class="txt c1"> </select></td>
						<td class="td3"> </td>
						<td class="td4"> </td>
						<td class="td5"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td6"><input id="txtWorker" type="text" class="txt c1" /></td>
						<td class="td7"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td class="td8"><input id="txtWorker2" type="text" class="txt c1" /></td>
					</tr>
					<tr class="tr13">
						<td class="td1"><span> </span><a id="lblOrdeno" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtOrdeno" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblOrdcno" class="lbl btn"> </a></td>
						<td class="td4"><input id="txtOrdcno" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id="lblInvono" class="lbl btn"> </a></td>
						<td class="td6"><input id="txtInvono" type="text" class="txt c1"/></td>
						<td class="td7"><span> </span><a id="lblInvoino" class="lbl btn"> </a></td>
						<td class="td8"><input id="txtInvoino" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr14">
						<td class="td1"><span> </span><a id="lblOordeno" class="lbl btn"> </a></td>
						<td class="td2">
							<input id="txtOordeno" type="text" class="txt c1"/>
							<input id="txtOdatabase" type="hidden" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblOordcno" class="lbl btn"> </a></td>
						<td class="td4"><input id="txtOordcno" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id="lblSordeno" class="lbl btn"> </a></td>
						<td class="td6">
							<input id="txtSordeno" type="text" class="txt c1"/>
							<input id="txtSdatabase" type="hidden" class="txt c1"/>
						</td>
						<td class="td7"><span> </span><a id="lblSordcno" class="lbl btn"> </a></td>
						<td class="td8"><input id="txtSordcno" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr15">
						<td class="td1"><span> </span><a id='lblMemo' class='lbl'> </a></td>
						<td class="td2" colspan='7'>
							<textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1880px;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1'>
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:25px;">
						<input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;" />
					</td>
					<td style="width:20px;"> </td>
					<td align="center" style="width:160px;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblProduct_s'> </a><a class="isSpec">/</a><a id='lblSpec_s' class="isSpec"> </a></td>
					<td align="center" style="width:95px;" class="isStyle"><a id='lblStyle_s'> </a></td>
					<td align="center" style="width:75px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblWeight_s'> </a></td>
					<td align="center" style="width:95px;"><a id='lblPrice_s'> </a><BR><a id='lblOprice_s'> </a><BR><a id='lblSprice_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblTotal_s'> </a></td>
					<td align="center" style="width:75px;"><a id='lblBunit_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblBmount_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblBweight_s'> </a></td>
					<td align="center" style="width:95px;"><a id='lblBprice_s'> </a><BR><a id='lblObprice_s'> </a><BR><a id='lblSbprice_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblBtotal_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblProfit_s'> </a></td>
					<td align="center" style="width:175px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" class="btn" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="hidden" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input class="btn" id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width: 10px;" />
						<input id="txtProductno.*" type="text" class="txt c1" style="width:83%;" />
					</td>
					<td>
						<input id="txtProduct.*" type="text" class="txt c1"/>
						<input id="txtSpec.*" type="text" class="txt c1 isSpec"/>
					</td>
					<td class="isStyle"><input id="txtStyle.*" type="text" class="txt c1 isStyle"/></td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td><input id="txtMount.*" type="text" class="txt num c1" /></td>
					<td><input id="txtWeight.*" type="text" class="txt num c1" /></td>
					<td>
						<input id="txtPrice.*" type="text" class="txt num c1" />
						<input id="txtOprice.*" type="text" class="txt num c1" />
						<input id="txtSprice.*" type="text" class="txt num c1" />
					</td>
					<td><input id="txtTotal.*" type="text" class="txt num c1" /></td>
					<td><input id="txtBunit.*" type="text" class="txt c1"/></td>
					<td><input id="txtBmount.*" type="text" class="txt num c1" /></td>
					<td><input id="txtBweight.*" type="text" class="txt num c1" /></td>
					<td>
						<input id="txtBprice.*" type="text" class="txt num c1" />
						<input id="txtObprice.*" type="text" class="txt num c1" />
						<input id="txtSbprice.*" type="text" class="txt num c1" />
					</td>
					<td><input id="txtBtotal.*" type="text" class="txt num c1" /></td>
					<td><input id="txtProfit.*" type="text" class="txt num c1" /></td>
					<td>
						<input id="txtMemo.*" type="text" class="txt c1"/>
						<input id="recno.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>